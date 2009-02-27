From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFH] rebase -i optimization
Date: Fri, 27 Feb 2009 13:29:32 +0100
Message-ID: <fabb9a1e0902270429t5d31aaaet1e8c07e2b42751c3@mail.gmail.com>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
	 <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>
	 <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>
	 <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 13:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld1sA-0008BC-1t
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 13:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbZB0M3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 07:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160AbZB0M3h
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 07:29:37 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:36604 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194AbZB0M3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 07:29:36 -0500
Received: by fxm24 with SMTP id 24so1022501fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RS3hNgmkpsfli2B2zuc29HJHdiCt/P54BBF8Gsc6C+4=;
        b=Ol0t9jMzxyjEpftjlfPidev58r3wgaYiP4d1ZU1nLyK9lw9S3BXyjHaSAQrwjVi5HS
         QoTthYvu5Du2J7ZjAY3+SwygXmpE0fI3mnEMa1nU2rHTs8hSlhqKZ8F8+9OEwf5cqZmD
         n3MLQFlvo3as8W0V5QyG1lmgB+qKxqsVr7FhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=br3a3CmJxu/fDkVl+IXAJ3XvnPTOEkRjTgkdiY2JtFcsZuJGy7FPAiz8Vhp6ui1kWd
         bKLTht74zndx0yYZJskYtYInc6LKUL9EV+YjSLCLOdmljaDG+YQ6qbGPDwNI5PLOQaWm
         ZEU9ulG4deBmU93zM7EGh1zT96CtO2gvYJ8bs=
Received: by 10.103.214.13 with SMTP id r13mr1279616muq.37.1235737773016; Fri, 
	27 Feb 2009 04:29:33 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111665>

Heya,

On Fri, Feb 27, 2009 at 11:50, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On one hand, I could imagine that it is just a question of skipping t=
hose
> 'pick' commands that do not contribute anything. =A0That would be a p=
retty
> simple function that would be called at the very beginning.

Exactly, that's what I had in mind.

> On the other hand, this very simple strategy would fail pretty quickl=
y
> (and badly) with -i -p. =A0And that is the stuff I am mostly spending=
 my Git
> time budget on these days.

I would be fine with making this optimization optional (with a config
option?), and barf if both the optimization and -p are supplied. We
could even automagically ignore the config option for -p, and only
barf if both -p and this option are specified explicitly?

> Having said that, I think yours might be such a common case that it i=
s
> worth optimizing for.

Does this fit in your git time budget, or would you prefer I have a
stab at it? If the latter, any hints on where to put such a call?

--=20
Cheers,

Sverre Rabbelier

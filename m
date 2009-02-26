From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFH] rebase -i optimization
Date: Thu, 26 Feb 2009 16:33:32 +0100
Message-ID: <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
	 <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>
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
X-From: git-owner@vger.kernel.org Thu Feb 26 16:35:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LciGP-00068d-AO
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZBZPdi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 10:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754969AbZBZPdh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 10:33:37 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:50309 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbZBZPdg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 10:33:36 -0500
Received: by mu-out-0910.google.com with SMTP id i10so228859mue.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 07:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zlGse/KZEDocLyjCI0VYyyq6omsqA3ozW2WYSFbu93s=;
        b=WF+kjXzYGagTp6HWD8i/4bHG+Qa0OICEsI+xRy2TvOLrDGAT8D6hHtb24FpVd+2e33
         qqCodNLD5EtO76d8ssgBZMqFseYArJgSAX1s9jwYEcv+6E2SKACQI0rzoaYrSi88IJ0f
         U7oAFBu8qrIqFYilFz05ZuaB6vpam/TPW2mDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iGj94FkVTdGYOZcSCjeeBm3ih/TNwlQe+bGJmhhFTuXFdGSgl0dbej1EOgP28InY/j
         KDvc38em+AdhGLKVUibzBlmda12NNxaFlEVRuJJ/2UEHNoVtDWN1I8OIVFb3fCjsK/mp
         KkE909kvymAGYkgAMNXvide9YoJBSD6oSW/X0=
Received: by 10.103.161.16 with SMTP id n16mr725404muo.79.1235662412579; Thu, 
	26 Feb 2009 07:33:32 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111575>

Heya,

On Thu, Feb 26, 2009 at 15:59, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> This code is supposed to do exactly what you want:

Hmmm, I can't say I understand it 100%, but what I can see from
reading the code and looking at the output of 'rebase -i -v' is that
it does a 'git reset --hard' on each commit if it was already applied,
instead of figuring out beforehand what to reset to? If that is the
case, it might still take a long time to do the rebase if it takes
long to do the 'reset --hard' between the patches (say, if a big
change is made).

> Unfortunately, it seems to be quite broken by all the different direc=
tions
> rebase -i was pulled to, but maybe you see the bug right away. =A0Oth=
erwise,
> I'll try to reschedule my Git time budget later tonight.

After reading the code and trying with -v, I don't think the current
code is broken, just that it might be optimized to be even faster?

--=20
Cheers,

Sverre Rabbelier

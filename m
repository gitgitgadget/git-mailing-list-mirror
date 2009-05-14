From: Aaron Cohen <remleduff@gmail.com>
Subject: Re: [PATCH 3/3] read_directory(): infrastructure for pathname 
	character set conversion
Date: Thu, 14 May 2009 18:36:24 -0400
Message-ID: <727e50150905141536r5f3c4c1ap615166ba71018bf3@mail.gmail.com>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
	 <alpine.DEB.1.00.0905150018070.26154@pacific.mpi-cbg.de>
Reply-To: aaron@assonance.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 00:36:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jXV-000691-KN
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbZENWg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbZENWgZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:36:25 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:36653 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZENWgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 18:36:25 -0400
Received: by bwz22 with SMTP id 22so1584841bwz.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B+cA5TabtRDNv7nVWOhhR4V+sQPRjO9bfzMnEvgPHcg=;
        b=WjQFgobShAeAAsnBqVm2V8Qu3CRRqpVjaOS4U+Za0fMqWc7puup9+ndz/rAc5+Jz7E
         PpxBmSx4SxFts+8Ha9JDyf63HoQJGbJR+wc5NGuq+dNWB3hSdbUM6ykNI2HoUNhBd08k
         c6PN/13XyiISvktNQpzRcdAqwUoa+snlrCa8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=oDKW3zDwse+cQbUuyFav37dZBrfAU+mryDcITRj4vkIGpTluV4WjR9jSD6K7sofyEC
         EEP5cMDhs+JyCeAVRvZN/z3UqIHIuICpN3YNKTkr8lmbMzJabmTBAz90rDmNjnpfVNq1
         CqEBIg1SIPHfm4XQzInmdRUeYw/dGdYT2c+dA=
Received: by 10.204.60.133 with SMTP id p5mr2582106bkh.143.1242340584488; Thu, 
	14 May 2009 15:36:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905150018070.26154@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119233>

On Thu, May 14, 2009 at 6:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 14 May 2009, Linus Torvalds wrote:
>
>> The use of "//" as the filesystem path component separator may be odd,
>
> Hopefully it will not bite us on Windows: "//fileserver/x" is different
> from "/fileserver/x" there: the former tries to access the share "x" of
> samba server "fileserver", while the latter will expand to "C:\Program
> Files\Git\fileserver\x" (or wherever you installed Git).
>
> Ciao,
> Dscho

Does this possibly allow using the magic "\\?\" prefix on windows to
avoid file name length restrictions?
-- Aaron

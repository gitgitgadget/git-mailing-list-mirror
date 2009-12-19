From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Fri, 18 Dec 2009 22:21:33 -0800
Message-ID: <4B2C70ED.1020602@gmail.com>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>  <1261172078-9174-1-git-send-email-bebarino@gmail.com>  <loom.20091218T223918-175@post.gmane.org> <1261173577.14059.5.camel@swboyd-laptop> <loom.20091218T234129-280@post.gmane.org> <4B2C395A.6080300@gmail.com> <4B2C66D3.1070508@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 07:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLsjR-0006yO-NG
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 07:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZLSGVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 01:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZLSGVg
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 01:21:36 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:57890 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbZLSGVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 01:21:36 -0500
Received: by iwn1 with SMTP id 1so2650799iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 22:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=05rApLL5PKusQwJ/66JlczkWvePpFevwARAOfdvAcJM=;
        b=vMTCPaLg1uYZgFIbaJRz17cyp62Tk3vz5H1Oy3Yo1fR2zwaRddPg9voq81cAFbPW27
         tePCKQHSfxM8Re8vT2mrHyrgtA7+3ri/owI4qH8e+zYCnlk2hkjyncNfoN5v5uZO5z7P
         vftcgBxnX5VtMLqAEyuQeyFSfPsQsR9zq8T4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fisRuqN4qEZsSQebTop13i1Xoesh5c99Mf/AVijWyKRf+DJFai1O7QpiUsrU+S/mkk
         wvGQv3Y8F9+yUZXXGjNnItMjkkXNUmdeHdLaKmeUEbxsjPRgNyvyQcO7SQraS0qvD9sN
         Nrz8bybJBm2TqYDyB6OuCuhZnhhAMkA/KWgGM=
Received: by 10.231.121.93 with SMTP id g29mr2521704ibr.13.1261203695344;
        Fri, 18 Dec 2009 22:21:35 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm2719761iwn.4.2009.12.18.22.21.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 22:21:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <4B2C66D3.1070508@byu.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135465>

On 12/18/2009 09:38 PM, Eric Blake wrote:
> Closer, but not there yet.  "$/" is still not defined.  Then, as a matter
> of style, '\' is more readable than "\\" for representing a backslash.  So
> as long as we are shifting to '', we might as well do it everywhere in
> that line - write it like this:
>
> } | sed -e 's/$/;/' | tr ';' '\015'>  patch1-crlf.eml
>
> and you should be set.

Ah, I think you missed that this stuff is inside single quotes already. 
I would love to just do what you suggest here.

I'm a little confused because I see this in a test (am 
--committer-date-is-author-date) a ways down in the same file

     git cat-file commit HEAD | sed -e "/^$/q">head1&&


and following your reasoning that wouldn't be portable?

Either way, I'll look for a better replacement character instead of 
semi-colon.

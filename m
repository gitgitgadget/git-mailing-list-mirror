From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Some information that git diff saves and that git status does
 not
Date: Tue, 9 Mar 2010 11:20:29 +0300
Message-ID: <20100309082029.GG31105@dpotapov.dyndns.org>
References: <loom.20100308T111146-322@post.gmane.org>
 <7vpr3emr3s.fsf@alter.siamese.dyndns.org>
 <4B95EC43.2040705@viscovery.net>
 <4B95F183.7000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyWW-0001Do-Mc
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab0CIIUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 03:20:34 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:56148 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab0CIIUd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 03:20:33 -0500
Received: by fxm5 with SMTP id 5so884985fxm.29
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 00:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xjVhDE/Tx1QJR3rXmkvKI4oF3WYdtu4tgow4Qa7r9ZE=;
        b=eamVSkxeO5haXLo2G0uyNYhVxHCUi4gAqmIh8MBSvQgxtaoRPgBLgHsyqFIRJs5PCJ
         QLys6v7UfXDC7TLLBaNTB5vTtGyFMFy2Vr3e6OKVMkiqqd0PcbQwUbJvSGFYdBedJAvN
         9mwV5TpPA2gQBKwTMnCYNwrBchX+WArLK+nrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G2PLy6WqRdfkRDkG13Yf9joyHMS8aS2SF+1ySidHJTGbkqTWOYkSfPhZmZDiqX4jv3
         3vVvgK6xmqdyR/+5/txKVywFbWXZ+XjJbmteKkEbK5cm9erX/iS4yBpUHVaVvJtoRIVC
         6Rt28+kCm0/IyTxok3dcE1xG1626y3H6tfvhI=
Received: by 10.223.7.88 with SMTP id c24mr3413245fac.59.1268122832065;
        Tue, 09 Mar 2010 00:20:32 -0800 (PST)
Received: from localhost (ppp91-78-51-61.pppoe.mtu-net.ru [91.78.51.61])
        by mx.google.com with ESMTPS id 35sm10152459fkt.7.2010.03.09.00.20.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 00:20:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B95F183.7000708@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141802>

On Tue, Mar 09, 2010 at 07:58:11AM +0100, Sergio Callegari wrote:
> 
> I actually did not know about the
> 
> update-index --refresh

This is a plumbing commmand, which normally users should not use
directly, but when you copy your repo by hands or do something like
that, you may need it (or use "git diff").

> 
> but now I have the relevant information its name sounds obvious.
> And I suspected something like inode data entering the game.
> 
> As a matter of fact, I was obtaining the same effect with git diff.

Because "git diff" refreshes the cached stat information internally,
in the same way as "update-index --refresh". Junio wrote about this
recently:
http://article.gmane.org/gmane.comp.version-control.git/141708

> 
> What was appearing to me as a quirk is that:
> 
> 1) If you do not refresh the index, git works perfectly all the
> same.  For instance, git status shows the right info. Only it is not
> that fast anymore, since everytime it needs to runs the filters on
> all the files.
> 2) git status does not refresh the index, while other commands like
> git diff do.

Historically, "git status" was just the dry-run mode of "git commit". I
do not think that "git commit" should refresh the index. But in Git 1.7,
"git status" is no longer the dry-run mode of "git commit", so I see no
reason why it does not refresh the cached stat info internally...


Dmitry

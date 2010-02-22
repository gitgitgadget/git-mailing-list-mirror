From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: unexpected git-merge result
Date: Mon, 22 Feb 2010 08:44:25 +0300
Message-ID: <20100222054425.GC10191@dpotapov.dyndns.org>
References: <loom.20100219T202452-35@post.gmane.org>
 <7vaav4amjj.fsf@alter.siamese.dyndns.org>
 <loom.20100220T031401-572@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dale Rowley <ddrowley3@juno.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:11:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjR65-00069X-EC
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 06:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab0BVFob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 00:44:31 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:49051 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab0BVFoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 00:44:30 -0500
Received: by fxm5 with SMTP id 5so2296872fxm.29
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 21:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MYwcdzvr99QeQKrBUof+yC9XJ0oJ1vNdY+a4jAcpO2E=;
        b=kr43a4Kn/zYnp1aJFy/H8PdXcT7h8lXGITj23xEn4Y2wgQaCA/x0jaWxFd/UDYScDr
         tK6DAnoOH9mUyPWkhju1KTEbHBsfBeoJ3niHD2/gfzb1c670UZlzlD8v0+pDLzCmQ8XH
         BBoX5OTcxEvnjvdOj2DjSkaHVCfxP2k96zkDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MoEBNTcOYzGXLrHq80K6DqD0KbzyIBxfg5bmSdbXWitc28u0RUkCrNaeD2mDe1L6JW
         m6hmEKIidDyp5gafiz1YL+XXMfrr21+6QNdz/JaxggZcLEyTyDZmA92TSvnPg6tqoLff
         Z34y1QkQl16f0Dqr74SuVFqtihG7Twk5YSGPo=
Received: by 10.223.5.212 with SMTP id 20mr651439faw.19.1266817468270;
        Sun, 21 Feb 2010 21:44:28 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id 16sm1263732fxm.7.2010.02.21.21.44.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 21:44:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20100220T031401-572@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140614>

On Sat, Feb 20, 2010 at 03:45:09AM +0000, Dale Rowley wrote:
> 
> You're exactly right. I overlooked the cherry-pick, which clears things up a
> bit. But the basic problem remains:
> 
> A----D---E---H
>  \          /
>   B--D'----G
> 
> G only removed a few of the lines that were brought over in the cherry-pick
> (D'), so it was surprising when they re-appeared in H. Intuitively, one would at
> least expect a conflict in H since D'+G is asserting that these lines should not
> exist, whereas D (on the other branch) is asserting that they should. I can see
> how it would be difficult to make git-merge account for this though, so maybe
> this is just a subtle gotcha when merging branches? Is there an easy way to
> avoid this gotcha?

git merge does 3-way merge, which means that it does not look at whole
history but only on the current state and the merge base. So, if you
look at changes between A and G then those lines were not touched, and
A-E adds those lines, thus the end result is that these lines are added.


Dmitry

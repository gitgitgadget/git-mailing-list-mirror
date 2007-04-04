From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Wed, 4 Apr 2007 14:28:08 +0200
Message-ID: <81b0412b0704040528g3fd6b3d0id9cc1b98fe58d8e@mail.gmail.com>
References: <1175686583.19898.68.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Bennee" <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 14:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ4b1-00043t-KZ
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 14:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966105AbXDDM2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 08:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966326AbXDDM2K
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 08:28:10 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:31317 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966320AbXDDM2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 08:28:09 -0400
Received: by an-out-0708.google.com with SMTP id b33so205682ana
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 05:28:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fQmYUk+ro+gFi/6J3kA9MpuCRJQzxkG0fW30mURhWbhKkFB3/bxyCVvEfmZTkGX6+xaPF51pvcEBPoq7476jRRf++eOOEVy5hjl6OZdU3r++zb/byEIJXie1zXSX6qa/Z3rPhN4zGeah5vSKTNDEGvw/1OGyblrBCJ4jK3DWtRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WDkpGKEfpNZ0N9Bol4FZTEVu4h1sVqnJe5mNwxN+pjPBdEqMK15mRDN66v0UTFfjbSVY2A7vp3+C4wSBI8emxFahupMAGRBYCh1NccOBs6fZd/XQ8xusYGmz32EEdjY1yfuVyMzeEHvR7Kl6Fs8+nfn+4Y/l46TKLVSaaARgc7s=
Received: by 10.100.35.17 with SMTP id i17mr367534ani.1175689688828;
        Wed, 04 Apr 2007 05:28:08 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 4 Apr 2007 05:28:08 -0700 (PDT)
In-Reply-To: <1175686583.19898.68.camel@okra.transitives.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43732>

On 4/4/07, Alex Bennee <kernel-hacker@bennee.com> wrote:
> Is there an invocation of git-diff or another tool that can tell me all
> my diffs are present in the big uber-commit of my master branch baseline
> release?

You can limit git-diff to the pathnames you touched in your commits
(assuming you now the first commit you sent upstream).

git diff-tree --name-only first HEAD | while read f; do
  git diff-tree --shortstat upstream HEAD -- "$f"
done

It is very inefficient, though

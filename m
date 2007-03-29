From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 16:44:51 +0200
Message-ID: <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
References: <20070329075010.GA3493@hermes>
	 <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
	 <20070329125803.GA16739@hermes>
	 <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
	 <20070329141230.GB16739@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 16:44:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWvs0-0001jD-Jv
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 16:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbXC2Oox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 10:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbXC2Oox
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 10:44:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:22424 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbXC2Oox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 10:44:53 -0400
Received: by wr-out-0506.google.com with SMTP id 76so248319wra
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 07:44:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iA5Yul5bQsUi96AMIP2naUC1ZkAcP/fSHuQjZA+3jrffR9JJ6pjVg87zKGkkjSVrlNco8QrfvBUz6VeIdxBfVW28IKrcgm1ZaNnUy30MDIJXEOja0t1tA7LlaNnYZL/SAoMhNzNd7MuoZMAOfBN9zg34ISyxz++HR21dswAddaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LK0wd8dJHnDqqgYt1nGRVNPXS7HzJ6YjV7A4PGwyh+H1Inzo14lw11csoa28NRlFyAF4LU1uLBFVRw4NeSh4v1T29txMBBm7z1cTAdV3vUbzhubVYmWT1XVX9sOOmM062uoOPTvFdzl8ghpxyB+VhBXQ7xg8kCOsU9wN7YZ22Rg=
Received: by 10.100.107.2 with SMTP id f2mr451368anc.1175179492021;
        Thu, 29 Mar 2007 07:44:52 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 29 Mar 2007 07:44:51 -0700 (PDT)
In-Reply-To: <20070329141230.GB16739@hermes>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43437>

On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> > Did it crash before? If it didn't, is it possible for you to bisect
> > the commit which caused the problem?
>
> It occurs running
>
> git merge -s recur test HEAD merge
>
> with
>
> 6c711269d4e49072703255ce29bd4d8c53e4f4ba
>
> which introduced the C version of merge-recursive.

So, it _always_ crashed for you.

> Here is the output from that more verbose version:
>
> Merging HEAD with 0134d595adb023841750f1ce84ecb94dd4e4c9cb
> Merging:
> 922ee6e3f1222c8e171e6ea0b6ac0f28fb1f0683 Mail.
> 0134d595adb023841750f1ce84ecb94dd4e4c9cb Mail.
> found 2 common ancestor(s):
> 29e722de58df3cd82600fa5215ec26f80a8c0f9a Mail.
> 2c3490d82610d12d8dfde36b29c4ec5a50955b89 Mail.
>   Merging:
>   29e722de58df3cd82600fa5215ec26f80a8c0f9a Mail.
>   2c3490d82610d12d8dfde36b29c4ec5a50955b89 Mail.
>   found 1 common ancestor(s):
>   e2123cfd9a53e441c7c715627953606c6093e0e4 Merge commit 'origin'
>   CONFLICT (rename/rename): Rename .drafts/new/1175001142.P509Q1.hermes->.mom/cur/1175098106.P18146Q0M209985.socrates:2,S in branch Temporary merge branch 1 rename .drafts/new/1175001142.P509Q1.hermes->.drafts/cur/1175001142.P509Q1.hermes:2, in Temporary merge branch 2

Rename conflict... Will see, if I can reproduce it without your repo.
In the mean time, how about

> /Users/cougar/local/bin/git-merge: line 311: 25426 Segmentation fault      git-merge-$strategy $common -- "$head_arg" "$@"
> No merge strategy handled the merge.

Is it MacOSX, by any chance? On 64bit? just collating data

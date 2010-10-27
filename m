From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 12:36:44 -0500
Message-ID: <20101027173644.GB15657@burratino>
References: <AANLkTinLbaE6He-bxA_+CT6J5uWmZSgodGs6SXO7eqnr@mail.gmail.com>
 <20101027165723.GC11069@burratino>
 <AANLkTimoSH2C4dBDDN1KMaFAp_nwAtLy5_uNFfiuz5GR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9vk-0007Oo-Ew
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab0J0Rgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 13:36:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54495 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0J0Rgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 13:36:51 -0400
Received: by gwj21 with SMTP id 21so592611gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DLrMVZO4B2IUkn5nxs6mZT+JM4PoCJOtP5vUPOZoCrg=;
        b=Kl4TRStGbZg0wogrJ7W3xayTuJSp9tndM6zM+YTPuMryb1iAzG2mUEw7tT2OGo6mA1
         rl2yiwmOOXXPGrO8VsgXv0X1ACU3sjliUMH9w+mnafz8ftFc/c35IuF9BK6AMUJBfAgd
         mAuff859cX3jydI3kInuVGYHHdntDdx6FeeUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DRdtoRFGblbnz3Ddw6zhuG3dim5dQ4vv3uXUy2CTn9oTl25kNmZQ/2FVWMrKjkXgCc
         uwcXHkUTS6OkfppJ/9IL59urEDtuJc1UVYAPuYPUstQ5X6Q8aJmsGtIFxORqIxSzql37
         Xt582M+JbcwtGx2JLE18ClXzqd6Xudos6kJm4=
Received: by 10.239.187.137 with SMTP id l9mr2936437hbh.181.1288201009779;
        Wed, 27 Oct 2010 10:36:49 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q3sm12418vcr.27.2010.10.27.10.36.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 10:36:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimoSH2C4dBDDN1KMaFAp_nwAtLy5_uNFfiuz5GR@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160107>

Eugene Sajine wrote:

> Thanks for prompt answer. But let me clarify:
>
> When you do pull git performs:
>
> fetch of the remote branch to the FETCH_HEAD
> and then merge of FETCH_HEAD into the local branch
>
> What I'm saying is that your local branch should be rebased on top of
> FETCH_HEAD instead
> 
> In this case there is no such thing as "often rebased public branch".

Ah, but there is.

Imagine you are Junio and just received a pull request from Pat.
Then you might try:

 $ git pull pat for-junio

which will do all the fetching and merging magic that "git pull"
is known for.  Now if pat's for-junio branch is based on the tip
of your current branch, this will be a fast-forward and it doesn't
matter whether you merge or rebase.  But what if there are some
intervening commits?

 $ git pull eric for-junio
 $ git pull pat for-junio

If this pull were the rebasing kind, the result would be for Eric's
commits to be rewritten based on Pat's.

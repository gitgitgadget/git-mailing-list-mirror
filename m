From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH] remove unnecessary 'if'
Date: Sun, 14 Dec 2008 19:21:01 +0300
Message-ID: <20081214162101.GB21358@myhost>
References: <1228918156-3953-1-git-send-email-aspotashev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 17:22:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBtjj-0006sn-66
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 17:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbYLNQVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYLNQVF
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 11:21:05 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:53398 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbYLNQVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 11:21:04 -0500
Received: by bwz14 with SMTP id 14so815891bwz.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=FJqLbmfBfV4kZvlomvYY3unoWsmgOnaxivA3FNaSpP0=;
        b=q7b+BM5PyA/1BOahEbi+RyHiKNY0KLQcRbf6l7m1XvB4REr+mfe40Qxe26kEuoc58U
         2eUp3B72lE6wyU0jhe2nPn6I+nsOuqjFLKgva/BFPjXqrSjtlMfBGjeUQHOHEN5XhFdO
         VlwofDD3BtMabj0F3fdrE7iSm9QOEfvl577No=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YWCIbIlRMG47ErFQ2ziM2mgcIiRxP3JIRsRQSj88KcBZhcthnd8tZfVHkLg7iMVsaF
         kAmdNeCjy0lR7zVHuv9Tf/X2sKoAnNsw0kSbTvyoJy7FM1lX52gg9rn+LbqjeKfk0n8r
         wTcyJ1OW3h7KSaHEPr5j6IxPz8OlF4PqursJs=
Received: by 10.86.84.5 with SMTP id h5mr3226922fgb.49.1229271660783;
        Sun, 14 Dec 2008 08:21:00 -0800 (PST)
Received: from smtp.gmail.com ([91.78.101.148])
        by mx.google.com with ESMTPS id 4sm715226fgg.57.2008.12.14.08.20.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 08:20:59 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sun, 14 Dec 2008 19:21:01 +0300
Content-Disposition: inline
In-Reply-To: <1228918156-3953-1-git-send-email-aspotashev@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103091>

Hello all!

What happened with this patch? Is it wrong or breaks comprehensibility?

On 17:09 Wed 10 Dec     , Alexander Potashev wrote:
> 'patch->is_new' is always <= 0 at this point (look at 'assert' at the
> beginning of the function). In both cases ('is_new < 0' and 'is_new == 0')
> the result of those two lines is zeroing of 'is_new'.
> 
> Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
> ---
>  builtin-apply.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 4c4d1e1..904a748 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2440,8 +2440,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
>  	if (!cached)
>  		st_mode = ce_mode_from_stat(*ce, st->st_mode);
>  
> -	if (patch->is_new < 0)
> -		patch->is_new = 0;
> +	patch->is_new = 0;
>  	if (!patch->old_mode)
>  		patch->old_mode = st_mode;
>  	if ((st_mode ^ patch->old_mode) & S_IFMT)
> -- 
> 1.6.0.4
> 

					Alexander

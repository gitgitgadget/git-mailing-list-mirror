From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/15] t1510 (worktree): fix && chaining
Date: Wed, 7 Dec 2011 15:51:00 -0600
Message-ID: <20111207215100.GB2911@elie.hsd1.il.comcast.net>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
 <1323286611-4806-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 22:51:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPOU-0004Jf-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 22:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab1LGVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 16:51:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38592 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618Ab1LGVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 16:51:07 -0500
Received: by yenm11 with SMTP id m11so505100yen.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 13:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vRKxs8/MtPgy4vqDoMT7S18roNAWp5U1hUTszZ2R+Uo=;
        b=sr3xvPrTrdRCTmzH8EKKkAggUJKRfIfEhEQGKEGkE8roR6qhJZFkMRgSp1GhdYrhA3
         KftaGiiPBO+5rlHP+V/0b6ii9Y+bcR0cC493MN/ijS6YjKm3JZZY9YOSLX6A0eF/B7dk
         qo1RVHFsrlEg966Ms2nMiwYzrpAJe+omGlkQE=
Received: by 10.236.176.3 with SMTP id a3mr225573yhm.111.1323294667055;
        Wed, 07 Dec 2011 13:51:07 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q16sm8370056anb.19.2011.12.07.13.51.05
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 13:51:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323286611-4806-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186503>

Patches 5 and 6 look safe, though I haven't tested them.

Ramkumar Ramachandra wrote:

> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -48,7 +48,7 @@ test_expect_success 'setup: helper for testing rev-parse' '
>  '
>  
>  test_expect_success 'setup: core.worktree = relative path' '
> -	unset GIT_WORK_TREE;
> +	unset GIT_WORK_TREE &&

On some shells, like /usr/xpg4/bin/sh on Solaris, unset returns nonzero
status when the variable passed was already unset.  Will this work on
such platforms, or does it need to be changed to use sane_unset?

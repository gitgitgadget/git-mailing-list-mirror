Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405EAC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 05:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbiDYFJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDYFJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 01:09:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950F8BE0A
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 22:05:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so27367812ejd.5
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m/cTlEREUpIyzDpIfam1K2NSLCAK7xHvDM1w483M+6I=;
        b=bSrHTT83Ac//tldxPDcQhWSlH7vxdSmdXtrv94wsTT+H+HQKd2IgAibGW7gj9GONlM
         gjb2hrp3WvhXw+gPMpww3kqw/K+YFxznYTeccFIvFfrTwBPjKXHrM1COSUN1GOhtIW2/
         Y8Vf5Ae5T/LUOl0InwQKX4Xq2lhqSjlN2CXys+iiTrLPDFV0M37RV0isH+kwtML2x1V1
         YT5NCifqMlqdgqyzZVUoJhm0E1Rs0RQ4vfdyokfop8OKk7HeVreNe4oglBrUSHk6Y+5M
         OUeuZ6rMPKIPrj4BIRHu+t4cZiCVMqxQE4CVUDyYlXqxb950kgs7zl0L3WcJ+lljooPx
         hT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m/cTlEREUpIyzDpIfam1K2NSLCAK7xHvDM1w483M+6I=;
        b=jQCrne3Nxukoqyzvznyrp+/w76dQ/mkaMlSJ8WqW/pi9VUqRSsxqWOE1Q5e88BH6wt
         +gX1tqU0NmqF59M8z9N7NybGHXBk+Dwo+a2W6afAQcXaoob/UnnP0yeV3r8jCcavVPvh
         uwAv8UfxzygGUjfvsiADB7WxcYvowrFmCSgEa1sZwoKSphKm/7W0+lMZD1YDOBn0qB/x
         1V8FU8kDFFBerZxA4tnVZj1pUouy/xPfjTZisdBatLRtsoYyOkXCApEy8IwyfkJNfUE9
         9WJh3iKzqZIZprNHS74YySI9y4dSC4mPCH35pP51pCJdnQ2TmaSX9YKaTbTKESOr9jYV
         K/Sg==
X-Gm-Message-State: AOAM532O+hu9/Xh/iEQ3GJnw0C2/HcEaKnHtY++5YNYJzMcgn6LT6kZP
        hescFQaIcWivvlP3K9SHLrI=
X-Google-Smtp-Source: ABdhPJym5/3OIXt4DC+q6atM3ix/ZWDSTz2OjD21mnxgc5QFCJpNP3PYcv/j7R0cSKcWee58y8YnqQ==
X-Received: by 2002:a17:907:3f95:b0:6ef:f08e:64a1 with SMTP id hr21-20020a1709073f9500b006eff08e64a1mr15217330ejc.461.1650863156500;
        Sun, 24 Apr 2022 22:05:56 -0700 (PDT)
Received: from szeder.dev (62-165-236-195.pool.digikabel.hu. [62.165.236.195])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm3194900ejk.119.2022.04.24.22.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:05:55 -0700 (PDT)
Date:   Mon, 25 Apr 2022 07:05:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
Message-ID: <20220425050549.GA3280@szeder.dev>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
 <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g>
 <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2022 at 07:01:08PM -0700, Carlo Marcelo Arenas Belón wrote:
> On Sat, Apr 23, 2022 at 04:44:57PM -0700, Junio C Hamano wrote:
> > 
> > Actually, not quite.  when "git" runs in "sudo git", the real
> > identity has long lost
> 
> Right, but in this specific case, the terminal is still a good indication
> of who the user is, so the following would work.
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 58fd813bd01..5d5d91688ee 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -442,6 +442,11 @@ static inline int is_path_owned_by_current_uid(const char *path)
>  	struct stat st;
>  	if (lstat(path, &st))
>  		return 0;
> +	if (isatty(1)) {
> +		struct stat ttyst;
> +		if (!stat(ttyname(1), &ttyst))
> +			return st.st_uid == ttyst.st_uid;
> +	}
>  	return st.st_uid == geteuid();
>  }

Our 'GIT-VERSION-GEN' runs 'var=$(git describe ...)', so standard
output is not a terminal during 'sudo make install'

> It obviously needs more polishing and portability work, though, and I don't
> like that it makes the general case more complicated, so maybe would be better
> to only do it running as root?
> 
> At that point, though you might as well excempt root from this check
> 
> Carlo

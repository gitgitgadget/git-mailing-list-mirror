Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143061FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbdA3WXE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:23:04 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35666 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbdA3WXD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 17:23:03 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so24416723pfa.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jnE2uWnPhGupc8UFMp2pV3bFkRNj0Be1vYr6WjSNkQE=;
        b=JDaRtzdrnkZSOZTU8iGnEvKoqNLq0Hyej2yQ0BOCSTbmjHU6T5jQhgA1etiSfLK5oW
         VAs1p0YSQn3UmLRtGWMAfAFO3uMupTPsjhZgjc+QfCSijFTtWAq1UbV/DzG5fTcRBbCG
         gWOPD7y7DBSeyMgPts9M9y16llpHVqzTHyOyuAo4Ez9VjfXWk+7e6oKpAwYPpDLwDeS3
         rGkyRCQy50UykTf24d7kilHnWXvszcoEZBVuYfnTmc80n6rqrDP68ZhE99TL+gy2M2f8
         ei+vDU53pPpQI3ZVk0Ed0Ha8ATitr7tbb+5cKYXfMnu1YGxTNOCwi2Vpvzk4Ylpn0zyP
         SG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jnE2uWnPhGupc8UFMp2pV3bFkRNj0Be1vYr6WjSNkQE=;
        b=E+fxRdqxmoKb36j3arzmwuiEEc12XjyCw4L4VjwOo93yY2D7eBO2z7b1qgDGANlwhD
         jNEuk0ZNr+tGrrotnf4lLYLnVmim+4hJ6197gei6j/f0jKNv4agTqToIfHrV4wySmANw
         I+V1h51/zu5vQTJpkFeVYbozAHWievRddcAbYdOctBrI7YwB3KDB9hK70oaAF6jlH2d2
         KNMuzsUcxmoWrujHZOejKFa+WHal6weXKnTvywSnAjmdqMQ0MHefItQzTGWCfl9DtT/W
         xgRsipQIVt2RH0xUyORQ5o7T3JHVPW3/uCz1Au089bH9X6XUv6V+JtA+w0jngO0NWKhR
         Hsdw==
X-Gm-Message-State: AIkVDXITKh0CWbv3KQuH9RE4/an6g9Hj/VOUjTBmcxYsdpKAeYQN381bUiAp1aLhQy15DA==
X-Received: by 10.84.160.203 with SMTP id v11mr34725898plg.133.1485814975156;
        Mon, 30 Jan 2017 14:22:55 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id d78sm35076047pfb.43.2017.01.30.14.22.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 14:22:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/5] diff: use SWAP macro
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
        <84944ecd-d14e-b5e9-7566-9ab2b68c02fb@web.de>
Date:   Mon, 30 Jan 2017 14:22:53 -0800
In-Reply-To: <84944ecd-d14e-b5e9-7566-9ab2b68c02fb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 28 Jan 2017 22:41:47 +0100")
Message-ID: <xmqqmve8tcg2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Use the macro SWAP to exchange the value of pairs of variables instead
> of swapping them manually with the help of a temporary variable.  The
> resulting code is shorter and easier to read.
>
> The two cases were not transformed by the semantic patch swap.cocci
> because it's extra careful and handles only cases where the types of all
> variables are the same

Ah, that explains my "huh?" in 3/5; thanks.

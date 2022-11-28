Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B069C4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 23:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiK1X0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 18:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiK1X0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 18:26:13 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884E12AF2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:26:12 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h15so688638ilh.12
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=abdRoeMEK3lQvWVWX+4DSUjWDlf/pUDsgK7wIas4Dvo=;
        b=CJvf44Mp1MWN68MYHwoIG9lGItoxvHIFHnZMu1mDBLPRzngjU8LRAkTj4Z+Vgl5z/T
         jiefcQ9/LQFOkKmv2jntqG8fCXKP0RJdR6qcPjnC75Zw1RsB9e0X0Rw5S95jwifvmtwa
         9+bYi+k6I35FvDHfwBg65zmvFCIpXwPoCOSCzZrEXS0q0gQFNLFY7jlgSAx90eCcd05j
         tjunbs9qlGfB94/Vp2pEhQhyNtzPwalbBofQ1B9/xyDcg9foWqvjNVuLQTn1pKtrBiMr
         faLcDhY3TMPq+U50KlltOlFp6bvBSZOXZlrVVX/435YNxvZy5jo5nQmJbBKfp5ElT0gS
         ZqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abdRoeMEK3lQvWVWX+4DSUjWDlf/pUDsgK7wIas4Dvo=;
        b=UkEiYmhwBlZJ4Q/0MdgZIGdlWyg9jyCT4qn2ge/S67AACIkHYOF713XIIifjHXDVPO
         qUTmQVPnGJuRWNQAbu+DahvtA6jSAGGQN1ZBDrEgm409PHnJWiABfpOLDysmDTA5vHrN
         ic+xsWmX79r6Q0nArcqyd2yXa2brFVp5gcC8au/3A7XjMhJSro8ImdxK/Rku4hpIzMzd
         oTN4PeYwctkvPkcMToHFqEMBJqdWGq1x8iKFRISRAV5YrfbLienJzOz5TcF/BOriy5sF
         fL79cTJknV+iKBHndFyoL5TrY4kglVz8OhbR7DCtVs2qeLYW2rKuclYjV7JgVokHD2Ac
         Dn5w==
X-Gm-Message-State: ANoB5pmkSQNcdCcXVe3uRq7xbI8o+AbLUFHrsyE7YnU4H1R1Sndy4KL+
        R6WKHOIV3Keb5cniGq+NCCNIuA==
X-Google-Smtp-Source: AA0mqf7kFWTWUZQsFfB1X+l1IB8OteYOGUzF/DRHk+7pgFKFZswHZHlfTqHJGVhcHdHX20V3AUBG+A==
X-Received: by 2002:a92:6e0a:0:b0:302:4d37:9e69 with SMTP id j10-20020a926e0a000000b003024d379e69mr18441759ilc.160.1669677971607;
        Mon, 28 Nov 2022 15:26:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o7-20020a056e02092700b003001f822301sm4236582ilt.81.2022.11.28.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:26:11 -0800 (PST)
Date:   Mon, 28 Nov 2022 18:26:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/4] pack-bitmap.c: break out of the bitmap loop early
 if not tracing
Message-ID: <Y4VDkq9vlLjFfnCx@nand.local>
References: <cover.1669644101.git.dyroneteng@gmail.com>
 <22deec6aab6649b228af7d858b93672f9ce2b925.1669644101.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22deec6aab6649b228af7d858b93672f9ce2b925.1669644101.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 10:09:52PM +0800, Teng Long wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index aaa2d9a104..3b6c2f804a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -527,8 +527,15 @@ static int open_pack_bitmap(struct repository *r,
>  	assert(!bitmap_git->map);
>
>  	for (p = get_all_packs(r); p; p = p->next) {
> -		if (open_pack_bitmap_1(bitmap_git, p) == 0)
> +		if (open_pack_bitmap_1(bitmap_git, p) == 0) {

While we're here, we *could* change this line to read:

    if (!open_pack_bitmap_1(bitmap_git, p))

which more closely adheres to our conventions. But I don't think just
because we could do something necessarily means that we have to, so I'm
happy to leave it alone, too. It definitely does not merit a reroll on
its own.

Otherwise this patch looks quite reasonable.

Thanks,
Taylor

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4BF202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 06:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdI0G7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:59:18 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:52261 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdI0G7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:59:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id p87so6795256pfj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=wwg/b/QizbFsTdBL2mRu+9CIugI/Komhj44zNLAIm58=;
        b=A3OpMW3PVXLCjV84++lPCbyftTXm7Y+xvG1jtQ4eM4mYN0U8aXkBBgzdruuk+a+L5a
         V6FIhwqgnfagVxJzB66KdP9eYVshQGyZ+wp7HOtosfuDzeOsJittZyV+G7C+3ipukOGF
         PeqDm75wm/aaFMaxUGw5NezBa0/84S+eVEecY2FHpiUBUhvmy3MXFXKq7cfn/TwepvL1
         xHhDEpjbkJd/fX33W3VKLl8OEhXXYVEgY2LpOGyQc9pK2bn8NwJ1iRMerkJqgkMkOkuj
         8gItHnTM0uuUVKXcTJGzpXGFQXzQ6HGyQ4NBn8dIYbksy6WThWQ70F95F1OqomQOWH6R
         AjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=wwg/b/QizbFsTdBL2mRu+9CIugI/Komhj44zNLAIm58=;
        b=Pf44eoHANmoaPxU0fOg0/BqxuCmlwkuLuvOeUWxVPitSLQhMgOcVczmcNzdZZ/8U/l
         Jf5Nd2DUfIqgt5gIxriR/fTl9qiHXhG23SoyX6NwPARDcXGJuT6vMdxRMPdWlI47+oXF
         G+5v5+zQ2Ubx6+JtS/ejK+Tpms8zQ1zmonz/TAB5MELXkyrF1Rmqu0NUMMbeq7mkt26L
         ehkpZ8lgJYayVcl0bT9pKk2OvyioiDEOS7G8pnZrFzYZFgRb/RGCVyeZaC4uD0GIbis0
         ffFJvo7yhDlW2U5P1tg0mBBaTmFzW5Yy7miPwSwl0euoxusY2oeUclBmZx8IqO0PBSdx
         32Wg==
X-Gm-Message-State: AHPjjUhl/kj6lfjiK7vQrqjbNKNGgxaX3crCvRMgx10A68OJ4Ty9dlaw
        MHMXlTNatEkCUmmIwsqmrLmIiZG7
X-Google-Smtp-Source: AOwi7QDplyGIZ7/BhlPgKw9/p1AFwAdescBDpV6c9pGM/L+xZN679gOOi1Dg0UjNC7QY7z2oxuTRIg==
X-Received: by 10.84.244.204 with SMTP id f12mr431152plt.32.1506495557173;
        Tue, 26 Sep 2017 23:59:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id y13sm19327620pfi.27.2017.09.26.23.59.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 23:59:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/7] prefer "!=" when checking read_in_full() result
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
        <20170927060028.ehddn5zwf6v6jsvs@sigill.intra.peff.net>
Date:   Wed, 27 Sep 2017 15:59:15 +0900
Message-ID: <xmqqr2us4ofw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/csum-file.c b/csum-file.c
> index a172199e44..2adae04073 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -19,7 +19,7 @@ static void flush(struct sha1file *f, const void *buf, unsigned int count)
>  
>  		if (ret < 0)
>  			die_errno("%s: sha1 file read error", f->name);
> -		if (ret < count)
> +		if (ret != count)
>  			die("%s: sha1 file truncated", f->name);

I personally find that this "ret < count" that comes after checking
if ret is negative expresses what it is checking in a more natural
way than "ret must be exactly count".

It is not a big deal, as either one needs to be read with an
understanding that read_in_full() would read at most "count" bytes
to see if the right condition is being checked to declare
"truncated" anyway.  But I somehow find

	ret = read up to count
	if (ret < 0)
		read failed
	if (ret < count)
		we failed to read as much as expected

a bit more natural.

> diff --git a/pkt-line.c b/pkt-line.c
> index 647bbd3bce..93ea311443 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -258,7 +258,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
>  	}
>  
>  	/* And complain if we didn't get enough bytes to satisfy the read. */
> -	if (ret < size) {
> +	if (ret != size) {
>  		if (options & PACKET_READ_GENTLE_ON_EOF)
>  			return -1;

Likewise, even though it is harder to see that this follows another
explicit check for "ret < 0".

Thanks.

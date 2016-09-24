Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227391F935
	for <e@80x24.org>; Sat, 24 Sep 2016 22:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965385AbcIXW4y (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 18:56:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36564 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934155AbcIXW4w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 18:56:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so8330584wma.3
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ei8CFIqGqtZhk/YpkgL11DIENF63IOriEmsvNwLsYjE=;
        b=iZQslr4ngaS187n7DjiMBGUp4JxTxX03ldHTZlloglSy2A6WZP/1AlbzeDoIVzGZoG
         wvq/uomYv4S0Z1DCO9WJgN30OP8XnFDtkRXHndzAIUDarwojjPkNUxXblEF76UnYPpo0
         f7yXIi6vji/1RqyIDCW3H6Dq7ZgmsQ0cGbZwliy8Q3ELooeZNBFG/74qYN7wqMvUlpVt
         0PokzzZlpiuAsx6xIKtqx84xRECDsdY72TkgRGmE+Mjo7mpK/obiw+17wjpyXwJ1yHvy
         XkY+vexJe2qyxBJYyFQOa+pW4T3S9yeo/hi8aFQ2Q97uSBP63SWWVDPIwifV4sIbYGXd
         1enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ei8CFIqGqtZhk/YpkgL11DIENF63IOriEmsvNwLsYjE=;
        b=lEDJZVLl9MCak0hLMEwI3KG1IimkJpI0xZ6JU9NXgt5YTor25EuuurzP2wZwXORHD3
         ap+/JNveMSHIDe6RzxZGGpUqCDeCXJwjOEocetQzD5DiGlccNZ5J6VJzfLYyh2qVEctW
         W+/8PjPZHj6jjVvbD8R435ZEbwnXYAuDns66OAGel2QX2UXTP78LHJ05qeOsI9eE4Ggu
         yDFlaC0gQW5cHiv3+Y0LiDJ0SgYlvHkzmpd6OTOm8kRR/lXdUmJ/RDB+fsn9B33WPQ3G
         xgWcGMKJxNVk9c0MFiUbjintaX6HZjjfB5sIAb0TLNCXPsJKq3r4Jf53m2PTwEM5mO5v
         j6SA==
X-Gm-Message-State: AE9vXwOod44B4D2waiuh/NSPSRZh16931ia7HWfZjMqaEVedq7dFaQygzAFRf18bDeyDww==
X-Received: by 10.194.93.198 with SMTP id cw6mr12328733wjb.212.1474757810809;
        Sat, 24 Sep 2016 15:56:50 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id q10sm3114583wme.6.2016.09.24.15.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 15:56:49 -0700 (PDT)
Subject: Re: [PATCH v8 05/11] pkt-line: add packet_flush_gently()
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-6-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0763ff86-9593-ff58-6d9d-1ff920bf1071@gmail.com>
Date:   Sun, 25 Sep 2016 00:56:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-6-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_flush() would die in case of a write error even though for some
> callers an error would be acceptable. Add packet_flush_gently() which
> writes a pkt-line flush packet like packet_flush() but does not die in
> case of an error. The function is used in a subsequent patch.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>

Looks good.

I guess the difference in treatment from packet_write_fmt_gently() in
the previous patch is that there isn't anything to extract to form
a common code function... I have skipped a few iterations of this series.

> ---
>  pkt-line.c | 8 ++++++++
>  pkt-line.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 3b465fd..19f0271 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -91,6 +91,14 @@ void packet_flush(int fd)
>  	write_or_die(fd, "0000", 4);
>  }
>  
> +int packet_flush_gently(int fd)
> +{
> +	packet_trace("0000", 4, 1);
> +	if (write_in_full(fd, "0000", 4) == 4)
> +		return 0;
> +	return error("flush packet write failed");
> +}
> +
>  void packet_buf_flush(struct strbuf *buf)
>  {
>  	packet_trace("0000", 4, 1);
> diff --git a/pkt-line.h b/pkt-line.h
> index 3caea77..3fa0899 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -23,6 +23,7 @@ void packet_flush(int fd);
>  void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int packet_flush_gently(int fd);
>  int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  
>  /*
> 


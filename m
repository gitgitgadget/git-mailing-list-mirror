Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4DF1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 17:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdFIRBL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 13:01:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33158 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdFIRBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 13:01:10 -0400
Received: by mail-pg0-f68.google.com with SMTP id a70so8158887pge.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xL0+GsSsBpiuuTx7v5MYbP0or86JUbrl3Knl7UlCquQ=;
        b=tJPjdQC7nBO9Hlhgb5A+IvsR6lEniOIjjVWvlx5pbu80pe0W1gSo/aDLbEZZ1EyPIF
         AanVZxWcbzoGDGTmvrjKkqk6XWf3V7p+bJNAxYzkg5QdBpvRT3h1aK60S7DFqyhnxQGH
         2spSHvQa0Tqgj8NmPOSougZ0X/kYClpO9ofIhF0Fy+V9Gj/rKkH07EgpqkZIbQiXFqCV
         jzm0TRqFy7VwtSCPHc+OvbQUorwUmrcZm6yKTK0bHOrYZqMs/0QvcIVBRS1dj03tAzoB
         x5ZO+Ecep6yrv1+heCGtsja46yqBMOgblz5QHaPEInfIdb8GV4jgZCv503MwHj1Wb6fE
         Bwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xL0+GsSsBpiuuTx7v5MYbP0or86JUbrl3Knl7UlCquQ=;
        b=JaihY99RTQafUKYuNfnlbVnr3wxQymjXdK2QRPKpQhnw9JuCkZqoKHuON+32Yf+ZJ2
         nyxnyzSsPOG2D02Bj3IZBwmqyq0pEpPTaGOjbvfcbXXck1kioKu7JmUS2zy2rqO9OBEW
         8ZPvVX3QrE2aylGJsYbCzS/2EPZoWwnVjLxNm3EL5GqyTuR1YulsVq5OfHKodNVJb/PL
         zsXKZbJIZGPViOFHrtYtqah/PFe2Ytb8XF3FzESCMNHMAYnN2lDXPp/aiGPzJk9vCMq7
         D53aYtpTAKZbXo9zO1911nBUa0Bwpj+/GM4OtKmbWZgwJmmGDtsoqCs9D2af05pgwTT+
         WaXw==
X-Gm-Message-State: AODbwcAVNSwdxS1u2ixhJbmRYc0rJE1ozKPHbaN5FnbOXxD3KHrmgn4s
        wJSFyECdqKQ8Zg==
X-Received: by 10.98.66.76 with SMTP id p73mr43565595pfa.180.1497027669538;
        Fri, 09 Jun 2017 10:01:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id z4sm3671816pgc.22.2017.06.09.10.01.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 10:01:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] config: report correct line number upon error
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
        <078fd144ddefa22892861488a7d3f48eb8d5b775.1496851544.git.johannes.schindelin@gmx.de>
Date:   Sat, 10 Jun 2017 02:01:08 +0900
In-Reply-To: <078fd144ddefa22892861488a7d3f48eb8d5b775.1496851544.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 7 Jun 2017 18:06:09 +0200
        (CEST)")
Message-ID: <xmqqmv9h5c4r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When get_value() parses a key/value pair, it is possible that the line
> number is decreased (because the \n has been consumed already) before the
> key/value pair is passed to the callback function, to allow for the
> correct line to be attributed in case of an error.
>
> However, when git_parse_source() asks get_value() to parse the key/value
> pair, the error reporting is performed *after* get_value() returns.
>
> Which means that we have to be careful not to increase the line number
> in get_value() after the callback function returned an error.

Sounds sane.

Is this something we can protect easily with a new test or two?

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 146cb3452ad..9b88531a70d 100644
> --- a/config.c
> +++ b/config.c
> @@ -604,7 +604,8 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>  	 */
>  	cf->linenr--;
>  	ret = fn(name->buf, value, data);
> -	cf->linenr++;
> +	if (!ret)
> +		cf->linenr++;
>  	return ret;
>  }

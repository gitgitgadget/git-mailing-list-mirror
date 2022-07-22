Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2FC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 11:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiGVL0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVLZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 07:25:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF2126109
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:25:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g1so5442528edb.12
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+dX+kfn7iR8kSwwWkJniWmpabh6mKoa60nZvmdoiYAU=;
        b=FPrS8rghxK2u0RLceQkVjsD/VhYT7N9vLDVeWkOras1Wff+Vb+mGHIvtdZm4NZyzyy
         Kl0B1oOFxrjQlJRbdz5J6zjgLEyN/H0ktRBteYMrpXo9BCIi5MR4eS/nvE587fWAOLZ2
         mQQ4V7T10z/g5ZwlurkZbCLA9O5uZxHwKt+iriFr+88h3pVHJ+ye7drUPJAG33wBw6od
         7RjvEY/h6Y5lWJd+Lvg8n3Fg/+eQf6cp1KnlQLsiL3M8wk2CaD7g4SQ/pjqPh4SiNWfu
         U/JLoAm2A6sqZ9NZiPJc9NZ4dTky6/BAWPi6EZhOj9Zl30i+or33/FNWEtWik0FH1vm1
         18pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+dX+kfn7iR8kSwwWkJniWmpabh6mKoa60nZvmdoiYAU=;
        b=GAJs+LvfFe/Abw7S3IQeHEKX7F4KMtvTl434NvRE0JxkDrUhEPDlO1WGNuEX0Xvp9s
         wU00OmKLSHjdBXi/sEmSQCV7+LvZovhcIrilqUX7PgofxpjqdL3A9nFtMAcHeyj11/ve
         UO+FIViZpeJ1j2abWDpPW9gmALL0WPnNsvMxL+dkBWK3XTvLXl/OZYTd6FLqENFRLepW
         n4RGc9Xy3kGRHxB5LwXS4AMfUI5RDrXW9VOmlo3Z7V9JYJbr3VT0eMXQot7FWwaYpD+M
         QrxrQPeY1ITR5EkRgXZ4k0JHNKz/P77RGKDk+zZiJ9e4wjyo5ECIbibCjqFPx6CX1IV8
         w5uw==
X-Gm-Message-State: AJIora9+Mq5MJs7A9rnJD3BbnZfVKx9UEva6Z/2tHplQbYf/orpy8seq
        hC9yAOeONGcdRrxa/h67P0mq2RSN58RUZA==
X-Google-Smtp-Source: AGRyM1voTFah5+PoIC5pwm+bRHz3pOUp6fly/kFYqngs3X52OGk0c2E6lQhhtak/FYBpS7W1o3gf+g==
X-Received: by 2002:a05:6402:159a:b0:43b:ba6c:d0e2 with SMTP id c26-20020a056402159a00b0043bba6cd0e2mr117827edv.418.1658489157202;
        Fri, 22 Jul 2022 04:25:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906190b00b0072b2eab813fsm1907105eje.75.2022.07.22.04.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:25:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEqn5-005IiK-UG;
        Fri, 22 Jul 2022 13:25:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pkt-line.h: move comment closer to the associated code
Date:   Fri, 22 Jul 2022 13:19:37 +0200
References: <6a14443c101fa132498297af6d7a483520688d75.1658488203.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6a14443c101fa132498297af6d7a483520688d75.1658488203.git.matheus.bernardino@usp.br>
Message-ID: <220722.867d45s81o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Matheus Tavares wrote:

> ec9a37d ("pkt-line.[ch]: remove unused packet_read_line_buf()",

Nit: "log --pretty=reference" for me emits this length of SHA-1 on a
fresh clone:

	ec9a37d69b (pkt-line.[ch]: remove unused packet_read_line_buf(), 2021-10-14)

In this case ec9a3 is non-colliding, but you might want to adjust
whatever your local alias is to use our default hash length instead of a
presumably hardcoded length of 7 ;)

No need to re-roll for that...

> 2021-10-14) removed the "src_buffer" and "src_len" parameters from
> packet_read(), only leaving them at packet_read_with_status(). Let's
> also update the function documentation by moving the comment about these
> parameters from the former to the latter.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  pkt-line.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/pkt-line.h b/pkt-line.h
> index 6d2a63db23..1f623de60a 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -49,14 +49,6 @@ void packet_fflush(FILE *f);
>   * Read a packetized line into the buffer, which must be at least size bytes
>   * long. The return value specifies the number of bytes read into the buffer.
>   *
> - * If src_buffer and *src_buffer are not NULL, it should point to a buffer
> - * containing the packet data to parse, of at least *src_len bytes.  After the
> - * function returns, src_buf will be incremented and src_len decremented by the
> - * number of bytes consumed.
> - *
> - * If src_buffer (or *src_buffer) is NULL, then data is read from the
> - * descriptor "fd".
> - *
>   * If options does not contain PACKET_READ_GENTLE_ON_EOF, we will die under any
>   * of the following conditions:
>   *
> @@ -104,6 +96,14 @@ int packet_length(const char lenbuf_hex[4]);
>   * returns an 'enum packet_read_status' which indicates the status of the read.
>   * The number of bytes read will be assigned to *pktlen if the status of the
>   * read was 'PACKET_READ_NORMAL'.
> + *
> + * If src_buffer and *src_buffer are not NULL, it should point to a buffer
> + * containing the packet data to parse, of at least *src_len bytes.  After the
> + * function returns, src_buf will be incremented and src_len decremented by the
> + * number of bytes consumed.
> + *
> + * If src_buffer (or *src_buffer) is NULL, then data is read from the
> + * descriptor "fd".
>   */
>  enum packet_read_status {
>  	PACKET_READ_EOF,

This change looks good to me, thanks for catching this & cleaning up
after my change.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261991F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbcIHVYF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:24:05 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33378 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbcIHVYE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:24:04 -0400
Received: by mail-oi0-f42.google.com with SMTP id y2so93995168oie.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=czyqhAP3/6F1i5zno7O1BJ16Ddo5lJ/jsYCQZLRRptM=;
        b=nUKhu2krtE47zW+4Q4BYNc6niE32kdjJuZLjLmpq+vH5bvWY3THQIwiUm6scD1EEvy
         IMnNhrFQjlCfsq5ny9GZQUARB1js5l7Pcohy+JqECp/mbfnwQQQ6CgzWYWReITlakfaK
         KRIogngtW9aQk6lZPM0szO9VcBtIXoO2X6pp4nuVRThGowR+F7Pi2Ckn6KY3eGnVjl51
         9Nwrjfcuo58DFZjZa95J1qZX9oqCma8h8MzmbGxE77ezT5Qepw4j+btZk6zvTy0NZRtj
         u/gqXvbRRt2IxqRL7z8lk5soNVUwv8538TPqPslZL66oRk9d/XFk5Ggj/SQsMWZKS+3a
         mZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=czyqhAP3/6F1i5zno7O1BJ16Ddo5lJ/jsYCQZLRRptM=;
        b=ERGwkNFLVCBrHIEisJCTtRII7mbJtPgB6iRlW4F5l9jsMNoWDS3fj+ZDbR4ymVSRjb
         VyvhTDpLYVInD1YOG0U5jhaxwYzHZEESBKVS/+6RcCmETgljHkHe0xuzJguHLGYU5vus
         u6NyyQez3ou7D7RnYHWDsELhdyuVZCTJtjmPY5VCz+Rh5QQe/Qdgt8TkLXfzQ+q9rXYK
         81EYFN//TLl++iLacjwCgWZiBJEojS9xIJM6QJ03ZaZa5NQ1seqPwTcFZvrp+lZUnWvn
         MLlHG1ZvaKeqIes+x5q0az6wBKSg0Ztq30SGOkFjWCp4nIIAEcfd1GF+OvCW4QxzKFVU
         sZXQ==
X-Gm-Message-State: AE9vXwP6hfwa04Th/5sC1DbLuAYUxaVOMtzC64Zrvkeu0EBhOfUQY8WVHX5IsGnaXIkfLmqASQovNsC2fH/JlXVq
X-Received: by 10.202.195.1 with SMTP id t1mr157725oif.144.1473369843396; Thu,
 08 Sep 2016 14:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 8 Sep 2016 14:24:02 -0700 (PDT)
In-Reply-To: <20160908182132.50788-6-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-6-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Sep 2016 14:24:02 -0700
Message-ID: <CAGZ79kZdroDdD5SHP+-9svSTYbJfn2vsFXAwC4aen3hMVEOOPA@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] pkt-line: add packet_write_gently()
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 8, 2016 at 11:21 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> packet_write_fmt_gently() uses format_packet() which lets the caller
> only send string data via "%s". That means it cannot be used for
> arbitrary data that may contain NULs.

Makes sense.

>
> Add packet_write_gently() which writes arbitrary data and returns `0`
> for success and `-1` for an error.

I think documenting the return code is better done in either the header file
or in a commend preceding the implementation instead of the commit message?

Maybe just a generic comment for *_gently is good enough, maybe even no
comment. So the commit is fine, too. I dunno.


> This function is used by other
> pkt-line functions in a subsequent patch.

That's what I figured. Do we also need to mention that in the preceding patch
for packet_flush_gently ?

>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 37345ca..1d3d725 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -181,6 +181,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
>         return status;
>  }
>
> +int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +{
> +       static char packet_write_buffer[LARGE_PACKET_MAX];
> +
> +       if (size > sizeof(packet_write_buffer) - 4) {
> +               error("packet write failed");
> +               return -1;
> +       }
> +       packet_trace(buf, size, 1);
> +       size += 4;
> +       set_packet_header(packet_write_buffer, size);
> +       memcpy(packet_write_buffer + 4, buf, size - 4);
> +       if (write_in_full(fd_out, packet_write_buffer, size) == size)
> +               return 0;
> +
> +       error("packet write failed");
> +       return -1;
> +}
> +
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  {
>         va_list args;
> --
> 2.10.0
>

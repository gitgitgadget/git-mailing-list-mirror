Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C7E1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 19:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeACT1u (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 14:27:50 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:45195 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbeACT1t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 14:27:49 -0500
Received: by mail-wr0-f178.google.com with SMTP id o15so2631843wrf.12
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OpER2ILIXP00s1E1xb9THf0NG2pWG/hGJkfgl4nJwNQ=;
        b=pHsNdP36NPZryZ+eJ+cSyXTXaCistn2gKkLXepWVjkns/BajZ1CyTnhJOVEVMNM22S
         M32kQLME9JnCpqPisWKWLSYPI+VAgZIkaApe7VKszOQr7Vjq4njF7kuE7ldI/rmcsSbI
         lTitftXQDHiUgCS0dAtRz5R37m2On3qEYW6VkK/ms4LZnta5d8XqHkBDP4iwFHar4vMK
         Zbzn/HlVtwlCkNNO4+rydSWvi7Hl7pm5457VsBmPwUj5qvukOnsqB1kdooDrftN97IZ6
         fs8p/U3EVW5pcJ1RNNpuzqQlMh4QfbUteKSs4TRESnlmlAjWLef8dN4Q7HT5jXYCvl+I
         +MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OpER2ILIXP00s1E1xb9THf0NG2pWG/hGJkfgl4nJwNQ=;
        b=lSts3BNimiDHirl5FpjFeLAvMWaSyriC96zwZg8rBZp/NjcExn/E6oZMnZ2N6OsGhQ
         dX4rOiAkfNMGA5hPkJVtTA8hY4g/swpzGKCGZKW7AivjtIZSMvUQclRcINgmJsgu3/17
         2SURqFf4Nyr7dpZSRFcXjoLW3bx9U+v7XryAv5lQg7gLhJH+Da7WEzzGouqnEXEZSdre
         HSH65eOALUahEc5ZQIxbfaI3Gfw0qkS/lLVTqeIenIyzge6nmBRJZCKH/npXyLHuojts
         FkfuS545kTaqDvjxxpgW2W1jU/APMhKbe6kZxMl7MyzAldXiSf03NlKzH7PdAjxLBP7Y
         yjRQ==
X-Gm-Message-State: AKGB3mJefdO8NDTKmNFd3+imL721lFipwnkKlK/Kax/s/40OHNhciH5M
        s1/z6RYlDJ47f1BZ+BgBlwkuLBynIFE6NmE9geie0V0ATgg=
X-Google-Smtp-Source: ACJfBouRjNN5kXXmr7bxDn3X/TQqOWEQ8nm2lsDjEL92/oowT4E7Dq/1g+9tuU+nck/ZikZtsX0MlAWuLAPf800ukuM=
X-Received: by 10.223.169.231 with SMTP id b94mr2637569wrd.63.1515007667754;
 Wed, 03 Jan 2018 11:27:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.195.101 with HTTP; Wed, 3 Jan 2018 11:27:47 -0800 (PST)
In-Reply-To: <20180103001828.205012-2-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 11:27:47 -0800
Message-ID: <CAGZ79kbd1_nnYEJVN8a_NuwrEfHbT0wiwEfdkUz-kZRdpstqHA@mail.gmail.com>
Subject: Re: [PATCH 01/26] pkt-line: introduce packet_read_with_status
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> The current pkt-line API encodes the status of a pkt-line read in the
> length of the read content.  An error is indicated with '-1', a flush
> with '0' (which can be confusing since a return value of '0' can also
> indicate an empty pkt-line), and a positive integer for the length of
> the read content otherwise.  This doesn't leave much room for allowing
> the addition of additional special packets in the future.
>
> To solve this introduce 'packet_read_with_status()' which reads a packet
> and returns the status of the read encoded as an 'enum packet_status'
> type.  This allows for easily identifying between special and normal
> packets as well as errors.  It also enables easily adding a new special
> packet in the future.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pkt-line.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------------
>  pkt-line.h | 15 +++++++++++++++
>  2 files changed, 57 insertions(+), 13 deletions(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 2827ca772..8d7cd389f 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -280,28 +280,33 @@ static int packet_length(const char *linelen)
>         return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
>  }
>
> -int packet_read(int fd, char **src_buf, size_t *src_len,
> -               char *buffer, unsigned size, int options)
> +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> +                                               char *buffer, unsigned size, int *pktlen,
> +                                               int options)
>  {
> -       int len, ret;
> +       int len;
>         char linelen[4];
>
> -       ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
> -       if (ret < 0)
> -               return ret;
> +       if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
> +               return PACKET_READ_EOF;
> +
>         len = packet_length(linelen);
>         if (len < 0)
>                 die("protocol error: bad line length character: %.4s", linelen);
> -       if (!len) {
> +
> +       if (len == 0) {
>                 packet_trace("0000", 4, 0);
> -               return 0;
> +               return PACKET_READ_FLUSH;
> +       } else if (len >= 1 && len <= 3) {
> +               die("protocol error: bad line length character: %.4s", linelen);

I wonder how much libified code we want here already, maybe we could
have PACKET_READ_ERROR as a return value here instead of die()ing.
There could also be an option that tells this code to die on error, this reminds
me of the repository discovery as well as the refs code, both of which have
this pattern.

Currently this series is only upgrading commands that use the network
anyway, so I guess die()ing in an ls-remote or fetch is no big deal,
but it could
be interesting to keep going once we have more of the partial clone
stuff working
(e.g. remote assisted log/blame would want to gracefully fall back instead of
die()ing without any useful output, I would think.)

>         }
> +
>         len -= 4;
> -       if (len >= size)
> +       if ((len < 0) || ((unsigned)len >= size))
>                 die("protocol error: bad line length %d", len);
> -       ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
> -       if (ret < 0)
> -               return ret;
> +
> +       if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0)
> +               return PACKET_READ_EOF;
>
>         if ((options & PACKET_READ_CHOMP_NEWLINE) &&
>             len && buffer[len-1] == '\n')
> @@ -309,7 +314,31 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
>
>         buffer[len] = 0;
>         packet_trace(buffer, len, 0);
> -       return len;
> +       *pktlen = len;
> +       return PACKET_READ_NORMAL;
> +}
> +
> +int packet_read(int fd, char **src_buffer, size_t *src_len,
> +               char *buffer, unsigned size, int options)
> +{
> +       enum packet_read_status status;
> +       int pktlen;
> +
> +       status = packet_read_with_status(fd, src_buffer, src_len,
> +                                        buffer, size, &pktlen,
> +                                        options);
> +       switch (status) {
> +       case PACKET_READ_EOF:
> +               pktlen = -1;
> +               break;
> +       case PACKET_READ_NORMAL:
> +               break;
> +       case PACKET_READ_FLUSH:
> +               pktlen = 0;
> +               break;
> +       }
> +
> +       return pktlen;
>  }
>
>  static char *packet_read_line_generic(int fd,
> diff --git a/pkt-line.h b/pkt-line.h
> index 3dad583e2..06c468927 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -65,6 +65,21 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
>  int packet_read(int fd, char **src_buffer, size_t *src_len, char
>                 *buffer, unsigned size, int options);
>
> +/*
> + * Read a packetized line into a buffer like the 'packet_read()' function but
> + * returns an 'enum packet_read_status' which indicates the status of the read.
> + * The number of bytes read will be assigined to *pktlen if the status of the
> + * read was 'PACKET_READ_NORMAL'.
> + */
> +enum packet_read_status {
> +       PACKET_READ_EOF = -1,
> +       PACKET_READ_NORMAL,
> +       PACKET_READ_FLUSH,
> +};
> +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> +                                               char *buffer, unsigned size, int *pktlen,
> +                                               int options);
> +
>  /*
>   * Convenience wrapper for packet_read that is not gentle, and sets the
>   * CHOMP_NEWLINE option. The return value is NULL for a flush packet,
> --
> 2.15.1.620.gb9897f4670-goog
>

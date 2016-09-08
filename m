Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1F81F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964993AbcIHVtf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:49:35 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36533 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932473AbcIHVte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:49:34 -0400
Received: by mail-oi0-f51.google.com with SMTP id x125so40205291oia.3
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O1mZzrmxo//xYsSkqV7UK0Qj8S2Hz9+9Xez169eVDvU=;
        b=P02bzsfce8SsBhij6VLfzS8IrgTJEBSI5ZxbryjJnSb4Lemw+au58EIUYnVvOIlu6u
         D/P6Ym9gkXVj46bcYmdSrXBUW51W+2kZXjHXfI9fzuczO6DOxw4lW02FBwIrGorONWmo
         nuk6skTjKTJHRqBf3w3iQAbvk5xll4q0u7QqYbhAtnV5FxqggGbXGCOr6ALIH39suJP+
         jH7MqbK3mH2cgYI56HMtTA0DCgN7g4ZzM1eJGKpJ2QJJLNouRx51bAfbw6ig/d35Mo/k
         C7mdY08IZXVcw5C2gtVQ2CiC1aaPdn6fRge/wbc3e2dRGZq4QIjuZqxKF4JS1udpy9tt
         wuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O1mZzrmxo//xYsSkqV7UK0Qj8S2Hz9+9Xez169eVDvU=;
        b=ZGUvWFLnrk508AJTu0lGvpValHvFrNqL5gTBr5i63QkX8N5ENEccI/+/ww6NQ7mkEs
         25R4q2uvgYWny2KHJwXqmkmbChDTneolsgAV1e0obhbZvW2ZRvGPPOnbS8OErb3py2Po
         ChZkWjpVEh96Gudy0T6W6oekbuSfu0f65WlPzTvnB/BAG5O+yec4exbjEW23/76N3J1f
         MFc21G0iLQEdwcK8Un+HDHLFHfv7SvJ4T03P8oPQE5w7+hXijlgpFOr0v7B2Z7wyr86d
         +H//wYEhrr4Vo52JY/xHf6svK3o+sGo4vS1/FbCmIbeQAFjl76IDOQgdWgQNPEHjlWB0
         ulYg==
X-Gm-Message-State: AE9vXwPYEZPQfDrYrCT27BpoY2v7mE5RRLMufFbn4gQNsKz0PhvKRltzf0Yb0M0h6JGjKghqbwcC3NcnmkBk75sB
X-Received: by 10.202.97.2 with SMTP id v2mr209551oib.157.1473371373397; Thu,
 08 Sep 2016 14:49:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 8 Sep 2016 14:49:32 -0700 (PDT)
In-Reply-To: <20160908182132.50788-7-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-7-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Sep 2016 14:49:32 -0700
Message-ID: <CAGZ79kYHX6-hhKW_6JEd1hBNi8R+sBY-RjZARfHDMnyLKFZnsQ@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] pkt-line: add functions to read/write flush
 terminated packet streams
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
> write_packetized_from_fd() and write_packetized_from_buf() write a
> stream of packets. All content packets use the maximal packet size
> except for the last one. After the last content packet a `flush` control
> packet is written.

I presume we need both write_* things in a later patch; can you clarify why
we need both of them?


> +       if (paket_len < 0) {
> +               if (oldalloc == 0)
> +                       strbuf_release(sb_out);

So if old alloc is 0, we release it, which is documented as
/**
 * Release a string buffer and the memory it used. You should not use the
 * string buffer after using this function, unless you initialize it again.
 */

> +               else
> +                       strbuf_setlen(sb_out, oldlen);

Otherwise we just set the length back, such that it looks like before.

So as a caller the strbuf is in a different state in case of error
depending whether
the strbuf already had some data in it. I think it would be better if
we only did
`strbuf_setlen(sb_out, oldlen);` here, such that the caller can
strbuf_release it
unconditionally.

Or to make things more confusing, you could use strbuf_reset in case of 0,
as that is a strbuf_setlen internally. ;)

> @@ -77,6 +79,11 @@ char *packet_read_line(int fd, int *size);
>   */
>  char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>
> +/*
> + * Reads a stream of variable sized packets until a flush packet is detected.

Strictly speaking we read until a packet of size 0 appears, but as per
the implementation
of packet_read we cannot distinguish between "0000" and "0004", i.e.
an empty non-flush
packet. So I think we're fine both in the implementation as well as
the documentation here.

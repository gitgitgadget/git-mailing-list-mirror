Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60111F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbcIHVSl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:18:41 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34965 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcIHVSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:18:40 -0400
Received: by mail-oi0-f49.google.com with SMTP id s131so90931993oie.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Jl85Z4OFB/6hYcjLnhuTw1v/NnyjAKa8LzWPbRRQQI=;
        b=Xxann0oOJhsjr3obwfua0yaGHkBYtBgkDDQ9FxIIlsEmCnl5A4rTwmyrEbBvz9cNgY
         qOwgcRWaTpPC6benmpMja9YrwtYQ7da6ILLhB45tjHk4X+26v5WUgV1ZUEBAW6urlYvw
         fDP6lOjjOSCaPhVZnT90Eyex1MB66cpVrQ+2zkxUpzZBXkGC2dxqJJn3RMOBrx3j0jC0
         HHfpkogjgvM67c218trOEm4/YDKYIkUg2zWkJ0VzDge2+pgWivPFVXFN37ruAzCMQMls
         mJylXYTPitFiRzMiNF66KOoJf5a1Q1CHbRrUKxjVMJl9dKHIeiiLy/EgVDFQkGWLnza9
         qnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Jl85Z4OFB/6hYcjLnhuTw1v/NnyjAKa8LzWPbRRQQI=;
        b=X/w4xylALzB+zlswK/g85ujZtg7gmoxXfUkmaHEjC0vu5DbSVJYjqV+3j0ZCejTc2G
         /lBn/UXHGR7aAo5WCYjGbnsBEdTstbGv7lvC9/XjgtaZQHYetX/t8c0vx5Y8IyXzvdya
         AwcZEHNNZLu1tJzP6GKZqkalcsKosttzhFRwXkTySSJhSWTcPsSVPvqwAS+QdxowsorQ
         1R0PEJs7/QWvWWwUerC7i4+EkRK2H7AjenF2HzrRBpQwR0XwW4VmdLjS+fJCvv5ph8dX
         JHbU2M4DdsAJq7LTj2urdH9q+b74XsQ2DRp8pDMVkxPqYEoF2us9XC6jMzOGjez5OTmS
         vyGg==
X-Gm-Message-State: AE9vXwMGjlp/dRhvjW0nxYIBiES384PmcHeMA+QTpErKEFxEv/W2Vt420o0iusawc6tZnppz2ZmAUc3DQ3frlyy8
X-Received: by 10.202.214.2 with SMTP id n2mr35279oig.167.1473369517724; Thu,
 08 Sep 2016 14:18:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 8 Sep 2016 14:18:37 -0700 (PDT)
In-Reply-To: <20160908182132.50788-4-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-4-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Sep 2016 14:18:37 -0700
Message-ID: <CAGZ79kY0GaWuuh_MzKL6FZ7KWF2Kwhfh9qnEYd-qX8VDQWNmCQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] pkt-line: add packet_write_fmt_gently()
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

> +static int packet_write_fmt_1(int fd, int gently,
> +                              const char *fmt, va_list args)
> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       size_t count;
> +
> +       format_packet(&buf, fmt, args);
> +       count = write_in_full(fd, buf.buf, buf.len);
> +       if (count == buf.len)
> +               return 0;
> +
> +       if (!gently) {

    call check_pipe from write_or_die here instead of
    reproducing that function?

> +               if (errno == EPIPE) {
> +                       if (in_async())
> +                               async_exit(141);
> +
> +                       signal(SIGPIPE, SIG_DFL);
> +                       raise(SIGPIPE);
> +                       /* Should never happen, but just in case... */
> +                       exit(141);
> +               }
> +               die_errno("packet write error");
> +       }
> +       error("packet write failed");
> +       return -1;

I think the more idiomatic way is to

    return error(...);

as error always return -1.

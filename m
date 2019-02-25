Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035F220248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfBYXpc (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:45:32 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44658 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBYXpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:45:32 -0500
Received: by mail-pg1-f178.google.com with SMTP id j3so5222429pgm.11
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjifFblatUgbqztjSErI3IbCH+sbcBqQE6t/9wcKTn8=;
        b=malRHzW4pgPrNH9AkJ97Jnmj4HCdVw7T+2Yo9k4AS2rGrNEsAk1fjk9itQi8bcv3Cz
         e2+YdDN5Kl0VKn1ELBDD2Z3dmej2nnGpBZ7G9nG36CuAF7NVwTnnL/lIq7Mv/EHcFQmR
         CRL/xonlLqTqRNbBvNWyicncnq5przwbR0gQ7A4yuGiELNQmZNOBpMMh1UU1466DiPNr
         jWL3VcN2emk8YrHRqlrF5m93Q8GFJyajRpkWWmE3Wx8tO0qMXTiGCDJeZkKSiArI2/bo
         9DHEbf5yegungP+C9Mj2vqHlgq72cL6vQBFNnXYALJRETf34IgYfWl3QQovLR76KD5Qv
         nCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjifFblatUgbqztjSErI3IbCH+sbcBqQE6t/9wcKTn8=;
        b=gJ56sK4SUxhToFPcr73ffIs8dxuiuby6LpuUWgSAmIBW3axYZ6XsL9e52Xtrkpoj3J
         CzDkOh9gLitp6GYuWoBtJWbguHSFinMDdG3OEg44aZi6I7V5dVI39FvgXfAW1pY5jJK4
         qwh88K6o5qDhz8R4SFJPiXhuTB3djUBFuUTuUi1gDiVtvXkjDe8zZOwsMednqCWa0mBg
         JEUmnTzDPWfuGbqNpObNIZl0xFvJg+28i2nonrpCYK3fm8le0NNp5wAFjtxF7ojkzil2
         PMqt6MwzTY0TE7520hGOfX4KHjcoJXW4c3AW+CTa+a/MdvXntZHtqBU96kjBMqFl6hKV
         efTw==
X-Gm-Message-State: AHQUAubWHciDcnYRDPwMtH8VHRx/bccquqzuQkzIEQTG455J+nlq6mdY
        byQGMbF1imvbzuMvJ59omYw=
X-Google-Smtp-Source: AHgI3IbLfjdwvyI5A4wXZfuS8H9FwuGoGECnufsJIRs9z8PqgJA8IYieZ1RE/BZhTTypYsBvVX54jw==
X-Received: by 2002:a65:43c1:: with SMTP id n1mr21803525pgp.248.1551138330953;
        Mon, 25 Feb 2019 15:45:30 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id s4sm6489184pfe.16.2019.02.25.15.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:45:29 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:45:28 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [WIP 0/7] CDN offloading of fetch response
Message-ID: <20190225234528.GD16965@google.com>
References: <cover.1550963965.git.jonathantanmy@google.com>
 <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:
> On Sun, Feb 24, 2019 at 12:39 AM Jonathan Tan <jonathantanmy@google.com> wrote:

>> There are probably some more design discussions to be had:
>
> [...]
>
>>  - Client-side whitelist of protocol and hostnames. I've implemented
>>    whitelist of protocol, but not hostnames.
>
> I would appreciate a more complete answer to my comments in:
>
> https://public-inbox.org/git/CAP8UFD16fvtu_dg3S_J9BjGpxAYvgp8SXscdh=TJB5jvAbzi4A@mail.gmail.com/
>
> Especially I'd like to know what should the client do if they find out
> that for example a repo that contains a lot of large files is
> configured so that the large files should be fetched from a CDN that
> the client cannot use? Is the client forced to find or setup another
> repo configured differently if the client still wants to use CDN
> offloading?

The example from that message:

  For example I think the Great Firewall of China lets people in China
  use GitHub.com but not Google.com. So if people start configuring
  their repos on GitHub so that they send packs that contain Google.com
  CDN URLs (or actually anything that the Firewall blocks), it might
  create many problems for users in China if they don't have a way to
  opt out of receiving packs with those kind of URLs.

But the same thing can happen with redirects, with embedded assets in
web pages, and so on.  I think in this situation the user would likely
(and rightly) blame the host (github.com) for requiring access to a
separate inaccessible site, and the problem could be resolved with
them.

The beauty of this is that it's transparent to the client: the fact
that packfile transfer was offloaded to a CDN is an implementation
detail, and the server takes full responsibility for it.

This doesn't stop a hosting provider from using e.g. server options to
allow the client more control over how their response is served, just
like can be done for other features of how the transfer works (how
often to send progress updates, whether to prioritize latency or
throughput, etc).

What the client *can* do is turn off support for packfile URLs in a
request completely.  This is required for backward compatibility and
allows working around a host that has configured the feature
incorrectly.

Thanks for an interesting example,
Jonathan

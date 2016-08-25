Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0391F859
	for <e@80x24.org>; Thu, 25 Aug 2016 18:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756044AbcHYSqg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 14:46:36 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38015 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755778AbcHYSqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 14:46:14 -0400
Received: by mail-it0-f52.google.com with SMTP id n128so106374602ith.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yunxnGUxgoFQDjXViPT+6bKi6GZddn2WNkagNUuvcLA=;
        b=ZGuE2tUAaDLxj6pouSePu5rm8UANazZ9rcjyDbZqjdtSdYANkA3Ym762KMAidU3yXB
         uZNPcDOMaKOajCDayD2MLR0PIEIXev8rqeyj98snriIdz3zmRwAUkE/ItDOoP66qswcV
         BR7L0surpfhylj7gdMcONwyIcIpXQK+0xDnyToxd81UcxXJ2hkp8423xxQ/d7oooEwmo
         kdK8rdvt6qEdlQ3qSnrHAOKo47hgTq5jvjDVxEXWGA+duIRQ/3Bsf0UE8KcoPLbnQ/1R
         nUr6GeMDAqGyxNMQtzDMFk6eAOZ96mvFI9FpzOij1cCG2GuX6PeT/VnK89Iujk4w56GR
         4UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yunxnGUxgoFQDjXViPT+6bKi6GZddn2WNkagNUuvcLA=;
        b=ZnVo9Ij/glPqyg4k6oaRtTmQNk7YSwkLv3b1wpYRixXfoWNs/y1ooEd0l3qcFlPoZV
         AHf+NAwG7g+G685TY7losLDBYPkndhikXjVkBBC6jb35w9aFCnxfo5+ahmkilakqeIIS
         k8oeCAXrSbQeND+9gb++1F+vmkv0l846N4zhzmlzIOHmkphEjD0JSNbUs4x5zBHqvkrJ
         8OSK4CLfkGOTCoZ0HXLaoVDql+omLwVDVdLIVEgYdYjAFS3p3NO0eZ1Rx+8BHkiMsZHT
         taaQpsvEWihTKVlzxr7wUv/l04NDlCZlUEyRphIxf0JGxrGvK7iPQekJWgt6/nQDNM0+
         jRkA==
X-Gm-Message-State: AE9vXwPEbIEbKX4EsiSFIbiRDvAmX3Bw3VjG9DorvHOSOS4xSEM91vJPLF94DFooUrkF/FQAg4V4cGyzcPztpAN9
X-Received: by 10.36.189.76 with SMTP id x73mr6436378ite.97.1472150767085;
 Thu, 25 Aug 2016 11:46:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 25 Aug 2016 11:46:06 -0700 (PDT)
In-Reply-To: <20160825110752.31581-7-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-7-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Aug 2016 11:46:06 -0700
Message-ID: <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush
 terminated packet streams
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 4:07 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> packet_write_stream_with_flush_from_fd() and
> packet_write_stream_with_flush_from_buf() write a stream of packets. All
> content packets use the maximal packet size except for the last one.
> After the last content packet a `flush` control packet is written.
>
> packet_read_till_flush() reads arbitrary sized packets until it detects
> a `flush` packet.

So the API provided by these read/write functions is intended
to move a huge chunks of data. And as it puts the data on the wire one
packet after the other without the possibility to intervene and e.g. send
a side channel progress bar update, I would question the design of this.
If I understand correctly this will be specifically  used for large
files locally,
so e.g. a file of 5 GB (such as a virtual machine tracked in Git), would
require about 80k packets.

Instead of having many packets of max length and then a remainder,
I would suggest to invent larger packets for this use case. Then we can
just send one packet instead.

Currently a packet consists of 4 bytes indicating the length in hex
and then the payload of length-4 bytes. As the length is in hex
the characters in the first 4 bytes are [0-9a-f], we can easily add another
meaning for the length, e.g.:

  A packet starts with the overall length and then the payload.
  If the first character of the length is 'v' the length is encoded as a
  variable length quantity[1]. The high bit of the char indicates if
  the next char is still part of the length field. The length must not exceed
  LLONG_MAX (which results in a payload of 9223 Petabyte, so
  enough for the foreseeable future).

  [1] A variable-length quantity (VLQ) is a universal code that uses
  an arbitrary number of bytes to represent an arbitrarily large integer.
  https://en.wikipedia.org/wiki/Variable-length_quantity

The neat thing about the packet system is we can dedicate packets
to different channels (such as the side channels), but with the provided
API here this makes it impossible to later add in these side channel
as it is a pure streaming API now. So let's remove the complication
of having to send multiple packets and just go with one large packet
instead.

--
    I understand that my proposal would require writing code again,
    but it has also some long term advantages in the networking stack
    of Git: There are some worries that a capabilities line in fetch/push
    might overflow in the far future, when there are lots of capabilities.

    Also a few days ago there was a proposal to add all symbolic refs
    to a capabilities line, which Peff shot down as "the packet may be
    too small".

    There is an incredible hack that allows transporting refs > 64kB IIRC.

    All these things could go away with the variable length encoded
    packets. But to make them go away in the future we would need
    to start with these variable length packets today. ;)

Just food for thought.

Thanks,
Stefan

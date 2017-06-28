Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE22F2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbdF1UAM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 16:00:12 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35832 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdF1UAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 16:00:10 -0400
Received: by mail-pg0-f50.google.com with SMTP id j186so36639448pge.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5jNP/05RdrmJbE4R7aVTzpz3uWG8MzPldXmEUytxl9E=;
        b=bsE+ovU9jQcssqInHcoqUCetHHGu+HPIkz5MOmHXNUTSMeke/ubFmRPgqzsloalUt3
         lLEF6pCKVcwPXyuXGr1e6EecGE1+pdM/M+d4Xie1zBEO13PbRga+ftNTOoGGhrbjpwoj
         6/M1/1nEt2JLFVtdwG4f6hshlNdEY7bRkZZKI4jloNJNqVpMk1TfLYmbFFCJwnABAt2N
         C6ZLd5a+VJy8nbjHLy//ew7vO1dcwEOXiY8fpXLXDe0Qr4m99zKo+oBqQndnaeFfp2J+
         p4SPc2C+uPQoY+QnfU3RBA5IzQI1IPpZBBLx087srFO51TwmqRyN4c+wnaBb1mexTipL
         gTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5jNP/05RdrmJbE4R7aVTzpz3uWG8MzPldXmEUytxl9E=;
        b=WZq4eAX7Vyvro+qQUEqNOGVsC6jOBpfU+MAtStqtHh0kTjU8dL7743FTvC71Y9LNbt
         hlZAYH7ngrWa3pEhup0P1ms1/+YazRqQFY+SP4zUXTaifkw83a06GU9kJXKzFfwpG2FI
         bchMFw6Rmx0ubMBd2dck/9fQ4WTP7cKoLI1852aRtgPCbuM+gOFiXDPUyN90WHXjbh/6
         LuV7Zz4wPjj6krhdRuS+v/rP62vwzpQprBabBR6TeEeXbXGvQHl9/Mg27mYXEuumy2rY
         Cb+lpQVY8Vv0kSHeLlm6Re9H62CmNvNBA/N6sstMlLcw2VF2CdyKTrs7M961yeI5vbBL
         K69w==
X-Gm-Message-State: AKS2vOx/GeUq6mueiu4rZItXI9X3yJkR7Pz8TuLjOc2f0y86FdwqnfWi
        5hJzZHCAtdA/RSx1/lO/+Qw8seOVTsY/
X-Received: by 10.98.19.136 with SMTP id 8mr12509091pft.105.1498680009896;
 Wed, 28 Jun 2017 13:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 28 Jun 2017 13:00:09 -0700 (PDT)
In-Reply-To: <xmqqwp7wyei3.fsf@gitster.mtv.corp.google.com>
References: <20170628005651.8110-1-sbeller@google.com> <20170628005651.8110-6-sbeller@google.com>
 <xmqqwp7wyei3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Jun 2017 13:00:09 -0700
Message-ID: <CAGZ79kYXzMkO0jtAbCS3f57NtXFHqxVtFUVgq=wNC8PDrfa1dA@mail.gmail.com>
Subject: Re: [PATCH 5/6] diff.c: omit uninteresting moved lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> It is useful to have moved lines colored, but there are annoying corner
>> cases, such as a single line moved, that is very common. For example
>> in a typical patch of C code, we have closing braces that end statement
>> blocks or functions.
>>
>> While it is technically true that these lines are moved as they show up
>> elsewhere, it is harmful for the review as the reviewers attention is
>> drawn to such a minor side annoyance.
>>
>> One of the first solutions considered, started off by these hypothesis':
>
> Hypotheses is the plural form of that word, I think.
>
>>   (a) The more blocks of the same code we have, the less interesting it is.
>>   (b) The shorter a block of moved code is the less need of markup there
>>       is for review.
>>
>>       Introduce a heuristic which drops any potential moved blocks if their
>>       length is shorter than the number of potential moved blocks.
>>
>>       This heuristic was chosen as it is agnostic of the content (in other
>>       languages or contents to manage, we may have longer lines, e.g. in
>>       shell the closing of a condition is already 2 characters. Thinking
>>       about Latex documents tracked in Git, there can also be some
>>       boilerplate code with lots of characters) while taking both
>>       hypothesis' into account. An alternative considered was the number
>>       of non-whitespace characters in a line for example.
>
> It was puzzling what the above two paragraphs were.  I took (a) and
> (b) were the hypotheses, and the two above, and also the next
> paragraphs, were the design that fell out of them.  But that is not
> what is happening.  You changed your mind and settled on the design
> in the next paragraph.

Yes, I somehow want to say:

  "What is implemented in this patch is stupid. And I know it, but I
   know no smarter idea. This is what I thought was smarter, maybe
   someone in the future can be inspired by this, at least."

> Perhaps we can do without all of the "I thought about this but it
> didn't make sense" that is longer than the solution in the patch?

As I do changes based on your responses, I want to squash
these patches sent out last night into the original patch, so I'll butcher
the commit message to be way smaller

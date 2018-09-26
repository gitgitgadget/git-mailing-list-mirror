Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5571F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIZX3e (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 19:29:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbeIZX3d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 19:29:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so27776145wrr.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f73lYZm4jTg5mcp9y7gL7pO4PHqoxykd6IhSBuFOr+w=;
        b=OCifc8tT2ZbBu/R9OruZv/tNzA411RcgbN/OifIXikk+lpyGwKoEy3gtG3NSsUhek5
         i3YHAZFjOhC54zDGAzWrcvtmV5NGM+/vCuGVXv/SDzA1M+5yRhw4IRhpBdFZGWdh1Tf8
         qYnAyhkdz0dkV4MiUaBtBmW9JpIXYKbrHfRu2jXw6pt32scB/EMdlacIvrxflgMev0aB
         M/1OEstk37htqgVAusXrTOkKC81rlXzxwOIJBji+PRiKBFFeTlHkQuNEJbJwOU5zzGns
         2gMBHDugxvkMAyFhOE2yb9+c0li/wHuJrEbERqB+ilf32Rk15gOIKLd3IrwtyKEOVW2r
         j4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=f73lYZm4jTg5mcp9y7gL7pO4PHqoxykd6IhSBuFOr+w=;
        b=FJ5epchQS8UuEOaUj1CzssTSW/HjQAk8oymca4D9BymrSy08c0J+031z5kyi/ChwTF
         jAwBZRKVj/uVAOQzIhYWmTbCNqqorkGD6mdFVkUy5QuorCX94mHW2hUqERip8AUy2tcL
         BEyJqjX4tHOfxP5lnDPw1+W1LjowkKRi1Q7OnXRepDM1/UlpgkBG2kMsVoybtBMv5pcv
         ySFSxFTNxUnYYyX3cBtgB4/dDajmCfOFW/ZzCAn4bp+eSfWaYisKbYAEYevVpNI+hadZ
         HaSdqfep9hggZWfq352ywoOl4aH5cS2WfGxuu1MEaNRSUCtIYR0435tnqjwZJvPsrAqQ
         Cmpw==
X-Gm-Message-State: ABuFfoiakSbSpUePLY1IomnLN08o3ZK0zhiwFV5QhpaQgdQltkNErLFu
        zwGgmp2NQm3JWujoJQuEyr4=
X-Google-Smtp-Source: ACcGV61XJ7gLU73faMs9uyF9doHBpSlNk6zIHpuCBhVwtIZCYMfDEFN+VP8mamKSJWRUfvQ1gdXXVg==
X-Received: by 2002:adf:ab13:: with SMTP id q19-v6mr2073457wrc.62.1537981811359;
        Wed, 26 Sep 2018 10:10:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v6-v6sm5567034wro.66.2018.09.26.10.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:10:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
Date:   Wed, 26 Sep 2018 10:10:10 -0700
In-Reply-To: <20180926041517.GA2140@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 26 Sep 2018 00:15:17 -0400")
Message-ID: <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 25, 2018 at 12:26:44PM -0700, Stefan Beller wrote:
>
>> On Sat, Sep 22, 2018 at 5:58 AM Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>> >
>> >
>> > On Fri, Sep 21 2018, Stefan Beller wrote:
>> >
>> > > +/*
>> > > + * Apply want to each entry in array, retaining only the entries for
>> > > + * which the function returns true.  Preserve the order of the entries
>> > > + * that are retained.
>> > > + */
>> > > +void oid_array_filter(struct oid_array *array,
>> > > +                   for_each_oid_fn want,
>> > > +                   void *cbdata);
>> > > +
>> > >  #endif /* SHA1_ARRAY_H */
>> >
>> > The code LGTM, but this comment should instead be an update to the API
>> > docs, see my recent 5cc044e025 ("get_short_oid: sort ambiguous objects
>> > by type, then SHA-1", 2018-05-10) for an addition of a new function to
>> > this API where I added some new docs.
>> 
>> ok will fix for consistency (this whole API is there).
>> 
>> Longer term (I thought) we were trying to migrate API docs
>> to headers instead?
>
> Yes, please. I think it prevents exactly this sort of confusion. :)

CodingGuidelines or SubmittingPatches update, perhaps?

 Documentation/CodingGuidelines | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfbd..b54684e807 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -358,7 +358,11 @@ For C programs:
    string_list for sorted string lists, a hash map (mapping struct
    objects) named "struct decorate", amongst other things.
 
- - When you come up with an API, document it.
+ - When you come up with an API, document it.  It used to be
+   encouraged to do so in Documentation/technical/, and the birds-eye
+   level overview may still be more suitable there, but detailed
+   function-by-function level of documentation is done by comments in
+   corresponding .h files these days.
 
  - The first #include in C files, except in platform specific compat/
    implementations, must be either "git-compat-util.h", "cache.h" or

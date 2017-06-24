Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002D020401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755257AbdFXSv6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:51:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35198 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbdFXSv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:51:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so12260949pfs.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+TfafXsk+Bwvtf6IAOilEGbx0U8SKnSvLmPlWnXQiG0=;
        b=put22KUecc3azHOyqb7NCCS66R9nM/1RYl2fZtqhf2dBKwFfQC/ULZgtsxu1Oqy1bf
         zE5xX/9PIZY+8SNTOfQ5/+Nub+W5TUWauh3PhQzvSB9ubtVsyEU5J6hTJm77U74/hRu+
         NELOstJYBy+v72vvuDx0/N60+PG7Q7Y8y3BuM/YOUiUNkqa/s/0Lf6+4NHO37imVBKi8
         QlQ3pNMKnNKmsQXLf+UfBBaCGDYEKQVKdmRA/bXQEadj6bwrjAly05YPvv/BeD9ncfyJ
         K0V4CMAugx8KCLNbunU6C5fy9k0eK1AMTuWEYw1ctVr67tk4Zti4mUj03elz/ha/IjwY
         YfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+TfafXsk+Bwvtf6IAOilEGbx0U8SKnSvLmPlWnXQiG0=;
        b=Poe17YUQy7BlEOF4hVbdUjbh+l1bEIk9EJO6bRYGCHaklgQj+JpHCzH8Ghv/cWPTV3
         XtzAi/VekQRfOEPv19pKf7dJpT02IUFDkYX6e4qfnwHAbMTrFjWc+mI2PueHuE4gF87g
         K1g4CNuzV8kmqwU3QF37e4fMGbpWhdhqCsMf7Z1cRnjegO5udD+69lXxwjhopFSp8Fom
         c8EkQrvHupcr1tnJGVUE7Oq+ds9kPkL9484Gx8dgAc+0sO9zo9oNZkSvr44XR8LNqPAU
         PZamEUJWFe9Q0Rr3uXlp2QdaImfuo9tRPVOOLhTS6IsLcBRdj04Ngg/sJ47LOemagwUx
         jhMQ==
X-Gm-Message-State: AKS2vOyjqsC+WocyPk6T9j0PvobIXXthjwef6feJ/yDd0ZWHJmnpicVq
        hH/8iL+NZKczDg==
X-Received: by 10.84.229.13 with SMTP id b13mr15751120plk.1.1498330311048;
        Sat, 24 Jun 2017 11:51:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id j24sm17463969pfk.78.2017.06.24.11.51.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 11:51:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, tboegi@web.de,
        e@80x24.org, ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 5/5] convert: add "status=delayed" to filter process protocol
References: <20170601082203.50397-1-larsxschneider@gmail.com>
        <20170601082203.50397-6-larsxschneider@gmail.com>
        <20170624141941.usy2pyhid3jrf3ku@sigill.intra.peff.net>
        <A8FAEFDC-1ADA-4355-80DC-069A739F829C@gmail.com>
Date:   Sat, 24 Jun 2017 11:51:49 -0700
In-Reply-To: <A8FAEFDC-1ADA-4355-80DC-069A739F829C@gmail.com> (Lars
        Schneider's message of "Sat, 24 Jun 2017 19:22:40 +0200")
Message-ID: <xmqq37ap9q2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 24 Jun 2017, at 16:19, Jeff King <peff@peff.net> wrote:
>> 
>> Speaking of which, _are_ we OK with out-of-order processing in things
>> like checkout? Certainly we care about deleting items before checking
>> out new ones (so getting rid of "foo/bar" to make room for "foo" and
>> vice versa).  I guess it's OK as long as the delayed items are always
>> filters that check out new items.
>
> Junio noticed that too but thinks we should be OK:
> "[...] We checkout removals first to make room so
> that creation of a path X can succeed if an existing path X/Y
> that used to want to see X as a directory can succeed [...]"
>
> http://public-inbox.org/git/xmqqvavotych.fsf@gitster.mtv.corp.google.com/

In which I said

   ...  I
   think "remove all and then create" you do not specifically have
   to worry about with the proposed change, but you may need to
   inspect and verify there aren't other kind of order dependency.

Yes, I think having two separate loops in the caller can help
guaranteeing this, as long as the delayed items are always filters
that check out new things.  It will break once you have delayed
removals but I do not see how such a thing would be necessary ;-)

But there may be other kinds of order dependency--I didn't look for
them.

>>> @@ -647,6 +653,14 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>>> 	if (err)
>>> 		goto done;
>>> 
>>> +	if (CAP_DELAY & entry->supported_capabilities &&
>>> +	    dco && dco->state == CE_CAN_DELAY) {
>> 
>> In a complicated conditional with bit operations, we usually put the bit
>> operation in its own parentheses so it's more obvious that it wasn't
>> supposed to be "&&". Like:
>> 
>>  if ((CAP_DELAY & entry->supported_capabilities) &&
>>      dco && dco->state == CE_CAN_DELAY))
>
> Agreed!

Why wasn't this caught earlier?  I thought this is something gcc warns about.

>> The operator precedence is such that it works without them, so this is
>> just a style question (I'd also usually put the flags field before the
>> flag itself, but that's really getting into aesthetics).
>
> You mean (entry & CAP_DELAY) instead of (CAP_DELAY & entry)?

Peff is continuing his explanation why (A & B && C) is technically
correct and preferring ((A & B) && C) is purely stylistic.  "A & B"
binds tighter than "something && C" which means that (A & B && C)
cannot be misinterpreted as (A & (B && C)).


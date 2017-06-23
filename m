Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126E220282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755197AbdFWUZI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:25:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33857 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755191AbdFWUZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:25:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so8894482pfe.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PcizUdbRlKqvX+POdpi8kd3nu+y754Az2E4YCE7SRfM=;
        b=Gi8WxijrwXm02PBAmnKplVPtZWiRhL/0RPZoiKmCt+j/omuuVdwk8+sWxnK1A8AgAq
         lsqi23iCiZ5VMVBjWTGHinPSXuDXJRd69X2fCwYnkqowTK4DK/fe6xvzk5e1nO1yTBtx
         beks1/u3coTaOJYro8pGHD8DlKM4lvmYjA1t7Ya2uTgLPZ9Jvpt4RoyzQ+kzieFViM88
         JdMncZA02v1rHRjg45XeBt6f0jSD+m8pQd6NyM1OyGGJayvKWU5f6Igrf9pJEyawMQC4
         LhehbtYoIvfm9LIAx6vF2LvWBhwhHRWTBDdT4ZhgbDwhpXYaykHKHCe8SBP+EXyiNAol
         cdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PcizUdbRlKqvX+POdpi8kd3nu+y754Az2E4YCE7SRfM=;
        b=icKjnMcDYqkYRpGfoMkLzeGurF1HB3pVDF2U42eB2OoF1GGU8Lus5QaTnuvgYYuhBx
         o2zHX0coI3VfYZ8DEqmNnpHohcXXDjjx64H7n6uh+yZW1lYUywmd8Gmp+3HOJitBhQJd
         4K7851NdD7AvqNDogKEGwweFPdeGhf8nkbVjN1xA5SqgE5QgCx7+fr0Y1zH3I8/5ceP2
         XYbeYSVRAQY0QchxOwBJ/fSHaPRM+03Bi237viglNidopkMMaodX3Ar0Qwr7sHkrYUU7
         oeUEPkR6XPk7mqvFm+zNQ3rWrtb3Rk3j4D7Ce/YvAw6bDIIWPu5pKlM9cRQBG3aMFUZh
         zoHQ==
X-Gm-Message-State: AKS2vOxyuQPNvi9wo5m5NgPQrYeJon7/8m17eZwFyA5uBshtfqJz4XF3
        TIlAig7NX2DJzg==
X-Received: by 10.99.47.69 with SMTP id v66mr10133037pgv.47.1498249505359;
        Fri, 23 Jun 2017 13:25:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id g10sm12349079pfc.38.2017.06.23.13.24.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 13:24:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Create a reference backend for packed refs
References: <cover.1498200513.git.mhagger@alum.mit.edu>
        <20170623190159.5ct2mgjcm6vuulz6@sigill.intra.peff.net>
Date:   Fri, 23 Jun 2017 13:24:58 -0700
In-Reply-To: <20170623190159.5ct2mgjcm6vuulz6@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 23 Jun 2017 15:01:59 -0400")
Message-ID: <xmqq1sqae9k5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 23, 2017 at 09:01:18AM +0200, Michael Haggerty wrote:
>
>> * Change patch 17 "packed_ref_store: support iteration" to always
>>   iterate over the packed refs using `DO_FOR_EACH_INCLUDE_BROKEN`.
>>   This switches off the check in the packed-ref iterator of whether a
>>   reference is broken. This is now checked only in
>>   `files_ref_iterator_advance()`, after the packed and loose
>>   references have been merged together. It also saves some work.
>
> I'm curious why you prefer this solution to just removing the code
> entirely. Wouldn't it be an error to call the packed ref iterator
> without INCLUDE_BROKEN? The "entries may not be valid" thing is a
> property of the packed-refs concept itself, not a particular caller's
> view of it.

Thanks for pointing it out.  I was wondering about the same thing
and you phrased it a lot more succinctly than the draft I was
writing.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A393720401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbdFUVns (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:43:48 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36101 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdFUVnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:43:47 -0400
Received: by mail-pg0-f53.google.com with SMTP id u62so63009530pgb.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8kwKJv0lec4Tr5cNLvzevkmYndVo93gH9qRKzz+wE0s=;
        b=SofHrSJki2rEm+8fO3gbvfjxgq5cHNtEkYGQzLC0vzRd+/q/Kp0QpB3CXqmYQS9sXF
         0qc1MSXzwOzgTTi8figgyERRFodnyDRq+nKNV0LtcGMs84tZx7F/CE8rkcoJWf7foWL4
         xh0XwAQkM9jMHHzmXIRrqaeh6sJ+iPEsVnWzUEDWYwvjZpzBxUyxkcu7IWUgn7JY0gEB
         vnZE9ZitAlARxHXZOwhcYqx7oa1+SvEkXYDZ/nKX4qWcni5tvaps/muZMP2jK71uixmb
         /w49YsSKNOC7Owsn8HgBGsX9ex1vMUR9gLMu/UqKy5mzehrzamRJqK/wJ/2khHyYnlI4
         z/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8kwKJv0lec4Tr5cNLvzevkmYndVo93gH9qRKzz+wE0s=;
        b=dJGBmSzztj8TLilSY7BYvNZx0J0MnRAW8Dw3UgUKM3kaoPf0eJx1PgaqTpXK1EW7HB
         tAdfB3YZwFYoYrl5e5ZIuH0entSK1159nSBXi8Gcs4qK3LWYgm5k3gUYNnLq3tx4fE4i
         SDEHLmtEEg+SaJiMiq9uWJ+YFDbyMuEP9L0FfTziZpVyMjhVxXx8D1mFOadhd83gvUi2
         il/iQPCX262OVbhgetUXDOwON8NvkSPuqnGSoJtsZ1t8S5Fz/ZAw0DiSpxXfKGHDJlvr
         nuoPzZ8N9JtcQ4B2bFlCu+YGnDd2lQj3gfKQplkXhBtNHvAmuzw4lFqjSEppDPsYbB7o
         dPxw==
X-Gm-Message-State: AKS2vOx8dqWLNDEyw9Gx3rsu0dN2LJJgctzDuLUe4m/4otHnkiQNSsay
        O4zXaS04VlDG5rxLceE=
X-Received: by 10.98.147.19 with SMTP id b19mr38251583pfe.145.1498081426536;
        Wed, 21 Jun 2017 14:43:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id j27sm23004277pgn.63.2017.06.21.14.43.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:43:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-5-sbeller@google.com>
        <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
        <xmqq7f05niwt.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZnDdtB6O5jnt7ouG-qoOS90kZALqZB_-gOT0OQcJzvRg@mail.gmail.com>
Date:   Wed, 21 Jun 2017 14:43:45 -0700
In-Reply-To: <CAGZ79kZnDdtB6O5jnt7ouG-qoOS90kZALqZB_-gOT0OQcJzvRg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 21 Jun 2017 14:23:14 -0700")
Message-ID: <xmqqtw39m2y6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> I looked through out code base and for enums this is
>>> actually strictly enforced, so I guess I have to play
>>> by the rules here as I do not want to be the first
>>> to deviate from an upheld standard.
>>
>> You sound like you are trying to find an excuse "not to play by the
>> rules".  Don't.
>
> When the rules are not yielding best results, adapting the rules
> should be considered.

I do not think anybody is saying that it is unreasonable to have a
wish that it would be wonderful if we could use C99 features.  

Trailing comma at the end of enum is the least interesting addition
(it is a fix for a previous editions' brown-paper-bag mistake).  I'd
be delighted if we can drop support for older compilers and start
using designated initializers, for example.

Finding other's violation of the current coding guideline is *not*
the right way to promote for that future, however.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B112A20282
	for <e@80x24.org>; Fri, 23 Jun 2017 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbdFWRN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 13:13:29 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33235 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753870AbdFWRN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 13:13:28 -0400
Received: by mail-pg0-f43.google.com with SMTP id f127so23582062pgc.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VW/bGsOt/CsA79kPnCW+uwbVS363zud8Cm7x9Wg0KFU=;
        b=VOxLMPWbA1FnBLBdmd/04K2BMGPWdJyjsCCe7DaGmna97U4AVgCzNCV8wLYSjgPao3
         RyCtKsqBlwF4KCXSCHqeD4sLkQaiKDjQXgdiJD/28tb3cg9wwa+h/QDmm6qPkbPjyRxs
         Qz768FLiLgew9VY8rrOddZ3/Zi475Ke8Qu8xDOSb9+BiAp1tPh3gu5ELnWJqfgWSSkcz
         eHyxBitLyl063DFmbCa7HLIzoOdj2VuTF4yT6RahpglPwhnkcvocj89AcSBAS5zaaqAw
         pf8fM7GlnEPe4j4TJ27dcxbQvgE1J1hEZd1XBZRI4KVX8d3kXcXJwRmWZbA5PjV9FlVv
         AP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VW/bGsOt/CsA79kPnCW+uwbVS363zud8Cm7x9Wg0KFU=;
        b=QfpaPYptgAUFBq5KX1WIC99iAKfBfa5UjPVWda4qQFx+CzROf8m/2O6bt8+9IzP4lC
         rFsmVFSieSiQTE7fzqZ1WL6IV9Qz0H2yCC3rmDMlqe/S1sohl2Sqg8NMHLkgb9Rfkfso
         7G3696ufJR25iW+J0cKWuxdrRDySD2tRBMmQ+Vzenr1ivYUyiCuyUSZGgJ5COy5xiUI8
         GDSlbLlUMzkwRXWKCp8ObD6HmdwqANCmZuz9lkCsw9aLrj9+AhKym+nrpFlc6xIyvsqm
         4RQLVDxHULPGYmo6rlvgYq3mFtG5QsB6frOQrYfI48Wbvn7Ju8LroXxCLMqHL1NgnA6d
         G6JA==
X-Gm-Message-State: AKS2vOy13TUNGO+z+GGv77qPJ7eBnNVlGv4U9K4boE4w+Oi7ZscjXMSN
        AoHQ5q+X/oqzQA==
X-Received: by 10.98.31.10 with SMTP id f10mr9307172pff.164.1498238007836;
        Fri, 23 Jun 2017 10:13:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id z70sm10211489pgz.3.2017.06.23.10.13.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 10:13:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param to bool
References: <20170623144603.11774-1-avarab@gmail.com>
        <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net>
Date:   Fri, 23 Jun 2017 10:13:26 -0700
In-Reply-To: <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 23 Jun 2017 10:51:03 -0400")
Message-ID: <xmqqa84yfwzt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The idea was that eventually the caller might be able to come up with a
> TZ that is not blank, but is also not what strftime("%Z") would produce.
> Conceivably that could be done if Git commits carried the "%Z"
> information (not likely), or if we used a reverse-lookup table (also not
> likely).

The former might be conceivable, but I do not think the latter is
workable.  Knowing that a location happened to be using a particular
GMT offset at a specific point in time simply is not sufficient to
give us a zone name; the whole idea of a zone name being that it
will give us rules that would apply to other timestamps, not just
the one we are paring with GMT offset in our committer and author
timestamp fields.

A third possibility is the information may come out of band.
Something like "When gitster is in +0900 he is in JST" can be
maintained per project and supplied by the caller.

> This closes the door on that.  Since we don't have immediate plans to go
> that route, I'm OK with this patch. It would be easy enough to re-open
> the door if we change our minds later.

I agree that it is not too much hassle to revert this change.  I
actually would not have minded if René's original were written with
a boolean flag.  But I do not see the value in flipping ("" vs NULL)
with a bool now.  The benefit we are gaining (other than closing the
door) is unclear to me.

>>  /**
>>   * Add the time specified by `tm`, as formatted by `strftime`.
>> - * `tz_name` is used to expand %Z internally unless it's NULL.
>>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>>   * of Greenwich, and it's used to expand %z internally.  However, tokens
>>   * with modifiers (e.g. %Ez) are passed to `strftime`.
>> + * `omit_strftime_tz_name` when set, means don't let `strftime` format
>> + * %Z, instead do our own formatting.
>
> Since we now always turn it into a blank string, perhaps "do our own
> formatting" could be more descriptive: we convert it into the empty
> string.

Yeah, that reads better.  I am also OK if this said that an empty
string is an accepted POSIX way to fallback when the information is
unavailable---and we really are in that "information is unavailable"
situation in this code.

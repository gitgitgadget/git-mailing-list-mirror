Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8847BC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B961152
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhGMSRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbhGMSRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:17:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADDCC0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:14:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l26so26084819eda.10
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jOCCz3FIIwsE6XIwhF8l2/cjTiUAtbT6d4kwf/gHAv0=;
        b=CowGXU9efJQ0Gk9ZlnKbhcUz7hKuE3CcPRaNayZk466GO64HEFVFNcXjt8LPrV3tuL
         FlT5maIaThAqlLCI8OX/dBVVtoV2P81ATc85kWITr3KUziDyxsmdVs0DbGMUwJuHWIrj
         zAt42pg0rZn9ywHy/X+W2gB64BLN3Qn533WgtPPZoE1kw9ft6IeENXxkOeD1VxBpn3cH
         b/G6o2DeqQyrGghEV8ZqDsByZf+goM2UKU1en10CPO+BE3furF9P+Ieve+hTfWpcn28N
         P8WHiM8jDF6atsZmZVYZnAH1Rx0XBM5iZEPcCN4ZIpl07TcZ8feQfRHnocMFxJMviEmg
         hPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jOCCz3FIIwsE6XIwhF8l2/cjTiUAtbT6d4kwf/gHAv0=;
        b=Cdpzb9nAsrYz7OY+RyvdDNDIF0l1w60nOC/qAfafuL3qWlRPbK40gzLgk7zGSGESEn
         MQSHVdh0jcfpGXsycctuNYFMNV78yqcWCvw5ci41TYEvSCkq0Xm/iTmn6zIaafc0l3mH
         RTXFmILrgJGDQGlE9NAg8p7XzdtExDxpbPCbAOg8mc5gK8XgJNRnxKuzZWIUa6M5lv08
         dGeQLDRZvf1awOY74rTJvvbsTjZaFjz7JsUZLNwHn9dE3oQNtBjoomtd1f+daqZDSOmM
         3AOls+IJXqzX4/SXdBTeoaRk0B1NqqQQLHLkxy/kv1tk2c86hVzCGr9yxm8eM5xYoiMT
         TJvA==
X-Gm-Message-State: AOAM531KsDXf9bOTo/C+Vmr8i8d0IsvQvTDLZ35bIO2okAzU/lGleAls
        UMxAahg10NK+A6w4UamcFtY=
X-Google-Smtp-Source: ABdhPJxx7glJZI9eqD8cnWet9eB3r0tjluR+b6VE3rOaZX3UEDBAHXhi4V6FeEFTQp/7W7u28WZ+rA==
X-Received: by 2002:aa7:d353:: with SMTP id m19mr7711132edr.162.1626200090736;
        Tue, 13 Jul 2021 11:14:50 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a25sm9049903edr.21.2021.07.13.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 11:14:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 17/34] fsmonitor--daemon: define token-ids
Date:   Tue, 13 Jul 2021 20:11:38 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <37fdce5ec3afaa9aae5001c648fced0675dae0c4.1625150864.git.gitgitgadget@gmail.com>
 <87mtr5bpuw.fsf@evledraar.gmail.com>
 <f38ed916-cfd8-06b2-43dc-689720a96a6e@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <f38ed916-cfd8-06b2-43dc-689720a96a6e@jeffhostetler.com>
Message-ID: <87pmvm2i8x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff Hostetler wrote:

> On 7/1/21 6:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> +	if (!test_env_value) {
>>> +		struct timeval tv;
>>> +		struct tm tm;
>>> +		time_t secs;
>>> +
>>> +		gettimeofday(&tv, NULL);
>>> +		secs =3D tv.tv_sec;
>>> +		gmtime_r(&secs, &tm);
>>> +
>>> +		strbuf_addf(&token->token_id,
>>> +			    "%"PRIu64".%d.%4d%02d%02dT%02d%02d%02d.%06ldZ",
>>> +			    flush_count++,
>>> +			    getpid(),
>>> +			    tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>>> +			    tm.tm_hour, tm.tm_min, tm.tm_sec,
>>> +			    (long)tv.tv_usec);
>> Just bikeshedding, but can we have tokens that mostly sort
>> numeric-wise
>> by time order? So time at the start, not the flush_count/getpid.
>
> As I described in a rather large comment in the code, tokens are opaque
> strings -- without a less-than / greater-than relationship -- just a
> random string that the daemon can use (along with a sequence number) to
> ensure that a later request is well-defined.
>
> Here I'm using a counter, pid, and date-stamp.  I'd prefer using a GUID
> or UUID just to drive that home, but I didn't want to add a new .lib or
> .a to the build if not necessary.
>
> Perhaps I should compute this portion as hex(hash(time())) to remove the
> temptation to look inside my opaque token ??

Why does it matter if someone looks inside your opaque token if the code
is treating it as opaque by just doing a strcmp(old,new) on it?

I just suggested this as a debugging aid, i.e. when you the human (as
opposed to the program) are looking at this behavior it's handy to look
at the token and see that your cookies don't match, and that they look
to be N seconds apart.

And furthermore, if git crashes or whatever you can now easily look up
what process crashed if you've got the leftover cookie, if you've also
got trace2 logs.

>> Maybe I'm missing something, but couldn't we just re-use the trace2
>> SID
>> + a more trivial trailer? It would have the nice property that you could
>> find the trace2 SID whenever you looked at such a token (could
>> e.g. split them by "/" too), and add the tv_usec, flush_count+whatever
>> else is needed to make it unique after the "/", no?
>>=20
>
> I would rather keep Trace2 out of this.  The SID is another opaque
> string and I don't want to reach inside it.

For the purposes of the git.git codebase it's fine to reach inside of
it, especially for a "I'd like a near-enough-UUID, and I know the trace2
SID already does that per-program", so you just need e.g. a sequence
counter within the program to ensure global uniqueness with other git
processes for such a cookie.

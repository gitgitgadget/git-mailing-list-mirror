Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D983C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793C960F55
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhHBMqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhHBMqz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 08:46:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1868C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 05:46:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z11so1864737edb.11
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VnoJvUr6g5R7SK5WreqiyQh6nKq+GFnc38F+5vO7cAw=;
        b=oAblrQRapcY37OTynGkZOWEVQmfy7U1ZuUNQKv9qI26qLnjyApMCbQ5kTr2sv0mr2o
         i7MVt/N5YbVjcXGj6dsdRyoXV0MLEkiicD0Q47mXEoAwjLcQsnxwYe+Kzow3Yxomf89Z
         PMFGWHnUbfaZUWYL8gOpTVfHg7hRE2Yxng7cgzgVv9O4ao/k2tfSi7WJNbBPR6NZn/vw
         /UshDz3wxZ8sPNaVpQrlyFFQ2Uih8GmmhdCBcn4zHNHYtHNbT3Pi1k8ZfoEAGIr2j+Rk
         FoF8w7wo+N5cyfZRFCKlWJIoKCyB0m2tmKa252BFpfdLs0MdTqmXnITMoHypkiotzVvz
         rHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VnoJvUr6g5R7SK5WreqiyQh6nKq+GFnc38F+5vO7cAw=;
        b=XZA5X08UGl60VBf/Ks6kdrMxms9O1UGmXUL4g6MsWMrHoAHqznTYOguOgErtBukUAB
         kjXhkkTSxOgVDqGGqeuBhrhrcWiuRSWw5tH/piQdhiBXjTjVx3hkQOb/NLx+YcyylvL6
         QEz0Yh+6kZ9j9x5hYGDQs35SV6NFPb4z+ZPacXsLsjxUm/hx/gRB5SUzIF6kW+XOezhb
         kjVdsOY3vQzTBMJK1DWPoQup4Qp2/GLpQ1L0S5pBBP/juHUtbh0Z4MQqoXx86qvkjH6G
         CjO1V0ydnjPnOwSRgKbaFPOqWsFWlj8oQv3VEcOU3EuZ3fuShZTqoFS0jDxdl1Ltj2M+
         IXiQ==
X-Gm-Message-State: AOAM531t24SPCgXIcCKG2BgRyiazqOYrFV0F90powo07LPjZU5QxpLqF
        MqebidESm2Rbsa9WjFy4i7w=
X-Google-Smtp-Source: ABdhPJx7rYryvAv5L10ipSu1G1AyNWS8QVinLBMZ2Gdpcg8rMPmmSc70B9jQ33Ltr8mH7k2ecNXXVg==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr19254905eds.166.1627908403589;
        Mon, 02 Aug 2021 05:46:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id og35sm4589301ejc.28.2021.08.02.05.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:46:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 02 Aug 2021 14:45:58 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
 <87r1fcp4gy.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87r1fcp4gy.fsf@evledraar.gmail.com>
Message-ID: <877dh4ovyl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jul 21 2021, Emily Shaffer wrote:
>
>> +`"cmd_ancestry"`::
>> +	This event contains the text command name for the parent (and earlier
>> +	generations of parents) of the current process, in an array ordered fr=
om
>> +	nearest parent to furthest great-grandparent. It may not be implemented
>> +	on all platforms.
>> ++
>> +------------
>> +{
>> +	"event":"cmd_ancestry",
>> +	...
>> +	"ancestry":["bash","tmux: server","systemd"]
>> +}
>> +------------
>> +
>
> Okey, so because of later NEEDSWORK no system that runs systemd will
> currrently have output like this, just Windows.
>
>> +	/*
>> +	 * NEEDSWORK: We could gather the entire pstree into an array to match
>> +	 * functionality with compat/win32/trace2_win32_process_info.c.
>> +	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
>> +	 * gather the immediate parent name which is readily accessible from
>> +	 * /proc/$(getppid())/comm.
>> +	 */
>
> This comment:

To clarify, this was ment to be continued with "seems to remove the
need..." below. But I later inserted the commentery about switch/case
in-between, which made that unclear.

> [...]
>> [...]
>> +		/*
>> +		 * NEEDSWORK: we could do the entire ptree in an array instead,
>> +		 * see compat/win32/trace2_win32_process_info.c.
>> +		 */
>
> Seems to remove the need for this comment, i.e. we comment on this
> limitation of linux-specific get_ancestry_names twice, both in the
> function and its caller.

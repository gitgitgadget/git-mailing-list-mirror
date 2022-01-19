Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F2FC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355225AbiASOng (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 09:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355133AbiASOnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 09:43:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF4C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 06:43:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c24so10780663edy.4
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1mgRhwaUOIjaaBRPxLHj9enaT9b5yquZrLW61ZtP1ZA=;
        b=TNcjj5qzewJ4ugt4PuaHG5BAVbnDipNRryXlLNOOZ9i0KFt+rglz20hNWpQRx8iH+8
         7tDQ2vqXlESbbHH5Kqb16T2Ppjp13vaXog8DjL4ljq5E2lWXcDuKUgThGNXBvFFFqL5J
         c/cpdpowgUkT1pc92qcsPcD2wdBPEJqeUimpUMAZZMFKgKLHaTVlCYnNDeyBs+YT/3FO
         3OAhhpQVfg+k7qcDUScIy9isTnQZoedVZQ2sr9t2RmRyJHL6mCEpwgS5ZnVuxTupraF9
         LOqN9CmqNF7p2vIf4ptYOyJvvm8U1JCXx7P6wrHQu+vY6QjHzAF3GXRscBET+si7H3y1
         1aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1mgRhwaUOIjaaBRPxLHj9enaT9b5yquZrLW61ZtP1ZA=;
        b=SYiUNEE8hMbnKRyQX9pqUEsUwzs6II8ceVDPYrOjFOilaoV0bh7RVVWZD/zkBQWwyX
         ugzFlnOttbLpxywxGCIV+O0c4YU9/bEGlDWLntFD0RpSy37dgitPwOCFrMAboNvVwNHt
         Xbd2j7Sxmzr9V/eXg+OFN9xL/SSRGqT1+AnVdbyctwCnl/bSZ2oI/LytIrIhzLURCGjX
         cMUNMXmRJQeRVVNconUu13i33IMHn7GsWLZ4TDgdt1FMmFzZS0c+VqREYNPWG1Khb7F2
         rq8P+b+KW2/aKoEZE/1uH7MsZyHU+zxSXIl8eyrls0MB/O5hvQlxQCvjM8I9LoEkoPkK
         81bg==
X-Gm-Message-State: AOAM530iidJyew6ifsu0g8jZkjxVemImZWRq9syC5J8J+93vR2l3w8UQ
        tYPhR37WtVP+HDZCM7Iw1ko=
X-Google-Smtp-Source: ABdhPJwrMJRnwt0Fwfp9GQzCzEi9L0xaU9wtm8G83nnImMaw8T2SaiRNI43EspS6/fuz8UhJSTxDKQ==
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr30174102edu.196.1642603413649;
        Wed, 19 Jan 2022 06:43:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n7sm3924981ejj.82.2022.01.19.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:43:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nACBQ-001mI5-7i;
        Wed, 19 Jan 2022 15:43:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] parse-options: document automatic
 PARSE_OPT_LITERAL_ARGHELP
Date:   Wed, 19 Jan 2022 15:41:48 +0100
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
 <xmqqh7a0r87q.fsf@gitster.g> <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
Message-ID: <220119.867davokff.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 19 2022, Ren=C3=A9 Scharfe wrote:

> The help strings for arguments are enclosed in angle brackets
> automatically.  E.g. if argh is specified as "name", "--option <name>"
> is printed, to indicate that users need to supply an actual name.  The
> flag PARSE_OPT_LITERAL_ARGHELP turns this off, so that "--option name"
> is printed instead, to indicate that the literal string needs to be
> supplied -- a rare case.
>
> This flag is enabled automatically if argh contains special characters
> like brackets.  The developer is supposed to provide any required angle
> brackets for more complicated cases.  E.g. if argh is "<start>,<end>"
> then "--option <start>,<end>" is printed.
>
> Add a comment to mention this PARSE_OPT_LITERAL_ARGHELP behavior.
>
> Also remove the flag from option definitions for which it's inferred
> automatically.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Somehow I feel this is not enough, but I can't pin down what's
> missing.

Rather than just remove the flag from {am,push}.c and document this it
would be better to add it to the optbug() checks in
parse_options_check().

That way we'll ensure that these flags won't be redunantly specified, if
we care enough...

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EE4C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3750660EE4
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhI0MLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhI0ML3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 08:11:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB74C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:09:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g7so8897805edv.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8ErU485aASPvQgUGLI+wNUk3BRoZUbejm1pWFDlBC1g=;
        b=ioMU8GLFxKjAIkkXzRgOebWFUqSzIuIVTog9eScAznbikHFrL+wBfFW77sCVe3E+4E
         b6N3McgY+6NwlVuQvqPup8ha5yXL66/J1KdDcMwXX54a402CuTTNJ1dESXj+IcIJ7jiO
         7hDj27raD0UPj6TZThz340pkNarQM5vee/zIS6Mdyh66LQREwdbEvCgfkfd41ov0ZPHN
         ep8UsHgnE1Qbufo5hAUe2gzlXUFWXndBROLJfeYJyyTKiGZI5nMhdX+5g9mjGuP6dRBk
         eOX91qNRfEPV9MH7YCQ1A8I7Fra0zudY62cOwQxNWW/ttuMpEbaCZBIi4LLCFu6OiE4z
         xhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8ErU485aASPvQgUGLI+wNUk3BRoZUbejm1pWFDlBC1g=;
        b=rStOGqPybfoKZN2qPirzx/ThYD2YfHoH5txlgHjm6gOYKmC4tAfwNGEaQ/qM00FpxX
         UjW5zC3gt5kRHomVxderZRBRgB7IMH0XGnXs2+tuQnJq5+77YOgPFxFpNCD2eYX9KKha
         2m6+QYY34WK2Kq+joU4h03Gx9RcjLaj46uXdKM+P14+K71A3iL5R5OAXstoyZsYqhwqL
         ogV7wu/BbpS4XoGaDwQfjtbwL7QIa5OpC50s6Zz0vh+j4qiKcpuwVDfIPQiAV1N/ofKc
         iu3CCJhMfzPXONc90wdWejpYhle28oAAEXWUZuYXSqgsoLlkG2BupvWM+6FcXnfOvmD8
         S5Ag==
X-Gm-Message-State: AOAM530srZpfWI9z6LV3yheANFjq97fsAs7DzyLtotBSzkWzpxMbEQdi
        HlfeDcgeQWjYduJZwQVnOzQ=
X-Google-Smtp-Source: ABdhPJwiR6SpSJuVcby9VyTHQsUFPha7NI0SWN9pwvcJFhabV5oAIE+k20Kk/x5tfFWdWzRPr6QcuQ==
X-Received: by 2002:a50:9d4f:: with SMTP id j15mr23374243edk.68.1632744590332;
        Mon, 27 Sep 2021 05:09:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m7sm1119151ejc.83.2021.09.27.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:09:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br, gitster@pobox.com
Subject: Re: [PATCH v3 6/8] grep: add repository to OID grep sources
Date:   Mon, 27 Sep 2021 14:08:20 +0200
References: <cover.1628618950.git.jonathantanmy@google.com>
 <cover.1629148153.git.jonathantanmy@google.com>
 <f362fc278cc2d0291c24097a75f8cfdfe88c27d6.1629148153.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <f362fc278cc2d0291c24097a75f8cfdfe88c27d6.1629148153.git.jonathantanmy@google.com>
Message-ID: <878rzi1ape.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 16 2021, Jonathan Tan wrote:

> Record the repository whenever an OID grep source is created, and teach
> the worker threads to explicitly provide the repository when accessing
> objects.
> [...]
> diff --git a/grep.h b/grep.h
> index 480b3f5bba..128007db65 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -120,7 +120,20 @@ struct grep_opt {
>  	struct grep_pat *header_list;
>  	struct grep_pat **header_tail;
>  	struct grep_expr *pattern_expression;
> +
> +	/*
> +	 * NEEDSWORK: See if we can remove this field, because the repository
> +	 * should probably be per-source. That is, grep.c functions using this
> +	 * field should probably start using "repo" in "struct grep_source"
> +	 * instead.
> +	 *
> +	 * This is potentially the cause of at least one bug - "git grep"
> +	 * ignoring the textconv attributes from submodules. See [1] for more
> +	 * information.
> +	 * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
> +	 */
>  	struct repository *repo;
> +

I ran into this comment and read the linked E-Mail, and then the
downthread
https://lore.kernel.org/git/CAHd-oW6uG1fap-T4UF17bJmjoHAqWCDq9KbY+_8a3cEnnfATxg@mail.gmail.com/;

Given Matheus's "I've somehow missed this guard and the..." there I'm
not quite sure what/if we should be doing here & what this comment is
recommending? I.e. do we still need to adjust the call chains as noted
in the E-Mail the comment links to, or not?

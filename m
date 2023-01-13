Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E1C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbjAMKgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbjAMKf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:35:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0C78160
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:34:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e10so1058274wri.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mgdI8Fn6p/GYU4a/CAwGtYsJKWQqPyFtAM+i94nTyM=;
        b=qM5l/jJB7mnFgSR+74vGlG4i7EMgPzybIxgdm0LgOtZpgMAgMlNzd5dNPkzmvwYmPm
         9N0wgMJLwnDSkm9NuKcC+XGmG8R9tvD2WIuEE9HDKpZZtHl1Qtj2qvRe2RcJFyf73BHc
         PL40fEkLdh/phITSj19bMqU1Xm/r6yuZwlWluctyUNlMzWgtNaMfPSygmbj2/kDDGRct
         xY7CQnVS8QH1gurIVnylGGTyq1liu4ewHvhr23ug2pfQZNEjWYDgGLMy6AC7HGVbrnOD
         ynaAxA+kee4aDGuNCNWh0qyyj9sv/qlJ1NIZiKl/PFj2L8BsMRpuYnZ1VEbByYYDAFj1
         QpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mgdI8Fn6p/GYU4a/CAwGtYsJKWQqPyFtAM+i94nTyM=;
        b=5Xk2Cf5sGN4xM/GTjUXgqghdvADZjWJqgTljZk5yq92XfhPRZ+kQIQle0epSulGlMM
         zVP+jm9y4rpX0IV+0/9qUVIEpzvtrxSqKVUFKKpsYv22UHitI5mGgfPnmJQWP5wphrDf
         DdGtgP6t+yFWr/+mJNNyaEm3pe3Ht4zbyX+R9rkhF9NxZLVqNXb7lEyS6o8iYxxGZwoP
         Q0ZiCWxmIlq25F7m89+iETmowq25QoO2VXn45FAugTTAO0DIjsFNdIzBvYXpm0TEn4Lg
         wNlll0dLRdzQm1HACgEFFyaWlCvhjI+emJw3UrLMiMmkzFVXDlW900ayogGnrR0rgqIh
         OCAg==
X-Gm-Message-State: AFqh2kqdqxb602krT57nT/Y1Iimh5znfeXwyUIFBYBP+ppyb5/HYdc/8
        0n0ZhK74yjhw1Ynp7qQM80k=
X-Google-Smtp-Source: AMrXdXuvUE9N7f+6gUWrXhxpoKc7HIXZVyVaek8pLchYpLa1nwxBV/IT3BEZPOGHwYtXt2HVXad1xw==
X-Received: by 2002:a05:6000:1e1d:b0:2bd:bb4a:2596 with SMTP id bj29-20020a0560001e1d00b002bdbb4a2596mr8126076wrb.7.1673606075161;
        Fri, 13 Jan 2023 02:34:35 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d526e000000b0028e55b44a99sm965161wrc.17.2023.01.13.02.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:34:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <44d98c85-d1d7-ed01-20e7-744324e36b13@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 10:34:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/9] rebase & sequencer API: fix get_replay_opts() leak
 in "rebase"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
 <patch-v2-3.9-f06f565ceaf-20230112T124201Z-avarab@gmail.com>
In-Reply-To: <patch-v2-3.9-f06f565ceaf-20230112T124201Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/01/2023 12:45, Ævar Arnfjörð Bjarmason wrote:
> Make the recently added replay_opts_release() function non-static and
> use it for freeing the "struct replay_opts" constructed by the
> get_replay_opts() function in "builtin/rebase.c". See [1] for the
> initial addition of get_replay_opts().
> 
> To safely call our new replay_opts_release() we'll need to change all
> the free() to a FREE_AND_NULL(), and set "xopts_nr" to "0" after we
> loop over it and free() it (the free() in the loop doesn't need to be
> a FREE_AND_NULL()).
> 
> This is because in e.g. do_interactive_rebase() we construct a "struct
> replay_opts" with "get_replay_opts()", and then call
> "complete_action()". If we get far enough in that function without
> encountering errors we'll call "pick_commits()" which (indirectly)
> calls sequencer_remove_state() at the end.
> 
> But if we encounter errors anywhere along the way we'd punt out early,
> and not free() the memory we allocated. Remembering whether we
> previously called sequencer_remove_state() would be a hassle, so let's
> make it safe to re-invoke replay_opts_release() instead.
> 
> I experimented with a change to be more paranoid instead, i.e. to
> exhaustively check our state via an enum. We could make sure that we:
> 
> - Only allow calling "replay_opts_release()" after
>    "sequencer_remove_state()", but not the other way around.
> 
> - Forbid invoking either function twice in a row.
> 
> But such paranoia isn't warranted here, let's instead take the easy
> way out and FREE_AND_NULL() this.

The changes below look good, but this message needs updating to reflect 
the re-roll.

> @@ -359,6 +359,7 @@ static void replay_opts_release(struct replay_opts *opts)
>   	free(opts->strategy);
>   	for (size_t i = 0; i < opts->xopts_nr; i++)
>   		free(opts->xopts[i]);
> +	opts->xopts_nr = 0;

I don't think we need this now we're only calling replay_opts_release() 
once.

Best Wishes

Phillip

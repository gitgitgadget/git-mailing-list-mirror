Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1CDC433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 23:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJAXop (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 19:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJAXol (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 19:44:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E5C3A
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 16:44:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so9321449pjb.0
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Ov07taPwylR33v/zXSHOoHfrOlRvbB1pl02zZB5PZlc=;
        b=RvEssjmFK+1Xtu95fV2rc9XHzp8GVwfGJJsw7days+3c+P6wqwKZs9nx3kobbHyVcg
         D1eU/mR5T/56yY3JpDv98IsNjxmebM536zU3E7f/ehlwdKIgAPhji42vsLHwMQnBltBU
         X9zMDuly7b3PDRN7zrUM0pBQVCOxQJa9dErAF/MFhjM0hLco99fd2d72TCGimt+F0lPi
         /WLgGB4zSWcsFeZGIQEWcAHLbbWmWZwnZSPeUFWasT6kDPGi1pfTsobxgpozVPB0BdsX
         LkelYq0ufwtVBwh4R7M5FK8yhLwerz4ep5TTGj1eabCrXZFa2AtDQ3W9KIvL6c72aUox
         F5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Ov07taPwylR33v/zXSHOoHfrOlRvbB1pl02zZB5PZlc=;
        b=u/89d78ALVhFR6H0fSmXnZhE/sQVKzIkPtQVtCPfsZy9FtJR+DdF0jzpeqR2DOq5MQ
         Z0jQ8ySouSqBi1i+k2gQruBS2RZpKH/LM5vSYyf3vSSIG+4mKb7LXfnDSL8PlIYgvVv2
         vjXOSWRlEUFp2zCZApRhkzvgie9KbRpzK5pjFs/GtllQ2Dq5n+YPnYhfqrypau7982rz
         gf+iViolwGNInGuuQN/MInCPK9Q16ol0zgJauzRIevsZVH7ViG/H40REcnvSawOU4EBP
         VTGf2pd/SMK+klSzqwIJ9ljTpyifdIgcIFrI376pOT83DPecX2EdOCpedJF5Jq82PH18
         vixQ==
X-Gm-Message-State: ACrzQf0iWPeH0cFXr46HIrR25ZnlPSlXCqK7WBlZo21yjS7oWVgCLE4g
        p+PS+J//GyRT1IdfW9iPPok=
X-Google-Smtp-Source: AMsMyM5mi7voZL7dmFH0XgoC3NM5CWWfAotImRNnJxquqMdHK+xJqZg82bvQ+IXkNrFbUZjQyOrw1Q==
X-Received: by 2002:a17:902:ccc4:b0:17c:7cc1:a401 with SMTP id z4-20020a170902ccc400b0017c7cc1a401mr9688600ple.58.1664667877501;
        Sat, 01 Oct 2022 16:44:37 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b00176c431e7e2sm4416289plc.13.2022.10.01.16.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 16:44:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 21/36] doc txt & -h consistency: add missing options
 and labels
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-21.36-1713227d497-20220930T180415Z-avarab@gmail.com>
        <xmqqwn9j2xmu.fsf@gitster.g>
Date:   Sat, 01 Oct 2022 16:44:36 -0700
In-Reply-To: <xmqqwn9j2xmu.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        01 Oct 2022 11:43:05 -0700")
Message-ID: <xmqqczbbyuqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of going over the patches in the rest of the series, I think
we'd probably need to step back a bit and give ourselves a general
guideline.  

This list is a draft of things I have learned from reading the
series, many of them from this step 21/36 alone, but some are from
earlier steps.  I think the ones with '*' in front of them are not
controversial, but others are merely my suggestions at this point:

 * Use of spaces in optional [] and choose-from-one, both for
   freestanding token and for a value (i.e. what immediately follows
   an equal sign '='), are as specified in [PATCH 1/36].

 * For a command "git cmd", the documentation in the SYNOPSIS
   section and the usage string from "git cmd -h" ought to match.
   Let's call them simply a "usage string".

 * The usage string for a command that has majorly different
   operating modes can and should enumerate the different forms
   separately (cf. how "git diff -h" lists different modes).

 * The usage string for a command with a large number of options can
   and should use "[<options>]" placeholder in the SYNOPSIS and
   "usage:" lines, i.e. "git cmd [<options>]", and let the
   DESCRIPTION section (in documentation) and the option listing (in
   the output from usage_with_options() function).

 + The usage string for a command with a small number of options can
   enumerate individual options as long as the result (for each
   operating modes) can fit on a single line.

 + When a usage string shows options individually (instead of using
   [<options>] placeholder and leaving the listing to the latter
   half of usage_with_options()):

   - if an option has both long and short forms, only long form can
     and should be shown if the resulting line would become overly
     long with both listed as choices.

     do   : "git cmd [--quiet] [--verbose] [--dry-run] <pathspec>"
     don't: "git cmd [--quiet | -q] [--verbose | -v] [--dry-run | -n] <pathspec>"

   - when showing a Boolean option, show only the form that
     countermands the default, unless the command can take a
     different default depending on the context.  When use of other
     options or configuration can change the default value, show the
     option as "--[no-]option".

     do   : "git pack-refs [--all] [--no-prune]"
     don't: "git pack-refs [--[no-]all] [--[no-]prune]"

   - when showing an option that can be given multiple times that
     causes cumulative effect (as opposed to the "last one wins"),
     signal that by saying "--option..." to signal that it is
     meaningful to have one or more of them.


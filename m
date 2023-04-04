Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089FC76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 00:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjDDAQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDAQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 20:16:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01778A6
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 17:16:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c18so29686782ple.11
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680567385;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=moPLv3Od0PVspw8Sg0LzMQZgJnRMhW2VXlF3qHHw7nA=;
        b=V4/d7s8jOmq1cigCttR3yEVp/oIl1krRr+Cly1S/wJsSWJYVEXhv9oGXyNxS3N6S+O
         CqY9tXPg3rCPhjg2WPcWJTJXTtMCHzVKKkYBzx1urujZcBfA8abWO/lexhCFhWHqO5H5
         kHAma/vI+DHcnyWXAE4ciAD/4TwK6dkuR+I7NRhWH4xiee+JL0+fqnFDgLeZvfbT0Ki3
         6cTJnuj8jLzKxHisjexTEuzeqwXpi8PHaj4yg0WQ5Y5PJashACuSwAkX3gJxnGU65TC3
         Uw3stCSC57rrGlV1Up0FrUV9qmKDjKMzWfMqjyY4XFq+l0nqk8/CbZ5m7AO5xtVrUuuM
         TIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680567385;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moPLv3Od0PVspw8Sg0LzMQZgJnRMhW2VXlF3qHHw7nA=;
        b=fCBXHTW/UE07qQFE7a5DWu25SwIiL7tlen26V6R78Ci1NEmlUFPybi9TboJJSCWPZi
         n4qCfq04UTVfr2uQLLXrTLE03LfNYs0RG2ViUdU+RHgSbS9bPEuFIq5ZOM+pLLZAmT6Y
         ICfMC3gujCPx1XA9ax0UjjKzs00EX/BZJ5QNDNF4FpQCx/FN0iO0JmCY6dyaIOdzdmry
         UXtQg7RriKNeQzQlR9Xxb41YTA3ggYhfuZ9YpRk2jgpnr14b9wrxlVR2Kb5I+976PnUt
         qGjO6WXz3+VUzgKM5k3lUvK2MDxRiSrdJq7z9HOL/dvmkbOOISki+GscDEU74thjdMGK
         JJjg==
X-Gm-Message-State: AAQBX9c1DEOVgw3sOEIb1EIeMz46yG5jxwRyt7AXIdUf/nxnJ+HLC6ku
        Dp2OSkExA40TetaQpQijjDc=
X-Google-Smtp-Source: AKy350Z23Sr/62bxIa9Z0qarSc5dBJMLXQ6zncZ2FeNWifs2E8w+Vm3KNHM4IGv3buv1fSNH9x7U/Q==
X-Received: by 2002:a17:90b:1d04:b0:23b:3672:3b53 with SMTP id on4-20020a17090b1d0400b0023b36723b53mr622399pjb.39.1680567385309;
        Mon, 03 Apr 2023 17:16:25 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902760500b001992fc0a8eesm7208202pll.174.2023.04.03.17.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:16:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Raghul Nanth A <nanth.raghul@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
Subject: Re: [GSOC][PATCH v1] diff-index: enable diff-index
References: <20230403190538.361840-1-nanth.raghul@gmail.com>
Date:   Mon, 03 Apr 2023 17:16:24 -0700
Message-ID: <xmqqv8ic33jb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A <nanth.raghul@gmail.com> writes:

> Uses the run_diff_index() function to generate its diff.

The sentence lacks a subject.
> +	test_all_match git diff-index HEAD --cached

See "git help cli".  Do not write rev after a dashed option.

Thanks.

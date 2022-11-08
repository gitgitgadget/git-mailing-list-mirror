Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3601CC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 17:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiKHRIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiKHRIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 12:08:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CB5C23
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 09:08:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t25so40289038ejb.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7qSmrqt7jyZjyHCZNxLfYLPntrHEX8vRXor4WJktsy8=;
        b=BjssXK3hj8A/M9udy57wymgFaiysjAr589FSStz1HoKiqwLVq0BAPdZUyjhPeWxzlI
         CJrrYvHyZrXQ+JvcxyugCBgbgH+r+kCYy/gmcsz/4/NqjUX7wKHs0kCiY980Zfp8rLie
         rklWAEPEptjIuvlLoTw5EhYpgMtVXKKQ76QfplNgALBqoFcOflUeFbVxMO9ZR21Bhks4
         hTyNF3krUYUtmX00U4iZBitykXhwu87pWykatbuL/6oHIKPJ0LZIg6tNGDQ6CaZvZpC+
         Gr2aWOcbOYiGofroAZAT0mB9koIuLMdOa7a4YUORfyKMOIIdiCSExBy4muKnks4Csxid
         hHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qSmrqt7jyZjyHCZNxLfYLPntrHEX8vRXor4WJktsy8=;
        b=7n5F1OciYDFiBz7hNps7mKc2PtTqVzWPzAFwUhwJI3WyNOCVQmWPCNQ50c26eRDlCv
         1GRlYOgezulzqiPhPCSs3qjSBb/iQjZmvLpC2MCGa9AWr4Dpl7tJVHyxinkUX0dzLJ7b
         atI+HLLUvmzrPsqkNe5JYcUHYpH0HrjFh8nUtGTXUgJoGRzzBCJR2O0uq79rrPeMj7gc
         BdxR63DjNeC/oXO/uv3rQM86aMRBcEtVzw01ZMFLOtXQQlEGoxYoBW8ps24JkajWzYjC
         OcffA/U9FsJ/bmvDHDYgXvC27dgxq+rhHJN7zqUE8jXAalw4MXh3oqMYZlL2h1Ctrp+H
         rd5A==
X-Gm-Message-State: ACrzQf2aXQdY4nbgom3P218ALXSOrs4ChOSOdRKdPCtVkdNyCud+i1/k
        L8zzFTdcJjdkCKrNx09OUTQ=
X-Google-Smtp-Source: AMsMyM4gg8gRgHsGikCBwr0I2Yeg+8WBd2rTpEsOGFt8AqHIDKzcvfc2QpCQz7R9QISMbRnSuXPfjA==
X-Received: by 2002:a17:906:3054:b0:7ad:e82b:ac23 with SMTP id d20-20020a170906305400b007ade82bac23mr40827771ejd.235.1667927321463;
        Tue, 08 Nov 2022 09:08:41 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id kx23-20020a170907775700b00773f3cb67ffsm4828273ejc.28.2022.11.08.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:08:40 -0800 (PST)
Date:   Tue, 8 Nov 2022 18:08:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason via
         GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/9] protocol v2: add server-side "bundle-uri" skeleton
Message-ID: <20221108170839.GA1731@szeder.dev>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <a02eee983185815d94ba1124b43eae43280aa963.1667264854.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a02eee983185815d94ba1124b43eae43280aa963.1667264854.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 01:07:26AM +0000, Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> An earlier version of this patch [1] used a different transfer format
> than the "key=value" pairs in the current implementation. The change was
> made to unify the protocol v2 verb with the bundle lists provided by

s/verb/command/ here, and in a couple of later commit messages and an
in-code comment as well.

As mentioned before on a previous bundle-uri patch series, protocol v2
has commands, not verbs.


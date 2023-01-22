Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF04C54EAA
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 22:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAVWxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjAVWxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 17:53:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10518164
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 14:53:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d8so10129654pjc.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 14:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avMdQdDMT8muG/8nDXfuxsKaspytt6drY9mI4uXEWiI=;
        b=EhifTv1yvxaAfiH83MRvHBP2I3emYl9Tp1JqLU3SXPREGnfjx4RjnegwAnaFTnbkLU
         RZMOXeXw0sM6G+xtBcLygqQHAM6UUVqBpeCw7BXR9LwzKhuQaZa/XKr3ngn85uvYaQA9
         VqdEkAv97be7H/f9aywPX71/AczJrjUmCuHQdty9t+al5WFvEidXNvCP815Z0f6DGjPz
         1fso81TMr1j26TPaXAgOwx9xsO9avoQsFcPuU+vvIH7bUM8bsYR2+kEvDCA0cQfxfqyy
         hkhch83964rD/dqeBbUhEOD+VjTXHMXX97VbPO+fLD3OlWKDEgh1UjH/hOa41ZlbMkRa
         kc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=avMdQdDMT8muG/8nDXfuxsKaspytt6drY9mI4uXEWiI=;
        b=vdqQCSYx9ne767xvCtiadn4g4yMh/oJeCW4o2Su8RWHRJpKmfmD/lDjPlmCkze9SPc
         of4iviL75QDvDzoQA8/zLLqsqqybigX8HGhjcJxCCmJQsnvFup8GHcCXVriXXP4sxp1d
         SE7LiJKl+v6gTo8D+3UKXp3A5bkEp70I4B7YFSon1AHIKTf/C5VfLwP0eblZNLrFwHeR
         xp93W/iE5VISQI7tfxIFTRJJHtFR6nDpgKn1n8DtOMzodMxgqZuVUo9IY5w1ikwkTVQi
         ChL8GYMhd6SjLII/DB0Ex4i7JvfQMIFRwLZ7nbJqxp0cC4d9b6DGMp1HVUoHdPJ7Ngc1
         W4+A==
X-Gm-Message-State: AFqh2krqoYaMWM+/5Jzn0IbOin8bNuoLpuCh79yilQcR98U8QUUPdAtL
        iUe3yzd20piuzq5mPPz8FdFkAqxU5yA=
X-Google-Smtp-Source: AMrXdXtxQKcZEhQEx83xGOfXGp/0IY0tT3Thpvx9Q5zIRlyH5uBeVe/DsWcMBwIP5pyUyIsoIhuJMw==
X-Received: by 2002:a05:6a21:8cc3:b0:b8:7d27:2cbd with SMTP id ta3-20020a056a218cc300b000b87d272cbdmr22108312pzb.43.1674427995330;
        Sun, 22 Jan 2023 14:53:15 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm18229331pfk.98.2023.01.22.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 14:53:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: render dash correctly
References: <20230122165628.1601062-1-rybak.a.v@gmail.com>
Date:   Sun, 22 Jan 2023 14:53:14 -0800
In-Reply-To: <20230122165628.1601062-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Sun, 22 Jan 2023 17:56:28 +0100")
Message-ID: <xmqqcz76qizp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Three hyphens are rendered verbatim in documentation, so "--" has to be
> used to produce a dash.

Sad but true.  I suspect folks with TeX background were so
accustomed to type three dashes to obtain em dash, but with AsciiDoc
(and asciidoctor), sadly, two dashes is a way to ask for em dash.

The changes in your patch look all reasonable to me at the source
level; I didn't do Documentation/doc-diff to verify, though.

Thanks.

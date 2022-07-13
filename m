Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA40C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 11:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiGMLpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiGMLo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 07:44:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CDFEF227
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:44:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l124so9996941pfl.8
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SIfr4RsaA++xTfG4Yd2tf7oAtiSBJ3Awaar30sNsMU=;
        b=WJ41Q4VlUL/FpS4u9HB2pGY8x66zhUtt6RslEFivaAkvnJ34qyG/MSiMzAs80eIi8E
         7ELo7sd+9FrI1yBxoRjjBoXp/13W/juS7Vh6lZrreRJ2TJ2U4gjUZkJnV2BO6djBLgZl
         y2PumlSUZ6PiHP6jV3Nx5mt2VEFqS6z3PR6LFwlPIQIBgV/49B9VR14Maay9wevcqM6P
         g6Om4LVTonbpfKyPay7b1zAKzXrqDDCG3llvXgl1MrOLyYAun2E8VxelzruniCl67buV
         Tw4lmK1Xm2HuAoCdjMHuadlGLo3fAt+5ZadJa5Z/VIm8KU8H/xWj9dgtdYgA6hTyWdwV
         yKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SIfr4RsaA++xTfG4Yd2tf7oAtiSBJ3Awaar30sNsMU=;
        b=LaFRYHODYs89cKiVaJX5izsq3GR8AkFvp+fUvmPwpEu6opL7k6H52RLKhb3/saON8/
         eGrPehhvX/5WW2LicjuSIwxsSJCef9aLBWbu8+d+melM5A6k4GWjaQC4CB0g57D2R0r4
         RquRrwwTTVOo5SV1pvkF6TIihSwJmwg3+9CxoqSVTNZnIYsnkkZmVdngRfo3VdoLg2Kt
         cCcoygj5PzLIMzDNvuC7F/uA8vPLvgCH1fdzPhJjgMvc2J5nXeVZ7ZhBUInQaJrDlSv+
         LWJBIxtE6qdb4Pbm+SrwOk2S37M+tcyo4g33RaEyhZxel7eMnbx0553sB7eC8pYoMywF
         V2Aw==
X-Gm-Message-State: AJIora//iwQuPPcTRg/Z8pcttW6VDvkpNlmNiBdyKl5utDPZwnLwWOQH
        eH8pNKpmx5zUQfAxU1Cy52I=
X-Google-Smtp-Source: AGRyM1v++0QGyphc3S1//fRJSKg+lhTnw1+yYfdlW4rPPh8UFxUWeelKKpKebrUWDql8fIACTTP25w==
X-Received: by 2002:a05:6a00:1aca:b0:528:1f7d:4ffe with SMTP id f10-20020a056a001aca00b005281f7d4ffemr3044074pfv.16.1657712697788;
        Wed, 13 Jul 2022 04:44:57 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id z18-20020aa79592000000b0052abfc4b4a4sm8034323pfj.12.2022.07.13.04.44.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 04:44:57 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 1/7] clean: fixed issues related to text output format
Date:   Wed, 13 Jul 2022 19:44:50 +0800
Message-Id: <20220713114450.53250-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <xmqqwncjmk76.fsf@gitster.g>
References: <xmqqwncjmk76.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 11 Jul 2022 14:08:13 -070 Junio C Hamano wrote:

> This does not seem to be about "git clean".  Mistitled?

Yes, will fix.

> pack-bitmap.c: fix formatting of error messages
>
> perhaps?

Will accept.

Thanks.

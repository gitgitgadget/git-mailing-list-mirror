Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67921C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 09:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKUJpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 04:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKUJpP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 04:45:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B7F950C5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 01:45:10 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v28so10819709pfi.12
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 01:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/V/NFt1mgzJBwXL3V0AzmP1AvqnLgrhMLQOOs74ZyI=;
        b=R5+x7eAUROBr+qgLYtn3vxCcpJEXYO9kkI62mxhtsn4BV/PckiM+USMKglkQpoZrP4
         C4gd0Gv+Bdmi1kcVl4r3O06UkrmvKPMr5uCg2QSpePSyFUodjvI9lbYcTLy2Acj5Nf//
         pVeOJACSGNskxhLkXy2J55q2WtmiDXH2Bken/HV/Oo0P8+Zb4flt6fb9Rvh58nyoRVhT
         MK6CguXwpKtzLnr12zAo3rnW79lJ8MtUYfL3PEkX/fK9X1b4Z9dfxQZV5eZwvS3M9R07
         nmeqqelygbHSGSAjooO6fCpvlWYXGwr6I1lhcwkq9oe/wLeTJRk861kQN/sKCAneg4Gn
         e/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/V/NFt1mgzJBwXL3V0AzmP1AvqnLgrhMLQOOs74ZyI=;
        b=zOQ2MqJIj5zxB3sbVRUcY2aFqXcQJGzehQfmq2CsRPDevOvpnOS7TGbiRhHsNYr4zA
         5ztHVxRtdVrgGt4teVj1OfjhsWL+GEjorh+9E+9/x7mQUBVonv1R+NWPclq9sn13kndW
         YI7qVi0e0UNMN0eK5DXt5yYATnSKLkF6DvJzJOPP7GpErZLYcRObVFTg4SSSwussjva/
         qV7978PXBoj4MkH/zGYJ7tDfvLg9pJTb9XowBA1mKtapJg1qQsAnvMuVllq+rQVQ1XWV
         LapHyWB4nQ5dNgOZF4W08bS3vTiZgMVbS7nkTuXbUVJ3fwoZE4oIhAHIXzpxGRtPG3om
         0o1w==
X-Gm-Message-State: ANoB5pl/e0sQiMsax3l0mlykVcz9Gi35arpAY6hzAIteQnRHLR3uNAUW
        CyX5slyT7jThldh+8/6DELM=
X-Google-Smtp-Source: AA0mqf7VWktRTSTSo2FP3r4imDS1Dlmmac46+B8GFMPGT1GFGmSAwvwh0H9GxpK8OTYPl8NoJckfSQ==
X-Received: by 2002:a62:1e03:0:b0:56b:d68e:41f6 with SMTP id e3-20020a621e03000000b0056bd68e41f6mr19309603pfe.36.1669023910264;
        Mon, 21 Nov 2022 01:45:10 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709027e4600b0017f36638010sm9135706pln.276.2022.11.21.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 01:45:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v5 1/2] cat-file: add mailmap support to -s option
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-2-siddharthasthana31@gmail.com>
        <xmqqy1s4wyvf.fsf@gitster.g>
        <CAP8UFD1CB90eoWpQmGJbfxK7uHX0-u4BuSE-v=mD1yuW+nnAxA@mail.gmail.com>
Date:   Mon, 21 Nov 2022 18:45:09 +0900
In-Reply-To: <CAP8UFD1CB90eoWpQmGJbfxK7uHX0-u4BuSE-v=mD1yuW+nnAxA@mail.gmail.com>
        (Christian Couder's message of "Mon, 21 Nov 2022 10:40:31 +0100")
Message-ID: <xmqqtu2svdy2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Yeah, right. So I would suggest the following:
>
>      git cat-file commit HEAD >commit.out &&
>      wc -c <commit.out | sed -e 's/^ *//' >expect &&

You should not use sed for things like that.

	echo $(wc -c <file)

should suffice to strip away unwanted $IFS around the output
(Note. lack of any quotihg around $() is the key).

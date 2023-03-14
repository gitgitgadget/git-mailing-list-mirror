Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D5FC6FD1D
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 11:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCNLJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjCNLJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 07:09:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1559B8C586
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 04:08:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so14746004pjg.4
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678792127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIGGfyJUlgdw/1o4fMo7+vTO7lYBlrTD9BOGqxttSJk=;
        b=ADcRFtfmkdQlBybo7ZdUw6NQiz/Gh/+3VOSAvonKwK63PqV7I2LqrmQJvQzGA3LFTD
         xbPsat5Rgk9Co4KHyhIjT1JDPGSGR/LwH081eZ/mlehFz/ESKrHmZ7TRWOgQlgrBQsj6
         AIi9y3HU+yCPnjuA7tVje0YEDc2LpNCZ1671VhYeZ32L2gMljYcdAzQVP+Lo2OvIHkF5
         YK0ySrI+AsACB2b3hTam/Ms4qaWHuAAdM5mPSc7Ylzw8yFD2TSnqZFAEOjTX5i51cMyg
         AcB5EQpnseZrVsDCspT675pfKdhoz2VAZuL8yRrFqj+g/AMr1rbRi2O4evTWeKEF2i5V
         n7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIGGfyJUlgdw/1o4fMo7+vTO7lYBlrTD9BOGqxttSJk=;
        b=QHquiJlUj8LqjwV5ZSYFCjyIgjaFTMh1DtPAJSpX2yQm9NzwDfbcqmYrF22szam8Ek
         huPIV8ClMhsNMe4JnDupp9FHlydnJ20VCPl+3LH9BEPVWQBqRSsMz/cMk+xSFz9AWVRf
         cur0l8DuklpYpKNF6jupviroWEd13WBEeQIc1fYfv6sxtv5fuMKnUjFAct9EzkV/j2aG
         2q98l2swL2vnzlgam3Mb7vTVTmCpBc+jNTeW4gte9yqTELvTWc4qN04Jfc5AP3cZ6HMm
         faPgfxhIXLjvFjGgAmrCKXX8tDJp/WM0pmLPT/aoqlhoR3vIMrO/WbmPPU+B9Ofa4mpn
         az4A==
X-Gm-Message-State: AO0yUKVUUv+5OnNMv5bfjjF1jV1eusDszx011Suy/dMNppU2oGmvQh4a
        LD/YDzjUneJW/R3VTfWiNu+0PTz4HZPPvQrO
X-Google-Smtp-Source: AK7set8GFZVBMEZzSPS+n5hRHo2Ur5XSxY2dcx7inM/4Row3AEC3ptDeZBl9OfS4snvnp8hTR4xcjg==
X-Received: by 2002:a05:6a20:2d8:b0:d4:84fe:a056 with SMTP id 24-20020a056a2002d800b000d484fea056mr4356368pzb.27.1678792127114;
        Tue, 14 Mar 2023 04:08:47 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id r15-20020a63204f000000b0050bcf117643sm877606pgm.17.2023.03.14.04.08.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:08:46 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, l.s.r@web.de, peff@peff.net, tmz@pobox.com
Subject: Re: t3206-range-diff failures on non x86 arches
Date:   Tue, 14 Mar 2023 19:08:36 +0800
Message-Id: <20230314110836.11226-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.459.gd58159df.dirty
In-Reply-To: <xmqq8rggm9x9.fsf@gitster.g>
References: <xmqq8rggm9x9.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Confirmed.  That fixes the tests.  Thanks!

Sorry for the problem and thanks very much for reporting.

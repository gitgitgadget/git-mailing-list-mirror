Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF23C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708F722D08
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406950AbhARSGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436613AbhARSGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 13:06:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A5C061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:05:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p15so9942806pjv.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:subject:from:to:date
         :message-id;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=VP2TW2YhEd+l9F6I2b6zz2APOrGZWjqyCjX/Hp/VfFxy7aiEgWAFdMJmuL+pE/uafG
         iWBGfvlkOGkm6Za/IAaMnag85NwCI60ekv0oCeFg2p6E0Ltp1t/f90yxj6+K3JLRTQJ4
         2Jz2egQWjs4kzBBrIZaJtVpV8EnYMC66gNGuEkDWG/gexEMamwrp/n1KXx8MkHLB0R6x
         gh4ctsk3Z9uGMqcGcU6FGoqoJLbIYbSov2O0Pn6emCRvOG7fi6xFTATL4ekjtzUTrfE3
         YVkcY17OcHHrHzPMYxN+PjvMQe6OHzOKCcithITSd9H0wJgHBbPZHw/CUqwOiR2CCkDV
         tJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:to:date:message-id;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=J+eMP08STYTETBpRCFJquNii5Jatul7k89FxLauq/J3WzXpPzjRKMPQO4iTXvZPnp7
         e4bGLLLGZvJWdYf6/rqD7ZbGo81ZO1/zZaK8U+Vu50FQZAEYuzYkycfJWxfPuQnxvISP
         v5gd4MgjYGNW5olC/LFRQrRpEw91RkuAQRy+PG84OubhW2iGrrICY1vZriI01NJrP+Vm
         pXtA0q2WBtvbK2TKAUAkex7KCY5AxS9Vr4XJ0zJbTTcCdyU9q4zueAKOnhmVcRXn0dkP
         Lw0n6mqhxonHKYmlNApv/PFi1t8d2V+TIHKtyvJ2j00wu8e283QKEEAYnuoqPxhXUtx+
         cAgg==
X-Gm-Message-State: AOAM5334AYjt9+zoat8bvAzqAal7pMe4aehr7SKXnhH0OEt0Ibssnu23
        2hofZnYn7zQLGiK2jFZcSEU2JGpA+oXO6Q==
X-Google-Smtp-Source: ABdhPJww1pXF3FuIHd3JiRG6y7WlVBGpx7u1Jke8Qg4D+H5bllue+LGdFNBNK80uZJ6LdrBCR/KCiw==
X-Received: by 2002:a17:902:d715:b029:de:ba0f:2503 with SMTP id w21-20020a170902d715b02900deba0f2503mr648325ply.70.1610993137859;
        Mon, 18 Jan 2021 10:05:37 -0800 (PST)
Received: from localhost ([193.37.32.44])
        by smtp.gmail.com with ESMTPSA id q35sm43140pjh.38.2021.01.18.10.05.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:05:37 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: DEVEL: Help with feature implementation
From:   "FriendlyNeighborhoodShane" <shane.880088.supw@gmail.com>
To:     <git@vger.kernel.org>
Date:   Mon, 18 Jan 2021 18:00:23 +0000
Message-Id: <C8MHALZN265H.26C215XSL8PPK@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


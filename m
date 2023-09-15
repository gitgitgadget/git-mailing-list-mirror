Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E013EED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjIOSpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbjIOSol (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:44:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0533C3D
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:43:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7edc01fdc9so2638168276.3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694803403; x=1695408203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9T2HKtyNqm3gARmL57441WLzxOU6CrqsYsUSbtrAoQ=;
        b=Z4Yw8q8S/h/Mk/JipMeTgc5DVN8UDmHI/Uf4YDZXLDUGsoVv9AjX7oWsNrTOFOCUoC
         vXLxjpdB+6N6sqswQt2cGeUJ+FohH63K/O0bsEXW5YUgQSVLga0ACJYG1MmZLP2wN5Fp
         kjDso0MUyyZn+7jpdzt9c31pM84F/+Rq9EdZT4IbikoYe4qkkjqyGdlOWedw99Q5RZoe
         Qs0DWAixPCF00KdSEWPDIK7chWIWQ6lJXnIPlWngCTlttyAr7kNCPC0Uz8KA/X3Ik8jS
         bzNVDEhJFEsT2ANOVdHXJXFHyJjbTOendq16XladjagYmvKrVlfyOG6xVwhnHNl9cGl3
         MHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803403; x=1695408203;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9T2HKtyNqm3gARmL57441WLzxOU6CrqsYsUSbtrAoQ=;
        b=Uf4bWt0e/XdRRo4keffQZcmjBu6KjagkYx9ip0Y5Tcd2FkILsrn99gros0KJB24SbK
         985OtnrQ74syU3F4WM8mx49Wah1qGBVH4V4jDuLiUriV2a1UEjJYCs+SUOoeI28HgkUE
         obZcqo3Sxit1dZaDKQOrBMNC8DH8fjYlF7fItOdFHDdprMAxgwbVs7ptG6s0uZT+DCyg
         YCtbCN5+whsD8Iv2T3tttNtyYCf+iQzvaMgsqvBEyY56s3JRnFibLK22oZuBWxlsqaKr
         m9aGS6xKJKvfe9y7JUS2Fwyqd+OIIrktKL2S+6gwC0dqZvtgnYIxV0tvbw6STweHRuTT
         QIiA==
X-Gm-Message-State: AOJu0YwirAOhyj/4UgcKZPYq0kaP4UASoy4pd6LPl8sdfnU8jLZhUc7l
        OULIdYhOEKnGU5R36d9oDLBZAfyyAOTNXNvwGjHj
X-Google-Smtp-Source: AGHT+IEZQP+CAUgrWQR5+p7MPMFn2L3m/SL8q2fH9R94TUzFC3NjPQQnx73+AKqyh2Tv+obTdXW1LBLZ1D0mYxq/wIDw
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:841e:7bbe:cbee:5eda])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:181b:b0:d81:4107:7a1 with
 SMTP id cf27-20020a056902181b00b00d81410707a1mr52968ybb.2.1694803403336; Fri,
 15 Sep 2023 11:43:23 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:43:21 -0700
In-Reply-To: <20230908174443.1027716-6-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915184321.1598611-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 6/6] git-std-lib: add test file to call git-std-lib.a functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Add test file that directly or indirectly calls all functions defined in
> git-std-lib.a object files to showcase that they do not reference
> missing objects and that git-std-lib.a can stand on its own.
> 
> Certain functions that cause the program to exit or are already called
> by other functions are commented out.
> 
> TODO: replace with unit tests
> Signed-off-by: Calvin Wan <calvinwan@google.com>

I think the TODO should go into the code, so that when we add a unit
test that also deletes stdlib-test.c, we can see what's happening just
from the diff. The TODO should also explain what stdlib-test.c is hoping
to do, and why replacing it is OK. (Also, do we need to invoke all the
functions? I thought that missing functions are checked at link time, or
at the very latest, when the executable is run. No need to change this,
though - invoking all the functions we can is fine.)
 

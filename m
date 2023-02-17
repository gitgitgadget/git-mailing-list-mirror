Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB50C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 17:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBQRUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 12:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQRUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 12:20:40 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C966EF02
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 09:20:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id ay25so943418pfb.12
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 09:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2rfX85g5FrDSWGzj7Y0W2BGTCcYsCbyjGSyqz+PsgM=;
        b=MmAbIGQdz2iGzhL6vLM7BJE6qj8OIDDrgxgNUNIdNEMMpxE79h2AXUQnVvhI63iMPG
         gvWla2VMVQ0rPBiTN4GDGTTSXuH+mdA3++cDCZehTFuNzi335R7VGgyt9nHWvqnDRVHX
         THfC7ZjUf1cEHJD5jGlYjpbofgxg/hJYuRMMn6FvHPDlxDzjPyfQLcKdKhyPDPSVwpyV
         /3q2EGhCkrWLFy0cT4y8pH1Utqom3JeAtzLfpeqshoArWNCGLUhbj0/SH5DTJ+DMHx25
         D9VzampGbpwe42bHkANHHjmLy3+coO6li6Z2lA5MBpZZtQa7HZkW9ZcJuTmieEzs8ToK
         YR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2rfX85g5FrDSWGzj7Y0W2BGTCcYsCbyjGSyqz+PsgM=;
        b=oV0uuPUmdZHjJbARToauroFch1/ZPSLDw5J0EB2vFgkO54jf9BlwhXDokuAgFRaWqL
         DU3JXxa/hY5+I43WbvWG3s7mda8QWiCB5BkomWep5aAleW8QjIQHHUIcmroAFcHmvVCU
         y7HERPsPkjn9mfsFpQu4ccZGDZIovfqhGzIgVBDK25VtV2VBNisZ1c2WOa7tZWrO7vfr
         vKP67E/ftEcTS6/Pf/eUPnzmYBYaDQDQMJAcqJZHUa29BjuZhKDaH07l5AB9d9fO5A6f
         /g6oMX62NHsf6ynL88Bl+SmlqTRo70mczGjvW0WqgyUAMA2UA7Vg6lgSWQK/cZqJvHul
         mM0w==
X-Gm-Message-State: AO0yUKXuPUsjzy8k1HwB202XYpYXsXYxSYvwFYGqEOuryH/hneCvpFNu
        QQR7jP9esEkb++ROj/fM3dPCAU9pVG7A/g==
X-Google-Smtp-Source: AK7set8vIilHQSzZkr4x2ihuVPmFJVsJAA2agXIpQK4FFWOitCsDexW3R8Tb+2+w4ZQi6JeU27nf6g==
X-Received: by 2002:a62:7b4d:0:b0:5a8:cc65:5766 with SMTP id w74-20020a627b4d000000b005a8cc655766mr2005776pfc.6.1676654438865;
        Fri, 17 Feb 2023 09:20:38 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.151.85])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78e13000000b00593baab06dcsm3317857pfr.198.2023.02.17.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 09:20:38 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hariom18599@gmail.com
Subject: Re: [PATCH 0/2] [WIP] removed fetch_if_missing global
Date:   Fri, 17 Feb 2023 22:50:35 +0530
Message-Id: <20230217172035.79864-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <pull.606.git.1587412477.gitgitgadget@gmail.com>
References: <pull.606.git.1587412477.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Are you still working on this? If not, then I would like to take this up
and write the tests, if it is worth doing. I think it would be a better
exposure of the codebase and would be helpful for GSoC.

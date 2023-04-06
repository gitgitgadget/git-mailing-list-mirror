Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F6DC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 17:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbjDFRI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbjDFRIz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 13:08:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F893DE
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 10:08:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so51762305lfu.5
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680800932; x=1683392932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhayxRLs4R4P6zluBc6GmkT1H95vAY6muokY87xGmxc=;
        b=HMDQvJ1xiByi7hwLYe9t9x8vGYYREoAPByUNtUgKLLMvkJQDyYkKMKR/OfZGlO0mkF
         VMMG1lwSsVL/x2zmORJinu0SrYNAYrCvmCI3I8CDKnRmUK9g/z60oc2VVJU1tPMVVnzq
         UusXcf5YP+WaD2E2W2s3e/O4G4yNHVsjuQ651Icmh+FD75u/CcMoPYpJoElLYVkaEtr0
         J+eas2xkZhlhevmUliqb2bBo3gcnKdgCtt+8oZ7I/0Fp6CExx1OE5c6/rBo/KyVbci8q
         ROuD1KdAUQb5E406URSUviRzn1X0BqH5z5f2wMjJ487Ep1DxmGMXbM1E+n7/cSHJn3qN
         ozJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800932; x=1683392932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhayxRLs4R4P6zluBc6GmkT1H95vAY6muokY87xGmxc=;
        b=IfgC0s8ltDMPOQmIlM/YZmaCX2r2c4Pnz9IJNr4/ubOhzpWU0mfa7CWi/ei0LUgmTU
         JDV0wYr4qMYu2Er5q3CeTYqKP0zQ+GullPK1dugfSzsZMqoata71Dv5YoRDhgAwrVNto
         eNDPU/8Z1iz3voXT9G6qroI+JphQJ3XjuwhKCc1Yn7mbPGwOFc6vu6z7WvpVtbBlj5lF
         Dd9OQTquF8nU3mS4HXXKlJF52YkE4Dvhha0uHNXe809qXEWbdJGkG6Vy1KNkoVSqjE1H
         +Jw7zFIo/w+YxoL502aQ44No4kS55JI4CvuqJRAfadLeIQW+NmJTx5MKlkZFdr394mc+
         ZTtQ==
X-Gm-Message-State: AAQBX9dcH6deaVlRdECVxDmUYUCHE2UZM2iDjaHSLcXHfRewS8hHlZSE
        duozZZfoiQK5lj+OVof3qGeBCebI5DzREg==
X-Google-Smtp-Source: AKy350ZgYB8TMrtntevaVUuNMFcPVJo57HFoJr0REVsqIbd5QAVqlWyGowBfHZY05HNKzZIrMBCm4w==
X-Received: by 2002:ac2:5d2d:0:b0:4ea:f4f4:dccd with SMTP id i13-20020ac25d2d000000b004eaf4f4dccdmr2510994lfb.68.1680800932069;
        Thu, 06 Apr 2023 10:08:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9c74:f016:4c88:53bb])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24850000000b004e817c666eesm338412lfy.193.2023.04.06.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 10:08:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com, peff@peff.net,
        oystwa@gmail.com
Subject: [PATCH v2 0/2] branch, for-each-ref: add option to omit empty lines 
Date:   Thu,  6 Apr 2023 19:08:35 +0200
Message-Id: <20230406170837.10060-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqq4jq0hp1i.fsf@gitster.g>
References: <xmqq4jq0hp1i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 - Improved commit message in 1/2,
 - Stopped considering flag combinations as an error, which greatly
   simplified the logic,
 - Improved weird test file generation,
 - Removed short option and renamed long option,
 - Changed conditions to check the string length before the flag, which
   imo. reads better.

Øystein Walle (2):
  ref-filter: remove unused ref_format member
  branch, for-each-ref: add option to omit empty lines

 Documentation/git-branch.txt       |  4 ++++
 Documentation/git-for-each-ref.txt |  4 ++++
 ref-filter.h                       |  1 -
 builtin/branch.c                   |  6 +++++-
 builtin/for-each-ref.c             |  7 +++++--
 ref-filter.c                       |  1 -
 t/t3203-branch-output.sh           | 24 ++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  8 ++++++++
 8 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.20.1


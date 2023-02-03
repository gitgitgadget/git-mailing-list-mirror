Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65949C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 23:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjBCXXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjBCXXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 18:23:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639AEA07ED
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 15:23:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m8so6587025edd.10
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s15l9aBTEyGRZvE5ciKCSelLgtDvxHPpSaEX3wkTjXo=;
        b=Bx4q8BcZTB24BJ/qJLDkHosvADUCPwVtCtI+g/EQ1k/dqIgGKYzQEnHQnpLwOkHZ4p
         3luQvzhDxTg+7nFWjet3cMGh9vvXkpRrDP6JYXwi3tKYl/h8mL4Gkvt4CLfrak2HNhsG
         9srtI67ScCpwOZgvQXSaKjYl3QKA4YhUwYGS6+guwKPH1tMmonnca4+wKT/qKN84R/yP
         3N2IeY5vQzXuM1nLdj+J36JuulQlaLH2D279ltQnNmX2MKbIc4m8cR/bIM/KxI31ZZRP
         rr5QYaLU+RaRfF79N0uGfCrdmu8dfZq0mzmFyIaps3WGer6b22BhW0pUhNZmDiWkvJhV
         crog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s15l9aBTEyGRZvE5ciKCSelLgtDvxHPpSaEX3wkTjXo=;
        b=x7cd9k0YS0DNBRkiKBO6eRtJ9hrmUA4iH49E07x3DdP+uiQO+OzWqVCLE08jTaQDhQ
         PEjU1PLwEes1+SHfGCD0YZ7oO0U9ksDe9oKZCyYT2LWJuCKiZJ5O9pGL2pJguhPKOg+7
         yBuWRsTWivC+bS4PCMjEXLo0luhC8BCjySmIpx/lll4LhHQ+YFSwCKMvVwb0yC6Y0Ucc
         uNvmtM5ZhMvm09L7cy9hFJG5CtBBdNXJ8oyC1CJsInmx/WsefDiZ/Glem6wEeOlI3R0F
         1C0fOoeXLjR05LwX0dOwD5njO2VWC+s0PnX489JF+20F8NT2WtzFeY1YtnN1J/mSXAVK
         gxTw==
X-Gm-Message-State: AO0yUKVK0uoIXeyzW6n8NRmRZABm8kNFnAokcnYhDirlm6FjTvnp/0h+
        l5ZFpRq4ykm0wrXGawgFPY2smOSc2u+LPAg9lfE=
X-Google-Smtp-Source: AK7set9ECfXm4A8rLfbdgbcH7omFjd5Q7JfhXZ7675GQRiaIYtocjopQptejFYkBAGyiN5//VccZ2w==
X-Received: by 2002:a05:6402:b27:b0:4a2:2daf:adcd with SMTP id bo7-20020a0564020b2700b004a22dafadcdmr11914570edb.27.1675466622481;
        Fri, 03 Feb 2023 15:23:42 -0800 (PST)
Received: from titov.fritz.box ([216.24.213.52])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b0049f88f00f70sm1787917edt.7.2023.02.03.15.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 15:23:41 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>, Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v1 0/3] userdiff: Java updates
Date:   Sat,  4 Feb 2023 00:23:36 +0100
Message-Id: <20230203232339.216592-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three patches to improve builtin userdiff support for Java features.  Some
pretty old features -- type parameters aka generics are actually older than Git,
and some quite recent features of Java: records and sealed classes, released in
Java 16 and Java 17 correspondingly, both from 2021.

https://en.wikipedia.org/wiki/Java_version_history

Andrei Rybak (3):
  userdiff: support Java type parameters
  userdiff: support Java record types
  userdiff: support Java sealed classes

 t/t4018/java-class-type-parameters                     | 6 ++++++
 t/t4018/java-class-type-parameters-implements          | 6 ++++++
 t/t4018/java-interface-type-parameters                 | 6 ++++++
 t/t4018/java-interface-type-parameters-extends         | 6 ++++++
 t/t4018/java-non-sealed                                | 8 ++++++++
 t/t4018/java-record                                    | 6 ++++++
 t/t4018/java-record-type-parameters                    | 6 ++++++
 t/t4018/java-sealed                                    | 7 +++++++
 t/t4018/java-sealed-permits                            | 6 ++++++
 t/t4018/java-sealed-type-parameters                    | 6 ++++++
 t/t4018/java-sealed-type-parameters-implements-permits | 6 ++++++
 t/t4018/java-sealed-type-parameters-permits            | 6 ++++++
 userdiff.c                                             | 2 +-
 13 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-class-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters-implements
 create mode 100644 t/t4018/java-interface-type-parameters
 create mode 100644 t/t4018/java-interface-type-parameters-extends
 create mode 100644 t/t4018/java-non-sealed
 create mode 100644 t/t4018/java-record
 create mode 100644 t/t4018/java-record-type-parameters
 create mode 100644 t/t4018/java-sealed
 create mode 100644 t/t4018/java-sealed-permits
 create mode 100644 t/t4018/java-sealed-type-parameters
 create mode 100644 t/t4018/java-sealed-type-parameters-implements-permits
 create mode 100644 t/t4018/java-sealed-type-parameters-permits

-- 
2.39.1


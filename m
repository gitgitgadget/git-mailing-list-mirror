Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5DA202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 16:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbdJSQGN (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 12:06:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:52590 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbdJSQGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 12:06:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id b15so10964557qkg.9
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TmBBWWGFJInygQM1fovtT9mAulpCnRN9gQVhoSdWlw0=;
        b=qzGyGLJZAbs/7/3hKuenloipapEuq/8EnKETD0xCyGVPXor6pIqvOHnMKkd+0OY699
         bdj6V2fdgOnylPnFqHTwN7Pq8E4wkSeSWywp7GO6SmYGLcsx+poju9JugherLqUls71E
         Tme25/3bX7647DQhulLIZ96d3x3NVLgsoMElyilyXG/yFO3t7vYzqIbzHC4QCgdW3LvK
         LJkJngW2Sf5tpjcVmbMGcRB4WIaAspQ8BUV/WHMLgVNhuxqdFIONrAW31MaRKm7iNDzQ
         bi4y509MQxlF/KDUnZok7KR0mqFVXgIJNfykU/YG9qUsxaYjKFzD8Srmpd5C6edvBDhw
         a8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TmBBWWGFJInygQM1fovtT9mAulpCnRN9gQVhoSdWlw0=;
        b=HrveO0hbaj7VOv9riIb5J1JOpC5pj9pk2VmuixYSONzlm/JLSg2qo7O8CgdnohMKXl
         kP+761zGPx2QpsfjD77kxT6JfAFIBmsSh2dWorZURGJvX170AC8XefgySp6qLbscCrcM
         1N5cd8zXpRJrsXLAoyOpG2MeImkUGEm4ILcij3q8PonUAMbc//F9QgdNHyNnPW/o54mj
         an9vEeDaDdrRcz1KEStDRcIuXTMOd0HhWqbvf2A4RizjmYBtFiSZZVYeppvS/Nr7p/jk
         srRfdWtaBEfIxcHGLaT86JMQJdpL3NHHmTHhjLLbcDVQg4uuelGAA/xpl6We0UnloTr3
         HpfQ==
X-Gm-Message-State: AMCzsaUBWt0gx2IGrRsonIO7Z2DFKV88Ni0MzB34UmF1FbPWEJ389kag
        z0txhnIHirVk05oQevipbdw=
X-Google-Smtp-Source: ABhQp+TNU3PNtY1B18WooFgM5OJHWJlvowZ7kmpiP6ojO6ap63fDIhOsVAOelYbNoxUadW6FnmQauw==
X-Received: by 10.233.232.14 with SMTP id a14mr2678610qkg.256.1508429172265;
        Thu, 19 Oct 2017 09:06:12 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id c13sm9377085qka.50.2017.10.19.09.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 09:06:11 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v3 0/4] status: add option to show ignored files differently
Date:   Thu, 19 Oct 2017 12:05:57 -0400
Message-Id: <20171019160601.9382-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous iteration can be found here:

https://public-inbox.org/git/20171011133504.15049-1-jamill@microsoft.com/

The main difference is to address feedback around commit organization
and wording.

Jameson Miller (4):
  status: add option to show ignored files differently
  status: report matching ignored and normal untracked
  status: document options to show matching ignored files
  status: test --ignored=matching

 Documentation/git-status.txt                      |  21 ++-
 Documentation/technical/api-directory-listing.txt |  27 +++-
 builtin/commit.c                                  |  31 +++-
 dir.c                                             |  44 +++++-
 dir.h                                             |   3 +-
 t/t7519-ignored-mode.sh                           | 183 ++++++++++++++++++++++
 wt-status.c                                       |  11 +-
 wt-status.h                                       |   8 +-
 8 files changed, 310 insertions(+), 18 deletions(-)
 create mode 100755 t/t7519-ignored-mode.sh

-- 
2.13.6


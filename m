Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E041C1FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbcLBABR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:01:17 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36552 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbcLBABQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:01:16 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so48774860pfz.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzA2TUiJJpCKDBuI5Al2dmwIACXlqQLjfGlKpbvCLcQ=;
        b=S2pO1SVRGDajvg2eXaS00V39BK8TtaLBp8liNkuuh5zgpSDsQ0YXHAMQCsr7PdAEC4
         SPPTt5siugE1QEV/07WhpiYviEAV8QmIG0RN/K5xo/AjU5hzqObAd0sD1BdipFYd1RJK
         htM30CnTOmst5VzJgZrgknlUhuZtWGCIFLaDhRRcuN+r7LDO7fd+yEsIIgl5gYe61yh6
         jcGsEZScUnbYu74u8gMdNXxbVM/bORm/vPZSS701ZAHuzueu74dchjvbm/4pzZ5jkZwo
         Cnbb1r8pa6HkdVZoVXwMsC9/amQbEYqrsiIEteLqxZBLHKLkSZvNWWPRDzEMTZmUJ6bZ
         VAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GzA2TUiJJpCKDBuI5Al2dmwIACXlqQLjfGlKpbvCLcQ=;
        b=CdScDHfunpfPfgP6kLDlHKRzbhEHOSZOVrj8cDnXL6Px1sT59hoN3n58OSjywGqA7c
         FrAOn2ZTZ6w+Y0eRLvnom9riWkSQf6HrZTzrffuj2dnJz4Ura7WH8dzR8IQaoFzDNYX0
         LZ/04K/RWd2Gb9AHN2V/H746CaQDQAdQW55BY6h4fSDmpU0rrvXVRtu/4G/7FejRmO6K
         e+xKg9PjL8U79QCkbskKs17cnshMrxWmydiDLEURDmqL3xXm1xOYaDu1zH3+8wZLKQQr
         LfozXWndxLSc8KjYX4MYmAIE2n39S/XttvSb5cHZUozecMe9GzII7ZYVJCtKEFbG2zPI
         xhPA==
X-Gm-Message-State: AKaTC037QPjgvYrehg6ygqMSsTfHIyb8+8IFBUN/OsTamr1fcXsj1lP5avU0cUzCw3AeQ5O5
X-Received: by 10.99.207.17 with SMTP id j17mr71783180pgg.57.1480636875686;
        Thu, 01 Dec 2016 16:01:15 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r124sm2692687pgr.6.2016.12.01.16.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 16:01:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v8 0/5] transport protocol policy configuration
Date:   Thu,  1 Dec 2016 16:00:57 -0800
Message-Id: <1480636862-40489-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480623959-126129-1-git-send-email-bmwill@google.com>
References: <1480623959-126129-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v8 of this series moves the creation of an allowed protocol whitelist for
CURLOPT_REDIR_PROTOCOLS to a helper function.  This is to help out another
series which depends on the creation of a whitelist for CURLOPT_PROTOCOLS.

Brandon Williams (5):
  lib-proto-disable: variable name fix
  transport: add protocol policy config option
  http: always warn if libcurl version is too old
  http: create function to get curl allowed protocols
  transport: add from_user parameter to is_transport_allowed

 Documentation/config.txt         |  46 +++++++++++++
 Documentation/git.txt            |  38 ++++-------
 git-submodule.sh                 |  12 ++--
 http.c                           |  32 +++++----
 t/lib-proto-disable.sh           | 142 ++++++++++++++++++++++++++++++++++++---
 t/t5509-fetch-push-namespaces.sh |   1 +
 t/t5802-connect-helper.sh        |   1 +
 transport.c                      |  84 ++++++++++++++++++++---
 transport.h                      |  19 +++---
 9 files changed, 302 insertions(+), 73 deletions(-)

-- 
2.8.0.rc3.226.g39d4020


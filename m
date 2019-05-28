Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E121F462
	for <e@80x24.org>; Tue, 28 May 2019 10:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfE1KPs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 06:15:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32968 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE1KPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 06:15:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so19576552wrx.0
        for <git@vger.kernel.org>; Tue, 28 May 2019 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OftO2OxU3jPKpUwxcLglzbs5Kj1zrRakSZCAqSdLDU=;
        b=Dsr7eExwXcL1DGwgbKrZy0FQK6bl3fVsW8+JEWUsP5fc/6aR8mffS1npcqkcrInyoV
         YxulYRnkP5bj+xprmNmAX/umm26XV3XOegoRxCyAhrmFUo8T9MZb3sb+TK/JJCjIS0ra
         3KGLd/hC8ukX4fiJTlS5KL3y6dMt5Qi4VAbg2EmmhvKjd8KEPL8zWNIWn3FY0HBilZsQ
         BwDjOuBcI80/OOqxTuBN44PtPBd5d8mia9eOkELGI9YOqbAQ2FkUQsg0hq0PGf/9r2wB
         eAl3ogWYDqo7FZ9nHNG8B2gHItwNJpnl1GACvL20MEg+nG+oyGEJqcvlXeJIPElYAFZn
         KKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7OftO2OxU3jPKpUwxcLglzbs5Kj1zrRakSZCAqSdLDU=;
        b=SWBASRWO+nihbn9cPzGWSLjQRa1BsyVI+rOvtKlVyatvMCqNQnPjyMBA4vkk7ZB38l
         4A1QVJ/pVdXpZe5zwupiG/kascuFX3VZ+Jqm5RBCiltPFIPYHnP7nr64a+zFdYuC2JaW
         J/xUWyJ7oxw5IWhVxdV318KH0YgE1+OKODeJDB+ihU+F8ikXXN6r8QPJzRMD/5y/32Vt
         A/rG8Hksnoh2apo4IfSTyODOOlJIll+/30rbLR9lUYcKqF+tf53ZZ/V+qOPOMdvJ71kE
         1OmySrZsdCV5NjTd9aQfZcabarwzaPs0YNd46X9QoXE7NbXWCdBpABcrv9YBpXaRaNvs
         vUQg==
X-Gm-Message-State: APjAAAV2fLxV8Qrde7WUo5cpS9GvI3oOslg0yromQQZlfV3MZGDOimpW
        Us47yz18hpqWCMxNghF5f11D6MMn
X-Google-Smtp-Source: APXvYqx7T3zniPQ5PDHxucLqSqNiwllpKL1YuEb5BnNKH7Hndx+VN/8d36h5Pz+b+ae6rj2MmciFlg==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr3564473wrr.21.1559038546143;
        Tue, 28 May 2019 03:15:46 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:c43e:46a8:e962:cee8])
        by smtp.gmail.com with ESMTPSA id d9sm12339721wro.26.2019.05.28.03.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 03:15:45 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] request-pull: warn if the remote object is not the same as the local one
Date:   Tue, 28 May 2019 12:15:41 +0200
Message-Id: <20190528101543.16094-1-bonzini@gnu.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

In some cases, git request-pull might be invoked with remote and
local objects that differ even though they point to the same commit.
For example, the remote object might be a lightweight tag
vs. an annotated tag on the local side, or the user might have
reworded the tag locally and forgotten to push it.

When this happens git-request-pull will not warn, because it only
checks that "git ls-remote" returns an SHA1 that matches the local
commit.  Patch 2 of this series makes git-request-pull remember the tag
object's SHA1 while processing the "git ls-remote" output, so that it
can be matched against the local object.
    
Paolo Bonzini (2):
  request-pull: quote metacharacters in local ref
  request-pull: warn if the remote object is not the same as the local one

 git-request-pull.sh     | 46 ++++++++++++++++++++++-------------
 t/t5150-request-pull.sh | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 17 deletions(-)

-- 
2.21.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D641F404
	for <e@80x24.org>; Fri, 23 Feb 2018 14:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeBWOsE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 09:48:04 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33879 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBWOsD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 09:48:03 -0500
Received: by mail-lf0-f67.google.com with SMTP id l191so12713467lfe.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 06:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vyVI2/9d9L6+5pteMjTRTvyIknZ64MziLRVafQnpBmE=;
        b=ba7E1lEFdn1Fp83jll/OMrNWV7KtrYoaBzOFk7YcksO8pgQPW4/zJYi8jDKpAMl9eV
         H2KYDFDpp97Cnch23AbPWLG6c8LXG5WFj0nJm2EoiVrsK8efT4CNTx5cGXvDNFtXOwWT
         Fmc6SoarZn6TNPJKTOaRmhPLIDRcD0K6vm7lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vyVI2/9d9L6+5pteMjTRTvyIknZ64MziLRVafQnpBmE=;
        b=h1/fqJBsp/dYYynV1nVYtKMtmkjOy387n1CBCw8N82snuXSVQh0/IZkCzBGD1fXTiY
         d6qK4/zKGYYRhzdbNLGiWiIaRP1OiCE0QwXA+1T1dVAc2a9BFVbQBaO5a3QUt36xwDN4
         p5aeJAD8wXGLfdw2tj9g2MIFaXJsy3sZoL7J9U4Epp53kMEZC5PlZv3fABymEoMfkQ6y
         7e9sJgLrMpiJ+MA66TcM5FPQvFgjt/Y1CyqVqmb6gNfSsidnsYX0jt9zYc68c+ublcUv
         oD/kPHj0gQ0kytdzt9oFIHdnRzcYGWVErSq2nZzhnzHryofviVDBmmcyhA9xEq6KPd+N
         o+Ww==
X-Gm-Message-State: APf1xPAOO0+JJfHenmMmZRKrgS+slyKapk/wRCtOmM3bgOAnNAa75zrG
        W2LjswVBENKIinkj7bOgc8KDqY6QhVA=
X-Google-Smtp-Source: AG47ELs6wqDquv3XwUnFxXX3SZlx2PiKQtv4qxi6ir++tD+BfqwX5KgLdEnPMjNWqLI+VKMxr3Wc7g==
X-Received: by 10.25.125.213 with SMTP id y204mr1640431lfc.32.1519397281653;
        Fri, 23 Feb 2018 06:48:01 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t21sm497958ljd.55.2018.02.23.06.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 06:48:01 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 0/2] two small grep patches
Date:   Fri, 23 Feb 2018 15:47:55 +0100
Message-Id: <20180223144757.31875-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:

- Drop patch 3 with dubious gain/complexity ratio
- Add comments regarding ownership of grep_source

I was a little torn between copy-pasting the comment or just saying
"see above" in the second case. I think a memset would be confusing,
at least unless one extends the comment to explain why one then does
the memset despite the first half of the comment.

Rasmus Villemoes (2):
  grep: move grep_source_init outside critical section
  grep: simplify grep_oid and grep_file

 builtin/grep.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

-- 
2.15.1


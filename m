Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DAFE1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIRDQC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:16:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46255 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRDQB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:16:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so18810523wrc.13
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQDGX29O+3Eburn6RtFfCzVM8hRhjaCfCmoo5hRCdhw=;
        b=mkDZEKVjsZJ5VKWNDtET0zKijyhbUavPvDIjjydlmebEd5qSVnD9RScsaicTnpX2Id
         oFV2PGJR0+Gt8D+a7zgkc4Zc6M4QGSsIvNnOsi+bI3aWjdmAsypt0DvKcvj4HqA5XZA8
         L20gmIXL3UcwxiVcqzsiowC2Ik3AlGtJPcyCGNvuLNbVvsLNLvwr1pUzLHWvhXhhLxA2
         p88ZKcD4MKi1+P9h3bv2TsjqzAucDNsjgvB+X5O6DQ0GEBgGa3kf/BuchBlv7pxm/uJG
         Sg7eHQz4vb9+fzCDXN7vgdmqj5kRdnThqwQc7pbNtWV07isBZmcIA8HZQN4hwuN1mOXv
         BdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQDGX29O+3Eburn6RtFfCzVM8hRhjaCfCmoo5hRCdhw=;
        b=XpcxfyZfHgpV3cNmsBy3MQTSZLDh+9Cne32f/FYdbgYXXu/4xPfjCiHauyIjtllynU
         ak5xp1MxYLRuh6NiJ9pc3uLqUYEPg3inGkzQn8++iZQ6qcFaOP6XmY+UwUQxncsvdRPj
         WIx5ruBM3MEE8C3rn19m6WTVbnsl7s96D60jLgAlnP5SnyTCXVK2mgK06vNLq0R80wbp
         kBvflKAmBmW07G118c+NEiG+wn3D/VPL50mW9ANaX1O9G1Autv8vrerwwB8jf2f+Inp1
         elRczwZ65oE0nf8KL6yjRiVNSzsgYIkGYrvAf7cQXGL7Qrt0Uf0oHTFeBNne9jYAHISF
         IBqQ==
X-Gm-Message-State: APzg51A+FncteG+vUN1H23K8sNjH10iTPkrCD5hRDO4FO5A41YWYCvPr
        xUHSCOfzvyPJtZVYiuh8Sv0RCdsf
X-Google-Smtp-Source: ANB0VdbChwzUZrFQjm5U7x6GhNG6HnFyZmDtHVYIc7YIcckLDeoXrsJVk3Ohjivm2/oReVPdCQMp4w==
X-Received: by 2002:a5d:4b52:: with SMTP id w18-v6mr20317979wrs.87.1537220808877;
        Mon, 17 Sep 2018 14:46:48 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id a9-v6sm421520wmf.28.2018.09.17.14.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:46:48 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/2] t5551: compare sorted cookies files
Date:   Mon, 17 Sep 2018 22:46:26 +0100
Message-Id: <20180917214628.28325-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef
In-Reply-To: <20180917191806.19958-1-t.gummerer@gmail.com>
References: <20180917191806.19958-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jonathan and Junio for the comments on the first round.

Changes since the first round:
- add a preparatory patch to modernize the test script
- add Reported-by to credit Todd
- just use 'sort' instead of 'cat | sort'

Thomas Gummerer (2):
  t5551: move setup code inside test_expect blocks
  t5551: compare sorted cookies files

 t/t5551-http-fetch-smart.sh | 68 ++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

-- 
2.19.0.444.g18242da7ef


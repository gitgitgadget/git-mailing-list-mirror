Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF2C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjBUVrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBUVq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:46:59 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEDE31E13
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:46:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q5so6597656plh.9
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH/jpK/g8oeT3Refx0R0FvO4O4cMJaeZp+iEkUswa5A=;
        b=gXaNg64MkXiPDX+4IxtytWacHxixQG0p0WAwKp3W2wEjWGzF6WW3ifZh0Er7QKma71
         oZhsqrLVLvjX+u4urXw0scCf3V50qLMidBOzNRWmS5EOwMXIXPNL4zmBRgX55BrOajhq
         J5s8Pa/uuNnSkbv8rjdtmUChy/e9MuHGRLIh3Tzhlw/Kykk8sKWTRVjvOpPpwlCxrsSm
         osZKVZ8nf8d/36eWyYcJJFZh0DXZF2TtxYdIwKmVdd0HZEXiBfTRSwP94BatTcfauAcf
         Y1tPFIujdzw6okkmAfT8aLt2mvn3Hjm8gNf0N9z5ikLsyhkgx92D2o9GLI92hZIka0Nd
         XbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH/jpK/g8oeT3Refx0R0FvO4O4cMJaeZp+iEkUswa5A=;
        b=z5HNrVBOmEs8f1GDf4AOhHyasqwldGMClaAiLk1565CIX/iHeEf54LpLrS+8XYIgIC
         oESe0jp2FWu3iDzGbYXOFHnji2r93PupPPWk1g5NDGRkgwH3o93lNIqSn4NxWFG34z9Z
         Alk8scNH8KL/tRphHzJtxFVSqmLFyT4QjTohbMfZashsRxOcC04gasXHzeHTnHCG0IIj
         J8ZPWJh8rqm96TVDa8SPc5fw8ni459+uigV615QziwklY3LjTxuXDDUZ5ud0ZAcFpMQb
         kZMbMB+jME/SsTcJ/0tCBZMHYuF5ENHiAMO0OJLZFMz8pzTqTzyHUPm6CFe8j/y4xuhK
         7/OQ==
X-Gm-Message-State: AO0yUKWLKnF9gZbTwpGsNCUWbCwkbc9gGO0Rfgj/1ttRbjvReRra3e7V
        m9vRAmdogcrwFLt/YTE4WmRXRaxSHAt4oQ==
X-Google-Smtp-Source: AK7set/8TZa2b7aXAWz1l2bAlhv/CqO9F+2kZ2gOKOdZTd2RUdDTUgD4zchSeQidDmTJ513WPW31Fw==
X-Received: by 2002:a05:6a20:8418:b0:c7:1d60:3cc5 with SMTP id c24-20020a056a20841800b000c71d603cc5mr4267510pzd.22.1677016017865;
        Tue, 21 Feb 2023 13:46:57 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b00590ede84b1csm10325385pfm.147.2023.02.21.13.46.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Feb 2023 13:46:57 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [GSOC][PATCH v2 0/1] t4121: modernize test style
Date:   Tue, 21 Feb 2023 14:46:52 -0700
Message-Id: <20230221214653.85830-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230220235121.34375-1-gvivan6@gmail.com>
References: <20230220235121.34375-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edited the commit message to add what the commit does and added a period at the end of the sentence.

Added a space after the closing bracket in the second test.

Vivan Garg (1):
  t4121: modernize test style

 t/t4121-apply-diffs.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  61f1ed51f4 ! 1:  77fded7759 t4121: modernize test style
    @@ Commit message
     
         Test scripts in file t4121-apply-diffs.sh are written in old style,
         where the test_expect_success command and test title are written on
    -    separate lines
    +    separate lines, therefore update the tests to adhere to the new
    +    style.
     
         Signed-off-by: Vivan Garg <gvivan6@gmail.com>
     
    @@ t/t4121-apply-diffs.sh: test_expect_success 'setup' \
     -	'check if contextually independent diffs for the same file apply' \
     -	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
     +test_expect_success 'check if contextually independent diffs for the same file apply' '
    -+	( git diff test~2 test~1 && git diff test~1 test~0 )| git apply
    ++	( git diff test~2 test~1 && git diff test~1 test~0 ) | git apply
     +'
      
      test_done
-- 
2.37.0 (Apple Git-136)


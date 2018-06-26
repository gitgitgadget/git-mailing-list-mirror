Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F631F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeFZHa7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:30:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40231 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeFZHax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:53 -0400
Received: by mail-io0-f195.google.com with SMTP id t135-v6so1266645iof.7
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ulo4G657VuOgyfSE5G/5V9/zscIfsSJsR7bwYq3rxaw=;
        b=NfM901gLVq9InPZAJ5f26LZ5JoJbiu2SL4Eb0QsEinktM9IxpE4lquM1oo0Cx1wC+Z
         tWX+ZWv2tJDHaSC0gfluIJRRNh3a4MD/hiimeCY+2THtZv8V6SWm5zLr5mo9AbveQSF7
         slgyYKlgq2OIltcK8EoA5LPR2jBlBOQY7fK96ZjdLprmUWOD3ZOYHPAcknMAvdZvcJpV
         eSthpY1HhuxOIbp+9/eM6sLetsr4HUnfxVrlhUNCpraay6fghOOXPVY4jJAQ1Ebuy2GQ
         gFCjoXCHuL/m05qav3LwOAG88SIEh2T7uRDDF6WjUVCfAgNPwwqWm6RGzZLuql7CzhoS
         d0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Ulo4G657VuOgyfSE5G/5V9/zscIfsSJsR7bwYq3rxaw=;
        b=kqe13IIDCJzw2bbHxp+S6vtob+1EdBKGsGdssQUpiHx6XTtZwzhZOX70xQYutiIvHd
         eK8HdtqyUpQDE8dH90OWBb7yscytfWXodnmJ2L4vPYE0YgQxO+AI2F1WDp1JjOrqOrC+
         BN9WHkKHzHrLKYzql32TN75qLC0P6vOcxdqmNi3EVIg8Dpg9JygKFNr6ofEED9nZPf0B
         kWt+J7cBLQsHQpC/8Y20aN+mQHXnqDzOwIYzZc4v79verFmC7uhh7TeJs4IGpSc2KahO
         XLlSwALNqU+ugr0ta47hW+fSEqc/XdPV0BnuQOapxXnz1n+Xhq2Vq2n7wxkjAB2QL4Wu
         GeXg==
X-Gm-Message-State: APt69E11e76G30T0RA3+HNXQZOwZUrXQPQl9C6cIi4NZgPpKUzshpzdr
        +cYt+k2GWpmAB5xMYY5GJFPlDg==
X-Google-Smtp-Source: AAOMgpeWVxf1YvGUSB0fP5QIrJ7Ae3FPZ2jYh7NjGvBU4Z37syo3DEBBaWxwxp3lS2lmbsIL3Uf+xQ==
X-Received: by 2002:a6b:5d09:: with SMTP id r9-v6mr297503iob.170.1529998253156;
        Tue, 26 Jun 2018 00:30:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:52 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/29] t3303: use standard here-doc tag "EOF" to avoid fooling --chain-lint
Date:   Tue, 26 Jun 2018 03:29:36 -0400
Message-Id: <20180626073001.6555-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An upcoming change will teach --chain-lint to detect &&-chain breakage
inside subshells. The check works by performing textual transformations
on the test to link the subshell body directly into the parent's
&&-chain. Special care is taken with the final statement in a
subshell. For instance:

    statement1 &&
    (
        statement2
    ) &&
    statement3

is transformed to:

    statement1 &&
    statement2 &&
    statement3

Notice that "statement2" gains a "&&".

Special care is is taken with here-docs since "&&" needs to be added to
the "<<EOF" line which opens the here-doc, not the "EOF" line which
closes it. For practical reasons (namely, transformations are performed
line-by-line), only here-docs tagged with "EOF" are recognized.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3303-notes-subtrees.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index 704aee81ef..e353faa50b 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -39,7 +39,7 @@ test_expect_success "setup: create $number_of_commits commits" '
 		while [ $nr -lt $number_of_commits ]; do
 			nr=$(($nr+1)) &&
 			test_tick &&
-			cat <<INPUT_END
+			cat <<EOF
 commit refs/heads/master
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -47,15 +47,15 @@ commit #$nr
 COMMIT
 
 M 644 inline file
-data <<EOF
+data <<DATA
 file in commit #$nr
-EOF
+DATA
 
-INPUT_END
+EOF
 
 		done &&
 		test_tick &&
-		cat <<INPUT_END
+		cat <<EOF
 commit refs/notes/commits
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -64,7 +64,7 @@ COMMIT
 
 deleteall
 
-INPUT_END
+EOF
 
 	) |
 	git fast-import --quiet &&
-- 
2.18.0.419.gfe4b301394


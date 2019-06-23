Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3661F461
	for <e@80x24.org>; Sun, 23 Jun 2019 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFWUGA (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 16:06:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45472 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWUGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 16:06:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so5633051plb.12
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ir7JxHJ/FYsOYPO2NPtj5wOahJ0DH/LmYX8zPFtTTFs=;
        b=KMoh3iRSuJOtwIELIAyeaRQrMNtweszu94XNAkj2EOyg9WECqRL0sMpkSnLVgRDjAd
         oJfciQys0nZEIc8H1BS2uq9hT3EHjcYBNf1sdUouKtOJPChdF7w/PAjf45gDiFqJhEch
         Z/CZ7rRZsWWc6+uuM4HH00fEv6pwU0YumxjX6PdTAMa8cEVOnIPiLkOBX8HFEY8JGmxv
         V4bW9fqOK8MXnsfXEB0jvvP8kSodihMc6RYtH2CRDTLen1QQyQeXNQqhuMMHZmRwu25F
         +1ZKzPIBJMhX/XArnQ3I2qwqvdfFAtKXY+G2fgkhWgT6+aAE5TfQ1BRexmnXKE/3XbVR
         m5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ir7JxHJ/FYsOYPO2NPtj5wOahJ0DH/LmYX8zPFtTTFs=;
        b=W3xpuU9q4fytl43TBUICJoEoePI5xdQwl8rFajfUW0E31FtrHL1Nghm7VEIlRFUU/Q
         yDb1o5VPCyKK9J3wc6jxR6socVvOXMAOdpR+YEpeduPZnuuGbjM77pIM90s90p0naLpP
         jbWBbXX/hjLBn9J7SdYUgvvPVhMUeqvjHSCs288I8fFN7ygRDDqzML0mzRI8HRU7Y/M+
         2gBWDKU+TZ1EPa8O79M0Mh6M5EyQKGRecK6b+Qp1qx78+IKAqNmZCultD19QVHWeLoeC
         lm8HbIbR/sxhj1gna8lx2vKAhJf1TFaB1iVD8GNPCJoJh760wfF5bC1uhBPEaLfqKrRM
         dwjA==
X-Gm-Message-State: APjAAAXbgC4ebckeT4YJZswwFT12jQhoL9ap5nOFcQck4FzQXY9rhq62
        ejKmZlENzjK7ZuZqp9a51vw=
X-Google-Smtp-Source: APXvYqzYpZC1B3l9mLLTql9FYOeDCUsDyHVXwabLn1kX+vFao7YDgSBhlti7oGYPPNbII63vcscv5Q==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr103526987plg.62.1561320359630;
        Sun, 23 Jun 2019 13:05:59 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.213])
        by smtp.gmail.com with ESMTPSA id 27sm8621882pgt.6.2019.06.23.13.05.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 13:05:58 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v7 0/6] Teach cherry-pick/revert to skip commits
Date:   Mon, 24 Jun 2019 01:33:32 +0530
Message-Id: <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tied all loose ends. Add an advice config variable to guard advise() call
in 2/6.

Rohit Ashiwal (6):
  advice: add sequencerInUse config variable
  sequencer: add advice for revert
  sequencer: rename reset_for_rollback to reset_merge
  sequencer: use argv_array in reset_merge
  cherry-pick/revert: add --skip option
  cherry-pick/revert: advise using --skip

 Documentation/config/advice.txt   |   2 +
 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 +
 advice.c                          |   2 +
 advice.h                          |   1 +
 builtin/commit.c                  |  13 +--
 builtin/revert.c                  |   5 ++
 sequencer.c                       | 134 ++++++++++++++++++++++++++----
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 122 +++++++++++++++++++++++++++
 11 files changed, 266 insertions(+), 26 deletions(-)

Range-diff:
-:  ---------- > 1:  207042a895 advice: add sequencerInUse config variable
1:  67c212090d ! 2:  d7c603d47f sequencer: add advice for revert
    @@ -46,7 +46,8 @@
     +	}
     +	if (in_progress_error) {
     +		error("%s", in_progress_error);
    -+		advise("%s", in_progress_advice);
    ++		if (advice_sequencer_in_use)
    ++			advise("%s", in_progress_advice);
      		return -1;
     -	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
     +	}
2:  300d6f64f0 = 3:  b70299c572 sequencer: rename reset_for_rollback to reset_merge
3:  edc35f6a4c = 4:  569122c861 sequencer: use argv_array in reset_merge
4:  2b16d7ea4d = 5:  4580f0e5af cherry-pick/revert: add --skip option
5:  8f278b5139 ! 6:  f6f21b055b cherry-pick/revert: advise using --skip
    @@ -64,14 +64,12 @@
      		default:
      			BUG("unexpected action in create_seq_dir");
     @@
    - 	}
      	if (in_progress_error) {
      		error("%s", in_progress_error);
    --		advise("%s", in_progress_advice);
    -+		if (advise_skip)
    -+			advise(in_progress_advice, "--skip | ");
    -+		else
    -+			advise(in_progress_advice, "");
    + 		if (advice_sequencer_in_use)
    +-			advise("%s", in_progress_advice);
    ++			advise(in_progress_advice,
    ++				advise_skip ? "--skip | " : "");
      		return -1;
      	}
      	if (mkdir(git_path_seq_dir(), 0777) < 0)
-- 
2.21.0


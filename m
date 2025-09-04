Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEF3002D8
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992183; cv=none; b=NX250YvMJR6syYJ+1NY8vOKB28uOqegQphlud05bjnWsL+dQdjGfrKOLABnbkyixF55VuO0CoGtIhyU9OJeUQnD8/oqy5Lw8jY2d2Q5HhVw7eFv0Rg2NMjXIqlS0Hwn3muj2DN36oKHiPNKesnYCp5z7WOPoLLNyOEs3FJHW/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992183; c=relaxed/simple;
	bh=6U865Nx/dOktzwvi4W3DfzNSduLfKtc0sP0xYZWZ+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc6YylEckLjLfvDUWdzqVKPme2v/aGAIYMIbVzEWNAte2VgA7nJjLEkFwCD1jSRqEvkxP+HSOawnwNvwzizM4Iir+HY/PJd6utWV2FvIDbHTEr+/o/rHe8KX8Sf40W+gugNwu8p+LdDgF9kU2KAdQZIIO+z14szn94JZs38Bxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U80o58l9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U80o58l9"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3da4c14a5f9so1353890f8f.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992177; x=1757596977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9jxcFSyIEOvF3gw9TqejCSsbxv7/WPFiCBSnYpXSPE8=;
        b=U80o58l9ZPAELNeOJ/9BW2aFp7dtKUw/fsjn7/AnquDOZA1e+u6UBI6bP8ZkDEikFX
         pXpRxlOCEQHDprR0xQH802ebgqfoOBrmILlMfEoWbzod4j66HP/GQ3Q79mUY5WHQNeab
         IEtwoC9h0SjsqUCZsBlswu2yNM8C771E11A3IA1C+gWawgvFL4D3HJDtWE8KugEmJGTl
         HatDBSYhma2veG9fVrEzKdSwta6hXxeUR7ST6RvtjU4uHqsoPrLPiVNBifQdDTH5bjjc
         qHspeLhS7vnccGkSaJbOeNOmYDAgwB14jkpYtm3l2AxV3Oul8wZNVRPgJXkuudzbG5N8
         MtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992177; x=1757596977;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jxcFSyIEOvF3gw9TqejCSsbxv7/WPFiCBSnYpXSPE8=;
        b=XGXxctPoLKqsRmP+KUkrQyQ57NBZOxIrzbWT0ZfqpkWJUH9kMVnMtcBJIXwjV6mwKx
         Wu41pdoubJtjUDx6LMYaluewPGczoH0CXc3L+4CBOVtNIWPB8XILW5qNJyjG4N4OlPhO
         WcvAQSSIkCrRJiIt/IE70WLnK3cWyP6S9/k1qIGcYlLrinU5x3WT4RtaYvrcrGg+F22c
         FREAbUQniSfEkZJleDBpEC7hkXBsKMJ0PAbVTM6byZgzrgbPiDZTBbR6GdpymQisZYQf
         isEz8K4JiQ0u46s6dB4Pyx0qu+/W3WARLbm9WTfWbvjd1zuNO5thTCOBGvEXG8ruX9Sb
         aN0g==
X-Gm-Message-State: AOJu0Yy3Jtnzbcn/z+mL5c+mIQ5BLmUqFs4l/pJHNDIIAyGATSuyXzHH
	6p2pvcGvVNjvX6JyixqFWpQE5hLNpMwTVbCAsWBHD3HYKJWF5rx/tyMu25pBpQ==
X-Gm-Gg: ASbGncvbDNzPMX+FXa/8JB8CTWTPD0HJRgpgocd1RApJNaxtYXyGmn4r2FbJ+f4HSbe
	PzmxWKy1JCxRr/qPxqn4GM9dfMeYCcz4S7jqvNU/zbDKQAnfSOlp/MLidMxYj1q7c4/EsdTgv77
	uSS3ngekS/AZogjATo3lw9vM6RaAqGA0qak35nsvvU1Vis6UT/F814HCNsbGnvYbh72EAUt9vI9
	boqffTkcKFFSH6doLPevoC6ijzRQhjZlPV6HEF5CF1eZzBvBO2XFF9TkMtOZGF91Kb9ht/0mCVh
	eJ8lzXPrhj04XCzM9F2Fu3WK6MPRTWV8tUZs7ToAUJoIn7DZLP3VPXCXlKrh4tJaIHrHGQ3p5i1
	pE3B9+UmqWLFasYf2yfOtO6kaufN/d5fxGz97nb7G9f64Dr07VgFtsxz3Ow==
X-Google-Smtp-Source: AGHT+IF+Wesju7an5Mp92zsWCovUkKqyMq+yTalDGUKhIeBLSh4yAtPxasUEV0mD0rXZ84iZNnDUAw==
X-Received: by 2002:a05:6000:250a:b0:3ce:7673:bb30 with SMTP id ffacd0b85a97d-3d1b16f01e5mr17486008f8f.14.1756992176228;
        Thu, 04 Sep 2025 06:22:56 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d643dsm28278985f8f.26.2025.09.04.06.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:22:55 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/4] t4013: switch default branch name to main
Date: Thu,  4 Sep 2025 14:21:30 +0100
Message-ID: <2a112a1b983e44a53f52cd0fd1d1ad9b2ba12e3b.1756992089.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756992089.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk> <cover.1756992089.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove one of the last remaining uses of
"TEST_GIT_DEFAULT_INITIAL_BRANCH= main" in the test suite. We have
been steadily be converting tests from using "master" as the default
branch name since the introduction of TEST_GIT_DEFAULT_INITIAL_BRANCH
in 704fed9ea22 (tests: start moving to a different default main branch
name, 2020-10-23) The changes here are purely mechanical replacing
"master" with "main"

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t4013-diff-various.sh                       | 228 +++++++++---------
 ...ree_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...iff.diff-tree_--cc_--patch-with-stat_main} |   2 +-
 ...r => diff.diff-tree_--cc_--shortstat_main} |   2 +-
 ...diff.diff-tree_--cc_--stat_--summary_main} |   2 +-
 ...master => diff.diff-tree_--cc_--stat_main} |   2 +-
 ...e_--cc_master => diff.diff-tree_--cc_main} |   2 +-
 ...master => diff.diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.diff-tree_-c_--stat_--summary_main} |   2 +-
 ...t_master => diff.diff-tree_-c_--stat_main} |   2 +-
 ...-tree_-c_master => diff.diff-tree_-c_main} |   2 +-
 ...-tree_-m_master => diff.diff-tree_-m_main} |   2 +-
 ...-p_-m_master => diff.diff-tree_-p_-m_main} |   2 +-
 t/t4013/diff.diff-tree_-p_main                |   2 +
 t/t4013/diff.diff-tree_-p_master              |   2 -
 t/t4013/diff.diff-tree_main                   |   2 +
 t/t4013/diff.diff-tree_master                 |   2 -
 t/t4013/diff.diff_--dirstat_--cc_main~1_main  |   3 +
 .../diff.diff_--dirstat_--cc_master~1_master  |   3 -
 t/t4013/diff.diff_--dirstat_main~1_main~2     |   3 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |   3 -
 ...ff.diff_--line-prefix=abc_main_main^_side} |   2 +-
 ...master^_side => diff.diff_main_main^_side} |   2 +-
 ...mat-patch_--attach_--stdout_initial..main} |   2 +-
 ...at-patch_--attach_--stdout_initial..main^} |   2 +-
 ...e_--stdout_--numbered-files_initial..main} |   2 +-
 ...t_--subject-prefix=TESTCASE_initial..main} |   2 +-
 ...mat-patch_--inline_--stdout_initial..main} |   2 +-
 ...at-patch_--inline_--stdout_initial..main^} |   2 +-
 ...t-patch_--inline_--stdout_initial..main^^} |   2 +-
 ...--stdout_--cover-letter_-n_initial..main^} |   2 +-
 ...atch_--stdout_--no-numbered_initial..main} |   2 +-
 ...t-patch_--stdout_--numbered_initial..main} |   2 +-
 ... diff.format-patch_--stdout_initial..main} |   2 +-
 ...diff.format-patch_--stdout_initial..main^} |   2 +-
 ..._-m_-p_master => diff.log_--cc_-m_-p_main} |   2 +-
 t/t4013/diff.log_--decorate=full_--all        |   2 +-
 ..._--decorate=full_--clear-decorations_--all |   2 +-
 ...f.log_--decorate=full_--decorate-all_--all |   2 +-
 t/t4013/diff.log_--decorate_--all             |   2 +-
 ...f.log_--decorate_--clear-decorations_--all |   2 +-
 .../diff.log_--decorate_--decorate-all_--all  |   2 +-
 ... diff.log_--diff-merges=first-parent_main} |   2 +-
 ..._--diff-merges=off_-p_--first-parent_main} |   2 +-
 ..._--first-parent_--diff-merges=off_-p_main} |   2 +-
 ...g_--no-diff-merges_-p_--first-parent_main} |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...master => diff.log_--patch-with-stat_main} |   2 +-
 ...> diff.log_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...g_--root_--patch-with-stat_--summary_main} |   2 +-
 ...=> diff.log_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...root_-p_master => diff.log_--root_-p_main} |   2 +-
 ...log_--root_master => diff.log_--root_main} |   2 +-
 ...ter => diff.log_-GF_-p_--pickaxe-all_main} |   2 +-
 ...log_-GF_-p_master => diff.log_-GF_-p_main} |   2 +-
 ...{diff.log_-SF_master => diff.log_-GF_main} |   2 +-
 ...aster => diff.log_-IA_-IB_-I1_-I2_-p_main} |   2 +-
 ...log_-SF_-p_master => diff.log_-SF_-p_main} |   2 +-
 ...{diff.log_-GF_master => diff.log_-SF_main} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=0       |   2 +
 ...ount=2 => diff.log_-SF_main_--max-count=1} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=2       |   7 +
 t/t4013/diff.log_-SF_master_--max-count=0     |   2 -
 t/t4013/diff.log_-SF_master_--max-count=1     |   7 -
 ...iff.log_-S_F_master => diff.log_-S_F_main} |   2 +-
 ...cc_-m_-p_master => diff.log_-c_-m_-p_main} |   2 +-
 ...-m_--raw_master => diff.log_-m_--raw_main} |   2 +-
 ..._--stat_master => diff.log_-m_--stat_main} |   2 +-
 ...ter => diff.log_-m_-p_--first-parent_main} |   2 +-
 ...f.log_-m_-p_master => diff.log_-m_-p_main} |   2 +-
 ...ff.log_-p_--diff-merges=first-parent_main} |   2 +-
 ...master => diff.log_-p_--first-parent_main} |   2 +-
 .../{diff.log_-p_master => diff.log_-p_main}  |   2 +-
 t/t4013/{diff.log_master => diff.log_main}    |   2 +-
 ...iff.noellipses-diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.noellipses-whatchanged_--root_main} |   2 +-
 ...r => diff.noellipses-whatchanged_-SF_main} |   2 +-
 ...aster => diff.noellipses-whatchanged_main} |   2 +-
 ...t_master => diff.show_--first-parent_main} |   2 +-
 ...{diff.show_-c_master => diff.show_-c_main} |   2 +-
 ...{diff.show_-m_master => diff.show_-m_main} |   2 +-
 t/t4013/{diff.show_master => diff.show_main}  |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...> diff.whatchanged_--patch-with-stat_main} |   2 +-
 ...hatchanged_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...d_--root_--patch-with-stat_--summary_main} |   2 +-
 ...whatchanged_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...master => diff.whatchanged_--root_-p_main} |   2 +-
 ...ot_master => diff.whatchanged_--root_main} |   2 +-
 ...-p_master => diff.whatchanged_-SF_-p_main} |   2 +-
 ...d_-SF_master => diff.whatchanged_-SF_main} |   2 +-
 ...ged_-p_master => diff.whatchanged_-p_main} |   2 +-
 ...atchanged_master => diff.whatchanged_main} |   2 +-
 97 files changed, 217 insertions(+), 217 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_--summary_master => diff.diff-tree_--cc_--patch-with-stat_--summary_main} (86%)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_master => diff.diff-tree_--cc_--patch-with-stat_main} (89%)
 rename t/t4013/{diff.diff-tree_--cc_--shortstat_master => diff.diff-tree_--cc_--shortstat_main} (65%)
 rename t/t4013/{diff.diff-tree_-c_--stat_--summary_master => diff.diff-tree_--cc_--stat_--summary_main} (71%)
 rename t/t4013/{diff.diff-tree_-c_--stat_master => diff.diff-tree_--cc_--stat_main} (76%)
 rename t/t4013/{diff.diff-tree_--cc_master => diff.diff-tree_--cc_main} (91%)
 rename t/t4013/{diff.diff-tree_-c_--abbrev_master => diff.diff-tree_-c_--abbrev_main} (83%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_--summary_master => diff.diff-tree_-c_--stat_--summary_main} (70%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_master => diff.diff-tree_-c_--stat_main} (75%)
 rename t/t4013/{diff.diff-tree_-c_master => diff.diff-tree_-c_main} (93%)
 rename t/t4013/{diff.diff-tree_-m_master => diff.diff-tree_-m_main} (96%)
 rename t/t4013/{diff.diff-tree_-p_-m_master => diff.diff-tree_-p_-m_main} (97%)
 create mode 100644 t/t4013/diff.diff-tree_-p_main
 delete mode 100644 t/t4013/diff.diff-tree_-p_master
 create mode 100644 t/t4013/diff.diff-tree_main
 delete mode 100644 t/t4013/diff.diff-tree_master
 create mode 100644 t/t4013/diff.diff_--dirstat_--cc_main~1_main
 delete mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master
 create mode 100644 t/t4013/diff.diff_--dirstat_main~1_main~2
 delete mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
 rename t/t4013/{diff.diff_--line-prefix=abc_master_master^_side => diff.diff_--line-prefix=abc_main_main^_side} (87%)
 rename t/t4013/{diff.diff_master_master^_side => diff.diff_main_main^_side} (89%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master => diff.format-patch_--attach_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master^ => diff.format-patch_--attach_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--numbered-files_initial..master => diff.format-patch_--inline_--stdout_--numbered-files_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master => diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master => diff.format-patch_--inline_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^ => diff.format-patch_--inline_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^^ => diff.format-patch_--inline_--stdout_initial..main^^} (95%)
 rename t/t4013/{diff.format-patch_--stdout_--cover-letter_-n_initial..master^ => diff.format-patch_--stdout_--cover-letter_-n_initial..main^} (96%)
 rename t/t4013/{diff.format-patch_--stdout_--no-numbered_initial..master => diff.format-patch_--stdout_--no-numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_--numbered_initial..master => diff.format-patch_--stdout_--numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master => diff.format-patch_--stdout_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master^ => diff.format-patch_--stdout_initial..main^} (96%)
 rename t/t4013/{diff.log_-c_-m_-p_master => diff.log_--cc_-m_-p_main} (99%)
 rename t/t4013/{diff.log_--diff-merges=first-parent_master => diff.log_--diff-merges=first-parent_main} (95%)
 rename t/t4013/{diff.log_--no-diff-merges_-p_--first-parent_master => diff.log_--diff-merges=off_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--first-parent_--diff-merges=off_-p_master => diff.log_--first-parent_--diff-merges=off_-p_main} (95%)
 rename t/t4013/{diff.log_--diff-merges=off_-p_--first-parent_master => diff.log_--no-diff-merges_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--patch-with-stat_--summary_master_--_dir_ => diff.log_--patch-with-stat_--summary_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--patch-with-stat_master => diff.log_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--patch-with-stat_master_--_dir_ => diff.log_--patch-with-stat_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--root_--cc_--patch-with-stat_--summary_master => diff.log_--root_--cc_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_--summary_master => diff.log_--root_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_master => diff.log_--root_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--root_-c_--patch-with-stat_--summary_master => diff.log_--root_-c_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_-p_master => diff.log_--root_-p_main} (98%)
 rename t/t4013/{diff.log_--root_master => diff.log_--root_main} (96%)
 rename t/t4013/{diff.log_-GF_-p_--pickaxe-all_master => diff.log_-GF_-p_--pickaxe-all_main} (90%)
 rename t/t4013/{diff.log_-GF_-p_master => diff.log_-GF_-p_main} (91%)
 rename t/t4013/{diff.log_-SF_master => diff.log_-GF_main} (86%)
 rename t/t4013/{diff.log_-IA_-IB_-I1_-I2_-p_master => diff.log_-IA_-IB_-I1_-I2_-p_main} (97%)
 rename t/t4013/{diff.log_-SF_-p_master => diff.log_-SF_-p_main} (91%)
 rename t/t4013/{diff.log_-GF_master => diff.log_-SF_main} (86%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=0
 rename t/t4013/{diff.log_-SF_master_--max-count=2 => diff.log_-SF_main_--max-count=1} (79%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=2
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=0
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=1
 rename t/t4013/{diff.log_-S_F_master => diff.log_-S_F_main} (86%)
 rename t/t4013/{diff.log_--cc_-m_-p_master => diff.log_-c_-m_-p_main} (99%)
 rename t/t4013/{diff.log_-m_--raw_master => diff.log_-m_--raw_main} (98%)
 rename t/t4013/{diff.log_-m_--stat_master => diff.log_-m_--stat_main} (98%)
 rename t/t4013/{diff.log_-m_-p_--first-parent_master => diff.log_-m_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-m_-p_master => diff.log_-m_-p_main} (99%)
 rename t/t4013/{diff.log_-p_--diff-merges=first-parent_master => diff.log_-p_--diff-merges=first-parent_main} (97%)
 rename t/t4013/{diff.log_-p_--first-parent_master => diff.log_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-p_master => diff.log_-p_main} (98%)
 rename t/t4013/{diff.log_master => diff.log_main} (97%)
 rename t/t4013/{diff.noellipses-diff-tree_-c_--abbrev_master => diff.noellipses-diff-tree_-c_--abbrev_main} (81%)
 rename t/t4013/{diff.noellipses-whatchanged_--root_master => diff.noellipses-whatchanged_--root_main} (96%)
 rename t/t4013/{diff.noellipses-whatchanged_-SF_master => diff.noellipses-whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.noellipses-whatchanged_master => diff.noellipses-whatchanged_main} (96%)
 rename t/t4013/{diff.show_--first-parent_master => diff.show_--first-parent_main} (92%)
 rename t/t4013/{diff.show_-c_master => diff.show_-c_main} (95%)
 rename t/t4013/{diff.show_-m_master => diff.show_-m_main} (98%)
 rename t/t4013/{diff.show_master => diff.show_main} (96%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_--summary_master_--_dir_ => diff.whatchanged_--patch-with-stat_--summary_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master => diff.whatchanged_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master_--_dir_ => diff.whatchanged_--patch-with-stat_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master => diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_--summary_master => diff.whatchanged_--root_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_master => diff.whatchanged_--root_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-c_--patch-with-stat_--summary_master => diff.whatchanged_--root_-c_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-p_master => diff.whatchanged_--root_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_--root_master => diff.whatchanged_--root_main} (97%)
 rename t/t4013/{diff.whatchanged_-SF_-p_master => diff.whatchanged_-SF_-p_main} (89%)
 rename t/t4013/{diff.whatchanged_-SF_master => diff.whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.whatchanged_-p_master => diff.whatchanged_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_master => diff.whatchanged_main} (97%)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index cfeec239e09..55a06eadb31 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -5,7 +5,7 @@
 
 test_description='Various diff formatting options'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -70,7 +70,7 @@ test_expect_success setup '
 	GIT_COMMITTER_DATE="2006-06-26 00:04:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
-	git checkout master &&
+	git checkout main &&
 	git pull -s ours --no-rebase . side &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:05:00 +0000" &&
@@ -95,15 +95,15 @@ test_expect_success setup '
 	test_write_lines B A >dir/sub &&
 	git add dir/sub &&
 	git commit -m "Rearranged lines in dir/sub" &&
-	git checkout master &&
+	git checkout main &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 	git checkout -b mode initial &&
 	git update-index --chmod=+x file0 &&
 	git commit -m "update mode" &&
-	git checkout -f master &&
+	git checkout -f main &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
@@ -112,12 +112,12 @@ test_expect_success setup '
 	git update-index --chmod=+x file2 &&
 	git commit -m "update mode (file2)" &&
 	git notes add -m "note" &&
-	git checkout -f master &&
+	git checkout -f main &&
 
-	# Same merge as master, but with parents reversed. Hide it in a
+	# Same merge as main, but with parents reversed. Hide it in a
 	# pseudo-ref to avoid impacting tests with --all.
 	commit=$(echo reverse |
-		 git commit-tree -p master^2 -p master^1 master^{tree}) &&
+		 git commit-tree -p main^2 -p main^1 main^{tree}) &&
 	git update-ref REVERSE $commit &&
 
 	git config diff.renames false &&
@@ -127,15 +127,15 @@ test_expect_success setup '
 
 : <<\EOF
 ! [initial] Initial
- * [master] Merge branch 'side'
+ * [main] Merge branch 'side'
   ! [rearrange] Rearranged lines in dir/sub
    ! [side] Side
 ----
   +  [rearrange] Rearranged lines in dir/sub
- -   [master] Merge branch 'side'
+ -   [main] Merge branch 'side'
  * + [side] Side
- *   [master^] Third
- *   [master~2] Second
+ *   [main^] Third
+ *   [main~2] Second
 +*++ [initial] Initial
 EOF
 
@@ -311,64 +311,64 @@ diff-tree initial mode
 diff-tree --stat initial mode
 diff-tree --summary initial mode
 
-diff-tree master
-diff-tree -m master
-diff-tree -p master
-diff-tree -p -m master
-diff-tree -c master
-diff-tree -c --abbrev master
-:noellipses diff-tree -c --abbrev master
-diff-tree --cc master
+diff-tree main
+diff-tree -m main
+diff-tree -p main
+diff-tree -p -m main
+diff-tree -c main
+diff-tree -c --abbrev main
+:noellipses diff-tree -c --abbrev main
+diff-tree --cc main
 # stat only should show the diffstat with the first parent
-diff-tree -c --stat master
-diff-tree --cc --stat master
-diff-tree -c --stat --summary master
-diff-tree --cc --stat --summary master
+diff-tree -c --stat main
+diff-tree --cc --stat main
+diff-tree -c --stat --summary main
+diff-tree --cc --stat --summary main
 # stat summary should show the diffstat and summary with the first parent
 diff-tree -c --stat --summary side
 diff-tree --cc --stat --summary side
-diff-tree --cc --shortstat master
+diff-tree --cc --shortstat main
 diff-tree --cc --summary REVERSE
 # improved by Timo's patch
-diff-tree --cc --patch-with-stat master
+diff-tree --cc --patch-with-stat main
 # improved by Timo's patch
-diff-tree --cc --patch-with-stat --summary master
+diff-tree --cc --patch-with-stat --summary main
 # this is correct
 diff-tree --cc --patch-with-stat --summary side
 
-log master
-log -p master
-log --root master
-log --root -p master
-log --patch-with-stat master
-log --root --patch-with-stat master
-log --root --patch-with-stat --summary master
-# improved by Timo's patch
-log --root -c --patch-with-stat --summary master
-# improved by Timo's patch
-log --root --cc --patch-with-stat --summary master
-log --no-diff-merges -p --first-parent master
-log --diff-merges=off -p --first-parent master
-log --first-parent --diff-merges=off -p master
-log -p --first-parent master
-log -p --diff-merges=first-parent master
-log --diff-merges=first-parent master
-log -m -p --first-parent master
-log -m -p master
-log --cc -m -p master
-log -c -m -p master
-log -m --raw master
-log -m --stat master
-log -SF master
-log -S F master
-log -SF -p master
-log -SF master --max-count=0
-log -SF master --max-count=1
-log -SF master --max-count=2
-log -GF master
-log -GF -p master
-log -GF -p --pickaxe-all master
-log -IA -IB -I1 -I2 -p master
+log main
+log -p main
+log --root main
+log --root -p main
+log --patch-with-stat main
+log --root --patch-with-stat main
+log --root --patch-with-stat --summary main
+# improved by Timo's patch
+log --root -c --patch-with-stat --summary main
+# improved by Timo's patch
+log --root --cc --patch-with-stat --summary main
+log --no-diff-merges -p --first-parent main
+log --diff-merges=off -p --first-parent main
+log --first-parent --diff-merges=off -p main
+log -p --first-parent main
+log -p --diff-merges=first-parent main
+log --diff-merges=first-parent main
+log -m -p --first-parent main
+log -m -p main
+log --cc -m -p main
+log -c -m -p main
+log -m --raw main
+log -m --stat main
+log -SF main
+log -S F main
+log -SF -p main
+log -SF main --max-count=0
+log -SF main --max-count=1
+log -SF main --max-count=2
+log -GF main
+log -GF -p main
+log -GF -p --pickaxe-all main
+log -IA -IB -I1 -I2 -p main
 log --decorate --all
 log --decorate=full --all
 log --decorate --clear-decorations --all
@@ -377,35 +377,35 @@ log --decorate=full --clear-decorations --all
 rev-list --parents HEAD
 rev-list --children HEAD
 
-whatchanged master
-:noellipses whatchanged master
-whatchanged -p master
-whatchanged --root master
-:noellipses whatchanged --root master
-whatchanged --root -p master
-whatchanged --patch-with-stat master
-whatchanged --root --patch-with-stat master
-whatchanged --root --patch-with-stat --summary master
-# improved by Timo's patch
-whatchanged --root -c --patch-with-stat --summary master
-# improved by Timo's patch
-whatchanged --root --cc --patch-with-stat --summary master
-whatchanged -SF master
-:noellipses whatchanged -SF master
-whatchanged -SF -p master
+whatchanged main
+:noellipses whatchanged main
+whatchanged -p main
+whatchanged --root main
+:noellipses whatchanged --root main
+whatchanged --root -p main
+whatchanged --patch-with-stat main
+whatchanged --root --patch-with-stat main
+whatchanged --root --patch-with-stat --summary main
+# improved by Timo's patch
+whatchanged --root -c --patch-with-stat --summary main
+# improved by Timo's patch
+whatchanged --root --cc --patch-with-stat --summary main
+whatchanged -SF main
+:noellipses whatchanged -SF main
+whatchanged -SF -p main
 
-log --patch-with-stat master -- dir/
-whatchanged --patch-with-stat master -- dir/
-log --patch-with-stat --summary master -- dir/
-whatchanged --patch-with-stat --summary master -- dir/
+log --patch-with-stat main -- dir/
+whatchanged --patch-with-stat main -- dir/
+log --patch-with-stat --summary main -- dir/
+whatchanged --patch-with-stat --summary main -- dir/
 
 show initial
 show --root initial
 show side
-show master
-show -c master
-show -m master
-show --first-parent master
+show main
+show -c main
+show -m main
+show --first-parent main
 show --stat side
 show --stat --summary side
 show --patch-with-stat side
@@ -414,22 +414,22 @@ show --patch-with-raw side
 show --patch-with-stat --summary side
 
 format-patch --stdout initial..side
-format-patch --stdout initial..master^
-format-patch --stdout initial..master
-format-patch --stdout --no-numbered initial..master
-format-patch --stdout --numbered initial..master
+format-patch --stdout initial..main^
+format-patch --stdout initial..main
+format-patch --stdout --no-numbered initial..main
+format-patch --stdout --numbered initial..main
 format-patch --attach --stdout initial..side
 format-patch --attach --stdout --suffix=.diff initial..side
-format-patch --attach --stdout initial..master^
-format-patch --attach --stdout initial..master
+format-patch --attach --stdout initial..main^
+format-patch --attach --stdout initial..main
 format-patch --inline --stdout initial..side
-format-patch --inline --stdout initial..master^
-format-patch --inline --stdout --numbered-files initial..master
-format-patch --inline --stdout initial..master
-format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
+format-patch --inline --stdout initial..main^
+format-patch --inline --stdout --numbered-files initial..main
+format-patch --inline --stdout initial..main
+format-patch --inline --stdout --subject-prefix=TESTCASE initial..main
 config format.subjectprefix DIFFERENT_PREFIX
-format-patch --inline --stdout initial..master^^
-format-patch --stdout --cover-letter -n initial..master^
+format-patch --inline --stdout initial..main^^
+format-patch --stdout --cover-letter -n initial..main^
 
 diff --abbrev initial..side
 diff -U initial..side
@@ -448,13 +448,13 @@ diff --name-status dir2 dir
 diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
-diff master master^ side
+diff main main^ side
 # Can't use spaces...
-diff --line-prefix=abc master master^ side
-diff --dirstat master~1 master~2
+diff --line-prefix=abc main main^ side
+diff --dirstat main~1 main~2
 diff --dirstat initial rearrange
 diff --dirstat-by-file initial rearrange
-diff --dirstat --cc master~1 master
+diff --dirstat --cc main~1 main
 # No-index --abbrev and --no-abbrev
 diff --raw initial
 :noellipses diff --raw initial
@@ -482,25 +482,25 @@ test_expect_success !WITH_BREAKING_CHANGES 'whatchanged needs --i-still-use-this
 '
 
 test_expect_success 'log -m matches pure log' '
-	git log master >result &&
+	git log main >result &&
 	process_diffs result >expected &&
 	git log -m >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
-	git log -p --diff-merges=separate master >result &&
+	git log -p --diff-merges=separate main >result &&
 	process_diffs result >expected &&
-	git log -p --diff-merges=on master >result &&
+	git log -p --diff-merges=on main >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'log --dd matches --diff-merges=1 -p' '
-	git log --diff-merges=1 -p master >result &&
+	git log --diff-merges=1 -p main >result &&
 	process_diffs result >expected &&
-	git log --dd master >result &&
+	git log --dd main >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
@@ -511,19 +511,19 @@ test_expect_success 'deny wrong log.diffMerges config' '
 '
 
 test_expect_success 'git config log.diffMerges first-parent' '
-	git log -p --diff-merges=first-parent master >result &&
+	git log -p --diff-merges=first-parent main >result &&
 	process_diffs result >expected &&
 	test_config log.diffMerges first-parent &&
-	git log -p --diff-merges=on master >result &&
+	git log -p --diff-merges=on main >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'git config log.diffMerges first-parent vs -m' '
-	git log -p --diff-merges=first-parent master >result &&
+	git log -p --diff-merges=first-parent main >result &&
 	process_diffs result >expected &&
 	test_config log.diffMerges first-parent &&
-	git log -p -m master >result &&
+	git log -p -m main >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
@@ -572,7 +572,7 @@ test_expect_success 'diff-tree --stdin with log formatting' '
 	Third
 	Second
 	EOF
-	git rev-list master | git diff-tree --stdin --format=%s -s >actual &&
+	git rev-list main | git diff-tree --stdin --format=%s -s >actual &&
 	test_cmp expect actual
 '
 
@@ -585,16 +585,16 @@ test_expect_success 'diff-tree --stdin with pathspec' '
 
 	dir/sub
 	EOF
-	git rev-list master^ |
+	git rev-list main^ |
 	git diff-tree -r --stdin --name-only --format=%s dir >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'show A B ... -- <pathspec>' '
 	# side touches dir/sub, file0, and file3
-	# master^ touches dir/sub, and file1
-	# master^^ touches dir/sub, file0, and file2
-	git show --name-only --format="<%s>" side master^ master^^ -- dir >actual &&
+	# main^ touches dir/sub, and file1
+	# main^^ touches dir/sub, file0, and file2
+	git show --name-only --format="<%s>" side main^ main^^ -- dir >actual &&
 	cat >expect <<-\EOF &&
 	<Side>
 
@@ -610,7 +610,7 @@ test_expect_success 'show A B ... -- <pathspec>' '
 '
 
 test_expect_success 'diff -I<regex>: setup' '
-	git checkout master &&
+	git checkout main &&
 	test_seq 50 >file0 &&
 	git commit -m "Set up -I<regex> test file" file0 &&
 	test_seq 50 | sed -e "s/13/ten and three/" -e "/7\$/d" >file0 &&
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
similarity index 86%
rename from t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
rename to t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
index 9951e3677d6..af1cf20f4ca 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --patch-with-stat --summary master
+$ git diff-tree --cc --patch-with-stat --summary main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
similarity index 89%
rename from t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
rename to t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
index db3c0a7b2cc..0ec60420970 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --patch-with-stat master
+$ git diff-tree --cc --patch-with-stat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_--shortstat_master b/t/t4013/diff.diff-tree_--cc_--shortstat_main
similarity index 65%
rename from t/t4013/diff.diff-tree_--cc_--shortstat_master
rename to t/t4013/diff.diff-tree_--cc_--shortstat_main
index a4ca42df2a4..9a4ef031973 100644
--- a/t/t4013/diff.diff-tree_--cc_--shortstat_master
+++ b/t/t4013/diff.diff-tree_--cc_--shortstat_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --shortstat master
+$ git diff-tree --cc --shortstat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_master b/t/t4013/diff.diff-tree_--cc_--stat_--summary_main
similarity index 71%
rename from t/t4013/diff.diff-tree_-c_--stat_--summary_master
rename to t/t4013/diff.diff-tree_--cc_--stat_--summary_main
index 81c3021541b..9db08a4aa96 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --stat --summary master
+$ git diff-tree --cc --stat --summary main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_-c_--stat_master b/t/t4013/diff.diff-tree_--cc_--stat_main
similarity index 76%
rename from t/t4013/diff.diff-tree_-c_--stat_master
rename to t/t4013/diff.diff-tree_--cc_--stat_main
index 89d59b15480..7ecc67a524e 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --stat master
+$ git diff-tree --cc --stat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_master b/t/t4013/diff.diff-tree_--cc_main
similarity index 91%
rename from t/t4013/diff.diff-tree_--cc_master
rename to t/t4013/diff.diff-tree_--cc_main
index 5ecb4e14ae4..1a962856ad4 100644
--- a/t/t4013/diff.diff-tree_--cc_master
+++ b/t/t4013/diff.diff-tree_--cc_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc master
+$ git diff-tree --cc main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 diff --cc dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.diff-tree_-c_--abbrev_master b/t/t4013/diff.diff-tree_-c_--abbrev_main
similarity index 83%
rename from t/t4013/diff.diff-tree_-c_--abbrev_master
rename to t/t4013/diff.diff-tree_-c_--abbrev_main
index b8e4aa25307..039d127cf24 100644
--- a/t/t4013/diff.diff-tree_-c_--abbrev_master
+++ b/t/t4013/diff.diff-tree_-c_--abbrev_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --abbrev master
+$ git diff-tree -c --abbrev main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 ::100644 100644 100644 cead32e... 7289e35... 992913c... MM	dir/sub
 ::100644 100644 100644 b414108... f4615da... 10a8a9f... MM	file0
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master b/t/t4013/diff.diff-tree_-c_--stat_--summary_main
similarity index 70%
rename from t/t4013/diff.diff-tree_--cc_--stat_--summary_master
rename to t/t4013/diff.diff-tree_-c_--stat_--summary_main
index d019867dd94..05a8d16ba70 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --stat --summary master
+$ git diff-tree -c --stat --summary main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_master b/t/t4013/diff.diff-tree_-c_--stat_main
similarity index 75%
rename from t/t4013/diff.diff-tree_--cc_--stat_master
rename to t/t4013/diff.diff-tree_-c_--stat_main
index 40b91796b34..61d9f450dfd 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --stat master
+$ git diff-tree -c --stat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_-c_master b/t/t4013/diff.diff-tree_-c_main
similarity index 93%
rename from t/t4013/diff.diff-tree_-c_master
rename to t/t4013/diff.diff-tree_-c_main
index e2d2bb26114..a84e1185cf5 100644
--- a/t/t4013/diff.diff-tree_-c_master
+++ b/t/t4013/diff.diff-tree_-c_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c master
+$ git diff-tree -c main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 ::100644 100644 100644 cead32e925b1420c84c14cbf7cf755e7e45af8ad 7289e35bff32727c08dda207511bec138fdb9ea5 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 MM	dir/sub
 ::100644 100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f MM	file0
diff --git a/t/t4013/diff.diff-tree_-m_master b/t/t4013/diff.diff-tree_-m_main
similarity index 96%
rename from t/t4013/diff.diff-tree_-m_master
rename to t/t4013/diff.diff-tree_-m_main
index 6d0a2207fb3..5da1f7f5251 100644
--- a/t/t4013/diff.diff-tree_-m_master
+++ b/t/t4013/diff.diff-tree_-m_main
@@ -1,4 +1,4 @@
-$ git diff-tree -m master
+$ git diff-tree -m main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 :040000 040000 65f5c9dd60ce3b2b3324b618ac7accf8d912c113 0564e026437809817a64fff393079714b6dd4628 M	dir
 :100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 10a8a9f3657f91a156b9f0184ed79a20adef9f7f M	file0
diff --git a/t/t4013/diff.diff-tree_-p_-m_master b/t/t4013/diff.diff-tree_-p_-m_main
similarity index 97%
rename from t/t4013/diff.diff-tree_-p_-m_master
rename to t/t4013/diff.diff-tree_-p_-m_main
index b60bea039d9..29c9fc20b8b 100644
--- a/t/t4013/diff.diff-tree_-p_-m_master
+++ b/t/t4013/diff.diff-tree_-p_-m_main
@@ -1,4 +1,4 @@
-$ git diff-tree -p -m master
+$ git diff-tree -p -m main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.diff-tree_-p_main b/t/t4013/diff.diff-tree_-p_main
new file mode 100644
index 00000000000..c658062422e
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-p_main
@@ -0,0 +1,2 @@
+$ git diff-tree -p main
+$
diff --git a/t/t4013/diff.diff-tree_-p_master b/t/t4013/diff.diff-tree_-p_master
deleted file mode 100644
index b182875fb2f..00000000000
--- a/t/t4013/diff.diff-tree_-p_master
+++ /dev/null
@@ -1,2 +0,0 @@
-$ git diff-tree -p master
-$
diff --git a/t/t4013/diff.diff-tree_main b/t/t4013/diff.diff-tree_main
new file mode 100644
index 00000000000..dc5b9fdeb6e
--- /dev/null
+++ b/t/t4013/diff.diff-tree_main
@@ -0,0 +1,2 @@
+$ git diff-tree main
+$
diff --git a/t/t4013/diff.diff-tree_master b/t/t4013/diff.diff-tree_master
deleted file mode 100644
index fe9226f8a12..00000000000
--- a/t/t4013/diff.diff-tree_master
+++ /dev/null
@@ -1,2 +0,0 @@
-$ git diff-tree master
-$
diff --git a/t/t4013/diff.diff_--dirstat_--cc_main~1_main b/t/t4013/diff.diff_--dirstat_--cc_main~1_main
new file mode 100644
index 00000000000..168a357a02e
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat_--cc_main~1_main
@@ -0,0 +1,3 @@
+$ git diff --dirstat --cc main~1 main
+  40.0% dir/
+$
diff --git a/t/t4013/diff.diff_--dirstat_--cc_master~1_master b/t/t4013/diff.diff_--dirstat_--cc_master~1_master
deleted file mode 100644
index fba4e34175e..00000000000
--- a/t/t4013/diff.diff_--dirstat_--cc_master~1_master
+++ /dev/null
@@ -1,3 +0,0 @@
-$ git diff --dirstat --cc master~1 master
-  40.0% dir/
-$
diff --git a/t/t4013/diff.diff_--dirstat_main~1_main~2 b/t/t4013/diff.diff_--dirstat_main~1_main~2
new file mode 100644
index 00000000000..68097337089
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat_main~1_main~2
@@ -0,0 +1,3 @@
+$ git diff --dirstat main~1 main~2
+  40.0% dir/
+$
diff --git a/t/t4013/diff.diff_--dirstat_master~1_master~2 b/t/t4013/diff.diff_--dirstat_master~1_master~2
deleted file mode 100644
index b672e1ca63d..00000000000
--- a/t/t4013/diff.diff_--dirstat_master~1_master~2
+++ /dev/null
@@ -1,3 +0,0 @@
-$ git diff --dirstat master~1 master~2
-  40.0% dir/
-$
diff --git a/t/t4013/diff.diff_--line-prefix=abc_master_master^_side b/t/t4013/diff.diff_--line-prefix=abc_main_main^_side
similarity index 87%
rename from t/t4013/diff.diff_--line-prefix=abc_master_master^_side
rename to t/t4013/diff.diff_--line-prefix=abc_main_main^_side
index 99f91e7f0e3..67a2145a365 100644
--- a/t/t4013/diff.diff_--line-prefix=abc_master_master^_side
+++ b/t/t4013/diff.diff_--line-prefix=abc_main_main^_side
@@ -1,4 +1,4 @@
-$ git diff --line-prefix=abc master master^ side
+$ git diff --line-prefix=abc main main^ side
 abcdiff --cc dir/sub
 abcindex cead32e,7289e35..992913c
 abc--- a/dir/sub
diff --git a/t/t4013/diff.diff_master_master^_side b/t/t4013/diff.diff_main_main^_side
similarity index 89%
rename from t/t4013/diff.diff_master_master^_side
rename to t/t4013/diff.diff_main_main^_side
index 50ec9cadd61..ab81ec9e47b 100644
--- a/t/t4013/diff.diff_master_master^_side
+++ b/t/t4013/diff.diff_main_main^_side
@@ -1,4 +1,4 @@
-$ git diff master master^ side
+$ git diff main main^ side
 diff --cc dir/sub
 index cead32e,7289e35..992913c
 --- a/dir/sub
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..main
similarity index 98%
rename from t/t4013/diff.format-patch_--attach_--stdout_initial..master
rename to t/t4013/diff.format-patch_--attach_--stdout_initial..main
index 52fedc179e5..9f56380350d 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --attach --stdout initial..master
+$ git format-patch --attach --stdout initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main^
similarity index 97%
rename from t/t4013/diff.format-patch_--attach_--stdout_initial..master^
rename to t/t4013/diff.format-patch_--attach_--stdout_initial..main^
index 1c3cde251b5..80132ea99eb 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --attach --stdout initial..master^
+$ git format-patch --attach --stdout initial..main^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..main
similarity index 99%
rename from t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
rename to t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..main
index 02c4db7ec58..8e889090fbe 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout --numbered-files initial..master
+$ git format-patch --inline --stdout --numbered-files initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main
similarity index 99%
rename from t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
rename to t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main
index c7677c5951c..d7d2b12d155 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
+$ git format-patch --inline --stdout --subject-prefix=TESTCASE initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_initial..main
similarity index 98%
rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master
rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main
index 5b3e34e2c0c..c49c423f82f 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout initial..master
+$ git format-patch --inline --stdout initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^
similarity index 97%
rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master^
rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main^
index d13f8a81280..8669dbfe6c9 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout initial..master^
+$ git format-patch --inline --stdout initial..main^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
similarity index 95%
rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
index caec5537de3..b749be58b0a 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout initial..master^^
+$ git format-patch --inline --stdout initial..main^^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
similarity index 96%
rename from t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
rename to t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
index 244d964fc67..567f2221982 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --stdout --cover-letter -n initial..master^
+$ git format-patch --stdout --cover-letter -n initial..main^
 From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
 From: C O Mitter <committer@example.com>
 Date: Mon, 26 Jun 2006 00:06:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
similarity index 97%
rename from t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
rename to t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
index bfc287a147d..195b62ea4f5 100644
--- a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --stdout --no-numbered initial..master
+$ git format-patch --stdout --no-numbered initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master b/t/t4013/diff.format-patch_--stdout_--numbered_initial..main
similarity index 97%
rename from t/t4013/diff.format-patch_--stdout_--numbered_initial..master
rename to t/t4013/diff.format-patch_--stdout_--numbered_initial..main
index 568f6f584e6..0678a38515d 100644
--- a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--numbered_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --stdout --numbered initial..master
+$ git format-patch --stdout --numbered initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t4013/diff.format-patch_--stdout_initial..main
similarity index 97%
rename from t/t4013/diff.format-patch_--stdout_initial..master
rename to t/t4013/diff.format-patch_--stdout_initial..main
index 5f0352f9f70..b4a6302e7cb 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --stdout initial..master
+$ git format-patch --stdout initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4013/diff.format-patch_--stdout_initial..main^
similarity index 96%
rename from t/t4013/diff.format-patch_--stdout_initial..master^
rename to t/t4013/diff.format-patch_--stdout_initial..main^
index 2ae454d8073..36b32215826 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --stdout initial..master^
+$ git format-patch --stdout initial..main^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.log_-c_-m_-p_master b/t/t4013/diff.log_--cc_-m_-p_main
similarity index 99%
rename from t/t4013/diff.log_-c_-m_-p_master
rename to t/t4013/diff.log_--cc_-m_-p_main
index b660f3d5f28..f32746ea3ed 100644
--- a/t/t4013/diff.log_-c_-m_-p_master
+++ b/t/t4013/diff.log_--cc_-m_-p_main
@@ -1,4 +1,4 @@
-$ git log -c -m -p master
+$ git log --cc -m -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 6b0b334a5d6..c099399525a 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate=full_--clear-decorations_--all b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
index 1c030a6554e..c43684e5361 100644
--- a/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
+++ b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate=full_--decorate-all_--all b/t/t4013/diff.log_--decorate=full_--decorate-all_--all
index d6e79287846..48dca61681c 100644
--- a/t/t4013/diff.log_--decorate=full_--decorate-all_--all
+++ b/t/t4013/diff.log_--decorate=full_--decorate-all_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index c7df1f58141..8bbf891f658 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate_--clear-decorations_--all b/t/t4013/diff.log_--decorate_--clear-decorations_--all
index 88be82cce31..86b1353f514 100644
--- a/t/t4013/diff.log_--decorate_--clear-decorations_--all
+++ b/t/t4013/diff.log_--decorate_--clear-decorations_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate_--decorate-all_--all b/t/t4013/diff.log_--decorate_--decorate-all_--all
index 5d22618bb60..59fb17bfc54 100644
--- a/t/t4013/diff.log_--decorate_--decorate-all_--all
+++ b/t/t4013/diff.log_--decorate_--decorate-all_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--diff-merges=first-parent_master b/t/t4013/diff.log_--diff-merges=first-parent_main
similarity index 95%
rename from t/t4013/diff.log_--diff-merges=first-parent_master
rename to t/t4013/diff.log_--diff-merges=first-parent_main
index fa63a557dd1..bacee621e54 100644
--- a/t/t4013/diff.log_--diff-merges=first-parent_master
+++ b/t/t4013/diff.log_--diff-merges=first-parent_main
@@ -1,4 +1,4 @@
-$ git log --diff-merges=first-parent master
+$ git log --diff-merges=first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master b/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_main
similarity index 95%
rename from t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
rename to t/t4013/diff.log_--diff-merges=off_-p_--first-parent_main
index 597002232e5..fe180fda3be 100644
--- a/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
+++ b/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log --no-diff-merges -p --first-parent master
+$ git log --diff-merges=off -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master b/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_main
similarity index 95%
rename from t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master
rename to t/t4013/diff.log_--first-parent_--diff-merges=off_-p_main
index 5d7461a167e..dca62d4e608 100644
--- a/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master
+++ b/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_main
@@ -1,4 +1,4 @@
-$ git log --first-parent --diff-merges=off -p master
+$ git log --first-parent --diff-merges=off -p main
 commit 80e25ffa65bcdbe82ef654b4d06dbbde7945c37f
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
similarity index 95%
rename from t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
rename to t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
index 194e893c94f..0b541180887 100644
--- a/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
+++ b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log --diff-merges=off -p --first-parent master
+$ git log --no-diff-merges -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
similarity index 96%
rename from t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
rename to t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
index a18f1472a9a..3ed46cc8672 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
@@ -1,4 +1,4 @@
-$ git log --patch-with-stat --summary master -- dir/
+$ git log --patch-with-stat --summary main -- dir/
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.log_--patch-with-stat_main
similarity index 98%
rename from t/t4013/diff.log_--patch-with-stat_master
rename to t/t4013/diff.log_--patch-with-stat_main
index ae425c46722..2e12b557cb7 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git log --patch-with-stat master
+$ git log --patch-with-stat main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_main_--_dir_
similarity index 96%
rename from t/t4013/diff.log_--patch-with-stat_master_--_dir_
rename to t/t4013/diff.log_--patch-with-stat_main_--_dir_
index d5207cadf44..d511ea7f6bf 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_main_--_dir_
@@ -1,4 +1,4 @@
-$ git log --patch-with-stat master -- dir/
+$ git log --patch-with-stat main -- dir/
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
similarity index 98%
rename from t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
rename to t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
index 0fc1e8cd71f..3cfd0e64229 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git log --root --cc --patch-with-stat --summary master
+$ git log --root --cc --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--patch-with-stat_--summary_main
similarity index 98%
rename from t/t4013/diff.log_--root_--patch-with-stat_--summary_master
rename to t/t4013/diff.log_--root_--patch-with-stat_--summary_main
index dffc09dde9e..9f4d6dfa44e 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git log --root --patch-with-stat --summary master
+$ git log --root --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/diff.log_--root_--patch-with-stat_main
similarity index 98%
rename from t/t4013/diff.log_--root_--patch-with-stat_master
rename to t/t4013/diff.log_--root_--patch-with-stat_main
index 55aa98012de..0d69ae2e11b 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git log --root --patch-with-stat master
+$ git log --root --patch-with-stat main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
similarity index 98%
rename from t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
rename to t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
index 019d85f7de6..1b71add9dea 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git log --root -c --patch-with-stat --summary master
+$ git log --root -c --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root_-p_main
similarity index 98%
rename from t/t4013/diff.log_--root_-p_master
rename to t/t4013/diff.log_--root_-p_main
index b42c334439b..04581296ed5 100644
--- a/t/t4013/diff.log_--root_-p_master
+++ b/t/t4013/diff.log_--root_-p_main
@@ -1,4 +1,4 @@
-$ git log --root -p master
+$ git log --root -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_main
similarity index 96%
rename from t/t4013/diff.log_--root_master
rename to t/t4013/diff.log_--root_main
index e8f46159da1..d5e90fd6b48 100644
--- a/t/t4013/diff.log_--root_master
+++ b/t/t4013/diff.log_--root_main
@@ -1,4 +1,4 @@
-$ git log --root master
+$ git log --root main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master b/t/t4013/diff.log_-GF_-p_--pickaxe-all_main
similarity index 90%
rename from t/t4013/diff.log_-GF_-p_--pickaxe-all_master
rename to t/t4013/diff.log_-GF_-p_--pickaxe-all_main
index d36f88098b0..1f7a497c2d7 100644
--- a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master
+++ b/t/t4013/diff.log_-GF_-p_--pickaxe-all_main
@@ -1,4 +1,4 @@
-$ git log -GF -p --pickaxe-all master
+$ git log -GF -p --pickaxe-all main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-GF_-p_master b/t/t4013/diff.log_-GF_-p_main
similarity index 91%
rename from t/t4013/diff.log_-GF_-p_master
rename to t/t4013/diff.log_-GF_-p_main
index 9d93f2c23a8..c80dda41e9f 100644
--- a/t/t4013/diff.log_-GF_-p_master
+++ b/t/t4013/diff.log_-GF_-p_main
@@ -1,4 +1,4 @@
-$ git log -GF -p master
+$ git log -GF -p main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_master b/t/t4013/diff.log_-GF_main
similarity index 86%
rename from t/t4013/diff.log_-SF_master
rename to t/t4013/diff.log_-GF_main
index c1599f2f520..b94a7f78398 100644
--- a/t/t4013/diff.log_-SF_master
+++ b/t/t4013/diff.log_-GF_main
@@ -1,4 +1,4 @@
-$ git log -SF master
+$ git log -GF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_master b/t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_main
similarity index 97%
rename from t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_master
rename to t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_main
index 929f35a05b4..67e26b4e547 100644
--- a/t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_master
+++ b/t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_main
@@ -1,4 +1,4 @@
-$ git log -IA -IB -I1 -I2 -p master
+$ git log -IA -IB -I1 -I2 -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-SF_-p_master b/t/t4013/diff.log_-SF_-p_main
similarity index 91%
rename from t/t4013/diff.log_-SF_-p_master
rename to t/t4013/diff.log_-SF_-p_main
index 5e324389729..fa82ac14908 100644
--- a/t/t4013/diff.log_-SF_-p_master
+++ b/t/t4013/diff.log_-SF_-p_main
@@ -1,4 +1,4 @@
-$ git log -SF -p master
+$ git log -SF -p main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-GF_master b/t/t4013/diff.log_-SF_main
similarity index 86%
rename from t/t4013/diff.log_-GF_master
rename to t/t4013/diff.log_-SF_main
index 4c6708d2d0d..dbf770db49d 100644
--- a/t/t4013/diff.log_-GF_master
+++ b/t/t4013/diff.log_-SF_main
@@ -1,4 +1,4 @@
-$ git log -GF master
+$ git log -SF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_main_--max-count=0 b/t/t4013/diff.log_-SF_main_--max-count=0
new file mode 100644
index 00000000000..683b17eb998
--- /dev/null
+++ b/t/t4013/diff.log_-SF_main_--max-count=0
@@ -0,0 +1,2 @@
+$ git log -SF main --max-count=0
+$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=2 b/t/t4013/diff.log_-SF_main_--max-count=1
similarity index 79%
rename from t/t4013/diff.log_-SF_master_--max-count=2
rename to t/t4013/diff.log_-SF_main_--max-count=1
index a6c55fd4822..2102426f8cc 100644
--- a/t/t4013/diff.log_-SF_master_--max-count=2
+++ b/t/t4013/diff.log_-SF_main_--max-count=1
@@ -1,4 +1,4 @@
-$ git log -SF master --max-count=2
+$ git log -SF main --max-count=1
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_main_--max-count=2 b/t/t4013/diff.log_-SF_main_--max-count=2
new file mode 100644
index 00000000000..23e12a4cbbd
--- /dev/null
+++ b/t/t4013/diff.log_-SF_main_--max-count=2
@@ -0,0 +1,7 @@
+$ git log -SF main --max-count=2
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=0 b/t/t4013/diff.log_-SF_master_--max-count=0
deleted file mode 100644
index c1fc6c87317..00000000000
--- a/t/t4013/diff.log_-SF_master_--max-count=0
+++ /dev/null
@@ -1,2 +0,0 @@
-$ git log -SF master --max-count=0
-$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=1 b/t/t4013/diff.log_-SF_master_--max-count=1
deleted file mode 100644
index c981a038147..00000000000
--- a/t/t4013/diff.log_-SF_master_--max-count=1
+++ /dev/null
@@ -1,7 +0,0 @@
-$ git log -SF master --max-count=1
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
-Author: A U Thor <author@example.com>
-Date:   Mon Jun 26 00:02:00 2006 +0000
-
-    Third
-$
diff --git a/t/t4013/diff.log_-S_F_master b/t/t4013/diff.log_-S_F_main
similarity index 86%
rename from t/t4013/diff.log_-S_F_master
rename to t/t4013/diff.log_-S_F_main
index 978d2b41188..a75a42e1433 100644
--- a/t/t4013/diff.log_-S_F_master
+++ b/t/t4013/diff.log_-S_F_main
@@ -1,4 +1,4 @@
-$ git log -S F master
+$ git log -S F main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_--cc_-m_-p_master b/t/t4013/diff.log_-c_-m_-p_main
similarity index 99%
rename from t/t4013/diff.log_--cc_-m_-p_master
rename to t/t4013/diff.log_-c_-m_-p_main
index 7c217cf348c..427f7324568 100644
--- a/t/t4013/diff.log_--cc_-m_-p_master
+++ b/t/t4013/diff.log_-c_-m_-p_main
@@ -1,4 +1,4 @@
-$ git log --cc -m -p master
+$ git log -c -m -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_--raw_master b/t/t4013/diff.log_-m_--raw_main
similarity index 98%
rename from t/t4013/diff.log_-m_--raw_master
rename to t/t4013/diff.log_-m_--raw_main
index cd2ecc46283..31d9bc77073 100644
--- a/t/t4013/diff.log_-m_--raw_master
+++ b/t/t4013/diff.log_-m_--raw_main
@@ -1,4 +1,4 @@
-$ git log -m --raw master
+$ git log -m --raw main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_--stat_master b/t/t4013/diff.log_-m_--stat_main
similarity index 98%
rename from t/t4013/diff.log_-m_--stat_master
rename to t/t4013/diff.log_-m_--stat_main
index c7db084fd90..4c8909229bf 100644
--- a/t/t4013/diff.log_-m_--stat_master
+++ b/t/t4013/diff.log_-m_--stat_main
@@ -1,4 +1,4 @@
-$ git log -m --stat master
+$ git log -m --stat main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_-p_--first-parent_master b/t/t4013/diff.log_-m_-p_--first-parent_main
similarity index 97%
rename from t/t4013/diff.log_-m_-p_--first-parent_master
rename to t/t4013/diff.log_-m_-p_--first-parent_main
index 7a0073f5296..459e10786b9 100644
--- a/t/t4013/diff.log_-m_-p_--first-parent_master
+++ b/t/t4013/diff.log_-m_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log -m -p --first-parent master
+$ git log -m -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_-p_master b/t/t4013/diff.log_-m_-p_main
similarity index 99%
rename from t/t4013/diff.log_-m_-p_master
rename to t/t4013/diff.log_-m_-p_main
index 9ca62a01ed2..07453c56983 100644
--- a/t/t4013/diff.log_-m_-p_master
+++ b/t/t4013/diff.log_-m_-p_main
@@ -1,4 +1,4 @@
-$ git log -m -p master
+$ git log -m -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_--diff-merges=first-parent_master b/t/t4013/diff.log_-p_--diff-merges=first-parent_main
similarity index 97%
rename from t/t4013/diff.log_-p_--diff-merges=first-parent_master
rename to t/t4013/diff.log_-p_--diff-merges=first-parent_main
index 9538a275112..264a2f373ec 100644
--- a/t/t4013/diff.log_-p_--diff-merges=first-parent_master
+++ b/t/t4013/diff.log_-p_--diff-merges=first-parent_main
@@ -1,4 +1,4 @@
-$ git log -p --diff-merges=first-parent master
+$ git log -p --diff-merges=first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.log_-p_--first-parent_main
similarity index 97%
rename from t/t4013/diff.log_-p_--first-parent_master
rename to t/t4013/diff.log_-p_--first-parent_main
index 28840ebea1e..247980817b5 100644
--- a/t/t4013/diff.log_-p_--first-parent_master
+++ b/t/t4013/diff.log_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log -p --first-parent master
+$ git log -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_main
similarity index 98%
rename from t/t4013/diff.log_-p_master
rename to t/t4013/diff.log_-p_main
index bf1326dc366..c82b4dbf165 100644
--- a/t/t4013/diff.log_-p_master
+++ b/t/t4013/diff.log_-p_main
@@ -1,4 +1,4 @@
-$ git log -p master
+$ git log -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_main
similarity index 97%
rename from t/t4013/diff.log_master
rename to t/t4013/diff.log_main
index a8f6ce5abd6..50401f73e6e 100644
--- a/t/t4013/diff.log_master
+++ b/t/t4013/diff.log_main
@@ -1,4 +1,4 @@
-$ git log master
+$ git log main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
similarity index 81%
rename from t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
rename to t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
index bb80f013b37..3aa1f80af35 100644
--- a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
+++ b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --abbrev master
+$ git diff-tree -c --abbrev main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 ::100644 100644 100644 cead32e 7289e35 992913c MM	dir/sub
 ::100644 100644 100644 b414108 f4615da 10a8a9f MM	file0
diff --git a/t/t4013/diff.noellipses-whatchanged_--root_master b/t/t4013/diff.noellipses-whatchanged_--root_main
similarity index 96%
rename from t/t4013/diff.noellipses-whatchanged_--root_master
rename to t/t4013/diff.noellipses-whatchanged_--root_main
index c2cfd4e7292..2bec0558356 100644
--- a/t/t4013/diff.noellipses-whatchanged_--root_master
+++ b/t/t4013/diff.noellipses-whatchanged_--root_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root master
+$ git whatchanged --root main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.noellipses-whatchanged_-SF_master b/t/t4013/diff.noellipses-whatchanged_-SF_main
similarity index 86%
rename from t/t4013/diff.noellipses-whatchanged_-SF_master
rename to t/t4013/diff.noellipses-whatchanged_-SF_main
index b36ce5886e0..0c1476d19eb 100644
--- a/t/t4013/diff.noellipses-whatchanged_-SF_master
+++ b/t/t4013/diff.noellipses-whatchanged_-SF_main
@@ -1,4 +1,4 @@
-$ git whatchanged -SF master
+$ git whatchanged -SF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.noellipses-whatchanged_master b/t/t4013/diff.noellipses-whatchanged_main
similarity index 96%
rename from t/t4013/diff.noellipses-whatchanged_master
rename to t/t4013/diff.noellipses-whatchanged_main
index 55e500f2edb..c48d2851aab 100644
--- a/t/t4013/diff.noellipses-whatchanged_master
+++ b/t/t4013/diff.noellipses-whatchanged_main
@@ -1,4 +1,4 @@
-$ git whatchanged master
+$ git whatchanged main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show_--first-parent_main
similarity index 92%
rename from t/t4013/diff.show_--first-parent_master
rename to t/t4013/diff.show_--first-parent_main
index 3dcbe473a0d..480502d65c2 100644
--- a/t/t4013/diff.show_--first-parent_master
+++ b/t/t4013/diff.show_--first-parent_main
@@ -1,4 +1,4 @@
-$ git show --first-parent master
+$ git show --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_main
similarity index 95%
rename from t/t4013/diff.show_-c_master
rename to t/t4013/diff.show_-c_main
index 81aba8da96c..74ef8bc96b2 100644
--- a/t/t4013/diff.show_-c_master
+++ b/t/t4013/diff.show_-c_main
@@ -1,4 +1,4 @@
-$ git show -c master
+$ git show -c main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_main
similarity index 98%
rename from t/t4013/diff.show_-m_master
rename to t/t4013/diff.show_-m_main
index 4ea2ee453d5..8fd56736d97 100644
--- a/t/t4013/diff.show_-m_master
+++ b/t/t4013/diff.show_-m_main
@@ -1,4 +1,4 @@
-$ git show -m master
+$ git show -m main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_main
similarity index 96%
rename from t/t4013/diff.show_master
rename to t/t4013/diff.show_main
index fb08ce0e46d..630b52a95ef 100644
--- a/t/t4013/diff.show_master
+++ b/t/t4013/diff.show_main
@@ -1,4 +1,4 @@
-$ git show master
+$ git show main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_dir_
similarity index 94%
rename from t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir_
rename to t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_dir_
index c8b6af2f438..ce0754d556e 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_dir_
@@ -1,4 +1,4 @@
-$ git whatchanged --patch-with-stat --summary master -- dir/
+$ git whatchanged --patch-with-stat --summary main -- dir/
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master b/t/t4013/diff.whatchanged_--patch-with-stat_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--patch-with-stat_master
rename to t/t4013/diff.whatchanged_--patch-with-stat_main
index 1ac431ba921..aabccf39a53 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git whatchanged --patch-with-stat master
+$ git whatchanged --patch-with-stat main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
similarity index 94%
rename from t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
rename to t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
index b30c28588f9..c05a0e81496 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
@@ -1,4 +1,4 @@
-$ git whatchanged --patch-with-stat master -- dir/
+$ git whatchanged --patch-with-stat main -- dir/
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
rename to t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main
index 30aae7817b9..1f74b1b5487 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root --cc --patch-with-stat --summary master
+$ git whatchanged --root --cc --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master
rename to t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
index db90e515254..80d98121511 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root --patch-with-stat --summary master
+$ git whatchanged --root --patch-with-stat --summary main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_--patch-with-stat_master
rename to t/t4013/diff.whatchanged_--root_--patch-with-stat_main
index 9a6cc92ce7d..c0b9082a2c8 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root --patch-with-stat master
+$ git whatchanged --root --patch-with-stat main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
rename to t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_main
index d1d32bd34c3..0002c6912e1 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root -c --patch-with-stat --summary master
+$ git whatchanged --root -c --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.whatchanged_--root_-p_master b/t/t4013/diff.whatchanged_--root_-p_main
similarity index 98%
rename from t/t4013/diff.whatchanged_--root_-p_master
rename to t/t4013/diff.whatchanged_--root_-p_main
index ebf1f0661e0..39f3e2be746 100644
--- a/t/t4013/diff.whatchanged_--root_-p_master
+++ b/t/t4013/diff.whatchanged_--root_-p_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root -p master
+$ git whatchanged --root -p main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_master b/t/t4013/diff.whatchanged_--root_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_master
rename to t/t4013/diff.whatchanged_--root_main
index a405cb61388..36f4d6697f5 100644
--- a/t/t4013/diff.whatchanged_--root_master
+++ b/t/t4013/diff.whatchanged_--root_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root master
+$ git whatchanged --root main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_-SF_-p_master b/t/t4013/diff.whatchanged_-SF_-p_main
similarity index 89%
rename from t/t4013/diff.whatchanged_-SF_-p_master
rename to t/t4013/diff.whatchanged_-SF_-p_main
index f39da848228..0e2e67c0df8 100644
--- a/t/t4013/diff.whatchanged_-SF_-p_master
+++ b/t/t4013/diff.whatchanged_-SF_-p_main
@@ -1,4 +1,4 @@
-$ git whatchanged -SF -p master
+$ git whatchanged -SF -p main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_-SF_master b/t/t4013/diff.whatchanged_-SF_main
similarity index 86%
rename from t/t4013/diff.whatchanged_-SF_master
rename to t/t4013/diff.whatchanged_-SF_main
index 0499321d0eb..34c6bf6b950 100644
--- a/t/t4013/diff.whatchanged_-SF_master
+++ b/t/t4013/diff.whatchanged_-SF_main
@@ -1,4 +1,4 @@
-$ git whatchanged -SF master
+$ git whatchanged -SF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_-p_master b/t/t4013/diff.whatchanged_-p_main
similarity index 98%
rename from t/t4013/diff.whatchanged_-p_master
rename to t/t4013/diff.whatchanged_-p_main
index f18d43209c0..18f3bdeef48 100644
--- a/t/t4013/diff.whatchanged_-p_master
+++ b/t/t4013/diff.whatchanged_-p_main
@@ -1,4 +1,4 @@
-$ git whatchanged -p master
+$ git whatchanged -p main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_master b/t/t4013/diff.whatchanged_main
similarity index 97%
rename from t/t4013/diff.whatchanged_master
rename to t/t4013/diff.whatchanged_main
index cd3bcc2c726..d6c83ed8b03 100644
--- a/t/t4013/diff.whatchanged_master
+++ b/t/t4013/diff.whatchanged_main
@@ -1,4 +1,4 @@
-$ git whatchanged master
+$ git whatchanged main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
-- 
2.49.0.897.gfad3eb7d210


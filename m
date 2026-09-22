Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540A41A921
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082390; cv=none; b=qkWkp3uOzGlcvgLZLvo87liGzthCB0cFu4nlumD2bxsdeUrnv0hVxRPAPuLjoycXYWZ9Z3U6wmZQraqBG7DI4ItHhUmB0QGfUCiDuXAqTe8qIDM4CqeMvdesVf7uBZH49DRcqKn39sfCjBCRq1qwbIYJQolbz6o1OergfptS4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082390; c=relaxed/simple;
	bh=oJPROWwG7gQwCAryZ6ybzYI7t59IVgYQzzX3+68+dwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5ZT5wm1BdpbQCwqDoF+QOb1ZNeuNnyzNjXFcRyYB3CN1dHAdOQRmG7TGiJ3tArNli2/0BTxV8XSb3XP6WfhDL6Jc6CcXH0WJeyx/vKj6ukRw9EG64PJUXlETIzhxP088zLoRERc+P71t1Q5wNFfksNW9rtU+x4FsDBBdBNhrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7w0RlHY; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7w0RlHY"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8d6489419so320443e87.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790082386; x=1790687186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WxEovkV3NgPp5Ts4MzRIvLS/hq2dcHbaNjqWLlJeASw=;
        b=N7w0RlHY/sjAbm2uskFTfEjgcAcP5AfxB7S8TyQR7XAHEnMJz68wF2P1fnN4xUQqpW
         g6xWM81ZTlbEhRe4fU7MHZzO/PRO3ZnG5B/FnldWExiCDh1WDOe3jSlPIjvfYeMKKSIh
         Cko8R/gxO/SvIlF2rqQS/mwuY8HgzFgIo3YtCwdKF7m9ZM8rc2SxizxrlrjsmvdS84DF
         LRxSr5Sru0WFEumsvlOdSdOosE0iKMH2s0aTZZO51qWRWYiBrjlyld9S2InntOTVKOYl
         p+1l1yF/nXRDNVByqjClA6jqw2F19PMJDJ4WVpT0IrkKflBFI/JegXLj27es4mZL5C0x
         6meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082386; x=1790687186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WxEovkV3NgPp5Ts4MzRIvLS/hq2dcHbaNjqWLlJeASw=;
        b=VgLQAeFsFue66VKor5xt1dR9dPYHIi2M/2sqVXOD8/lXACixVRaIZSfmYaTA8r8436
         872bWbup13EQA1XUDO15s5eybr0xIwKCJLIU8+OHZR2b6zjK0bwPxo5WgayWJjyBG/on
         W55K6uFAo+3XF8p4oLa2qb9nUWvH7ECfFOotUdwjIrwhQODIlNQA8jTPiV4Csv8jJbOq
         xo6Dk37mosDi10oynMQ4q2SIUCVGLFhdvZgUKWZ7y1495j5vNYGorX6IHMJ4hOlVbCXg
         KGjEzzrd3X2YKmRWRYeKoi4lzOCJgbP7zwM+IJHzsgv/CfXdIgicklzs2ytt93YLF0CB
         UqxQ==
X-Gm-Message-State: AFuF++lfyXaIenSKcEJKGGTPl3yEmbV8PhgUVJ6AQO3HqwWeT5JRca88
	axbtu2nvaTXyE5kpEcVH7DcBjux4BhCjmMJG/5UwgaHrBoAkQyVMJmI+QT4Org==
X-Gm-Gg: AYBFou27MmtXCXLrZkItcF1WbKzIRDhYWKR9Gtt1YJm/ynlEH6gxTI4scrYCKD4XjKc
	WeNpjE1aYFwNnXCdSl9gRkGG8wvyw4pYjGV+36+CaciRcmVEb23G3/2o0EP8X5EoOXdYUGang7p
	YbSwH0xAL2PbZarcs3AnMlAQd84j5sFr8y7tjrk26qDgXJb+OuwX3Jz59yr+WBSDueHXygqmoTZ
	Yk9H/LgVHUrFFILwgHEAG05bJAMxEjOKLSWLgdRj6iL+TBF7KhGaUDMhvLm0X2jRGEvcZWNo/tN
	02OXsrfgzNzbDrd6nMfL5Db75ZUrZ5rS5XB25jQGJarpbvpbn/YTWiv2S2BCeq005O4JrrMKFdZ
	DWJxahlVTkNwb9Kk6XxsNjBuX9jG52QlAOH2xfYnIWAgS+i41V1nOfLR0aUE6UAf6TcHel43rcN
	SRh9uvrt/hEqf2PTUdvDO5tUuTwgV95F662TNOf44jSCgZaWyQgSXQ8xSBrzbtZYAhMamJm6y+4
	pHqMfSHzijv1xz1I3YWwQGSK5wUGITjOzMIgz8eumr1NjmPqhuzQZRWzjzDTkPE2q2I+uBgfKgA
	5Y03hvo38ov58upZqN6c2XiLGnMZBcrmyQ==
X-Received: by 2002:a05:6512:159d:b0:5b6:183b:d1ff with SMTP id 2adb3069b0e04-5b8c1848f71mr4246626e87.38.1790082386045;
        Tue, 22 Sep 2026 06:06:26 -0700 (PDT)
Received: from localhost ([185.104.15.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46e8bf7sm478038e87.63.2026.09.22.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:06:25 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v3 0/2] commit: allow -m/-F/-c/-C for all --fixup variations
Date: Tue, 22 Sep 2026 15:04:32 +0200
Message-ID: <cover.1790082176.git.erik@cervined.in>
X-Mailer: git-send-email 2.55.0.770.g0473647dd8
In-Reply-To: <cover.1779792311.git.erik@cervined.in>
References: <cover.1779792311.git.erik@cervined.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

Changes since v2:

  * 2/2: Junio noted [1] that after dropping --fixup from the
    -C/-c/--fixup incompatibility check, what remained (-C, -c, -F)
    was already rejected by the neighbouring die_for_incompatible_opt4()
    that groups those options with -m.  The check is now removed
    entirely instead of being narrowed.

  * 2/2: reworded the log message to lead with why -c/-C are the odd
    ones out once 1/2 is in place, rather than with the check that
    happened to block them.

  * Rebased onto current master.  1/2 is unchanged apart from that.

Background
----------

Today only -m works with plain --fixup, and neither -m nor -F works
with --fixup=amend: or --fixup=reword:, which makes those modes
awkward to drive non-interactively.  1/2 threads -m and -F through
prepare_to_commit() for all --fixup variations.  2/2 does the same for
-c/-C, which were blocked by the same incompatibility check that
caught -F, so that all four message sources behave consistently across
the plain, amend, and reword forms.

2/2 lives in its own patch and I won't object if reviewers would
rather drop it or take it separately.

A note on one design decision in 2/2.  -c/-C go through
prepare_amend_commit(), so if the source commit is itself an "amend!"
commit, its subject line is dropped and only the body is copied.  This
is what a no-source --fixup=amend:<commit> already does.

I kept that on purpose.  Under --fixup the subject is always generated
by git, so whatever -C supplies ends up in the body, and the body of an
amend! commit is the message destined for its target.  Copying the
"amend! X" line along with it would leave that line in the final
message after autosquash.  It also means

    git commit --fixup=amend:foo -C foo

and

    GIT_EDITOR=: git commit --fixup=amend:foo

produce the same commit.

The helper only knows about "amend!" and not "fixup!" or "squash!".
That is pre-existing and I have left it alone here.

The v1 -> v2 changes (refactoring prepare_to_commit() instead of the
special-cased file slurp in cmd_commit(), extending scope to -c/-C,
and the smaller review fixes) are described in the v2 cover letter [2].

[1] https://lore.kernel.org/git/xmqq1pbkefh0.fsf@gitster.g/
[2] https://lore.kernel.org/git/cover.1779792311.git.erik@cervined.in/

Erik Cervin-Edin (2):
  commit: allow -m/-F for all kinds of --fixup
  commit: allow -c/-C for all kinds of --fixup

 Documentation/git-commit.adoc             |  22 +++--
 builtin/commit.c                          |  40 ++++----
 t/t7500-commit-template-squash-signoff.sh | 114 +++++++++++++++++++---
 3 files changed, 131 insertions(+), 45 deletions(-)

Range-diff against v2:
1:  e9f07d49ee = 1:  4581f97cb7 commit: allow -m/-F for all kinds of --fixup
2:  b3fc743abf ! 2:  39e408e147 commit: allow -c/-C for all kinds of --fixup
    @@ Metadata
      ## Commit message ##
         commit: allow -c/-C for all kinds of --fixup
     
    -    The previous commit allowed -m and -F for all --fixup variations.  The
    -    -c/-C flags were blocked by the same higher-layer incompatibility check
    -    that previously caught -F, namely die_for_incompatible_opt4() grouping
    -    them with --fixup.
    +    The fixup code path in prepare_to_commit() only knows how to take a
    +    message body from -m or -F.  Now that the previous commit allows -m and
    +    -F for all --fixup variations, -c/-C are the odd ones out.
     
    -    Drop --fixup from that check and route the resolved commit through
    -    prepare_amend_commit() in the fixup path, mirroring the no-message-source
    -    behaviour of --fixup=amend.  With this in place, -m/-F/-c/-C all behave
    -    consistently across the plain, amend, and reword --fixup forms.
    +    Teach the fixup path to look up the ref given to -c/-C and seed its
    +    message when preparing to amend the commit, mirroring what --fixup=amend
    +    does when no message source is given.  With this in place, -m/-F/-c/-C
    +    all behave consistently across the plain, amend, and reword --fixup
    +    forms.
     
    +    The incompatibility check grouping -C, -c, and --fixup can go away
    +    entirely, as -C and -c are already rejected together by the check that
    +    groups them with -m and -F.
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
     
      ## Documentation/git-commit.adoc ##
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      			prepare_amend_commit(commit, &sb, &ctx);
      		}
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
    + 	}
    + 	if (fixup_message && squash_message)
      		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
    - 	die_for_incompatible_opt3(!!use_message, "-C",
    - 				  !!edit_message, "-c",
    +-	die_for_incompatible_opt3(!!use_message, "-C",
    +-				  !!edit_message, "-c",
     -				  !!fixup_message, "--fixup");
    -+				  !!logfile, "-F");
      	die_for_incompatible_opt4(have_option_m, "-m",
      				  !!edit_message, "-c",
      				  !!use_message, "-C",

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
2.55.0.770.g0473647dd8


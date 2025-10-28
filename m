Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6F2E88A1
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687984; cv=none; b=Ot6ULzfjLDFMZGhUoK8TXQoKIS7rpIzSMvLJwK0TN6YBXTJkOwK1VEg93gt3Ggnvov4T5Ysw8K7v39f/KIAx//G4awiO0ygyuN5AsqZyfbx9Nkntps7mqYIrnUg8osqn6XqVaM+koFqiHXKcJN0EBRIdj8VIFXV78CfgYeInsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687984; c=relaxed/simple;
	bh=6F3K13KrFhsQ8yknQHskLFIhx3PpkI8VXM9mnynqlCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vjbf2X78CC8vaL1hfzbIRo2gFHfXAWJxQmTMyLwVLfcVpz+nAjz7X4mPdeMQKD57XWp8C3kcFTeogseTC9OFYkqwAc9HoplJ/EnukaqgugudznO0k87ZfAMPJpfZhRSZoXVevFXi97g6vEOMB8jLas1dMVzWqAaCM7Tk0YzttEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTX0hfPM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTX0hfPM"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso239792a12.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687982; x=1762292782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEXWxRcqwKtylsJ5++fHyBY/NfparbSIp4AH8kFhKZI=;
        b=cTX0hfPMh8zDAu5BYCgVhP0q+Uiuei5Nc+S+STNdNpkYE0bxrXz+0R1nTuD2TJwgzM
         U8JbeP0HAHZQ8oML5GoVJqCqmZ3WopL7IAgPTx3uqHPVzN2uMqfdFAE3D6AY9wOEWR5m
         hP0sS7n5F/kUI5KHGNsqFxK1595ZzKOU558a6Ve6qs0UhAe05m5oHiy+xA4WgRynAe2E
         XKEjkJ1YyU0GKhxgAJHdMO7pEWLjf1Lm+VNJosPrHfrFrBgLi35SOM6SZTxlgqy+EKFe
         /KbCnqQ5HA/xyw5wJGQRRVjV4JR0rGzmpLyHTjHJL9/Ij8SEUevU5Vw5FPBk5ntJGryb
         QWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687982; x=1762292782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEXWxRcqwKtylsJ5++fHyBY/NfparbSIp4AH8kFhKZI=;
        b=d+36pv1zZi23A6hDBpX81cev1g2KM4seNsnqG7yryIUMV35II2WtzBlLM5FhLjUdh1
         xfN7y9c8p3uMWwhjeKmDy64c8u7smBjn+2+ZV2K1hXKirR0fjBoM+SiR1uLURuKFHDea
         MWoj7/y4ek2nZu9Y0Bxpas5j0UYYT7t+04GnAaGai+NIAYTwoZbbhRG0fyioWh0stVkv
         yTKPf7FgzwWjE9dDBzEiOjoheT75jhIxoSB8WaOrlTYm2N8weTmgDdZtsjv7hBAdFdLE
         hTOmByPxM31YW0HpxlPOPYsCN8fX+TDXXuvsVOA5Yzd7yF5FJ2BFwcFXeGvZ55zQtVUt
         VeRw==
X-Gm-Message-State: AOJu0YxrxB9uuJWlI/DlHMayzeAKN6tTzUwYFHbZ4436Q0fGau5TVjHf
	0ZiAx9gLU/5krTydeOF7DJrrFwTiuhpTBO0rMTbJ4Sm+I5j+urUDc+nombLY0vskq5E=
X-Gm-Gg: ASbGncuYcv6hPWITnDL5vDthPrJjXEfKBGur1G0uYAom4qAaZTnXHlKnHOHEn1fIK5Q
	uvxQHB5u32ECayHK3SRsC5y1SFHKab4sV/Xi1uLYM2fyznuYHO3Lu6sHt51AOT83JheUAXZL/i5
	sKW905YaL79hagCg7Gifue+hRrkXfK5Jc4GvKcIUz8mQX6J6/YK5xP08cOSd6wMZNX3tLdL8Wl0
	9u2pZRBVYKkAGpNoKuNFqBtVehJZPVT6oCvhbLYRYHFW2JXyTdekd5VPcWQIGuZvY6kc0VFFIqo
	DhmAn/cL/+18c4dU2b8ws74Uk7PfJEkVKeIjXgOYBpbvSfmift5mZ0t3yyKDKiZJ35iODAoZoU3
	biJgUFAAu8/GmDrIreGqTc3iYovsi/sxSGqjGoLb8Eh+Y74mZ3sZ2Oj6/dOLnj+RBVGleXVda/R
	YXbDmq4JqKBHsqGarDQfZZ4wB70q81yRgLa1AwIWWhTCtmDod5QWFVAxCEFHoBz3UbJ05lq1vQg
	kCMapJHWnkXVxyBJSHI8oDpEqkhq5mJAA0RbMsOMv8=
X-Google-Smtp-Source: AGHT+IGIlD4YZwL7+5zg8Xeqcm1YktG5r4jSwEDgHi+nVydHMp0OiTaCodoWMK/tZ1+eq1vj/HpDJQ==
X-Received: by 2002:a17:903:38cf:b0:279:373b:407f with SMTP id d9443c01a7336-294cc68682amr52745315ad.5.1761687981514;
        Tue, 28 Oct 2025 14:46:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm125645655ad.99.2025.10.28.14.46.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 14:46:20 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 0/3] replay: make atomic ref updates the default
Date: Wed, 29 Oct 2025 03:16:06 +0530
Message-ID: <20251028214609.10041-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022185045.29256-1-siddharthasthana31@gmail.com>
References: <20251022185045.29256-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v5 of the git-replay atomic updates series.

This version addresses all feedback from v4 reviews. Thanks to Junio,
Christian, and Phillip for the detailed technical reviews that helped
refine the implementation to Git standards.

## Changes in v5

**Added enum trailing comma**

Per Junio's suggestion, added trailing comma to enum definition for
future extensibility. This follows Git's established pattern and
minimizes patch noise when adding new enum values.

**Fixed error message formatting**

Following CodingGuidelines, wrapped ref names in single quotes in
error messages:
  - error(_("failed to update ref '%s': %s"), ...)

This provides better visual clarity and matches Git's error reporting
conventions throughout the codebase.

**Extracted helper functions for config parsing**

Per Christian and Junio's feedback, refactored config parsing into
clean helper functions:
  - parse_ref_action_mode(): String-to-enum conversion with source context
  - get_ref_action_mode(): Handles command-line vs config precedence

This eliminates code duplication and provides a single point for
validation logic, making the code more maintainable.

**Improved test suite with Git best practices**

Following Phillip and Christian's suggestions:
  - Switched from grep to test_grep for better error reporting
  - Used test_config for automatic config cleanup
  - Improved test isolation with proper state management
  - Used topic1 tag instead of $(git rev-parse) where appropriate

**Documentation improvements**

Fixed terminology and wording per Christian's feedback:
  - "ergonomical" → "ergonomic"
  - "configuration option" → "configuration variable"
  - "By default (with `--ref-action=update`)" → "By default, or with `--ref-action=update`,"

**Reverted unnecessary style change**

Per Junio's feedback, reverted the `const char * const` → `const char *const`
spacing change. The original spacing follows the prevalent codebase style.

## Technical Implementation

The atomic ref updates leverage Git's ref transaction API:
- ref_store_transaction_begin() with default atomic behavior
- ref_transaction_update() to stage each ref update
- ref_transaction_commit() for atomic application (all succeed or all fail)

The helper functions provide clean separation of concerns:
- parse_ref_action_mode() validates strings and converts to enum
- get_ref_action_mode() implements command-line > config > default precedence
- handle_ref_update() uses type-safe enum with switch statement

The on-demand config reading via repo_config_get_string_tmp() is simpler
than the traditional repo_config() callback pattern for this single-variable
case, while maintaining proper precedence behavior.

## Testing

All tests pass:
- t3650-replay-basics.sh (20 tests pass)
- New atomic behavior tests verify direct ref updates
- Config tests verify proper precedence and error handling
- Existing pipeline tests ensure backward compatibility

CI results: https://gitlab.com/gitlab-org/git/-/pipelines/2123403204

Siddharth Asthana (3):
  replay: use die_for_incompatible_opt2() for option validation
  replay: make atomic ref updates the default behavior
  replay: add replay.refAction config option

 Documentation/config/replay.adoc |  11 +++
 Documentation/git-replay.adoc    |  65 +++++++++++------
 builtin/replay.c                 | 121 +++++++++++++++++++++++++++----
 t/t3650-replay-basics.sh         |  91 +++++++++++++++++++++--
 4 files changed, 245 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/config/replay.adoc

Range-diff against v4:
1:  baa0cfdd4a = 1:  3e27d07d3b replay: use die_for_incompatible_opt2() for option validation
2:  3b5df166f3 ! 2:  643d9ca86a replay: make atomic ref updates the default behavior
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
         replay: make atomic ref updates the default behavior
         
         [Commit message unchanged - explains problem and solution]
     
     @@ builtin/replay.c: #include <tree.h>
      
     +enum ref_action_mode {
     +	REF_ACTION_UPDATE,
    -+	REF_ACTION_PRINT
    ++	REF_ACTION_PRINT,
     +};
      
     @@ builtin/replay.c: int cmd_replay
    -					ret = error(_("failed to update ref %s: %s"),
    -						    decoration->name, transaction_err.buf);
    +					ret = error(_("failed to update ref '%s': %s"),
     
     @@ builtin/replay.c: int cmd_replay
    -			ret = error(_("failed to update ref %s: %s"),
    -				    advance_name, transaction_err.buf);
    +			ret = error(_("failed to update ref '%s': %s"),
     
     @@ Documentation/git-replay.adoc
    -+    almost certainly find it more ergonomical to simply have the updating
    ++    almost certainly find it more ergonomic to simply have the updating
     
     @@ Documentation/git-replay.adoc
    -+The default mode can be configured via `replay.refAction` configuration option.
    ++The default mode can be configured via the `replay.refAction` configuration variable.
     
     @@ Documentation/git-replay.adoc: OUTPUT
    -+By default (with `--ref-action=update`), this command produces no output on
    ++By default, or with `--ref-action=update`, this command produces no output on
     
     -       const char * const replay_usage[] = {
    -+       const char *const replay_usage[] = {
    ++       const char * const replay_usage[] = {
     
3:  c35049881d ! 3:  334da71911 replay: add replay.refAction config option
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
         replay: add replay.refAction config option
         
         [Commit message unchanged]
     
     @@ builtin/replay.c: static struct commit *pick_regular_commit
      	return create_commit(repo, result->tree, pickme, replayed_base);
      }
      
    ++static enum ref_action_mode parse_ref_action_mode(const char *mode_str, const char *source)
    ++{
    ++	if (!mode_str || !strcmp(mode_str, "update"))
    ++		return REF_ACTION_UPDATE;
    ++	if (!strcmp(mode_str, "print"))
    ++		return REF_ACTION_PRINT;
    ++	die(_("invalid %s value: '%s'"), source, mode_str);
    ++}
    ++
    ++static enum ref_action_mode get_ref_action_mode(struct repository *repo, const char *ref_action_str)
    ++{
    ++	const char *config_value = NULL;
    ++
    ++	/* Command line option takes precedence */
    ++	if (ref_action_str)
    ++		return parse_ref_action_mode(ref_action_str, "--ref-action");
    ++
    ++	/* Check config value */
    ++	if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
    ++		return parse_ref_action_mode(config_value, "replay.refAction");
    ++
    ++	/* Default to update mode */
    ++	return REF_ACTION_UPDATE;
    ++}
    ++
     @@ builtin/replay.c: int cmd_replay
      	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
      				  contained, "--contained");
      
    -+	/* Set default mode from config if not specified on command line */
    -+	if (!ref_action_str) {
    -+		const char *config_value = NULL;
    -+		if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value)) {
    -+			if (!strcmp(config_value, "update"))
    -+				ref_action_str = "update";
    -+			else if (!strcmp(config_value, "print"))
    -+				ref_action_str = "print";
    -+			else
    -+				die(_("invalid value for replay.refAction: '%s'"), config_value);
    -+		}
    -+	}
    -+
    -+	/* Default to update mode if still not set */
    -+	if (!ref_action_str)
    -+		ref_action_str = "update";
    -+
    -+	/* Parse ref action mode */
    -+	if (!strcmp(ref_action_str, "update"))
    -+		ref_action = REF_ACTION_UPDATE;
    -+	else if (!strcmp(ref_action_str, "print"))
    -+		ref_action = REF_ACTION_PRINT;
    -+	else
    -+		die(_("unknown --ref-action mode '%s'"), ref_action_str);
    ++	/* Parse ref action mode from command line or config */
    ++	ref_action = get_ref_action_mode(repo, ref_action_str);
     
     @@ t/t3650-replay-basics.sh
     +test_expect_success 'replay.refAction config option' '
     +	START=$(git rev-parse topic2) &&
    -+	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
    ++	test_when_finished "git branch -f topic2 $START" &&
    ++	test_when_finished "git config --unset replay.refAction || true" &&
     +
     +	git config replay.refAction print &&
     +	git replay --onto main topic1..topic2 >output &&
     +	test_line_count = 1 output &&
    -+	grep "^update refs/heads/topic2 " output &&
    ++	test_grep "^update refs/heads/topic2 " output &&
     +
     +	git branch -f topic2 $START &&
     +	git config replay.refAction update &&
     
     +test_expect_success 'command-line --ref-action overrides config' '
     +	START=$(git rev-parse topic2) &&
    -+	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
    ++	test_when_finished "git branch -f topic2 $START" &&
     +
    -+	git config replay.refAction update &&
    ++	test_config replay.refAction update &&
     +	git replay --ref-action=print --onto main topic1..topic2 >output &&
     +	test_line_count = 1 output &&
    -+	grep "^update refs/heads/topic2 " output
    ++	test_grep "^update refs/heads/topic2 " output
     +'
     +
     +test_expect_success 'invalid replay.refAction value' '
    -+	test_when_finished "git config --unset replay.refAction" &&
    -+	git config replay.refAction invalid &&
    ++	test_config replay.refAction invalid &&
     +	test_must_fail git replay --onto main topic1..topic2 2>error &&
    -+	grep "invalid value for replay.refAction" error
    ++	test_grep "invalid.*replay.refAction.*value" error
     +'

-- 
2.51.0

base-commit: 419c72cb8ada252b260efc38ff91fe201de7c8c3

Thanks
- Siddharth

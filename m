Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2781388
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409476; cv=none; b=m3dUTpSzrLvfQfYndB8wSxjEqvvftBjMiUJkDT6bhpvPpV0U32UPDmAseZSpPLknkLQqFK2ZBiNERWzsXfrJjKsQkPeVeZvnxF/ekC9v/L0JGxdmyfHu40wUnLV7nmetj6d47SwB1h9IGnUyvLh/ZgMFwaggcbq8liLZljOsQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409476; c=relaxed/simple;
	bh=Pk7O5hxz9pK/f0DWTl+nYZvY/h7eNO+ma+Y01iptnhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnVxElA7XsFAZ9NRQtnY5nN0gzVTuXriZOZ0g0+4YdbtXLOUnVGVtL40glDF/XNE7Dzsi6rjDZRl//imLMo0zKVXpMS/VHtmebWQp9WNMM3PrUqYDS6rx8Xmie07E0kdCNxUOMAJ1WhpLAGppbKJ4pGgzgEOTf6xFjpToxzdlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUOisDqx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUOisDqx"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72b7a53ceb6so607894a34.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742409473; x=1743014273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXyiGB6Gna3V6zVvIvMcKgC+9D2YnI6LUAXBN/NY4Os=;
        b=FUOisDqx8Ny1UhmYmKH1v7W7/S7do3GN7/hgZTchQVNWrMG+Tm0R6uaXs8ZWNZGd9A
         TjuQwAFdRyelpkGI61AYkmEU7NJPIFDbXAFjkE89yaJJS1TFWwARAdCBTauLbxFP+BKJ
         OCdm0H2Rezn1Zp7zV2iNzN5dLyXx7U21PpODwVuJjV9MFbIlS2+z6rHFT899S02AnQb/
         i0oYHN+yS875QuC6IMP1UIuCMijl/0iKG/ECykveus2x+41wrhvYQl0qsAQPq1kknlBe
         xFLr0BX5AscOa8J6vlSrcRP4ImpPhUjlp1n/SUuvKpIc6nt7VjM3aBwuUHptcD1Ie3+a
         XlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409473; x=1743014273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXyiGB6Gna3V6zVvIvMcKgC+9D2YnI6LUAXBN/NY4Os=;
        b=QZ6CtHPfiaeKH1xxFVsX5+Hs4r6Ip0tMTzC70+ggk0lApkY2TV/FAdL2/8TM2jC+7E
         BC3vzXfHyepfVsnade7bf5AExqYf3VKv2RNj5G6jyc1VzCOB6dknRHFJZL11yv93Ul44
         +oqIFuJ3+wPjC79914HCihU0VRoZp6Yoc751jvK7+GjKOEtEmAC8Pqs0/KZCYLljiQZw
         WuFKi9E9IaWmaopg+s9CRPKBOcGGUoAnp+00MLFGArH19pjTGkXrsByumc2DMhNcmXcP
         TOEeTKOE3DtXoS3J2poR18wro7pgg2F7HStl0CPOiEtOiEW3nK/kGPn1OJMxLO0IaSt9
         ZWPA==
X-Gm-Message-State: AOJu0YxCoM9mQhTcEiHhNGKKvQn2SyGWS5oZUWVkehEPP87/p3BfPWjU
	Tu38/oC8VOKp5qAL7HVnaqJFu8+uYqfq3nTPvb+ifKeKJqFp+6V6yoWcEw==
X-Gm-Gg: ASbGnctMH26epl3L4TOJo5vR5m7gqAV4yBdVok4X3pMBCI94672JeP2ZwVrYaaEX0Pb
	n6qfqzZ8HJjIcnxEHmbCc+ptaAg3bCfUijApaRJOflrwSg1IC9WAP2wT8zzJBekMSavt5IMhnCc
	FslSV7bDunLIf0Nt5ZANLhZOCJqVeOQG0G2NoLBR8GGym/wtrUIJmuUwcBst0dNnEg3KS9DN2OV
	n2LOb21sXXqvZLTKPX4CVByv/roXE+6pmwuwRL0MjhkKe9vVajSV5SVq1VYb0EvvjoZTLEEMxhP
	3NpvGPeeqw8yyKdYkJvnGwRoAEqeV0NUGJSTbsbaiO7iR53VMzDo
X-Google-Smtp-Source: AGHT+IGVtpKMOAZ+iTU8V8gfBhJcqNcGwK3ot4iIRP+FHBLH3rcp4xS+X3I1HfMqWqTo+MwJbKxMWg==
X-Received: by 2002:a9d:674b:0:b0:72b:7be8:7ef7 with SMTP id 46e09a7af769-72c02ddf843mr383929a34.9.1742409472859;
        Wed, 19 Mar 2025 11:37:52 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e796sm2561943a34.48.2025.03.19.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:37:52 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/5] rev-list: introduce NUL-delimited output mode
Date: Wed, 19 Mar 2025 13:34:05 -0500
Message-ID: <20250319183410.1225428-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313235747.9583-1-jltobler@gmail.com>
References: <20250313235747.9583-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When walking objects, git-rev-list(1) prints each object entry on a
separate line in the form:

        <oid> LF

Some options, such as `--objects`, may print additional information
about the object on the same line:

        <oid> SP [<path>] LF

In this mode, if the object path contains a newline it is truncated at
the newline.

The `--boundary` option also modifies output by prefixing boundary
objects with `-`:

        -<oid> LF

When the `--missing={print,print-info}` option is provided, information
about any missing objects encountered during the object walk are also
printed in the form:

        ?<oid> [SP <token>=<value>]... LF

where values containing LF or SP are printed in a token specific fashion
so that the resulting encoded value does not contain either of these two
problematic bytes. For example, missing object paths are quoted in the C
style when they contain LF or SP.

To make machine parsing easier, this series introduces a NUL-delimited
output mode for git-rev-list(1) via a `-z` option. In this mode, the
output format for object records is unified such that each object and
its accompanying metadata is formatted without relying on object
metadata order. This format follows the existing `<token>=<value>` used
by the `--missing` option to represent object metadata in the form:

        <oid> NUL [<token>=<value> NUL]...

        # Examples
        <oid> LF                       -> <oid> NUL
        <oid> SP <path> LF             -> <oid> NUL path=<path> NUL
        -<oid> LF                      -> <oid> NUL boundary=yes NUL
        ?<oid> [SP <token>=<value>]... -> <oid> NUL missing=yes NUL [<token>=<value> NUL]...

Note that token value info is printed as-is without any special encoding
or truncation. Prefixes such as '-' and '?' are dropped in favor using a
token/value pair to signal the same information.

For now this series only adds support for use with the `--objects`,
`--boundary` and `--missing` output options. Usage of `-z` with other
options is rejected, so it can potentially be added in the future.

This series is structured as follows:

        - Patches 1 and 2 do some minor preparatory refactors.

        - Patch 3 adds the `-z` option to git-rev-list(1) to print
          objects in a NUL-delimited fashion.

        - Patch 4 teaches the `--boundary` option how to print info in a
          NUL-delimited fashino using the unified output format.

        - Patch 5 teaches the `--missing` option how to print info in a
          NUL-delimited fashion using the unified output format.

Changes since V3:

        - The -z option now only makes output NUL-delimited. Input
          parsed on stdin via the `--stdin` option remains unchanged.
          This is done to remain more consistent with other log family
          commands. Support for more explicit options to control
          NUL-delimited input/ouput behavior may be added in a future
          series via `--NUL-delimited-{input,output}` options.

        - Changed some variable names in tests that were a little
          confusing.

Changes since V2:

        - In patch 4, the documentation for the -z option now points out
          the `--stdin` behavior change earlier.

        - Minor code style and documentation changes in patch 6.

Changes since V1:

        - Use unified output format with `<token>=<value>` pairs for
          all object metadata.

        - Add support for the `--boundary` option in NUL-delimited mode.

        - Add support for NUL-delimited stdin argument parsing in
          NUL-delimited mode.

        - Instead of using two NUL bytes to delimit between object
          records, a single NUL byte is used. Now that object metadata
          is always in the form `<token>=<value>`, we know a new object
          record starts when there is an OID entry which will not
          contain '='.

Thanks for taking a look,
-Justin

Justin Tobler (5):
  rev-list: inline `show_object_with_name()` in `show_object()`
  rev-list: refactor early option parsing
  rev-list: support delimiting objects with NUL bytes
  rev-list: support NUL-delimited --boundary option
  rev-list: support NUL-delimited --missing option

 Documentation/rev-list-options.adoc | 24 ++++++++
 builtin/rev-list.c                  | 93 +++++++++++++++++++++--------
 revision.c                          |  8 ---
 revision.h                          |  2 -
 t/t6000-rev-list-misc.sh            | 51 ++++++++++++++++
 t/t6022-rev-list-missing.sh         | 31 ++++++++++
 6 files changed, 175 insertions(+), 34 deletions(-)

Range-diff against v3:
1:  d2eded3ac7 = 1:  d2eded3ac7 rev-list: inline `show_object_with_name()` in `show_object()`
2:  03cd08c859 = 2:  03cd08c859 rev-list: refactor early option parsing
3:  803a49933a < -:  ---------- revision: support NUL-delimited --stdin mode
4:  8eb7669089 ! 3:  f6ee01571d rev-list: support delimiting objects with NUL bytes
    @@ Commit message
         from `--objects` is appended to the record as a token/value pair
         `path=<path>` as-is without any truncation.
     
    -    In this mode, revision and pathspec arguments provided on stdin with the
    -    `--stdin` option are also separated by a NUL byte instead of being
    -    newline delimited.
    -
    -    For now, the `--objects` and `--stdin` flag are the only options that
    -    can be used in combination with `-z`. In a subsequent commit,
    -    NUL-delimited support for other options is added. Other options that do
    -    not make sense with be used in combination with `-z` are rejected.
    +    For now, the `--objects` flag is the only options that can be used in
    +    combination with `-z`. In a subsequent commit, NUL-delimited support for
    +    other options is added. Other options that do not make sense when used
    +    in combination with `-z` are rejected.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ Documentation/rev-list-options.adoc: ifdef::git-rev-list[]
     +
     +-z::
     +	Instead of being newline-delimited, each outputted object and its
    -+	accompanying metadata is delimited using NUL bytes. In this mode, when
    -+	the `--stdin` option is provided, revision and pathspec arguments on
    -+	stdin are also delimited using a NUL byte. Output is printed in the
    -+	following form:
    ++	accompanying metadata is delimited using NUL bytes. Output is printed
    ++	in the following form:
     ++
     +-----------------------------------------------------------------------
     +<OID> NUL [<token>=<value> NUL]...
    @@ builtin/rev-list.c: int cmd_rev_list(int argc,
      		} else if (skip_prefix(arg, "--missing=", &arg)) {
      			parse_missing_action_value(arg);
     +		} else if (!strcmp(arg, "-z")) {
    -+			s_r_opt.nul_delim_stdin = 1;
     +			line_term = '\0';
     +			info_term = '\0';
      		}
    @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --unpacked' '
     +	test_commit -C repo 1 &&
     +	test_commit -C repo 2 &&
     +
    -+	oid1=$(git -C repo rev-parse HEAD) &&
    -+	oid2=$(git -C repo rev-parse HEAD~) &&
    ++	oid1=$(git -C repo rev-parse HEAD~) &&
    ++	oid2=$(git -C repo rev-parse HEAD) &&
     +
    -+	printf "%s\0%s\0" "$oid1" "$oid2" >expect &&
    ++	printf "%s\0%s\0" "$oid2" "$oid1" >expect &&
     +	git -C repo rev-list -z HEAD >actual &&
     +
     +	test_cmp expect actual
    @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --unpacked' '
     +'
     +
      test_done
    -
    - ## t/t6017-rev-list-stdin.sh ##
    -@@ t/t6017-rev-list-stdin.sh: test_expect_success '--not via stdin does not influence revisions from command l
    - 	test_cmp expect actual
    - '
    - 
    -+test_expect_success 'NUL-delimited stdin' '
    -+	printf "%s\0%s\0%s\0" "HEAD" "--" "file-1" > input &&
    -+
    -+	git rev-list -z --objects HEAD -- file-1 >expect &&
    -+	git rev-list -z --objects --stdin <input >actual &&
    -+
    -+	test_cmp expect actual
    -+'
    -+
    - test_done
5:  591a2c7dac ! 4:  ccf6bd8d35 rev-list: support NUL-delimited --boundary option
    @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list -z --objects' '
     +	test_commit -C repo 1 &&
     +	test_commit -C repo 2 &&
     +
    -+	oid1=$(git -C repo rev-parse HEAD) &&
    -+	oid2=$(git -C repo rev-parse HEAD~) &&
    ++	oid1=$(git -C repo rev-parse HEAD~) &&
    ++	oid2=$(git -C repo rev-parse HEAD) &&
     +
    -+	printf "%s\0%s\0boundary=yes\0" "$oid1" "$oid2" >expect &&
    ++	printf "%s\0%s\0boundary=yes\0" "$oid2" "$oid1" >expect &&
     +	git -C repo rev-list -z --boundary HEAD~.. >actual &&
     +
     +	test_cmp expect actual
6:  669b3b5d9f = 5:  b1bd245155 rev-list: support NUL-delimited --missing option

base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
-- 
2.49.0.rc2


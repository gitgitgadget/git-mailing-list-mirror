Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8A1E489
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491327; cv=none; b=NDGmXLT9sq3154WZXdNvLuj9x89C3XyeOyQ70siS6kVc0Uy++Du8NVWC+hJA2UAqAtshdIbFXrzi2PXASII3rKM9x5GNZ7AKUiSwqYgAbzyfwzC/Q2NXnSz+mrLqKsNuotHFqNYOGPYTUIoZstIBKGG+BQlCm6y5vgcJB4ZsAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491327; c=relaxed/simple;
	bh=p0Sd0Ho2nYS27MAXhF2dr7ky9lSjc770EEpqTOV+kX4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MesWLRaOnPC1PwVtbW5jjQG0VCyAGnmFP1GoPtTx+2ZYCEmv4lytz4YrqDgALlTzLh31HKrXm/s/2veojZrRsjJTAi03W9C+OnSt+Zq3GDL5Lh1VvWIyil1yn6K8oU4Ih4xtPC4igV7aRhaF3UjGoMXFgWi0JzkgNdtiJVcrNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncOPsUpS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncOPsUpS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3686b285969so1094729f8f.0
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721491324; x=1722096124; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e23EM6xY/ea5liJigNFPfbCtIGNIEz+mftnspHNfJA=;
        b=ncOPsUpSNffisdWUKoreBAcCNA/mgfSplMeiVT4AxezdR4AhSV//CzhhXWrSLxiHds
         +3U/0D2zP5hH7aqxrq8eu1jIk87HNA8epe2r00HBpNNs1G/uDFzOPHSeoNrEIU5l0WGh
         lvTSI0k5qPv24MtwD4FEAq81LhQJ8z4tqJeSaHqUM+VeMJhWBkhGet5HHPOEg73MU1gI
         ekWhgiXvhCpLSxg3oHNTa4sm1saykrSYcgEMwwWt4cP8OBaiW/SseoFKyJu8rLV0Gait
         2pumUXziUlluoB03fMGv17HHLWbS1ARgVluaGducshN4WCmRaBGCU5a+GxUlvB5E5TrQ
         Rlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721491324; x=1722096124;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e23EM6xY/ea5liJigNFPfbCtIGNIEz+mftnspHNfJA=;
        b=YBVB4J7J0Mcw6cB8wxcxgYrgxC2jHAWZf4HFQtHwSxM3PcweBuijYoeJRSdmtaqVXL
         UwUVHEQ9IJvp2sqTA4Z84fsK+3Ndjb00jp2qmoad2++l0mBUwc6L3ULxI9dttKcUQdpE
         vVxenubhyW0PBijzRhm83+zaSuvDv58RnhWpHfRSAUm8PunVWcyUMoG1Wn7Wrmlc/vHm
         GW1YQBVWG2H71EptrIUspACLOA2pcJpHCTlWzkrqf9DFrQSarCEJl7Rrp2yEzRZj98H/
         aYBFLI++R+NEg3Z7S4SKL5sYAjtSZhUDVKu9sZjMW89/1uFtnInsd99/JbkrBNI/Gpo4
         YDyw==
X-Gm-Message-State: AOJu0Yy9Bh6CGVY241qN7OhJFhts1rYwz79bwPEudL0wpTYCWueqmzfS
	G6ITx1h4nEMNI+XLKquhCdaXqqo7ku2glZINvypnULqEmNs2NugJTpAxzA==
X-Google-Smtp-Source: AGHT+IFJNakz6a7DgsGs+6q7z2BuN5cvs1QPL1HSGlljrxFF6DgHQsQ3R8tx79rCPp5yXRVowrfuBg==
X-Received: by 2002:adf:b31d:0:b0:367:8a72:b8b4 with SMTP id ffacd0b85a97d-369bae46a5fmr1029756f8f.33.1721491323569;
        Sat, 20 Jul 2024 09:02:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a94c30sm89722545e9.47.2024.07.20.09.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 09:02:02 -0700 (PDT)
Message-Id: <pull.1763.v2.git.1721491320.gitgitgadget@gmail.com>
In-Reply-To: <pull.1763.git.1721312619822.gitgitgadget@gmail.com>
References: <pull.1763.git.1721312619822.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jul 2024 16:01:58 +0000
Subject: [PATCH v2 0/2] add-patch: handle splitting hunks with diff.suppressBlankEmpty
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

This is an alternative to jk/add-patch-with-suppress-blank-empty which was
recently discarded from next. I hope that normalizing the context marker
will simplify any future changes to the code.

Changes since V1

 * Updated merge_hunks() to use normalize_marker() as spotted by Junio
 * Updated the test so it checks merge_hunks() as well.

Phillip Wood (2):
  add-patch: handle splitting hunks with diff.suppressBlankEmpty
  add-patch: use normalize_marker() when recounting edited hunk

 add-patch.c                | 23 +++++++++++++++--------
 t/t3701-add-interactive.sh | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 8 deletions(-)


base-commit: 790a17fb19d6eadd16c52e5d284a5c6921744766
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1763%2Fphillipwood%2Fadd-p-suppress-blank-empty-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1763/phillipwood/add-p-suppress-blank-empty-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1763

Range-diff vs v1:

 1:  fd09e66727a ! 1:  34d8fd44a97 add-patch: handle splitting hunks with diff.suppressBlankEmpty
     @@ add-patch.c: static void complete_file(char marker, struct hunk *hunk)
       }
       
      +/* Empty context lines may omit the leading ' ' */
     -+static int normalize_marker(char *p)
     ++static int normalize_marker(const char *p)
      +{
      +	return p[0] == '\n' || (p[0] == '\r' && p[1] == '\n') ? ' ' : p[0];
      +}
     @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec
       
       		p = eol == pend ? pend : eol + 1;
       		hunk->end = p - plain->buf;
     +@@ add-patch.c: static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
     + 					    (int)(hunk->end - hunk->start),
     + 					    plain + hunk->start);
     + 
     +-				if (plain[overlap_end] != ' ')
     ++				if (normalize_marker(&plain[overlap_end]) != ' ')
     + 					return error(_("expected context line "
     + 						       "#%d in\n%.*s"),
     + 						     (int)(j + 1),
      @@ add-patch.c: static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
       	context_line_count = 0;
       
       	while (splittable_into > 1) {
      -		ch = s->plain.buf[current];
     -+		ch = normalize_marker(s->plain.buf + current);
     ++		ch = normalize_marker(&s->plain.buf[current]);
       
       		if (!ch)
       			BUG("buffer overrun while splitting hunks");
     @@ t/t3701-add-interactive.sh: test_expect_success 'reset -p with unmerged files' '
       
      +test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
      +	test_config diff.suppressBlankEmpty true &&
     -+	test_write_lines a b c "" d e f >file &&
     ++	write_script fake-editor.sh <<-\EOF &&
     ++	tr F G <"$1" >"$1.tmp" &&
     ++	mv "$1.tmp" "$1"
     ++	EOF
     ++
     ++	test_write_lines a b "" c d  "" e f "" >file &&
      +	git add file &&
     -+	test_write_lines p q r "" s t u >file &&
     -+	test_write_lines s n y q | git add -p &&
     ++	test_write_lines A b "" c D  "" e F "" >file &&
     ++	(
     ++		test_set_editor "$(pwd)/fake-editor.sh" &&
     ++		test_write_lines s n y e q | git add -p file
     ++	) &&
      +	git cat-file blob :file >actual &&
     -+	test_write_lines a b c "" s t u >expect &&
     ++	test_write_lines a b "" c D "" e G "" >expect &&
      +	test_cmp expect actual
      +'
      +
 -:  ----------- > 2:  7bdcd2df012 add-patch: use normalize_marker() when recounting edited hunk

-- 
gitgitgadget

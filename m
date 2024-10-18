Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B71D7E57
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259586; cv=none; b=i8giF4x7mBHZ+a6d4XYcbfWv8q/IqQrxJMuOjjpQReXl53eVuXdcdxQEZ5ctyXGo9AKBM4ltg9g84CPjQcMDHLyNOcHjUor4OP8WWq1u+RoJsaqLvOMRB7bfdoUJlb3fBnJ3folkLi3WM2ksWNUW9DaggTds1yQGpdo33ASoTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259586; c=relaxed/simple;
	bh=o+/wVG2kY5KkOghYuVBxS8GeWvs0yXMjfyfS36SB++0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kKqUcWmnrMSlxbeNA7vWHuHauTvTZpF9DELQUgn4K0GOQcaw674mJhOFN3Hk1x/TYIdouh7ct405GRTaLiE1fsOs/ess84SNp9S4Js1l38Nba60NfJDdfB+tyu6uz07RHux+oNiL1GEa1JJFGO7iwkvMuXBvQKMyt+mJlSDA3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz0ZFl8+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz0ZFl8+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99f629a7aaso372207366b.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729259581; x=1729864381; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi8J4xiTreKAqylJFuVqP+WfOwNczEVRUItXMIglfzc=;
        b=Dz0ZFl8+b8/xf4tZzi3poDknSjCV77dwqE1XmptGNxSad3JrxXSFmsDGBHovZQKMgS
         FHpNm9suOT0f7JUuUHC2o16t2rtoYLhHFzA6RmqUJ1YOOVrDi8RVVro/xG/Ss1o7lyHi
         DsNhh7sPed0zBdOAAIQAg/2iVrc3Yk39xx/WzEHIn+OTD3TSxlbvSL6HLy67UcomGwak
         p8+BVCU/fykq5HI/Fp6IAXhLCy21pQy12s4dBPfLz526/GMzdnHL6pyksRs21QW01Ckv
         7azAK5EHOBsWz7rHeYygF2wraZLkERBU75jYXLQxt3j0AjsvTuPjuCraWLy/4LZiA9ka
         0zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259581; x=1729864381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi8J4xiTreKAqylJFuVqP+WfOwNczEVRUItXMIglfzc=;
        b=VNZGA7FsBZysu050jBWSCOGuBQyeM4wljf86oQ3DDn93q9RHonjlyUwZ+ukKpLRXOY
         5boNdcGBEnQH7lKnVyyhqL4HOiuI4tZnqFWmTeORsWAbfDjtP8Q8EUtqmPP1CTD9RihE
         1OvDm3IaeMNzfjjA3EvhnJP0hUdQkggO589oTRLb0e5Jj72MZrEEW75Dvxsu6EjssSGX
         i/WlfH2Wd5vrGbN/SYh6r+teY632eHsizpxC344IEQC0pxWmGhGKFrUXjLZOOwNgiyHv
         MdCH7Bu+K5Vibp7wNCNuqx6wuZT7qpTrP1BnF7+COf6BIckbz4Q6UYXPboSxbJWxr3Na
         JX4A==
X-Gm-Message-State: AOJu0YxwyUMw+zcYa4Yfu3sO1rCG2d/IzH+O/iR9OgQWHSUlgBSPZNjd
	fJtZE48DI+ZWKh+cBN2OnL5Zl+Uvsw33bjvAGghdqd3xFBDrZOnsWve+Zw==
X-Google-Smtp-Source: AGHT+IEio1YHiuwlRm8QpvTubW1E4kkM4n0cJozTfepHXWPteAkY45KG4JTN8aHJjvA1JmHdlkW5Kw==
X-Received: by 2002:a17:906:c115:b0:a9a:49a8:35b2 with SMTP id a640c23a62f3a-a9a4cc3c062mr770081566b.20.1729259581449;
        Fri, 18 Oct 2024 06:53:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf60c9sm98991766b.162.2024.10.18.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:53:01 -0700 (PDT)
Message-Id: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Oct 2024 13:52:57 +0000
Subject: [PATCH v2 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes from Version 1:

 * In my initial commit, I mistakenly included changes from a different
   patch and commit. This issue has now been resolved.
 * I have split the original commit into three separate patches for better
   clarity and organization.
 * I added corresponding tests for each of the changes to ensure proper
   functionality.
 * In the first version, I used the following logic: if (strtoul_ui(v, 10,
   &timeout) == 0) Based on feedback from my mentor, I improved it to:
   (strtoul_ui(v, 10, &timeout)) and similar cases.

Usman Akinyemi (3):
  daemon: replace atoi() with strtoul_ui() and strtol_i()
  merge: replace atoi() with strtol_i() for marker size validation
  imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
    parsing

 daemon.c              | 11 +++++++----
 imap-send.c           | 13 ++++++++-----
 merge-ll.c            |  6 ++++--
 t/t5570-git-daemon.sh | 27 ++++++++++++++++++++++++++-
 t/t6406-merge-attr.sh |  7 +++++++
 5 files changed, 52 insertions(+), 12 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1810%2FUnique-Usman%2Fr_atoi-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1810/Unique-Usman/r_atoi-v2
Pull-Request: https://github.com/git/git/pull/1810

Range-diff vs v1:

 1:  bfff7937cd2 < -:  ----------- t3404: avoid losing exit status with focus on `git show` and `git cat-file`
 2:  e2cae7f3a51 < -:  ----------- t3404: replace test with test_line_count()
 -:  ----------- > 1:  a333d8a4013 daemon: replace atoi() with strtoul_ui() and strtol_i()
 -:  ----------- > 2:  5d58c150efb merge: replace atoi() with strtol_i() for marker size validation
 3:  c93bc2d81ff ! 3:  c09c7b3df0d parse: replace atoi() with strtoul_ui() and strtol_i()
     @@ Metadata
      Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
       ## Commit message ##
     -    parse: replace atoi() with strtoul_ui() and strtol_i()
     +    imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing
      
     -    Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
     -    and strtol_i() for signed integers across multiple files. This change
     -    improves error handling and prevents potential integer overflow issues.
     -
     -    The following files were updated:
     -    - daemon.c: Update parsing of --timeout, --init-timeout, and
     -      --max-connections
     -    - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
     -      tags
     -    - merge-ll.c: Enhance parsing of marker size in ll_merge and
     -      ll_merge_marker_size
     -
     -    This change allows for better error detection when parsing integer
     -    values from command-line arguments and IMAP responses, making the code
     -    more robust and secure.
     -
     -    This is a #leftoverbit discussed here:
     -     https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
     +    Replaced unsafe uses of atoi() with strtol_i() to improve error handling
     +    when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
     +    Invalid values, such as those with letters,
     +    now trigger error messages and prevent malformed status responses.
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
     -    Cc: gitster@pobox.com
     -    Cc: Patrick Steinhardt <ps@pks.im>
     -    Cc: phillip.wood123@gmail.com
     -    Cc: Christian Couder <christian.couder@gmail.com>
     -    Cc: Eric Sunshine <sunshine@sunshineco.com>
     -    Cc: Taylor Blau <me@ttaylorr.com>
     -
     - ## daemon.c ##
     -@@ daemon.c: int cmd_main(int argc, const char **argv)
     - 			continue;
     - 		}
     - 		if (skip_prefix(arg, "--timeout=", &v)) {
     --			timeout = atoi(v);
     -+			if (strtoul_ui(v, 10, &timeout) < 0) {
     -+				die("'%s': not a valid integer for --timeout", v);
     -+			}
     - 			continue;
     - 		}
     - 		if (skip_prefix(arg, "--init-timeout=", &v)) {
     --			init_timeout = atoi(v);
     -+			if (strtoul_ui(v, 10, &init_timeout) < 0) {
     -+				die("'%s': not a valid integer for --init-timeout", v);
     -+			}
     - 			continue;
     - 		}
     - 		if (skip_prefix(arg, "--max-connections=", &v)) {
     --			max_connections = atoi(v);
     --			if (max_connections < 0)
     --				max_connections = 0;	        /* unlimited */
     -+			if (strtol_i(v, 10, &max_connections) != 0 || max_connections < 0) {
     -+				max_connections = 0;  /* unlimited */
     -+			}
     - 			continue;
     - 		}
     - 		if (!strcmp(arg, "--strict-paths")) {
     -
       ## imap-send.c ##
      @@ imap-send.c: static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
       		return RESP_BAD;
       	}
       	if (!strcmp("UIDVALIDITY", arg)) {
      -		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
     -+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) != 0) {
     ++		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) {
       			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
       			return RESP_BAD;
       		}
       	} else if (!strcmp("UIDNEXT", arg)) {
      -		if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
     -+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) != 0) {
     ++		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) || !imap->uidnext) {
       			fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
       			return RESP_BAD;
       		}
     @@ imap-send.c: static int parse_response_code(struct imap_store *ctx, struct imap_
       	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
      -		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
      -		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
     -+		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) != 0) ||
     -+			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) != 0)) {
     ++		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) ||
     ++			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx)) {
       			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
       			return RESP_BAD;
       		}
     @@ imap-send.c: static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *
       				return DRV_OK;
       		} else {
      -			tag = atoi(arg);
     -+			if (strtol_i(arg, 10, &tag) != 0) {
     ++			if (strtol_i(arg, 10, &tag)) {
      +				fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
      +				return RESP_BAD;
      +			}
       			for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
       				if (cmdp->tag == tag)
       					goto gottag;
     -
     - ## merge-ll.c ##
     -@@ merge-ll.c: enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
     - 	git_check_attr(istate, path, check);
     - 	ll_driver_name = check->items[0].value;
     - 	if (check->items[1].value) {
     --		marker_size = atoi(check->items[1].value);
     --		if (marker_size <= 0)
     -+		if (strtol_i(check->items[1].value, 10, &marker_size) != 0 || marker_size <= 0)
     - 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
     - 	}
     - 	driver = find_ll_merge_driver(ll_driver_name);
     -@@ merge-ll.c: int ll_merge_marker_size(struct index_state *istate, const char *path)
     - 		check = attr_check_initl("conflict-marker-size", NULL);
     - 	git_check_attr(istate, path, check);
     - 	if (check->items[0].value) {
     --		marker_size = atoi(check->items[0].value);
     --		if (marker_size <= 0)
     -+		if (strtol_i(check->items[0].value, 10, &marker_size) != 0 || marker_size <= 0)
     - 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
     - 	}
     - 	return marker_size;

-- 
gitgitgadget

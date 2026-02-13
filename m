Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C70306487
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020698; cv=none; b=pbU+qbDXNFtXZ2HFJtGMiXHesWDkoe9TXjvRfzkNtSY3PEDzjIXg2iZYKgVmOngvF8T6Lg2af1iaM6LVOn+2Eff1oEetxRkkV3BBctrjEp0EME2f43zkmObjfH5qqmtwtzO+PqEbuRyH+htDDYZXFGO4HkVYBly80D65zT/PzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020698; c=relaxed/simple;
	bh=FJaSnMfKF36k/dN0JFdDSgL3NrGq4RITVNd1xTDl/aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaGGA4BrDAVYCaJmgQpExiQCf0tM0yzdgcbM5c+njzSUmi49EyvAq6K0UB64gCyFPPI2KNzK1zFnB35/LoPa2uUQra8nWub5fqxVPizanEAv3Hu6mEMf0T5DksZd8KcLv+6Dz+OsPNfpk8qJwVkmwbMgFOsS6m9Fe53rxBFE0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gid/AY/W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gid/AY/W"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43767807da6so844307f8f.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771020694; x=1771625494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txRDosfPod6AU8WUvWBGeTkKIQcFLODpqpYM9ZTlS+Y=;
        b=Gid/AY/WnB/JrrxeTztqszv3XaMt3Vg41iW/xGzLKXON5WT5kOhGGjvWGnL5OphmSB
         5dOjVKDoFJFzE/ZHmOFKBBiaFBscqTJ+fLdYdXtiKwgjcUpIafuEB2mypcYBvWvUq6Ek
         hfebvE8/fC85N95f3cIxpHu6w39z+emtlQWkBeX5w0xnCtII4GiBpHxzmySsEsukbW8Z
         nr2iw9cOfG3mY5Y1elvEJviQno1nw3/l47B3yrSlUxN6TAJLOqT1Fl7+tLRHdlZYyDAp
         P9Niumwzte4Od6BGdlJlUPEHlhS31KwLGenjrQ7BgmLmRVrLEApc3kSzEoa2cxfUXUZJ
         00aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771020694; x=1771625494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txRDosfPod6AU8WUvWBGeTkKIQcFLODpqpYM9ZTlS+Y=;
        b=lg9mGuGyVkFDqg/IhzHyXXzwOgkeaczJHiZ6vUZGZed8M2glZgySuGAbXQgp3ppyV3
         iMrE5PKAME/1GcWU0aonKeil27KnKJCfagWLCMhQgOG1dBe7nLVAp21X9oMmvwt9yTOi
         gJMpV9u/bA13Z5wNsZPYDvrx/hZLVFOZDGKM/OTkKR9/xS2ZR8a+b8v4NUdhtN35l90/
         RK3UX1+MWIloWv620y+ekhqiiH/o90hCMuSTSsXceyuLnA9j8RMEBaGdCDGm8PF9U2AZ
         o/+XmSjXllfLHoOQBe5k1uq90VvIl9EMRWJbP+cOoPgEJUQsg+Hdr+yqQPYGSe+PSlbL
         kP1w==
X-Gm-Message-State: AOJu0Yz1JO9fLuJbPeK3B0GBvgdpLkN83EGb1zgvVpq4ZQYcGv4+RsVo
	/BfSC+18aR7mWBLdaN67AGCGEg87ciNnN7W+L0kkFdRQQj5/iajkYrRKClZhwn2N
X-Gm-Gg: AZuq6aJwD3jyghMDNQdGBnl3RDSi/W+QX+dwGwND9jyes4jj2p0a4xgFpz8dVqjkMcw
	+K28KpUbCDBFH8R0dQbYi7fyydEQPsNEfLn9fgas2aJvMArmoH+Ne4lICTt0WtmXkjoQuGh+NIF
	dCyibi+xWVr9AAfLUXrxjpQL5Y8Pw5jI6/t13dNOYjfGKyXZlI4o27bv+XyoTopS0v9Z8jPaFQG
	oQBDwHLe3W2x0diiqiIi+0q24ftiH6aGIoRUMEFwQap7Vjpr9MwJKtQovF4sCDUoINzMZwnd4xb
	MdJTe0kA5WpmhurY0nX2gwD4tajBnMAkXb+y346D3ji/6hyDW07cIicYgO4f1LBAV4fUmUqAbWk
	XC8eVoez9WdyFMnVYENgE55aMd5YcruoygehXtQjvdyOtSDidenvsB2+HXc9KcV+GBXZgBPRfxN
	OqknFTCFe1qLQo7HtlEwuNaLzCMutXWrw=
X-Received: by 2002:a05:6000:24c4:b0:436:cea:6165 with SMTP id ffacd0b85a97d-437978c09d5mr5632825f8f.6.1771020694002;
        Fri, 13 Feb 2026 14:11:34 -0800 (PST)
Received: from localhost ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac92sm8535450f8f.1.2026.02.13.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 14:11:33 -0800 (PST)
Date: Fri, 13 Feb 2026 23:11:43 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v4 3/4] add-patch: allow all-or-none application of patches
Message-ID: <aed0a80d8e55e4331677844bd84635b758572959.1771015581.git.abrahamadekunle50@gmail.com>
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771015581.git.abrahamadekunle50@gmail.com>

When the flag `--no-auto-advance` is used with `--patch`,
if the user has decided `USE` on a hunk in a file, goes to another
file, and then returns to this file and changes the previous
decision on the hunk to `SKIP`, because the patch has already
been applied, the last decision is not registered and the now
SKIPPED hunk is still applied.

Move the logic for applying patches into a function so that we can
reuse this logic to implement the all or non application of the patches
after the user is done with the hunk selection.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c | 62 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 673ea659ff..7d4f17e432 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1420,6 +1420,40 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "P - print the current hunk using the pager\n"
    "? - print help\n");
 
+static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	size_t j;
+
+	/* Any hunk to be used? */
+	for (j = 0; j < file_diff->hunk_nr; j++)
+		if (file_diff->hunk[j].use == USE_HUNK)
+			break;
+
+	if (j < file_diff->hunk_nr ||
+		(!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
+		/* At least one hunk selected: apply */
+		strbuf_reset(&s->buf);
+		reassemble_patch(s, file_diff, 0, &s->buf);
+
+		discard_index(s->s.r->index);
+		if (s->mode->apply_for_checkout)
+			apply_for_checkout(s, &s->buf,
+					s->mode->is_reverse);
+		else {
+			setup_child_process(s, &cp, "apply", NULL);
+			strvec_pushv(&cp.args, s->mode->apply_args);
+			if (pipe_command(&cp, s->buf.buf, s->buf.len,
+					NULL, 0, NULL, 0))
+				error(_("'git apply' failed"));
+		}
+		if (repo_read_index(s->s.r) >= 0)
+			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
+							1, NULL, NULL, NULL);
+	}
+
+}
+
 static size_t dec_mod(size_t a, size_t m)
 {
 	return a > 0 ? a - 1 : m - 1;
@@ -1447,7 +1481,6 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
 	struct file_diff *file_diff = s->file_diff + idx;
@@ -1784,32 +1817,7 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 	}
 
-	/* Any hunk to be used? */
-	for (i = 0; i < file_diff->hunk_nr; i++)
-		if (file_diff->hunk[i].use == USE_HUNK)
-			break;
-
-	if (i < file_diff->hunk_nr ||
-	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
-		/* At least one hunk selected: apply */
-		strbuf_reset(&s->buf);
-		reassemble_patch(s, file_diff, 0, &s->buf);
-
-		discard_index(s->s.r->index);
-		if (s->mode->apply_for_checkout)
-			apply_for_checkout(s, &s->buf,
-					   s->mode->is_reverse);
-		else {
-			setup_child_process(s, &cp, "apply", NULL);
-			strvec_pushv(&cp.args, s->mode->apply_args);
-			if (pipe_command(&cp, s->buf.buf, s->buf.len,
-					 NULL, 0, NULL, 0))
-				error(_("'git apply' failed"));
-		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
-						     1, NULL, NULL, NULL);
-	}
+	apply_patch(s, file_diff);
 
 	putchar('\n');
 	return patch_update_resp;
-- 
2.39.5 (Apple Git-154)


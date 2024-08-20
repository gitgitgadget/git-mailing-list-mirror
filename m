Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280203B796
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118525; cv=none; b=BgTPim8FnG/07XTBWbk/zeCirQBU8T2DZakT4yvydvYj79c2wd0zswQNCDvaoFwXSBJa5cB3D+YaQAkgSjWyi+arcuUsryKoyl+0WM29+XdC3V5JSiq3buPXHILOlpceJFZzFX8hT3p2O8pzJqS3UtkzTEm7nRyqkAlnrem5a/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118525; c=relaxed/simple;
	bh=04M2SA6KLr1ytY4c4zDyaG6UDDk0NJk+zVZ7zJ5EVPg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gKgtPB57BAyKTY9cOZbgQkQdkxplmYqLSRuzq92KqoaHKUZ9R76MNpaxzPnYMKSlWU+k1nyA++RsPkXtJo0Z+pacn3L7So1MLVziZmAEtT2FP2QZeJBriU5G0XLczvtjp/mMVGkF/j/82nzqAbfjKf7LxZGgny5au9yPeRisDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlyibtG3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlyibtG3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8657900fc1so127866b.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118522; x=1724723322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u/SlEvxWfmaS8KDcb/mxNvkCVF5nerHKz183zR9kGw=;
        b=HlyibtG34BWAi0IKjmcWrLE+Uf26iINdagPCCqJui3YkhRyQzBPuOaYbc4+G4MzDAU
         jOceT6W47kzOKfF6ZPGRwerlYp3ISFKR2TrB7YoEpnFOx44ee58A8N4mRd8CzaxEbbZA
         qIjqySA73ckIiifo2xFZov8TujuffKIm17jHxgKHz8nz6xK+kf+IHtI4pGnKd3Fmndek
         oXVGmyQxGKbJms+rW2e19qY+l34zKEHDHKxWXa79p0uRUEE1/Lc0hQytzrZYBmpPDVka
         U5m1d+/X1Ys+XzC6iLUjNlKR29SbDrHIvWJFb5HAaUVGkkXjHEK8NgzrIUXy4xhnlEhY
         n1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118522; x=1724723322;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u/SlEvxWfmaS8KDcb/mxNvkCVF5nerHKz183zR9kGw=;
        b=I0QgnEQoZbt6t9H60fqLsBo68iXHZSYXz5vzIe7w/WNWCmeYkyXW16iA18oXo8dOuG
         qGEhz0iYP5lCrIHjsNjuENivet4wl+OpC17p0yz+amCpPf6zk1IWBoM/nXhLIRYcy8J1
         LzidoVtYY8ophNoORohGGF6d5pZmMVZQ56KGqNuEqepomq3wV5VQvJIVDgAsUQQrSbAk
         YzFK8TDodkO9ntQFy7gqhyrEKQA52U1m1Uu0Y35rS2V+t/iPOrCiCbicAsaGjQYwMgWM
         ogsx2K6LoJHK2JpWNJpkCpQdK5xIk6wc1w24131mMY4val26AQAjS+NI8KW8coGViAfs
         85pQ==
X-Gm-Message-State: AOJu0YwZcnnHJYsY3MKyef/dM7i91+U7ePsjrP2JDnWMPp6PspCHn04k
	pc/wBCIJEFObRRBxPOdd/iSREXECHpKF0gWCJP0kEDKsK+xqZtmTFE1dTA==
X-Google-Smtp-Source: AGHT+IHuViXBbSBFR5TP+5qU9EwUzb3raZM/wRQKxqATDShxTy64oMU+bcxGM4rOXPc1Yba4hvuf4A==
X-Received: by 2002:a17:907:2d88:b0:a7a:c083:8579 with SMTP id a640c23a62f3a-a8392a4b2e0mr918099966b.62.1724118521586;
        Mon, 19 Aug 2024 18:48:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c652asm707980266b.12.2024.08.19.18.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:41 -0700 (PDT)
Message-Id: <cb705d5fc8eedee276aa72bf1e15a36d6b4b4dd3.1724118513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:32 +0000
Subject: [PATCH v4 8/8] git-prompt: support custom 0-width PS1 markers
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

When using colors, the shell needs to identify 0-width substrings
in PS1 - such as color escape sequences - when calculating the
on-screen width of the prompt.

Until now, we used the form %F{<color>} in zsh - which it knows is
0-width, or otherwise use standard SGR esc sequences wrapped between
byte values 1 and 2 (SOH, STX) as 0-width start/end markers, which
bash/readline identify as such.

But now that more shells are supported, the standard SGR sequences
typically work, but the SOH/STX markers might not be identified.

This commit adds support for vars GIT_PS1_COLOR_{PRE,POST} which
set custom 0-width markers or disable the markers.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 6be2f1dd901..6186c474ba7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -129,11 +129,16 @@
 #    strings (SGR color sequences) when calculating the on-screen
 #    prompt width, to maintain correct input editing at the prompt.
 #
-#    Currently there's no support for different markers, so if editing
-#    behaves weird when using colors in __git_ps1, then the solution
-#    is either to disable colors, or, in some shells which only care
-#    about the width of the last prompt line (e.g. busybox-ash),
-#    ensure the git output is not at the last line, maybe like so:
+#    To replace or disable the 0-width markers, set GIT_PS1_COLOR_PRE
+#    and GIT_PS1_COLOR_POST to other markers, or empty (nul) to not
+#    use markers. For instance, some shells support '\[' and '\]' as
+#    start/end markers in PS1 - when invoking __git_ps1 with 3/4 args,
+#    but it may or may not work in command substitution mode. YMMV.
+#
+#    If the shell doesn't support 0-width markers and editing behaves
+#    incorrectly when using colors in __git_ps1, then, other than
+#    disabling color, it might be solved using multi-line prompt,
+#    where the git status is not at the last line, e.g.:
 #      PS1='\n\w \u@\h$(__git_ps1 " (%s)")\n\$ '
 
 # check whether printf supports -v
@@ -309,8 +314,8 @@ __git_ps1_colorize_gitstring ()
 		# \001 (SOH) and \002 (STX) are 0-width substring markers
 		# which bash/readline identify while calculating the prompt
 		# on-screen width - to exclude 0-screen-width esc sequences.
-		local c_pre="${__git_SOH}${__git_ESC}["
-		local c_post="m${__git_STX}"
+		local c_pre="${GIT_PS1_COLOR_PRE-$__git_SOH}${__git_ESC}["
+		local c_post="m${GIT_PS1_COLOR_POST-$__git_STX}"
 
 		local c_red="${c_pre}31${c_post}"
 		local c_green="${c_pre}32${c_post}"
-- 
gitgitgadget

Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01012A14B
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415836; cv=none; b=iEs5g2xRbrRo6KOXJU5MyEA7LPjnEwWNPuBCH9brVtsC8JECEXArKtikSpfxjW/N/ZpX5TVXC8mcO+5NYigSFK0YArzD4WX88yYfOxX4iv+MyaV9vVAY55SCY0vB6JcHo3+UqKuVzlhnCwOPTvg3pvBGZUbdgNSmXN7gDw1Q4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415836; c=relaxed/simple;
	bh=UKKPpYPTIB8l6rR71ijJperwJQGhIrQ6LtOA+ai1gV4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kNEzI+sSDJfIkRnD9yn0BeFGuEVsbOIoYZLfFxMaKFuKTjtnvAeWHl3vib81M9oCBf3cYNXmjIh+dWX+yZHoUdS9l5YTURVXc5s9xdkRcbfL+C2HKu4YcUDZf5MpZ0UcR3JxB/72Rq4aaYwXsSGqa705rCtAcuETyzPLibL+lWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZRWDflp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZRWDflp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346406a5fb9so4134363f8f.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714415833; x=1715020633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TB1BoVLiOux/HPrW8MyruJIMsPdwJkw5+l58oyD5a3c=;
        b=gZRWDflpgFUed+jErj0I1C9QR6dG+Gv+hfVDbZqrWjixJ9UymByFn2LGUsSZjwQRVw
         vk1HOsm61hhiD4MjlUCeBFjknO7mRsoNAi924uFqXGv+gK2X6a/CudmoD9luQn7ORzJl
         ziptgQ96s373tu2nzBgoA0hNhRRBDKcy+DIMEYvaE+SQkWpTWOCFeSGcILcDK27M3BvQ
         Ad3Ycqy/t8SRoVJ4Rf6DLKia8PbGlHjB6HbMHbVp+M4HukFufWRQu2jm4FKPE0Y1rUWE
         bkyNVPOEv9hzZCbPj2sfpxt83A6UVTtle6ifdQ8h7YVj+rdEKCrcijqLgfKspwd042KU
         UL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415833; x=1715020633;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TB1BoVLiOux/HPrW8MyruJIMsPdwJkw5+l58oyD5a3c=;
        b=qWD7o/hFoFoXbb48g3go/45UyBWOprNddrUfmzu5qRArwnTqiBxqvz2hN9TeuTWOmZ
         +pVstV6UKBlLYkqFPyemtSziplL4hhDwAba2unrnol6A5yiQLC2ObIKL8cYg/X491L9O
         LGupat1ZXnYihexLpV99WNd0bAzsnWChJD3SUL1UbqN+lvUUzzC6P7GN4zMDQM4IBTJw
         9F6DImYwugNOdC1YMaRZ8Zqc/U9RzFL504nYe9Xr90L1q/q2M496I7VADth/FUt5ANcl
         a13P5O2HSAVtmCGZlkB0OoExYeBd1yu3lX0em6Kv7mNmJPQbPD54El9P5U49oDln/AT3
         MV+w==
X-Gm-Message-State: AOJu0Yy2nCyrKlQb+FY0klYs6+j75PViDXQNupTeY1Myr8tdZ5lf4sju
	UuwmmP7LIj0+bhqUEVOhppA65dwoB3qmWfo6j+Sr/vwArqG7WL//L0WgBQ==
X-Google-Smtp-Source: AGHT+IGu/rXE/3QjHO3sx2HUj7VIABt4K3Ebp6u3f5c2R1WFftbi5sZmH6fYbC3/BTBX9weEzqUjWw==
X-Received: by 2002:adf:9791:0:b0:34a:e884:977b with SMTP id s17-20020adf9791000000b0034ae884977bmr6492035wrb.32.1714415833242;
        Mon, 29 Apr 2024 11:37:13 -0700 (PDT)
Received: from gmail.com (111.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.111])
        by smtp.gmail.com with ESMTPSA id cs18-20020a056000089200b003437799a373sm30347591wrb.83.2024.04.29.11.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 11:37:12 -0700 (PDT)
Message-ID: <95c0dfff-3b11-4156-a502-c741fc0b76f7@gmail.com>
Date: Mon, 29 Apr 2024 20:37:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/2] add-patch: response to unknown command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
Content-Language: en-US
In-Reply-To: <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the user gives an unknown command to the "add -p" prompt, the list
of accepted commands with their explanation is given.  This is the same
output they get when they say '?'.

However, the unknown command may be due to a user input error rather
than the user not knowing the valid command.

To reduce the likelihood of user confusion and error repetition, instead
of displaying the list of accepted commands, display a short error
message with the unknown command received, as feedback to the user.

Include a reminder about the current command '?' in the new message, to
guide the user if they want help.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                |  5 ++++-
 t/t3701-add-interactive.sh | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index fc0eed4fd4..2252895c28 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1667,7 +1667,7 @@ static int patch_update_file(struct add_p_state *s,
 			}
 		} else if (s->answer.buf[0] == 'p') {
 			rendered_hunk_index = -1;
-		} else {
+		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
 			color_fprintf(stdout, s->s.help_color, "%s",
@@ -1691,6 +1691,9 @@ static int patch_update_file(struct add_p_state *s,
 				color_fprintf_ln(stdout, s->s.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
+		} else {
+			err(s, _("Unknown command '%s' (use '?' for help)"),
+			    s->answer.buf);
 		}
 	}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c5531520cb..28a95a775d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -8,6 +8,8 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+SP=" "
+
 diff_cmp () {
 	for x
 	do
@@ -56,6 +58,19 @@ test_expect_success 'warn about add.interactive.useBuiltin' '
 	done
 '
 
+test_expect_success 'unknown command' '
+	test_when_finished "git reset --hard; rm -f command" &&
+	echo W >command &&
+	git add -N command &&
+	git diff command >expect &&
+	cat >>expect <<-EOF &&
+	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
+	EOF
+	git add -p -- command <command >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
@@ -232,7 +247,6 @@ test_expect_success 'setup file' '
 '
 
 test_expect_success 'setup patch' '
-	SP=" " &&
 	NULL="" &&
 	cat >patch <<-EOF
 	@@ -1,4 +1,4 @@
-- 
2.45.0.2.g84ce137e4a

Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4BDDA9
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713693115; cv=none; b=bh815/HFMq9pXtHR8kfwcY3SxNIaZjqmrKvmfScQfsnujYdtiuU3sLVnDXmDEHW7suCC4BYgBLWFoHp0KzWACQCZ8ZNofH77A61Fkj/JWwbtAF970nHE2A4jkA2TNxytusBZAQ29RM2+8nR2Ao0kUncm6VDKaBDBtxUI4jwb2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713693115; c=relaxed/simple;
	bh=U5tAuqQ8cP46PW3dM1CRH1siLR5jRW2W1oQ7OLC8EBM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oyr4essjN+HguQYSaDkqUL8yfmUhDfFKhC7i7sRPwETt+YwrPzZ6eUY32wPV3jglZGNC0Y4T8SvjV3XXyobma49G/EUerGD0xVaHejQJOGthgSppsKtak+FaShUFmobPzmi27iIX3XavK6x0JC6MTsIB06lMck0hAJDQqbGWBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awvbAUUy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awvbAUUy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a2a43c82aso2195655e9.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713693111; x=1714297911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umg5IsDXyeXYnp1gXq87u4uvjZkd/6d36JTWgco/V/M=;
        b=awvbAUUyDwIqNmEJ/krG8pfgyqtbqSELa5gkR2512Qjht69i0pX5uEmT4o6J0BkSHp
         4LTJeIq2+FCFYPAGzcZSAQmud89qo9jF+GxsxOWij96/t3sFiS78/WU/gV8x0C93Eqpk
         SDFeYqWe88c4pGuKqALgRtHueSjvoR1jkDJq2+RPiI/KCQlBdvdHLPzJsWIqicOPFWQa
         7m4wW0d21jaItERU/e535KVrtrUwUcze/HEnDsJ0P+R/scsyHNfc6jVsg06/813undEH
         KBYAySO75X6EEuvwTc1HWSPQkq5eFn4Svo0ZYg9fhrI4UmAVStLQuVBhj/WgzzccYqF8
         OSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713693111; x=1714297911;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umg5IsDXyeXYnp1gXq87u4uvjZkd/6d36JTWgco/V/M=;
        b=uPlsuXyhb2DGp4hQg1EJ1f6Fn5uyMReCmI+nlUKM5h0F//BuGZqCpDznkbOEd4c6Z+
         jbugKJCs4FpQD33zGMxGREUuAQVMZiF3BG8M7k0pAQk+YGO3GNDPTgHlK44JxOJeknJ7
         j3yFLXP6n3h2sButY+PSV9Qw5HWEYekviTWQgY8K2sJZJ4pE2yY9qFgxVlKuahd2suPV
         Yf4S1EWNaldbEr8qUjYAjRhVKsTngONhN6s2b0xfIH0tCTtgjoay0tbX8lC9W8R5Z7e5
         3TszmXSwLFy2DFpSqBuNczuFb8y9c6i8n+IEiMl0c1YHSub/rRDL+o3EU6fP9XEY1nJe
         vc8Q==
X-Gm-Message-State: AOJu0YzyZdr30qh/BiD1jc0z7qm3CIP3HHJg9tS31mJKNhX/Z+D1VULE
	EI6SOXw2NQSCsV041l/Bb6BKukd1SKDB221OqtIXNUOhId6g/Y8XZCRt0w==
X-Google-Smtp-Source: AGHT+IHHTsXidk61EUo+aWn+1IQHp+fF5A0B1Nk8lGvwdln6PIYOXKXJobPeO6OBA1gGtiJT16/Axg==
X-Received: by 2002:a05:600c:3549:b0:419:87ab:f6db with SMTP id i9-20020a05600c354900b0041987abf6dbmr4931423wmq.23.1713693111177;
        Sun, 21 Apr 2024 02:51:51 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0041a2a047827sm1727874wmq.6.2024.04.21.02.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 02:51:50 -0700 (PDT)
Message-ID: <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
Date: Sun, 21 Apr 2024 11:51:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] add-patch: response to unknown command
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
In-Reply-To: <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
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

Thanks.

Range-diff against v2:
1:  c94c838fad ! 1:  ddd8d380a7 add-patch: response to invalid command
    @@ Metadata
     Author: Rubén Justo <rjusto@gmail.com>
     
      ## Commit message ##
    -    add-patch: response to invalid command
    +    add-patch: response to unknown command
     
    -    When the user enters an invalid command, we respond with a list of
    -    accepted commands; the response we give to the command '?'.
    +    When the user gives an unknown command to the "add -p" prompt, the list
    +    of accepted commands with their explanation is given.  This is the same
    +    output they get when they say '?'.
     
    -    However, the invalid command may be due to either a user input error or
    -    a malfunctioning interface component, rather than the user not knowing
    -    the valid command.
    +    However, the unknown command may be due to a user input error rather
    +    than the user not knowing the valid command.
     
    -    Our response is unlikely to provide help in such situations.
    -
    -    To reduce the likelihood of user confusion and error repetition, if an
    -    unrecognized command is received, stop displaying the help text and
    -    display a short error message with the invalid command received, as
    -    feedback to the user.
    +    To reduce the likelihood of user confusion and error repetition, instead
    +    of displaying the list of accepted commands, display a short error
    +    message with the unknown command received, as feedback to the user.
     
         Include a reminder about the current command '?' in the new message, to
         guide the user if they want help.
    @@ t/t3701-add-interactive.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      diff_cmp () {
      	for x
      	do
    -@@ t/t3701-add-interactive.sh: test_expect_success 'setup (initial)' '
    - 	echo more >>file &&
    - 	echo lines >>file
    +@@ t/t3701-add-interactive.sh: test_expect_success 'warn about add.interactive.useBuiltin' '
    + 	done
      '
    -+
    + 
     +test_expect_success 'unknown command' '
    -+	test_when_finished "git reset command && rm command" &&
    ++	test_when_finished "git reset --hard; rm -f command" &&
     +	echo W >command &&
     +	git add -N command &&
     +	cat >expect <<-EOF &&
    @@ t/t3701-add-interactive.sh: test_expect_success 'setup (initial)' '
     +	test_cmp expect actual
     +'
     +
    - test_expect_success 'status works (initial)' '
    - 	git add -i </dev/null >output &&
    - 	grep "+1/-0 *+2/-0 file" output
    + test_expect_success 'setup (initial)' '
    + 	echo content >file &&
    + 	git add file &&
     @@ t/t3701-add-interactive.sh: test_expect_success 'setup file' '
      '
      

 add-patch.c                |  5 ++++-
 t/t3701-add-interactive.sh | 22 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index a06dd18985..7be142d448 100644
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
index bc55255b0a..d974bddcf2 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -7,6 +7,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+SP=" "
+
 diff_cmp () {
 	for x
 	do
@@ -55,6 +57,25 @@ test_expect_success 'warn about add.interactive.useBuiltin' '
 	done
 '
 
+test_expect_success 'unknown command' '
+	test_when_finished "git reset --hard; rm -f command" &&
+	echo W >command &&
+	git add -N command &&
+	cat >expect <<-EOF &&
+	diff --git a/command b/command
+	new file mode 100644
+	index 0000000..a42d8ff
+	--- /dev/null
+	+++ b/command
+	@@ -0,0 +1 @@
+	+W
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
@@ -231,7 +252,6 @@ test_expect_success 'setup file' '
 '
 
 test_expect_success 'setup patch' '
-	SP=" " &&
 	NULL="" &&
 	cat >patch <<-EOF
 	@@ -1,4 +1,4 @@
-- 
2.45.0.rc0.1.gddd8d380a7

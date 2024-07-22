Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A83770D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690665; cv=none; b=BET45tspKv23ebwYj9WpLnOfw+cV5BcPbERBclXz7Ay9kPoMTd60ffXBTUVhptEgwvbCbeHuTsTKgNjPPclnU2f0KBEF3hGZz1se+n7eq6nUiu33DDYPAdl6FBvtBx3/cN2G5KLpg9M5eF2Y1+eBgHhPvPaRsIXKXaLtXDgU+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690665; c=relaxed/simple;
	bh=h0jd7je2rVDPXCzkmS5gZd0WP75WR0aXdS9LlEBmEdE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lYAMzClYPQUaVShCc6n6K4dR8ouLhZXkW8TgeHJX+EcXzUwUu+duTfmNVrwB5Am8ng+qbiQU5rXaepxTcEp3kvTd44opso/+Om7owHRc2L/vhl6uiPx3FgSuZ3Yh9iaxj8SrPLUUsCZDVN6yWiBntyrfLslDM6bx8UCVFi3WnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D20uWdBM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D20uWdBM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso34926245e9.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721690662; x=1722295462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=06txJ3iw5TMQu7XSzh5HLypcYRbcR/3etZ5BHm29j34=;
        b=D20uWdBMPURx0mt89Z+iZSC0gncQPZMRkIjiKHns2ruKeYiumSP04PbZ/h7YD0vUuI
         IKOfKMj6vFX18fwrJMHcra3Pfnez86ayChZLK26dIGUy7z5Yhm+1+3IMEsKvsHmhiMxa
         +SeZ9weeJ9bexNFYnsQdhGAZagjeZLHi6IcpzBe6FnnJsLqAFKtareaL2aYVhKknaAVy
         y1uhzQrEF9CgxwymccFqhBgQzZzUk/vpogUJla7KomchQRlZdh4sbV6plAiNKfB68y1n
         6t94HUGpruilqn+DBsmUo9d/smHV8jXl7+G9rRK0FjO8Q500Wa0NNb6DcK/t2uji9xy5
         xM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721690662; x=1722295462;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06txJ3iw5TMQu7XSzh5HLypcYRbcR/3etZ5BHm29j34=;
        b=cdM2GhDIrAUz38HoJJOpRsLMtkXEQkof8+EaD9LmspnMD5Ukych6G6lus0F4GQb12P
         tCT/pA1iaF/JZDnFhGWnilMsfV8k/3CtsbGsw7j/qSK/OgDhNujJ9WBnOpUJfAycRuwl
         ndhvHS8hDJ1fglQPGk9e37P3ml8mz9fn7tRLFheNBSHWGq/RGvWCd7V4o0pglQ2lMbEK
         luZRC0MgLJ3FCtGxrLQHUSpIACbWziqyuYAEF7vDkRKPicR7buO0bXeDNUz/LpKFsW6R
         1t+VQ/eql9SjVaZcbAKSj2ImzdNhIwnGZUvatmORoLscPV55mes//3GSWqJ2/RamsL3w
         jc/w==
X-Forwarded-Encrypted: i=1; AJvYcCUPd9ZrUC8x5vZYYvIDkCRcSzCtPeoVpOZkSTGRog7w3Y/ejTUc7nYme2LWk8yTn7Zw0rannVBZWk+pdF22Mz5/fe8A
X-Gm-Message-State: AOJu0Yx4epxIS30h5ZWUV6zFad8CGk5ZB7Yem6a6kYolCOhn8jKfr3nT
	il3rtn6BwLGBGAs6r3lO8oLNrpZ5xua1GoF7bEcH1rezeJ1tC+5p
X-Google-Smtp-Source: AGHT+IEp2Ely1ApACwSxm49+DDFNkIeq4P+KxiQ9Hzo335OAi/WWvZ18bz2C3p509smtbXKDeK7jtw==
X-Received: by 2002:a05:600c:220f:b0:426:59ec:17a9 with SMTP id 5b1f17b1804b1-427dc55a20bmr61464555e9.22.1721690661499;
        Mon, 22 Jul 2024 16:24:21 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6901781sm145137875e9.14.2024.07.22.16.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 16:24:21 -0700 (PDT)
Message-ID: <5536b336-5122-47fd-be57-42c299abe60c@gmail.com>
Date: Tue, 23 Jul 2024 01:24:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] t3701: avoid one-shot export for shell functions
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com> <xmqqv80xcpe5.fsf@gitster.g>
 <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com> <xmqq7cdd9l0m.fsf@gitster.g>
 <43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com>
Content-Language: en-US
In-Reply-To: <43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The common construct:

    VAR=VAL command args

it's a common way to define one-shot variables within the scope of
executing a "command".

However, when "command" is a function which in turn executes the
"command", the behavior varies depending on the shell:

 ** Bash 5.2.21 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=1

 ** dash 0.5.12-9 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=1

 ** dash 0.5.10.2-6 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=

One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
tested did not get our custom GIT_PAGER, which broke the test.

Work it around by explicitly exporting the variable in a subshell.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c60589cb94..1b8617e0c1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -616,7 +616,11 @@ test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
 	test_when_finished "rm -f huge_file; git reset" &&
 	printf "\n%2500000s" Y >huge_file &&
 	git add -N huge_file &&
-	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
+	test_write_lines P q | (
+		GIT_PAGER="head -n 1" &&
+		export GIT_PAGER &&
+		test_terminal git add -p
+	)
 '
 
 test_expect_success 'split hunk "add -p (edit)"' '
-- 
2.45.1

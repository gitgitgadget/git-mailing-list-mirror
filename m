Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD3914A83
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273592; cv=none; b=fmkcIb84EZOehOv8SPixYdgaAjM656JASOJ0GAjfPgR4MisxZirDT7F8xBjoZ0JS44GvwimJwguqsnBadb2QQosTjgs1JQ//KW9gPrwf/9k9Xa85Z/0siJ1AYfKGdfp8rABMKcedxtYDJmHFOxyaNRVaenLk2gunpc3UzphCbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273592; c=relaxed/simple;
	bh=P97VhY7mgv+haIaL4099aEIm8ieuksACoN8NoGnorSQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TaLSjx6T1LfUaaf93VLGpMM8GwX0eNCDjZl2M0ul7B9KqzYSJVMAuXU/jtnl/qYRLQStB+03oFvB3QAQN0usYkiq8qGAPg6+Yc9TrqZd8EWzqPohyGQ51xPu3diLpa4/QpxptdVLVX3uSiBjZ0HndgxJ+OSh/0aevgRGirggKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KATe0ggX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KATe0ggX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso9365265e9.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 04:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273588; x=1706878388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKXj/xLI0k1peLlffj+79N3IMFOUS4YDMGT0CBhAv6o=;
        b=KATe0ggX/O1A8vitwUGsaQ4plZ9ZMKwwn5OqEgcKgd8j4hiY6IzBzJ5lMYa0BLxot1
         sXTt7I9epicF56pW2HEx+xmUWUwV8bM4jK2Sz04iaG55i/D3EVcqfh5AyHeXVYlszYAZ
         MJ0Js5cHA3UiAwMTBLRKgHG0mZZXWwRP815UTPnWGUCNlAEijQmYfsx+PQSgnRfajHWe
         Yp5A4SahGKfAuGy6EkwbxKn2huuh3uiOUsI8n1XAiXLrwxx+4YpH6CGf7t5Cdimn+M8+
         /rQWh+aSvM1EbDDZ00J2QgjuQ/vMhtiPUGnlbjHXf93BXcJbgEENCUas19ZThYPkHo5V
         AvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273588; x=1706878388;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKXj/xLI0k1peLlffj+79N3IMFOUS4YDMGT0CBhAv6o=;
        b=uksBCtqgmN/dHhailTkxLIcCsrjQWQKWJLyo+VgKaxT0bjAHtwGMscuVEL/OZqVogC
         +PrZ61QB1yzuUEFiVRpqcl59W4GQuFlUFWVXat4rcaHaMuvcBAOXI5WHt6d3HScehdfe
         uMyabIBbuK/Dsj30sB/Rxqt2crO39NUc4SvPP0/Vh1iP19aMEjOVmu8v6aHEvde8J8dd
         4Swwo4PWPUkar6MzJVN2lddinQFWmADpVAukiQtmso31tib7ErWzVEGEEixKMR0Jt+oE
         Zp2qLSqMoRZnAa+iaOHGsUnDImM2jCcV5VIrNon7/2sNfjykkud8GbM7jotTYnlQZxjc
         Q5uA==
X-Gm-Message-State: AOJu0YyKSB5Xtt6Z8y49Kzk+lDpymKR1kRdoM9CQjy7HYLKIfKrsYv7L
	woXfcBZnHULwZ34WIseZVJRpqnCTJ4tBvnmZUlg96UKmqvjlP83Y8ISrWidM
X-Google-Smtp-Source: AGHT+IEwFlY0SgGFL8PDa7CPSOLjplHHBmrF2v1HHvS9JaeTRHfd7PfKn1vJi3OoixZ5AlSBg7lWXQ==
X-Received: by 2002:a05:600c:5115:b0:40e:5f07:8179 with SMTP id o21-20020a05600c511500b0040e5f078179mr903601wms.55.1706273588011;
        Fri, 26 Jan 2024 04:53:08 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4806000000b003392ae3aee8sm1207551wrq.97.2024.01.26.04.53.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 04:53:07 -0800 (PST)
Message-ID: <5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com>
Date: Fri, 26 Jan 2024 13:53:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] completion: reflog with implicit "show"
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
In-Reply-To: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When no subcommand is specified to "reflog", we assume "show" [1]:

    $ git reflog -h
    usage: git reflog [show] [<log-options>] [<ref>]
    ...

We are not completing correctly this implicit uses of "show":

With ...

    $ git checkout -b default

... we are not completing "default":

    $ git reflog def<TAB><TAB>

And we are incorrectly returning the "subcommands" when:

    $ git reflog default <TAB><TAB>
    delete expire show

Let's use __gitcomp_subcommand to correctly handle implicit
subcommands.

  1. cf39f54efc (git reflog show, 2007-02-08)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash | 9 ++++-----
 t/t9902-completion.sh                  | 8 ++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5f2e904b56..c41f25aa80 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2448,13 +2448,12 @@ _git_rebase ()
 _git_reflog ()
 {
 	local subcommands="show delete expire"
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 
-	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
-	else
-		__git_complete_refs
+	if __gitcomp_subcommand "$subcommands"; then
+		return
 	fi
+
+	__git_complete_refs
 }
 
 __git_send_email_confirm_options="always never auto cc compose"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aa9a614de3..231e17f378 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2618,6 +2618,14 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
+test_expect_success 'git reflog show' '
+	test_when_finished "git checkout -" &&
+	git checkout -b shown &&
+	test_completion "git reflog sho" "show " &&
+	test_completion "git reflog show sho" "shown " &&
+	test_completion "git reflog shown sho" "shown "
+'
+
 test_expect_success 'options with value' '
 	test_completion "git merge -X diff-algorithm=" <<-\EOF
 
-- 
2.43.0


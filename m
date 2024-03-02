Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F806107A6
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709390263; cv=none; b=ntcGjPrFycQfVlmfeV0HeLn3tzmyCkvtH7FSyoc7DidLD0ASGurJ9drqU8tDv6hMbjji9+sDCkebkewBtwtg1+G0IhTOxY5m3YMIVcE3O77dEozkgGPlBa3zEOrBg/01VElaB4eBCMsCIigK4J13v1w7L+nVS8NFZTcVNVSh1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709390263; c=relaxed/simple;
	bh=R3/aojfXwKwvpbcHAQ6lVTpIeDegistZAX3HjLuNMRY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XA3qUm6gI58n3UxM1dtNZWOLT0FP29mvVD0RnpAfzKKz2uJM2tYZVA/VDR0fbVmygyGTxBdlHSNemHy3MYjUjaIA4ssfTD60vnQP3C5B7ZAa3Ss48kMYcCQuvMvgAVjdjPyzHNHuRFKeetGKlyV1UctAJNF92K+S4MtkmlpBKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH1nbrbQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH1nbrbQ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d24a727f78so34991181fa.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709390259; x=1709995059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8tMzxoQNRI8tKk3VpGlWSYH7DZZbWtTbAa4nyfvXsU=;
        b=SH1nbrbQ25qoH0JtIwylB++JFHs27fOde3lmbd8cRxblv6e33e2hr2B4bwpb+3vS7m
         fsrvSEzSW8ts+d/7MQcPVoh7fpUuTXiwQABkep3JYuff2SixiaA7qWgOVjdyyFMl9BEx
         1cHHboCPgnbEYkPSfGj2uQVdum6Gv+BPK51lXRTfzhVmXYQbec2SQCW7ApUs+u0YJ2qB
         cQFiCehyFIY5KbHFrOozuaGUVTYFBJumlTHeO/AwUchyEQhN9MRRMqP+n8Hc/+DpfEEq
         7m4O11forZpxM5NYRKtDWpfUxlrG3Np2lzUbMTBvPQ3SuKzHTtGFQzQbatT/ayz8kcEC
         iHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709390259; x=1709995059;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8tMzxoQNRI8tKk3VpGlWSYH7DZZbWtTbAa4nyfvXsU=;
        b=itTPhGv2LpW9KqP7px/g5ZQkW/C1r8/RSxvq/FHuE9f3uqt8kPOX0HQBvupa5ceI+9
         rcgyzgJX3AS3SIlLSu0vORtoYeA8oqp8LBi+aA0qZ0QFGoX8csBp8nzAAGXFMPEQ/DPi
         CU04BCMg57RnEpgE6D6Z4e5TC0JB2lcp7MxreKqHDiig8aPKiRcFJJgvUHOTxPWA+twS
         1iR0lAu2oTWQbfdWKjoL9oCM4KV0aSIJ7GsEWMmFxzTquvAOIaQly/U4JopXyGNyrMcW
         YtS8Rzta7HxSAZT3loi2476VZFPQHsuZNFUA710rdQgSScG/cJxbQo/Bp9zISbts6BBE
         B2TA==
X-Gm-Message-State: AOJu0YyWznIb9aupiZvKcBEbIyOaF/S7ZfvtoBnR+1ZceRBjyBuTc8Cx
	jSkUrmLwLv3/ilhZdQyIroPitrdupRkYuGWaoAH/gQKq91ydXlV2LXbo6Zwx
X-Google-Smtp-Source: AGHT+IH8wU2MrWwdhOPQk5WJkYl6jFiIk/Mcv9E5+XcjvUXxE2r/QIx3a5qBn1VIuvNMYBBgQczI5A==
X-Received: by 2002:a05:651c:10a1:b0:2d2:d6a0:6f3e with SMTP id k1-20020a05651c10a100b002d2d6a06f3emr3479750ljn.13.1709390259261;
        Sat, 02 Mar 2024 06:37:39 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id jz12-20020a05600c580c00b00411a6ce0f99sm8567187wmb.24.2024.03.02.06.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 06:37:38 -0800 (PST)
Message-ID: <ae0e2eaa-b7b9-4d95-8b73-c6be762341ef@gmail.com>
Date: Sat, 2 Mar 2024 15:37:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/5] completion: reflog with implicit "show"
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
In-Reply-To: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When no subcommand is specified to "reflog", we assume "show" [1]:

    $ git reflog -h
    usage: git reflog [show] [<log-options>] [<ref>]
    ...

This implicit "show" is not being completed correctly:

    $ git checkout -b default
    $ git reflog def<TAB><TAB>
    ... no completion options ...

The expected result is:

    $ git reflog default

This happens because we're completing references after seeing a valid
subcommand in the command line.  This prevents the implicit "show" from
working properly, but also introduces a new problem: it keeps offering
subcommand options when the subcommand is implicit:

    $ git checkout -b explore
    $ git reflog default ex<TAB>
    ...
    $ git reflog default expire

The expected result is:

    $ git reflog default explore

To fix this, complete references even if no subcommand is present, or in
other words when the subcommand is implicit "show".

Also, only include completion options for subcommands when completing
the right position in the command line.

  1. cf39f54efc (git reflog show, 2007-02-08)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash |  9 ++++-----
 t/t9902-completion.sh                  | 11 +++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8c40ade494..ff216f1c65 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2407,12 +2407,11 @@ _git_rebase ()
 _git_reflog ()
 {
 	local subcommands="show delete expire"
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 
-	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
-	else
-		__git_complete_refs
+	__git_complete_refs
+
+	if [ $((cword - __git_cmd_idx)) -eq 1 ]; then
+		__gitcompappend "$subcommands" "" "$cur" " "
 	fi
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aa9a614de3..dbd57e6a28 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2618,6 +2618,17 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
+test_expect_success 'git reflog show' '
+	test_when_finished "git checkout - && git branch -d shown" &&
+	git checkout -b shown &&
+	test_completion "git reflog sho" <<-\EOF &&
+	show Z
+	shown Z
+	EOF
+	test_completion "git reflog show sho" "shown " &&
+	test_completion "git reflog shown sho" "shown "
+'
+
 test_expect_success 'options with value' '
 	test_completion "git merge -X diff-algorithm=" <<-\EOF
 
-- 
2.44.0


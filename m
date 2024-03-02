Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5449365
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709389833; cv=none; b=JCq2EddJpkwG3EMyWBlGYE40nhUn9NAcsMHH4ZOp0BhoGpNj5NLbOx3dQJ+NnRSF/n3c+AaOF5LyOF/GAylaNHVVqLkLIR4ak2nLlUlix3waT+o1Alf3lUCFXCHmLYMBn+WBvDuYNbOfGal5CaGb9opcAxVgkBWUGA6UaP745rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709389833; c=relaxed/simple;
	bh=9fMfLC3EQhVpzb2VPTgrbCR+QGFOcyalKS6NShVG8mA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=uQP1EQVtblPRpq//dOhMvp3tTyHpwemBHjqlGeOPAhwNzzZHoli6y3VDR160ljR0nd2gE5vFz0xeZSqk09FA5omzYf8u0wIvg3KJaQNBJ7n32iSZfwTzoydq9j2661atjZAcWmy8q1X1ciOLCW3eWuQN5dyigfhdEaByhPpJK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqOdDGWW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqOdDGWW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412bb23e5c5so16596265e9.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709389830; x=1709994630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFFfW2g5QfIWTRUl2GAUOi5G9v8zvGLQu1PbHMwByNE=;
        b=OqOdDGWWtlgQOVhkaH4N3s4p4R74zrrC9uVsf+atPnJK/D4yNf/IIKX+l2KFiMpJV4
         S/lacr96lzmXnFXfPVTJ6biEKqSd1ddGe9UiRPcjwrIRxvKa03Xz78+/ND0VxNvAa6Yp
         MjYa58WhSqGnYAjAhd3HLBgaugyyxe2Sip8QapnmSjCDv9fICtdby0ojzFsNaLQme84u
         jmgemhrxLGuw+EuKCyUQp/hbNKD7EdKXJ2N6vD+Vuev5KXSUhdnBmYE0Db4fZhUUoyxA
         miDC2goE+0ns3pEyrrMsHkCTibl5S8g5eagozKxSYWOzQNYp9EIUeclVm9pFMnl/WxJO
         qXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709389830; x=1709994630;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFFfW2g5QfIWTRUl2GAUOi5G9v8zvGLQu1PbHMwByNE=;
        b=pBDCe1+a+xFch9G490dMa2zszOsBAeKrVEOUnXQlSewXxSKwBz65Qa9sYxgyIeL4BX
         CCvl0Ns9bBited/vNJUabn+34raSTVf2TVGI3c4/woUEI8aKiUs8WPGeKMTJNdXj9YO+
         mrTbd9MOxqrhhIBLn/t6QKNREfsd6UPdyRRLEP6OIiAYjfljb6FCpvrIZXk3iJwiCARq
         2nC/dVHm5vxzNEVP2W49nH0SZV7SUrguL21hdLhqvAAT1DPiRjz8C+EQCtcSMKLNUnJx
         K6nsAinaK2zwVInsGsl01ZF1sPxOWW+6QApik/dmrwpKBHwP/x2mL4DnwcW36o3Fan/m
         yZUQ==
X-Gm-Message-State: AOJu0Yza70t14vXisK+ojTn0GMVAr+lWzknqSZdGqHhRQAc9PyWV5Fer
	undeivTn/79CZCK+yZo3Mpp7tRq86b4udr+drXPgBINtm4DZmxah7S8XobxJ
X-Google-Smtp-Source: AGHT+IG80yC1WUCUEe+E5eTmYwl5k340Wvfwf4tUJxnq1dw+gRFNgyfBF/lhgrSVUd2XYqZ5OP3BUQ==
X-Received: by 2002:a05:600c:35d5:b0:412:bb8e:eb0 with SMTP id r21-20020a05600c35d500b00412bb8e0eb0mr4892553wmq.18.1709389829738;
        Sat, 02 Mar 2024 06:30:29 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id q13-20020a5d61cd000000b0033e11ff6284sm6824637wrv.12.2024.03.02.06.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 06:30:29 -0800 (PST)
Message-ID: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
Date: Sat, 2 Mar 2024 15:30:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/5] completion for git-reflog show
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This iteration has three main changes and two new commits since v2.

The changes:

 - The function __gitcomp_subcommand is no longer needed in this series.
   The patch that introduced it has been removed.
 
 - The description for the behaviour we're fixing in the patch 1/5 has
   been reworded to better explain the behaviour we're expecting.
 
 - Provide completion for both subcommands and references when the
   expectation is such that we're not sure if the implicit subcommand
   "show" is desired.

About the two new commits:

This series is described in the last "What's cooking" with:

 The command line completion script (in contrib/) learned to
 complete "git reflog" better.

So, while we're here I've included two new commits, 4/5 and 5/5, that
fit well in that description.

An important note is in the last patch, reporting the special case
needed for the <log-options> in the "show" subcommand.  This is what has
made me decide to include the new commits in this series.

Rubén Justo (5):
  completion: reflog with implicit "show"
  completion: introduce __git_find_subcommand
  completion: reflog show <log-options>
  completion: factor out __git_builtin
  completion: reflog subcommands and options

 contrib/completion/git-completion.bash | 70 ++++++++++++++++++++++----
 t/t9902-completion.sh                  | 14 ++++++
 2 files changed, 73 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  1a76491362 < -:  ---------- completion: introduce __gitcomp_subcommand
3:  8defb041ac ! 1:  61b9696238 completion: reflog with implicit "show"
    @@ Commit message
             usage: git reflog [show] [<log-options>] [<ref>]
             ...
     
    -    We are not completing correctly this implicit uses of "show":
    -
    -    With ...
    +    This implicit "show" is not being completed correctly:
     
             $ git checkout -b default
    +        $ git reflog def<TAB><TAB>
    +        ... no completion options ...
     
    -    ... we are not completing "default":
    +    The expected result is:
     
    -        $ git reflog def<TAB><TAB>
    +        $ git reflog default
    +
    +    This happens because we're completing references after seeing a valid
    +    subcommand in the command line.  This prevents the implicit "show" from
    +    working properly, but also introduces a new problem: it keeps offering
    +    subcommand options when the subcommand is implicit:
    +
    +        $ git checkout -b explore
    +        $ git reflog default ex<TAB>
    +        ...
    +        $ git reflog default expire
     
    -    And we are incorrectly returning the "subcommands" when:
    +    The expected result is:
     
    -        $ git reflog default <TAB><TAB>
    -        delete expire show
    +        $ git reflog default explore
     
    -    Let's use __gitcomp_subcommand to correctly handle implicit
    -    subcommands.
    +    To fix this, complete references even if no subcommand is present, or in
    +    other words when the subcommand is implicit "show".
    +
    +    Also, only include completion options for subcommands when completing
    +    the right position in the command line.
     
           1. cf39f54efc (git reflog show, 2007-02-08)
     
    @@ contrib/completion/git-completion.bash: _git_rebase ()
     -		__gitcomp "$subcommands"
     -	else
     -		__git_complete_refs
    -+	if __gitcomp_subcommand "$subcommands"; then
    -+		return
    - 	fi
    -+
     +	__git_complete_refs
    ++
    ++	if [ $((cword - __git_cmd_idx)) -eq 1 ]; then
    ++		__gitcompappend "$subcommands" "" "$cur" " "
    + 	fi
      }
      
    - __git_send_email_confirm_options="always never auto cc compose"
     
      ## t/t9902-completion.sh ##
     @@ t/t9902-completion.sh: test_expect_success 'git clone --config= - value' '
    @@ t/t9902-completion.sh: test_expect_success 'git clone --config= - value' '
      '
      
     +test_expect_success 'git reflog show' '
    -+	test_when_finished "git checkout -" &&
    ++	test_when_finished "git checkout - && git branch -d shown" &&
     +	git checkout -b shown &&
    -+	test_completion "git reflog sho" "show " &&
    ++	test_completion "git reflog sho" <<-\EOF &&
    ++	show Z
    ++	shown Z
    ++	EOF
     +	test_completion "git reflog show sho" "shown " &&
     +	test_completion "git reflog shown sho" "shown "
     +'
2:  b1aad9a667 ! 2:  b3133c69d3 completion: introduce __git_find_subcommand
    @@ Commit message
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
    -@@ contrib/completion/git-completion.bash: __gitcomp_subcommand ()
    - 	fi
    +@@ contrib/completion/git-completion.bash: __gitcomp_file ()
    + 	true
      }
      
     +# Find the current subcommand for commands that follow the syntax:
4:  4d3fb1d563 ! 3:  e6e526b436 completion: reflog show <log-options>
    @@ Commit message
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_rebase ()
    - 
      _git_reflog ()
      {
    --	local subcommands="show delete expire"
    -+	local subcommand subcommands="show delete expire"
    - 
    - 	if __gitcomp_subcommand "$subcommands"; then
    - 		return
    - 	fi
    - 
    -+	subcommand="$(__git_find_subcommand "$subcommands" "show")"
    + 	local subcommands="show delete expire"
    ++	local subcommand="$(__git_find_subcommand "$subcommands" "show")"
     +
     +	case "$subcommand,$cur" in
     +	show,--*)
    @@ contrib/completion/git-completion.bash: _git_rebase ()
     +		return
     +		;;
     +	esac
    -+
    + 
      	__git_complete_refs
    - }
      
     
      ## t/t9902-completion.sh ##
     @@ t/t9902-completion.sh: test_expect_success 'git reflog show' '
    - 	git checkout -b shown &&
    - 	test_completion "git reflog sho" "show " &&
    + 	shown Z
    + 	EOF
      	test_completion "git reflog show sho" "shown " &&
     -	test_completion "git reflog shown sho" "shown "
     +	test_completion "git reflog shown sho" "shown " &&
-:  ---------- > 4:  dfed95d495 completion: factor out __git_builtin
-:  ---------- > 5:  8193b7f4f9 completion: reflog subcommands and options
-- 
2.44.0

Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0C1EE7B7
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263846; cv=none; b=AtmCwv58Nut+PvKwUvfOoyJapPnGJk3Z2a/TOBKFZ0Qm8pYtxa5g7MIeWZ407TrWlzi+rwiVc926Yv75xL6eiLRzccjbbY7yo6qWas7Kxdte8Tt8TwBmqanXiijjEg59YLH2QnlT2Nkhu0m/lOAWor3OFa7wraTnP2w43HtdoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263846; c=relaxed/simple;
	bh=scw3f+MW/nn+D/R8xxceRmg7ks0NyD08XiXkHLQQVKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ymm6gtUGNBkPE4cLTIWD+mpUubWfRcItnrJt6tqTYqRsIonspqjgAe3SlloBE3bKG8Dt3gdfX/mBBUz7kVwUCRgjbSis+tEploYKH0fCWiQW5F+8mYZLEz7CW2o4bQsn1YlVHsYKU/FvjkX7j/Au46orm99XsEq8ZGvHhEzHytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+CNCGk3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+CNCGk3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso7744287a91.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263844; x=1739868644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnbHqRaT49qRQlMkRZBXJFZMcE9IOmmuwum3AmgemOk=;
        b=E+CNCGk3jTYfjnkVxXOgcnVN16BPlfMqYY/D+XMZkdx93foz3kExDyBB0twTcRMT8Z
         8EiW3DNu6ZBglCV2WtBOYadXCK11oI2iS4RIpd5M5CJkss0Gx21+6jfeD4SvOovMZLbV
         vUHPsuFfWu6wnGF+xlaSV2kT6fiah4rOIJKjZCG71I8rbN1z1syIepx1BsyQiRawsSlM
         ZoEezOAQhC1gtEHHROYoIEuaRSq+Hcn4evswbWLsm995n3g4dkl7MvE1dNAj7dTFGwBS
         p+clrJSQlHh6ccP9FmvjgXaiCCM4BN+VJwMK+6RmP99duAZkRBsT0qRsBWnBy5hhnr0b
         rt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263844; x=1739868644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnbHqRaT49qRQlMkRZBXJFZMcE9IOmmuwum3AmgemOk=;
        b=aZfvDPDHYgU2eh28CnKb/C9fWMt7/DWy/t33jV7y1LZiqo7CTF+BNQfNU5Qvj9LINR
         t87N0eDdSnbctfWTu1klAJ4TtZnXI2V4LkLidprOo94GYpEwGplTS6KIPZ4hAFssqnbO
         2q9FNv2HKwaXlsORX5FDoBMCLj1jpy5iku++BrRNVUwSUrHRQA2AbNFzca3ZD7gIk9Js
         FshRWdjWAv/ElO8ZF6qXELd908e9x6+KNDzEbIaESB71zaE1dg641e61E3jchhPBuME2
         U6sqgTRXvc+2jkmjTnC1bSFP+0dAH5XjD0nOrEU17N0tFqR0wJMm6st2x31YR9T5KQ8s
         fVyg==
X-Forwarded-Encrypted: i=1; AJvYcCWnsqGAXi8MFxaqE9o3dlJUcNiySObEZQt7K0dRAgM8608zrTNe51vqmypCZc9C3sOX5zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzALF98bn4bFClXXv35h91mpvpPXXz0/KSLhE1piChE87Hd1Yxe
	2kDXosVNe3XugJ1fFVl+epScM1joZX/JxtvJEF/x2W77y8zxvw1m
X-Gm-Gg: ASbGnctO/JgyBcc574kEMjJXLpHFKurwOa/Ua1icZKRbVDvTMwlGdxgg33OBYiOQUVE
	Ki375F5OxS1BvWKz2hg9fH1q5s0s+y6OVZUbySeaG+VYfBmr12PPtrdBmLwQbN52AMlfdyCiS0z
	+gxUY3q4/VXbQYig2KuB9b1tia3rpNXotM7a8izrCE3SSmLOW8p7tIyBT6P/3C9I3szuXVelG9X
	03ItNd8BMgVluEi/PoeG+DKTNB5J2brBIelD0zB0iccr7hbRw8xo4TwVnr31O5l61BMk48ZkIff
	iFk9F/07LOTU0LXruBK/1Az7HZSiOTecoKtx5zk=
X-Google-Smtp-Source: AGHT+IEGxbqPO8Myh3SgKMgim0tO0nc8BJJg5KWpYBGvlOUZCCtRGMpJr0beShXiXSWTTg94sGE+iQ==
X-Received: by 2002:a17:90b:3b44:b0:2ee:ead6:6213 with SMTP id 98e67ed59e1d1-2fa9eda537amr3529391a91.19.1739263843884;
        Tue, 11 Feb 2025 00:50:43 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:50:43 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 0/10] Long names for `git log -S` and `git log -G`
Date: Tue, 11 Feb 2025 00:50:12 -0800
Message-ID: <20250211085028.3923875-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've split the big change from v3 [1] into multiple, mostly independent patches
to make it easier to review and merge each one separately.

[1] https://lore.kernel.org/git/20250206014324.1839232-1-illia.bobyr@gmail.com/

Patches 1 through 4 are fixing minor bugs and inconsistencies.

Patch 5 contains updates gitdiffcore to use same placeholder names as the rest
of the code.

Patch 6 contains a minimum change to add long versions of -S and -G.

Patch 7 adds bash completion support.

Patches 8 through 10 increase usage of the long argument versions in tests, CLI
help and docs respectively.

Please, let me know if you prefer it split in a different way, or reorder the
changes.

---

I was not sure if I should include a reference to the previous version of the
patch into the next reroll.  It seems that
`Documentation/MyFirstContribution.adoc` suggests so.  But it creates very long
threads.  And I've noticed that not everyone is doing it.

---

Reply to review notes from Junio C Hamano:

On 2/6/25 12:59, Junio C Hamano wrote:
> Illia Bobyr <illia.bobyr@gmail.com> writes:
>
>> Most arguments have both short and long versions.  Long versions are
>> easier to read, especially in scripts and command history.
>>
>> Tests that check just the option parsing are duplicated to check both
>> short and long argument options.  But more complex tests are updated to
>> use the long argument in order to improve the test readability.
>
> While checking both may be a prudent thing to do, because the "-S"
> option and the "-G" option have been there with us almost since the
> beginning of time, the swapping all existing use of them with the
> longhand is rather unwelcome and needless churn, I would have to
> say.

My thinking is that as long version names improve readability, it also applies
to the test code.  When I see a short option I often have to check the manual to
remember what exactly does it do.  Even for "-S"/"-G" I find myself sometimes
confused as to which of the two does what exactly.  While the "grep" mnemonic
helps, I do not always remember it.

But, I think, I understand your point of view as well.

In v4 patch 5 contains a relatively minimum amount of changes that add long
alternatives for "-S" and "-G" just to the command line parsing.

I do not have your experience with assessing the churn, but if my argument about
the readability changes your mind, I've moved the rest of the updates into
separate patches, at the end of the chain.  Patches 8 through 10.  Making it
easier to discuss them in smaller chunks, if you wish so.  But also, I assume,
it should be easy for you to ignore those, if you do not want to include them?

> [...]
>> @@ -657,18 +658,19 @@ renamed entries cannot appear if detection for those types is disabled.
>>  It is useful when you're looking for an exact block of code (like a
>>  struct), and want to know the history of that block since it first
>>  came into being: use the feature iteratively to feed the interesting
>> -block in the preimage back into `-S`, and keep going until you get the
>> -very first version of the block.
>> +block in the preimage back into `--patch-modifies`, and keep going until
>> +you get the very first version of the block.
>
> If this paragraph _were_ written with the longhand from the
> beginning, I would not have minded too much, but I personally find
> it unnecessary to churn the existing document like this.
>
>>  `-G<regex>`::
>> +`--patch-grep=<regex>`::
>
> Same two paragraphs from the above apply here, and ...
>
>>  `--find-object=<object-id>`::
>>  `--pickaxe-all`::
>>  `--pickaxe-regex`::
>
> ... all of the above.
>
>> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
>
> Ditto.
>
>> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
>> index 642c5..e4b18 100644
>> --- a/Documentation/gitdiffcore.txt
>> +++ b/Documentation/gitdiffcore.txt
>> @@ -245,33 +245,35 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
>>  
>>  This transformation limits the set of filepairs to those that change
>>  specified strings between the preimage and the postimage in a certain
>> -way.  -S<block-of-text> and -G<regular-expression> options are used to
>> +way.  --patch-modifies=<block-of-text> and
>> +--patch-grep=<regular-expression> options are used to specify
>> +different ways these strings are sought.
>
> This is worse.  Here is the first part that describes the pickaxe,
> so mentioning both may be more appropriate; showing only the
> longhand nobody is familiar with (yet) does not make any sense.
>
>     ... certain way.  `--patch-modifies=<block-of-text>`
>     (`-S<block-of-text>` for short) and `--patch-grep=<regular-expression>`
>     (`-G<regular-expression>` for short) are used to ...
>
> Once establishing the equivalence between the longhand and the
> shorthand for these two options, we do not have to churn the
> existing text at all.

Applied your suggestion.

I guess one difference in the way you look at it, is that you default to the
short version when you can.  While I default to the long one, as I assume it is
easier to understand.  Someone not that intimately familiar with git might need
to go to the previous paragraph to recall what "-S" and "-G" are, while if they
are spelled as "--patch-modifies" and "--patch-grep", it might be less
necessary.  So, the argument is that while we are reducing the diff, we might
also be reducing the improvement in readability.

Being the author, I could also be biased when assessing how much more readable
"--patch-modifies" and "--patch-grep" are compared to "-S" and "-G".

>> diff --git a/diff.c b/diff.c
>> index d28b41..09beb 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4877,15 +4877,17 @@ void diff_setup_done(struct diff_options *options)
>>  
>>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
>>  		die(_("options '%s', '%s', and '%s' cannot be used together"),
>> -			"-G", "-S", "--find-object");
>> +			"-G/--patch-grep", "-S/--patch-modifies", "--find-object");
>>  
>>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
>>  		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s'"),
>> -			"-G", "--pickaxe-regex", "--pickaxe-regex", "-S");
>> +			"-G/--patch-grep", "--pickaxe-regex",
>> +                        "--pickaxe-regex", "-S/--patch-modifies");
>>  
>>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
>>  		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
>> -			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
>> +			"--pickaxe-all", "--find-object",
>> +                        "--pickaxe-all", "-G/--patch-grep", "-S/--patch-modifies");
>
> The message change looks fine; the indentation is broken.
>
> .git/rebase-apply/patch:184: indent with spaces.
>                         "--pickaxe-regex", "-S/--patch-modifies");
> .git/rebase-apply/patch:190: indent with spaces.
>                         "--pickaxe-all", "-G/--patch-grep", "-S/--patch-modifies");
> warning: 2 lines applied after fixing whitespace errors.
> Applying: diff: --patch-{modifies,grep} arg names for -S and -G
>
> These alone do not require a new iteration, as "git am --whitespace=fix"
> already corrected them.

Sorry about this.  I did check the indentation manually, but did not use a
tool.  Reconfigured my editor to use tabs now.

>> -		OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
>> +		OPT_CALLBACK_F('S', "patch-modifies", options, N_("<string>"),
>> -		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
>> +		OPT_CALLBACK_F('G', "patch-grep", options, N_("<regex>"),
>
> OK.  NOte that this says <regex>.  We may want to have a separate clean-up
> patch so that Documentation/gitdifcore.txt that used <regular-expression>
> and the placeholder used here match.

Makes sense.
I've added this fix as patch 5.
I've reformatted paragraphs in gitdifcore.adoc that were affected.
Let me know if you do not want me to reformat it, and just keep shorter lines as
is.

>> -			       N_("look for differences that change the number of occurrences of the specified regex"),
>> +			       N_("look for differences where a patch contains the specified regex"),
>
> This is an unrelated change that should not be in this patch.  If
> you want to modify it, please do it in a separate clean-up patch,
> just like the above <regex> vs <regular-expression> change.

Split it into patch 2.

>> -			  N_("show all changes in the changeset with -S or -G"),
>> +			  N_("show all changes in the changeset with -S/--patch-modifies or -G/--patch-grep"),
>
> This line is meant to be shown when the user requests list of
> options and their meanings.  Growing the message from 47 columns or
> so to 78 columns would make it wider than terminals when these
> messages are indented.  Because earlier entries in this array have
> already established the equivalence between the shorthand and the
> longhand, I do not think the output is understandable without this
> change.

A description for "-S" is already 81 characters long:

N_("look for differences that change the number of occurrences of the specified regex"),

So I was assuming if I grow another description to 77 characters it is still OK.
While one can find the correspondence between "-S" and "--patch-modifies" by
reading the "-S" description, in my mind, the same argument applies as to the
test readability - it just makes it a bit easier for the reader.

This change is now part of a much smaller patch 9, which is only about adding
longer alternatives to the CLI help messages that currently contain only "-G"
and "-S".  This way you can decide if you want it or not as a complete unit.  Or
if you want me to change it in some way, we can discuss it separately from the
rest of the changes.

By the way, I must admit I can not find a way to look at a help message
generated from these strings.  Running `git diff -h` shows a message from
`diff.h` and running `git diff --help` shows the man page.

---

Illia Bobyr (10):
  t/t4209-log-pickaxe: Naming typo: -G takes a regex
  diff: -G description: Correct copy/paste error
  diff: short help: Correct -S description
  diff: short help: Add -G and --pickaxe-grep
  docs: gitdiffcore: -G and -S: Use regex/string placeholders
  diff: --patch-{grep,modifies} arg names for -G and -S
  completion: Support --patch-{grep,modifies}
  diff: test: Use --patch-{grep,modifies} over -G/-S
  diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
  diff: docs: Use --patch-{grep,modifies} over -G/-S

 Documentation/diff-options.adoc        |  36 +++++----
 Documentation/git-blame.adoc           |   2 +-
 Documentation/gitdiffcore.adoc         |  55 ++++++-------
 contrib/completion/git-completion.bash |  11 ++-
 diff.c                                 |  18 +++--
 diff.h                                 |  11 ++-
 t/t4062-diff-pickaxe.sh                |   8 +-
 t/t4209-log-pickaxe.sh                 | 106 +++++++++++++++++--------
 8 files changed, 155 insertions(+), 92 deletions(-)

-- 
2.45.2


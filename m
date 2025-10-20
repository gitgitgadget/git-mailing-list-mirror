Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329131353A
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981271; cv=none; b=PhlrtaMqtNEV/+DRfEaY9Jmrm66lFn72sxM/w7JmdMByfxzuC0CjysOSy0mqW4WObPkAwUIQmnuyLpte5K/mfN2OGIn/9HRDjFpb3LZDUMSiW5u+vsqPOtrsvTMm7nZQr25vqnD14ZJiM/tCuaoc2fDVEEmzVq2dZ7ioxF4wWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981271; c=relaxed/simple;
	bh=gbI0qWGnn6tx4xpcSRjUBLaCP0M+rOpwSyQWE0ab2go=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Zc1dlkuf2sHVJCNNn4DcHr82ly0iGXCuupAxvIPrx4CcE34Y32BTJixlytdFbEYliFkEZGCj0rtWXYvuCazF0csBqUq2aueqPIkWCnQ/RM+tHyMoAaJBwpdhNMNstWw9uCSQg/FtIm1NjGY1otymYVC4UldDoQGRuzNBeFrEvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt622qcd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt622qcd"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33292adb180so4628423a91.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760981270; x=1761586070; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCHrONc6ToT112Wi8TnWVf2JBRfvwNtB1gNHKdT+avo=;
        b=Pt622qcdxCWuAyjl/6B4PizpCJ9PN7eaG/ohmod9puHV99kzKJafPu77lBV9mA4Esj
         7e6LuUUcrZfV0whd48DWPEqMU+AZtfgEruOpU6Cfz+oAfpX7BeldX2z8RXydHOGrrqzf
         4/kj6BUa4rRzlMbZ3fThQ7rjdzqcDsBw8OcEEnMRDex/b1ooK4vV4A/cpBQwqQKElLa9
         1cIMybSH1YxYbpK6WwiII5+kFCmOlgbegOvomvs5I/7HqSIjr+s0hghco3kE2clmHESp
         fxvuQT3oXASUHDUz6ikcJ9BKFG6xjuH0oENYlg2QTjPgMVHOvU3s+Vre/nUQT2T5w+Ed
         ZI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760981270; x=1761586070;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCHrONc6ToT112Wi8TnWVf2JBRfvwNtB1gNHKdT+avo=;
        b=m/Sxj4g1Ah4jIyUFE4Gn3zb5YhEwcGBD7++zboEXQE+wv1h9/PJZs4B7U/y96cy629
         0l5eOujJtuw/rxuTb4kVla5KvbBaL4jukFolBjP/aceA8OdMD2be/WzaSc+luzxPa6DX
         LSR4NDTRg901sMMjTO/+wFBfKWN6t+Ntz1Qh3c41VrRXF0OR/j4LpIk5infDpaAWJkEy
         qPsigoIDEWqUY3OJKuJE0/LR/m060XEU14uYVrSZAJ3KYPrXCHIyF1ShnrLbck4H9sMU
         3VZFCHsXauh6TBOBOgl7uSZFWUCCf5wKXyn9IK5MDaBBQ1gEJfaM+A6eTjZsxDRHGl/B
         j/dw==
X-Forwarded-Encrypted: i=1; AJvYcCU8jcyGofdKfnCDvvKVZYEOUgufrlWb9eutCqHyC3stwsQx8dRzzEvMUZpyPYTMTOohhbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipS04jmeRNO3fT6j74rtxi/v/d37hIbyLLHeOsSVL92JVxGor
	wus341yUpYXHt3P1kGRc0dcJgKNyKma3cgYDAkGwtpHKWw95vqStBuBU
X-Gm-Gg: ASbGncuhOxfg8WA43+F1ZHxCPF8EKEj8gu1GvOtl6JdTueglrBhbuhLumLYv4SYVt8v
	ws6eHp99cYCnGqHEkCmMbKRsqiQnOz+gEN1tYB0tp2cRpR37IimfJPHqWZR+DlLrlYMkUudSPm1
	nObE6F7FXvZY67D9/6sW+seSGrt91BjZQ9smQ5cpVpzEzVaMQlUSFO1sz3FwIH4gbEAhOVtEC6h
	/+HF4Q/BgmOe+oG9Y27WUQETQPVATotlfe/hkcFqhkDhFZUi6wm9VWhwxhzpYLYDD2IfHU2oIZH
	wTK+huT6GflDLu8N29XSxBPZtWL1HjH38mhroQpVOK3m2/HfNrYhbBcwZuBYTjBRuE1Tbj6cogF
	G5HGPn5IZzR8dMc/Oeli3vCx1K1lj4ND10PLsZ3tz8cS5j4IIHfi359hZJo4jQkZ3zZ0ULOQ19Z
	5GbE5tuxWUoB/5wMNpdzAFe9+grJMMfid35OMvJEM1mr6E
X-Google-Smtp-Source: AGHT+IHPj4asygZHGP2mA2+4tnWJIDX9KqggoyrGanx6hVyGQuSeioLTfTRX/p3qtAXQislXiNjsIw==
X-Received: by 2002:a17:90b:3848:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-33bcf84e18emr18549640a91.7.1760981269417;
        Mon, 20 Oct 2025 10:27:49 -0700 (PDT)
Received: from smtpclient.apple ([2404:7a80:b880:e400:44db:b75d:8ba8:a580])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5d00c909sm8463266a91.0.2025.10.20.10.27.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2025 10:27:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] completion: complete some 'git log' options
From: =?utf-8?B?5riF55Sw6YOB5byl?= <aimluck.kiyota@gmail.com>
In-Reply-To: <xmqqecqy3mf6.fsf@gitster.g>
Date: Tue, 21 Oct 2025 02:27:35 +0900
Cc: KIYOTA Fumiya via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Revi Ewer <revi.ewer@example.com>,
 Ill Takalook <ill.takalook@example.net>,
 KIYOTA Fumiya <kiyota-f@asahi.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF20FE9C-7AB1-42CE-9863-95CFEF43BF9C@gmail.com>
References: <pull.2073.git.git.1760878666840.gitgitgadget@gmail.com>
 <xmqqecqy3mf6.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.600.62)



> 2025/10/20 1:07=E3=80=81Junio C Hamano =
<gitster@pobox.com>=E3=81=AE=E3=83=A1=E3=83=BC=E3=83=AB:
>=20
> "KIYOTA Fumiya via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: KIYOTA Fumiya <aimluck.kiyota@gmail.com>
>>=20
>> 1. '--exclude=3D' option to 'git log' and 'git shortlog' are missing. =
Add the
>> option to __git_log_shortlog_options.
>=20
> Nice.
>=20
>> 2. The `--committer` option in `git log` requires a pattern, such as
>> `--committer=3Dba`, but in `git shortlog`, specifying a pattern =
results in
>> an error: =E2=80=9Cerror: option `committer' takes no value.=E2=80=9D =
Therefore, I=E2=80=99ll
>> handle them as separate options for completion rather than a shared =
one.
>=20
> "Therefore, I'll h" -> "H" then the result matches the previous one
> to describe the solution as if you are giving an order to somebody
> sitting at the keyboard and making the changes for you, which is the
> style this project uses.
Thanks, I'll update the commit message.

> Very good observation to notice the latter issue.  Has it been
> raised as a bug that shortlog uses --committer in a way inconsistent
> with the rest of the log family of commands?  Perhaps people often
> do not limit shortlog by committers like they limit by authors, but
> "group by committer" that is squatting on an option that users would
> expect to be used for "limit to a given committer" does sound like a
> small UI glitch to me.
>=20
> Will queue.  Thanks.
I=E2=80=99m not sure whether this is a known issue, but for now, I think =
it=E2=80=99s best to align with the current implementation (i.e., as in =
this patch) and add completion for 'git shortlog =E2=80=94exclude=3D' =
later when the bug is fixed.

>=20
>=20
>> Signed-off-by: KIYOTA Fumiya <aimluck.kiyota@gmail.com>
>> ---
>>    completion: complete some 'git log' options
>>=20
>>     1. '--exclude=3D' option to 'git log' and 'git shortlog' are =
missing. Add
>>        the option to __git_log_shortlog_options.
>>=20
>>     2. The --committer option in git log requires a pattern, such as
>>        --committer=3Dba, but in git shortlog, specifying a pattern =
results in
>>        an error: =E2=80=9Cerror: option `committer' takes no =
value.=E2=80=9D Therefore,
>>        I=E2=80=99ll handle them as separate options for completion =
rather than a
>>        shared one.
>>=20
>> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-2073%2FFKbelm%2Flo=
gCompletion-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-2073/FKbelm/logCompletion-v1
>> Pull-Request: https://github.com/git/git/pull/2073
>>=20
>> contrib/completion/git-completion.bash | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
>> index e3d88b0672..73abea31b4 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2218,7 +2218,7 @@ __git_log_gitk_options=3D"
>> "
>> # Options that go well for log and shortlog (not gitk)
>> __git_log_shortlog_options=3D"
>> - --author=3D --committer=3D --grep=3D
>> + --author=3D --grep=3D --exclude=3D
>> --all-match --invert-grep
>> "
>> # Options accepted by log and show
>> @@ -2296,6 +2296,7 @@ __git_complete_log_opts ()
>> $__git_log_shortlog_options
>> $__git_log_gitk_options
>> $__git_log_show_options
>> + --committer=3D
>> --root --topo-order --date-order --reverse
>> --follow --full-diff
>> --abbrev-commit --no-abbrev-commit --abbrev=3D
>> @@ -3229,7 +3230,7 @@ _git_shortlog ()
>> __gitcomp "
>> $__git_log_common_options
>> $__git_log_shortlog_options
>> - --numbered --summary --email
>> + --committer --numbered --summary --email
>> "
>> return
>> ;;
>>=20
>> base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
>=20


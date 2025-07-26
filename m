Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD5145348
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540669; cv=none; b=hPyEnseSVhLDjzzqavholHTSFF/TGR3iW6giPqMjl1b2npbE7tKZKnjb54+tV0tOmxbOVMOCfJCWmx0kG0fFB87PTavDAwfUtYz6JyI44yv0tp5VLeIIV6XqqSgx6qWyH5JGhOX7l/KrLjhClfd0uSsQvceeIRozk1BrvWNFSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540669; c=relaxed/simple;
	bh=FvWLZv9gRcB7FWMAx2rDOSIGFGavGlTy5DW038J3IGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmXC4mIdUL9tE/Q8PT8IXgyW+DBWlw0bEn1c+PuHh/2N892FXC0DhS76G5djW0XAX4ty0FXU9qmyDIoY+JTJCVezePYPqLMsucE4zTm2c3qgIrR2gjwaT8bp+zphEIEfX3G6tzeEeTnjO1YhnxIakEpSWdAX8SzfjyjOoKIO1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEQvJIf9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEQvJIf9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so628556266b.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753540666; x=1754145466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWd02SU3sKYFP7Y1xzljaLtGvCFl6MPPMXAv4BnI7mI=;
        b=nEQvJIf9ENXc1p8IdF9oefgnS+y0EgmPMGO2qq1TRB9l8a9i94r9a97sUX5QoHOjiI
         Tern0p3+o5ye9EEktE6Wjcn25uauNpycYII/WDrFwqvkkLhWw3wYyNTE+F99492PSJsM
         WYbxu8pHPX/ZZ/4H4Y2YiMcb4R5LppZDPXPnTg/9xQeVM/Fbmfk85/knePb2zweEvS1s
         /t0/tFIaXiwQuPcbRizb6ZQ5yGRiyv9usZGHRMWeAwRYBIg8UxdopZrv1YGsRgI5by7/
         Jllx+fT6aHa7LTXWW+XBRywUTcmPc1KkZDVdQ5n2BDyGtWIvp3d+ZSdF4zj1XWeKgmDZ
         S2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753540666; x=1754145466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWd02SU3sKYFP7Y1xzljaLtGvCFl6MPPMXAv4BnI7mI=;
        b=BhwCV4WzmtSiv3p4BkuHHCqORaKYHg0xwf0ip+zyjnVQwxiznjW+c03RC2PVpzf4ZS
         3tgOd3n7dP+04qZI3JZArCFceXg0mzgRqDwYC2iL6uYXCUgS4IVjrhK1wEta/mqE5hjf
         4OIfObwYq+zuySh4VhejxwbWWNUQF7DOxY3iA7OGpO58VuujxYGFN1P7zpHCfGhuY1tA
         QzrvaRoS9L0TasN87BP4WLWkI/ymkmneWFl2oruVLAUyu+Sx0oWY0NjrwqCJS1mGxJJL
         vWblZgRhjs5pWpcF5rPdoSKbck5vP1ZR7hirPxoc3SUMzzRB1ZQ86r0wQNo3LFs9TQta
         CFEg==
X-Gm-Message-State: AOJu0YydSkI7+Ez02FH8PHkLCJPthuid96LvFgnk1OCEyrX4fZRYkG8N
	SV0F9zP2kp27hod17lKXzsX581lkekS1qMNPg1vdIeC0WUTftACm8GLFCX53KYYEa6PWJc7jw6Y
	PJe/3AaCcSLBrWIpOHO8ZeAz95tdYZUM=
X-Gm-Gg: ASbGnctb7tFuTHqX4enl3R//Tbr6IucNr9hsL6Ts4wpdna2C6ycUYHJsSNh7CD3EmSH
	QjzmN+7POZzfPDqW7YittOplI52d16JQ2jywVdaM2vnKWC7HVZgRzGSNhewsOFaIR3urppRBDcF
	ZERGn4RPZd3FFwCQc4MZ0KZ2Mw4eghxDL1YaG0MdTiGI+8XWqW8RG6iQTqaG3g1fd7yrH4mXbsy
	//O405LuNC2jdR0FAso+rPauHk56CXNocyRu9j7JTuO6ys0wzJ+
X-Google-Smtp-Source: AGHT+IE4cWTfwbB2SgUuSjAJszjE9HicJk97oc8rYDbpkyRdc6IPpu27C4dUJEd+XGlOS5paK1q6Hkd4V0aurHnCDUU=
X-Received: by 2002:a17:907:728e:b0:ae6:abe9:4daa with SMTP id
 a640c23a62f3a-af61cd9e837mr680741166b.27.1753540665247; Sat, 26 Jul 2025
 07:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com>
In-Reply-To: <20250721115519.140361-2-usmanakinyemi202@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 10:37:33 -0400
X-Gm-Features: Ac12FXyUCkwx35jZaFrRUDUWUOsv24UfMfSvaWzSY_9Z42x1fJUtIKhUdP3UDnI
Message-ID: <CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:55=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> Replace manual `-h` tests with a loop over all subcommands using
> `git --list-cmds=3Dmain`. This ensures consistent coverage of `-h`
> behavior outside a repo and future-proofs the test by covering
> new commands automatically.
>
> Known exceptions are skipped or marked as expected failures.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t1517-outside-repo.sh | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 6824581317..9fcebb7d94 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -110,8 +110,29 @@ test_expect_success LIBCURL 'remote-http outside rep=
ository' '
>  test_expect_success 'update-server-info does not crash with -h' '
>         test_expect_code 129 git update-server-info -h >usage &&
>         test_grep "[Uu]sage: git update-server-info " usage &&
> -       test_expect_code 129 nongit git update-server-info -h >usage &&
> -       test_grep "[Uu]sage: git update-server-info " usage
>  '
>
> +for cmd in $(git --list-cmds=3Dmain)
> +do
> +       cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> +       case "$cmd" in
> +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
> +       difftool--helper | filter-branch | fsck-objects | get-tar-commit-=
id | \
> +       http-backend | http-fetch | http-push | init-db | instaweb.sh | \
> +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
> +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-=
ftps | \
> +       remote-http | remote-https | replay | request-pull | send-email |=
 \
> +       sh-i18n--envsubst | shell | show | stage | submodule | svn | \
> +       upload-archive--writer | upload-pack | web--browse | whatchanged)

Sorry, one more thing: I spot-checked a few of these, and it seems the
main issue that causes failures is the exit code; they seem to work
with "-h" outside a repo. Out of scope for this series, but something
worth tidying up as #leftoverbits ?

> +               expect_outcome=3Dexpect_failure ;;
> +       *)
> +               expect_outcome=3Dexpect_success ;;
> +       esac
> +       test_$expect_outcome "'git $cmd -h' outside a repository" '
> +               test_expect_code 129 nongit git $cmd -h >usage &&
> +               echo "Hello" &&
> +               test_grep "[Uu]sage: git $cmd " usage
> +       '
> +done
> +
>  test_done
> --
> 2.50.0
>
>


--=20
D. Ben Knoble

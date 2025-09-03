Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7922F4A18
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942814; cv=none; b=Tj6Qoj7U9CgBm4MY/sBzqaNtHixD7OMo2a3kPKHFTnyQoKF8IYde97lgGs/bNKK8RLuMQmynRD0jVw7vHcnTV1SYME3pX0bo6nScksN/IPQ5bkVS48uCYJP9yj8EtBXFs5LBmGTvlnucn0RbF2XLHkTRs6gobzWTUSio91k9b9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942814; c=relaxed/simple;
	bh=p1/hBjpAR870W4eff8NabcSyCuy2eOGxBEYvDEEq7UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDPrAWO5VaeyzwNtPxRSmAQMrxXrk9rUrXmLg15aR2QgiUK1kmYpKWfRdgt4Kn5L0JkWDuWuaL+ILIEILVqe0dFpc5nVgZ+C2/FjuSLI1ygBxRnW4vsa52aoIp+/BIY62bUOZdr+iijqOe9z2wzIz9ERoxrgO7roG6h++Tsq4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYFoxV2V; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYFoxV2V"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso474335a12.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756942810; x=1757547610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=961PtKntESlcAD5b2n7GAg+scvOt8J/X9QXLRlCvt6c=;
        b=HYFoxV2Vm+lFjOPiwzmKa5DErmyclKX0zB0bu+HZdBgYRkFDZwT2GimrRRuq9rXvBr
         aI+ZH0AZ1bkdCLCh5ecMrLgEPKgx7IRo2/fQ06QcSOwp7ttnhbmjoSvr4zTcb8xFOYSA
         zL4hgZD+L7945F9i7Ojfz2EOIyJ72dE6SF9Lt2KZAQvb437y1BWJx1q32XyKKhLpUohk
         Qsw07EelDSqhCd88vtBW1+cgT0wuXnavrJIseWVME0LGpyxwhNqn+URUfZM0UDI+Vp/B
         Y0mlu8RZfntYOwIYugiC+V0yda4VVwfNeUwJdAJt65xyRkRIC9Pj9aQAkYDnF2EKxU+B
         XFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942810; x=1757547610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=961PtKntESlcAD5b2n7GAg+scvOt8J/X9QXLRlCvt6c=;
        b=XrERgpF0cEp2mPbKxswin6nJ+Kx8fyTXcQObzjfnP5yqudXHtG2rq1hLMzudUuAZVL
         JNQsh9djSJXibFCQ2PsoyObiL6Y4pgnYLNomBIdvNBCxfXthcSQ2v5Tytk/6OQNH5jp/
         gP+xH1pFVpYzRVsjnQNMD4IG7cjIJuozg06Nk6WAusLYVJm606oV1s7cSpWoILS0u9WB
         v4kQDSl4HcIiWHVRRSuc8MJ3hVKAjGbRfZIY0TSbJl/o031vQk0sPZZv73iPkxPlZ0Ml
         WD0sRjZa/td6+Q08xdN2DCxcChdJ1BinPkrxeVWkhHpSAOvWUNcHSr6/0PKGUFFJoWwR
         3dnw==
X-Gm-Message-State: AOJu0YyXBwPEwLadkSxT8OIbk+CxwYVPSu4lN7EcX/kysKXTRJ1UCXlE
	ZDFyp2StCmYQWUO0GeIyUUE7rItqwSrrpCCNlBBafxdimkddqoivINE19PPFaqwzjuvVNJvH9QM
	PfEuvg3eAcKtpjJyy7lAyUQ0hmAUTm7s=
X-Gm-Gg: ASbGncuyl83EufE62kyfx+BxXREd/tfT61voNT4Ic+Nju2LvKDLfGod/gNYNtDAP292
	6vNhPAgWaBvTs27cVtGacPQ96l6wTW9fvHpRAf9w4j4mtLq4CTaCDbqvP4sxVTTIzzKJmFc4yQ/
	IG/z8oPiUE4oYjqz2YrAueWjF8C+xROxv8R/jVqk81dSRZ00LaRl03SSKcSayzIGSzhDyNviCfv
	A/zXrfPMIQKzDkrFdoPkBofmmlqa2wr2M8SoGucMQY/cM8VNSs=
X-Google-Smtp-Source: AGHT+IF3bLoiMOdNIPc5aSPOhBo3o0FrCii/j4BhERY8UCuOpDzY2b4UlMizGOl4TNrsKjEM2qyZyMwhlkjzAGLYMtk=
X-Received: by 2002:a17:907:72ce:b0:b04:61aa:6adc with SMTP id
 a640c23a62f3a-b0461aa6b6fmr546860266b.7.1756942809883; Wed, 03 Sep 2025
 16:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 3 Sep 2025 19:39:58 -0400
X-Gm-Features: Ac12FXz1sVcKUN_XJIEL6e4HH-0L2apzHDctPL8qi2MR6L3pH3Crt9x_7xR9zsI
Message-ID: <CALnO6CC5K81QRxJR3jvqyL+fO6Yec_Ee83EOeeiUEzF6oBV3UA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/16] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 1:42=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Changes in v2:
>   - Add a new "reword" subcommand.
>   - List git-history(1) in "command-list.txt".
>   - Add some missing error handling.
>   - Simplify calling convention of `apply_commits()` to handle root
>     commits internally instead of requiring every caller to do so.
>   - Add tests to verify that git-history(1) refuses to work with changes
>     in the worktree or index.
>   - Mark git-history(1) as experimental.
>   - Introduce commands to manage interrupted history edits.
>   - A bunch of improvements to the manpage.
>   - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-history-builtin=
-v1-0-9b77c32688fe@pks.im

Having test-driven this a bit, I wanted to mention a feature from my
editor that I use frequently and that "reword" reminded me of [*]. I
wonder if this would be a good fit for git-history, but certainly
wouldn't be _necessary_ for a v1.

With fugitive.vim [1], I can get a list of {staged,unstaged} changes
and commits. It looks something like this

Head: ps-jj
Rebase: origin/master
Push: benknoble/ps-jj
Help: g?

Unstaged (1)
M README.md

Unpushed to origin/master (16)
5c65c405e6 builtin/history: implement "reword" subcommand
b215e38d49 builtin/history: implement "split" subcommand
93977ef8d2 wt-status: provide function to expose status for trees
b09b4b9d48 add-patch: add support for in-memory index patching
[=E2=80=A6]

If I stage changes, then the following mappings are available when the
cursor is on any commit line:

cF                      Create a `fixup!` commit for the commit under the
                        cursor and immediately rebase it.

cS                      Create a `squash!` commit for the commit under the
                        cursor and immediately rebase it.

What they do is populate my command line with something like

:Git commit --fixup=3D<commit>|Git -c sequence.editor=3Dtrue rebase
--interactive --autosquash <commit>^

(The pipe is Vim's command separator, a bit like ";" or "&&" in shell.)

If git-history had a squash or fixup mode, I imagine it would function
similarly (and could be used as the backend for fugitive's cF/cS with
new enough Git).

[*] The reason I thought of this from "reword" is the obvious tie-in
to interactive rebase commands. Fugitive does have "cw" to reword the
last commit, "ca" to amend, and "cW" to "amend!" an arbitrary commit,
but no mappings that "amend!" + rebase immediately. It doesn't need
them because "rw" starts an interactive rebase with the commit under
cursor set to "reword" ;) likewise "rd" for drop.

[1]: https://github.com/tpope/vim-fugitive

--=20
D. Ben Knoble

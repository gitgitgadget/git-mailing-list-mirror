Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9D385D7D
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716530; cv=none; b=l/gQNi/vHqwOJ8oaP9tyTxt+0kjAZJwlXa8SQYtRHMjOohNFogBXmKx2awoZH6q5/SNYa96Tel9Te6HMYv5i2H0q3X6ddiJ2Mpe1uDO5mEMNmUIHTjtbNN69H+wcdqcR2jhp/exOiIi9dhKFQBJZfrhODFZa6k6Edhk4CcsIkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716530; c=relaxed/simple;
	bh=hInvd4/DPYr+7tCI/yaAA+uLfmRJFjtWwVbHKOhbc/c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=lkW5c5UjvJYUEENat/mIhUqWMEYyvZ7OPV+ecOWovC5zhwyCp+X6WsT6JNrM3VAG0whMfYEO9WdZ52X2KvC7sCOq3iKnJhzG1VjhBRgHxGjKOb9xSxOjQyt1QodtliUq4GoNIHBn9vccVwdREjzscTmXAT1jqopX7MgFaWgOBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGOaFJ8V; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGOaFJ8V"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efcef23d21so121030276d6.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784716528; x=1785321328; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHFqeAagPKmVmZQ7PMFmWsTP2DKt/1HbojxLqZPb35g=;
        b=hGOaFJ8V8LTRlz8PMoM4l7kCeCsxbNOD2tggKvSmidCdXxN6w85RrbJTQBmlkSiwk2
         f+weCD3oFr+XUo9S8aY4d4hG6RMCPc9hGd8RgevzASm7PdftDPrgbbcLgDFc6y9luT4g
         Yh2ZPCsUxmi3qcKWbVHcVGLPXGw/xBYY31+GMC1J9f+C/eu1mx3wqcGihS8TEFW6bVZD
         yxThLDulg29OW9dRTTh4hntolRYmjijiWBn/hGtg3AJap1QWwwM+1SmwJigZoMHELG7w
         XqTYXqSAOTvodXlssn8N4PKeNvVMaSrJkN642kwbz3T15oyoKDDd1bG0fC1x5HfQ9POF
         REhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784716528; x=1785321328;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHFqeAagPKmVmZQ7PMFmWsTP2DKt/1HbojxLqZPb35g=;
        b=SefiTX5OJePbRT/OOy8+TKQ1KKKC2ZyOIjEu3xwjrnPDZpwySEeVx1tyiUUwQhHl+i
         pe0D71ybma8R/sCS0RIarjw3qtrb9CeMAjpTHxhowcW2BwPVTpHPIy6tXYhfFvB4OqVk
         vy8pGEvDAUhW+b1o+MIe+aEh9rPd3f2PBX/jPtmc0FP8QvTqLHSot+kBOeSJpNXdKybh
         GGNG5xsE5aZ7/eMI0Pf1+FpCpAUFSp/dsDe1mEA3YFif0TCvoKGVKYJZPe2bGc9VKjXe
         Mbn3iQYhphZ/2WiHQtqeh+C46PC4xbgQzM4kG88RGg6X2ei7Z6vcAw1DycVgytevEvhn
         3xGw==
X-Gm-Message-State: AOJu0YzoF7rhcTg2pgENiBfnh4YMqK+s9rRBOMM5ZRFrvyIYQ+tv7ox2
	At7pEsKASvOL2chmH840WBOc7yt4zqEA3+LGB7wAvq1LJlYD9ZxgIsbA
X-Gm-Gg: AR+sD13vJNvhz9gRnk5H5orCQNsu6PGCpu8WOahoZBwAh2ETmXXUM2M9v9QmqQXftft
	0awrEPHOGGYIQ4zMhs1pLDLKbBxlKlhAZPX88LNtGOFrqD213MV6vYXKEayjAUhE5LlTEcrQv/u
	LTS1fPH6XfTj9tItepEi0P/P1+hkR786CadEbNxdhTtiyRZQoeVBl0BtY2CJvq4hblbGQ9FJwCL
	lNBtW9AyafJDjxq4Llrw0GhCbuhAN1uWZ+RinQmOrYZ7JPrRJR6BSvwsm+qn+HwJqDrfs+8SAob
	sGCDyF0LgqGyUY0aAUfd00CB37o4VXbxM2m9BbccspjFmpUkwvW/9zzhZATwVTq9kV1vw0NuVzg
	ifMiZjb0fZ6htSxrbgBD4oSuyKAe/k7hgev16wn/sFEX06uRzXTL0cQZEYvAwQb+Ttp7SdEUIU+
	XBCwhBke0UCYhwhSbxYnxquiLiTuk2ioMEQLiD6u2NCbwFRdIFZKQ0ZEkUzKgpyP+R36Tu9biiK
	QZM94YdzFRY0ZxDrSZq20mdhqeHKNySygadJcoBlYodtTbEXsaaeVqsf15qvI8tnw==
X-Received: by 2002:a05:6214:5912:b0:8e9:f62b:bee9 with SMTP id 6a1803df08f44-9077856c696mr249587366d6.57.1784716527482;
        Wed, 22 Jul 2026 03:35:27 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b089:8e47:e4dd:73f0:fa4:cadd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba9e1ad3sm17986466d6.29.2026.07.22.03.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:35:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/2] remote: url-based pushRemote with renamed remotes
Date: Wed, 22 Jul 2026 06:35:16 -0400
Message-Id: <3FE12592-B663-438C-B33E-A251AE08E146@gmail.com>
References: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 21 juil. 2026 =C3=A0 16:14, Harald Nordgren via GitGitGadget <gitgitgad=
get@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFix git status not showing the push branch after remotes are rena=
med, when
> branch.<name>.pushRemote is a URL matching exactly one configured remote.
>=20
> Changes in v4:
>=20
> * Match against the actual push URL, including pushurl and pushInsteadOf.
> * Clarify how rearranging remotes exposes the git status tracking problem.=

> * Simplify and correct the documentation for URL-valued pushRemote.
>=20
> Changes in v3:
>=20
> * Revamp commit messages to clarify motivation.
>=20
> Changes in v2:
>=20
> * Clarify that URL push destinations already work and that this change onl=
y
>   restores their tracking information.
> * Document URL values for branch.<name>.pushRemote and their @{push}
>   behavior.
>=20
> Harald Nordgren (2):
>  remote: pass repository to push tracking helper
>  remote: find tracking branches for URL push destinations
>=20
> Documentation/config/branch.adoc |   1 +
> Documentation/revisions.adoc     |   3 +
> remote.c                         |  43 +++++++++--
> remote.h                         |   2 +
> t/t5505-remote.sh                | 124 +++++++++++++++++++++++++++++++
> transport.c                      |   5 +-
> 6 files changed, 172 insertions(+), 6 deletions(-)
>=20
>=20
> base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2358=
%2FHaraldNordgren%2Fremote-resolve-url-push-tracking-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2358/Ha=
raldNordgren/remote-resolve-url-push-tracking-v3
> Pull-Request: https://github.com/git/git/pull/2358
>=20
> Range-diff vs v2:
>=20
> 1:  b1ac49de87 =3D 1:  b1ac49de87 remote: pass repository to push tracking=
 helper
> 2:  6e924a7fec ! 2:  a343af9d50 remote: find tracking branches for URL pus=
h destinations
>     @@ Metadata
>       ## Commit message ##
>          remote: find tracking branches for URL push destinations
>=20
>     -    Git already accepts a repository URL as branch.<name>.pushRemote a=
nd
>     -    can push to it. When a configured remote has the same URL, howeve=
r,
>     -    "git status" cannot show that remote's push branch.
>     +    Git accepts a repository URL as branch.<name>.pushRemote and can p=
ush
>     +    to it. This branch setting takes precedence over remote.pushDefau=
lt.
>=20
>     -    This can happen in fork workflows when the original remote is ren=
amed
>     -    to "upstream", the fork is added as "origin", and an existing
>     -    pushRemote value still contains the fork URL. The URL still point=
s to
>     -    the right repository, so pushing works. However, @{push} is unava=
ilable
>     -    because Git does not connect the URL to "origin". As a result,
>     +    A branch can be configured with a URL-valued pushRemote before an=
y push
>     +    occurs. If the remotes are later rearranged with "git remote rena=
me" and
>     +    "git remote add", the newly added remote may use that URL. The UR=
L value
>     +    is unaffected by the rename and continues to take precedence over=

>     +    remote.pushDefault. The URL and the remote then point to the same=

>     +    repository, but Git does not connect them for tracking. Pushing w=
orks,
>     +    but @{push} cannot identify the remote's tracking branch. As a re=
sult,
>          "git status" cannot show the push branch, and an up-to-date push c=
an
>     -    leave its local tracking information stale.
>     +    leave its tracking information stale.
>=20
>     -    When exactly one configured remote has the URL as one of its
>     -    remote.<name>.url values, use its fetch refspec to find and refre=
sh the
>     -    push branch. Keep the URL as the push destination so the configur=
ed
>     -    remote's push settings do not change existing behavior. Keep the
>     -    current behavior when no remote matches or multiple remotes match=
.
>     +    When exactly one configured remote uses the push destination URL,=
 use
>     +    that remote for push tracking. Continue to push to the URL so the=

>     +    configured remote's push settings do not change existing behavior=
. Keep
>     +    the current behavior when no remote matches or multiple remotes m=
atch.
>=20
>          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

I find this explanation makes more sense ; it=E2=80=99s not how I use remote=
 renames, since I don=E2=80=99t usually use URL-valued remotes, but I can se=
e how things arise now. Thanks!=

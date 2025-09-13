Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F401DE4EF
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791856; cv=none; b=UQGgtGqqtwuJWpjLotiTbUZnefkgmxrNHFuAVrHZBeuSLKEms+o6a5GonmyY+dP3C8KKbJ+SoItgW4LjhXWOzUo6gqDR/a6KtMC8AHJ4Kne4Vn67daGyEX1r5K4f4qxhhScfzACpB20WNDXnYaCmhWQ8fvtUQfZaPeBAkXzCsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791856; c=relaxed/simple;
	bh=VjHpHCA0My2pdK3JKGwED+tberNw2lbTqDNEtv536eY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Vou0Rzs9RzM4abmzA8PLgy6RbiAfwx69BwaWVdLEBBWhWe0qHCoPrewxXBhQoKJLdXnA+kZHq7zO+TDyKmHBaYFgcaeaz/TS/N0hCW7MdFpvj7H/HW/hFxZZO71O1sEnewAb4YkPRwZmUNedlsZvWVbpmHVmLwMGDZ/IMZebkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyLHes6U; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyLHes6U"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so1748212276.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757791854; x=1758396654; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXBiAwlZYCdHv/jPNbhtVITUo8k8aU9ULfFWGB0WHwQ=;
        b=gyLHes6Ufb3x+BSFNu9O/LKmpqjmhUIBGWmaxg0oBnN7Z5hL5hC7yNIkoCzlseSbIv
         H1BCYxjPut6ca/52xZFbwnnha/+8IJLc/r8zmMF/tynUq/CjyRzTL+tFqwX1VSqGUjMg
         NggdW+2Xmi2LpI4mONy6fyFP/yCXRYcAhp9vmD/02gPc7q7t3TAf1ABC8O5VvrFo6L3g
         xE0hSfQ+wjMuP/0yuvYyXv0K2ZnyX3xOGkBnBLd9wZdGCP3cMediqKoV48PtfqnVTO7N
         3jEzvfxg6FFRXpJhR/GtgTrfX2fI/rw2x4AlmE7244xrSczAuHwmhDgUIdk9qkwiZRBR
         k2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757791854; x=1758396654;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXBiAwlZYCdHv/jPNbhtVITUo8k8aU9ULfFWGB0WHwQ=;
        b=Om3eE2BsZriFnjVgEu+X/PG/ckvQm5ao4+OjnpsAfdjsXLoJKO9ZUzPFXVVf3ABOhD
         /DNJs+QMc8irwUumiFg5Jdr+STAhbNwlm7P6sY3Nz3HUy4kIQ8meaAwe5+TF5YB6QB4K
         T7IAFdSpMnQEe6L4ySRlJ4jeMx+Qfshxgxb48ts29CE3ZevFM8mU2KxvfvXT4gIkFp6z
         S3+ZCPP71Azl9ZXlcxe50VFJJFfiCXzH48GsuJbZX37Lb4x9NdYd1rJhz+0iwRJE7oNB
         3aFl3d+FFob/Fz8HPf22N0OyyMMgLPmA+EojRQkE73jxJiZdoHjudunCqosP2rEbtU+3
         VcyQ==
X-Gm-Message-State: AOJu0YwGLli+G1DJOOA1QioF22X7OCVqQt8Sb8XFOoQfkVtr2iRseINL
	JvPxuIWnUiraawCwz0OFKQcNAH0DS42u0HayT+gd3Iejmv3B2JNcefQpTOckU15s
X-Gm-Gg: ASbGncv2WT9NW/uVvIMJLL2oPXWY/MgbcYBd0LnsL+3754WCiki6V6s6R4xa+hQIsTo
	VLQ796hIjroRCbutRDwRC4FSvu4pfGIcoQMy6yB/zNYbQIGdU51czkBxnwIWB36kBJRzwCMFArD
	kGSC/GZT1iV0OljeGlLoaHcu38N2NhDUpgOzvHIBGmuahNKUwx3Pg0zATy46BFHE2rB+eZdrot7
	izLgJ643FaUB/cOge4ZzCar+aGkCm9o1OM1HWdmIeTME3ZT2jHd85ImOKPfzd4wfNwBxbwfY8rj
	MTWas2wANLIJlYtLuvcnKQL+/ud2Ipu81BIJFowsYIlSn34plh8c4rH7xXghDiUx0NKc82ZHTA2
	qO7DzPgqq68zuT8gFH03mq/0ZVIAdDwhi6QN3C2pQM3e1CPdvYvxMmm+3qj+K2dpNd63r+hkL+h
	nW6thdHZvBVl/feorzUnyVRUaBTw==
X-Google-Smtp-Source: AGHT+IFm8howVjWcdXL2NOsJJEm5aVA1jDejo8h7awoKqZlpds6wH2ZnGmNYfT9j340NymcqAjOVvA==
X-Received: by 2002:a05:6902:3389:b0:e98:a303:d1c with SMTP id 3f1490d57ef6-ea3d9c378damr6533417276.32.1757791853562;
        Sat, 13 Sep 2025 12:30:53 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3fab87806sm500102276.3.2025.09.13.12.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 12:30:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] extend --ignore-other-worktrees to 'rebase', add hints
Date: Sat, 13 Sep 2025 15:30:42 -0400
Message-Id: <F7295141-49F5-4013-911A-7730C130F8CC@gmail.com>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
In-Reply-To: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
To: Gabriel Scherer <gabriel.scherer@inria.fr>
X-Mailer: iPhone Mail (21F90)


> Le 13 sept. 2025 =C3=A0 10:13, Gabriel Scherer <gabriel.scherer@inria.fr> a=
 =C3=A9crit :
>=20
> =EF=BB=BFThe old 'workdir' contribution script was removed from git upstre=
am in May
> 2025, as it is largely superseded by the 'worktree' command.
>=20
> One significant difference between the old script and the command is that
> 'git' refuses to checkout or rebase branches that are already checked out i=
n
> another worktree. My understanding of the reasoning is that users may be
> surprised when a clean worktree becomes dirty as its index is changed from=

> another worktree. However, this safety net adds a mental burden to worktre=
e
> users, as they have to keep the other worktrees in mind when moving
> branches. Old goats like me who are used to the old 'workdir' script find
> this restriction somewhat painful.
>=20
> See the discussion thread
>  https://lore.kernel.org/git/5580aa89-09f1-426e-8483-c99481c998ab@gmail.co=
m/
> about this transition.
>=20
> The present patch series tries to provide a smoother migration path for
> supporters of worktree independence:
>=20
> - when 'checkout' refuses because the branch is used in another worktree,
>   display a 'hint' that mentions the possibility of using '--detach'
>   instead, and the '--ignore-other-worktrees' option to proceed anyway.
>=20
> - add support for '--ignore-other-worktrees' in 'rebase' as well, with
>   a similar hint.
>=20
> In the future I would be interested in adding an option
> 'branch.ignoreOtherWorktrees' to be able to ignore other worktrees globall=
y.
>=20
> Note: this is my first experience submitting a patch to the Git project, s=
o
> I apologize in advance for any mishap and welcome beginner-level feedback.=


I=E2=80=99m eager to see further reviews, but nothing I saw in this series s=
tuck out as a major problem. I saw we updated the rebase test cases; should w=
e add some more for checkout or worktree?=

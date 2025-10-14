Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C511C4A17
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432240; cv=none; b=POyIIuGkZpQP63or9cNLf/QWXVvdV//uHiOq9oF3Qon1fmr+R7r5ymQsSAkBiBu5WSxW/m1xZClFtIecjfbums1FRewd1X5bo18KneiIxreK+kLcyVRydhrC9k3XlI5WPurUtO73qRmGE5aOddpWq0aLF6iPuBKZYmJBb5r5oMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432240; c=relaxed/simple;
	bh=7RBiO11eJ8pvxt9QZY6uBhtC9i6XBsjYPvCFgDhWk68=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/iB6wNzkskcB3ybJObCd2rHpcV2DjgsBsmiNzjTQTcXWCOKmm0N9pJFxlYmtLO18f7DadRdbqqixiMrLOPfJ+0LR4K4hMdkbhD8Ht2IWS6I3aCE22NpCnMF3mHDypTESZCWYT0CnLWkGlO3TOP6OGBHiddY7xV1LT8kWYqzTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuR7reo5; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuR7reo5"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5523142df73so3439001e0c.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432238; x=1761037038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=otrUnpRf6hWvZYtT6ETSfCv3cGzX8fiaM+CGjusWGQo=;
        b=GuR7reo56N0H77fsG4sZbqF9e+uz13XVOLIo6D3zX40BCeafjyyoy6le1EMYyZZquD
         RoGoIll0V5tmi8LSMcNEvuptEmmgTaguPyFRRJfUevb2h8GEKave6Vyp6fkuhMiFkVR7
         Nj6bn6XR8Iyw9yB/ugBzW9mGGQzg+2HJxebHfTMNnVld4vZLdm2Gmmqqrz+nunl/3A9e
         OknVTdhjp1PpNlQbLC6gxNnHC2VHbhRHZeJYbrGHBs8/PRfRrsZON3aR5LqRy3eULC06
         aZ5LZdj6ean1kIjvLyz2Ia5MInyyeNyglIjQOG/0iu3LATRKrrqDrsmYL9iUgiqovers
         z9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432238; x=1761037038;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otrUnpRf6hWvZYtT6ETSfCv3cGzX8fiaM+CGjusWGQo=;
        b=MdvQtgen6Tn49Ol/fMGllYWWfDPq59EAcIKlaVxSnmqt9u+Z2yzy6URug5FW86wEQ4
         JNsQ6uIsQn0++tDm2Zeo9WbQjN3FGkg2XqMDYOAM7qfVN7JI+VAr5ciqXtbr622T8OA1
         5+Irk52F8g5e+7W4NtFC/A1cdZ8uh1D8wLLycfik3Nzti8MC0BnxDwti4GwYkcv3NGqp
         ijJ6fDL6cqH/tJ27g22D7Wvazfhevr9IoMsa5nArTtlTOoY+SGDm/psatBk6eZlkYfxV
         GfIMJZJQcABhnWWuevQIzemyfh9WQbiG6jypVxy/SC4tR/8B0jgKGHCrNxQEbTOP29ps
         KcGA==
X-Forwarded-Encrypted: i=1; AJvYcCVRrAzLXsZHieAJjJnPMRDAOi0DR/tG34Kcj92hEC0IhwvVNqGfKrI2GLswg+mOv6DCYzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLGbqF24O6ouaLSbX8q1MCCXScMu2jJHJ3G+sUrwjSvV2DOfL
	1NxfiiK0r8gI57UtEzWTNDb2AieKvz2BNZJmH3WboOGZinGXWSMI8GSz5dRZ3o6Y0b/+8PudDAj
	COF1jIfCTX38WIzyUvJTg/k/9HHqLN5GE+mYw
X-Gm-Gg: ASbGncvH2lJVfih6al/wMu+Vc7Np3QdAJCBvWfVH6058j4/9qvYhqdAavf4lk3XWLHe
	L1HXaWGNstn8W9zncM6dISUzsfIMV1M2CqAAhWMLTVwWOe2YDTXHIs4DXwYrZSoahEvKAqUeMGC
	fqMpZVW6Ez7Z7BdD+v4pDMOF+ln8yPsjBhoBEJPPhct/zjZ/kDo6DNFqcwkGtSl6HR/QmBcY2vA
	RvKq0dTh+vE+WQBYo6Gqeu65fPU73KTqR7XsXTc6yCEn20fEtKHPh0XVNna
X-Google-Smtp-Source: AGHT+IG8BdG845gJLL3HsYGV7GZwXawcvAMs8sjdHxxZbuwIX9pNE3KWxWOEeH8eEQcmvJEXzagq5/pG57Tp7jtMh2U=
X-Received: by 2002:a05:6122:da0:b0:54b:bc2a:f58d with SMTP id
 71dfb90a1353d-554b8aaa08emr8141488e0c.3.1760432237901; Tue, 14 Oct 2025
 01:57:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 04:57:15 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 04:57:15 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-4-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-4-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 04:57:15 -0400
X-Gm-Features: AS18NWAvIu6ZBvLMLrEuROnfB1qweIZActy6-O34VsFz5LP6Xtt9lvC3x5K2JK0
Message-ID: <CAOLa=ZTU7JvqiDqDK0gHbR1KshZ8A_rZgguNZykcHp2i--GQAw@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] replay: parse commits before dereferencing them
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000031208e06411a92f9"

--00000000000031208e06411a92f9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When looking up a commit it may not be parsed yet. Callers that wish to
> access the fields of `struct commit` have to call `repo_parse_commit()`
> first so that it is guaranteed to be populated.
>
> We didn't yet care about doing so, because code paths that lead to
> `pick_regular_commit()` in "builtin/replay.c" already implicitly parsed
> the commits. But now that the function is exposed to outside callers
> it's quite easy to get this wrong.
>

So I was wondering, wouldn't this duplicate the call made to
`pick_regular_commit()` and end up parsing the commit twice. But seems
like down the stack in `repo_parse_commit_internal()`, we check for
`item->object.parsed` and only parse if it hasn't been already parsed.
So this change is welcome.

> Make the function easier to use by calling `repo_parse_commit()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  replay.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/replay.c b/replay.c
> index 13d75d8054..c3628d2488 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -90,6 +90,9 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
>  	struct commit *base, *replayed_base;
>  	struct tree *pickme_tree, *base_tree;
>
> +	if (repo_parse_commit(repo, pickme))
> +		return NULL;
> +
>  	base = pickme->parents->item;
>  	replayed_base = mapped_commit(replayed_commits, base, onto);
>
>
> --
> 2.51.0.700.g236ee7b076.dirty

--00000000000031208e06411a92f9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9eacfa59c43afa94_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdUVHa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mempzQy8wV3hrZk9CeTVJb2YwbWpldmVaUGd6VFRWMgpyQWhmVnNRWkh6
NmVJb3R4U3loNFI1eDF0QXFHYk5BcnVXQ2VQVjNoczBrZFUwVXlNQkdQUEtJU0IwWDlNT2F4CnlE
OEl3d1hwQ3c5dlJ4WWh3YnR6SGxPRzc5eFRUNVZ0Qi9zbitNOSttbW1FQlBMWFlIVytGM1N3RDJE
dzl2aUUKNHBZenU3ZHNMeUtEalFGOTlHWjJXSyttbjZMVWp6N0VDTG84Qzk0ZHdUQ1pJL0xmSjdS
MXRxN0pyL0pCVjdoWgpCMG9XVi91Z3dDdE40azhHTkZQZ21qcUhxN1JVLzVIaUlLRkwzUzRDYVEv
ZDZvbUphQ3ZFdDRmd2NYOVhJQ1k4CmdnV0ZHaS9GblVDRzNCb3NlQlhXODJsMWF2WnIwTlFBemE4
VnpJYmNUZXhXa2RKRVFaclM0MEJLMTVzSG13SHgKNVVEVFhuUjkxR2RTQXlNZ1lXOHNhOHV0bDVT
amFlYUh6TDI4RkxkMVcxeEFkRjR4dGhVMm1yQ21udVlIelVFbwpNS2lEcXpRY3pLeWtQUFIzTlVa
aHB5cVFia3BKNjI5dW5DV3NrT3F6QXFwMk8vbVJMYlNjbXF3OUxFUFhvSGhvCm1SYlVxTmxucHl5
aHVTQU5TblBNWmhJVDFNS0tHcEIvMWZGZ1BrWT0KPWZPU0gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000031208e06411a92f9--

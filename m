Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F57535B6
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383139; cv=none; b=rldhHubNBr1NYrm2ArNSUGXst0pXpsXglWO3P8THqTYc6EzNsn3pUcF5cZp8mggN+teVX/fG34gERsom70ziFytjujQKN0LO/udfCrE3xNicdMnyjOeXjheSqlnwrCJyf8elKmL4TZIil7+S3fd6zVMcS9RNzDpmAyaJadceN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383139; c=relaxed/simple;
	bh=7QVtkmjjoi3VQlq/36HPCpEtpZ10CPzm1A/KQdQiRGc=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=peWNjhLVB2hI/rWEd77EhSMI/wuRnJ/QjROCi1QFsAgRPD4kf5yu9+XHGxaPE4nPJF6neGEWPXjbJ5HrdoX/S6wsRcZgU/F13Fafezc9PZhDcBxtL7+dOpc9XgXkGhp6bMMs5LYlz41stesLZfxsMZo8yW3hdmzevnApQpZ3rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHkM7sWU; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHkM7sWU"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a52c5c96feso544621eaf.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711383137; x=1711987937; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=As2VhwHUVRvWjgICzD0V+vG+bPhsdoOihJmMhoBPKPQ=;
        b=eHkM7sWU5b6ncF8MNBH4IhP4I+Bx3dfHyM5fjOnQ9T5VZm74wJ1MyttqQE2RWXgnrK
         egHxYqMfUUwwlQPzmIErEBUUPT2hntnmN9e2LAgeSbz7nXjHpghs8LHc4pYYtK751GSL
         I1egxz+qMQIvXjd+7NAp6HSaaOy6fd3RCHDgoHI4uMf9Iu+ZNVbpi41xLEizxkR9ZYEo
         EODVQm8DcJgwMolIS+EAQo8JHpDrm2mp5Ws7mz2EFlb4x6fVUvYh3l2PrrmjvjLFlhGb
         TUy08nXuQqLu4BTHclEThk4b21Nph9gdIyCtSw/rElmllLXRFXUP87W7VXXnEK2TzXTL
         YQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383137; x=1711987937;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As2VhwHUVRvWjgICzD0V+vG+bPhsdoOihJmMhoBPKPQ=;
        b=BZNyFnuVlWqaSoJLCvURXpKCcEDehpfYifVEpcOVq9pvj5tVthRc6QLeSSCHFRj9+1
         u2xx7vd1ffaL01mpuwbCSZBnrXMD2RTFPDiWhA+Yx+5Sebw9GuxzPgqO5JZMxb3dYg4+
         P+YEksfhOlDj8gYCT2snFhjBfWKIQqug2rfGoyACB2asms+c0mJQJn3UqOFkPh6mg2zE
         eYKV7+Uo1mXwvYmNF43mlCDKE09BYbSkc9F9GxEBlrnvgBLpDWRhXU16l7lK08BK+sl/
         W6gTj3scUG/tPD0UIMv5UTB2V1HgefjHAIE0LCDc+1ezz2Hk49EgIdyLaInaKHqfy4HW
         x/OA==
X-Gm-Message-State: AOJu0Yy/2svs9JbL8aNEhQ1XhiA+gx1/hfmixnJu2mDtDCzUqNP3CA7h
	6HswxCsbgwQsAtNb8+eDDiYwOcVmP3MNEtO07CbZx63UhHS9KT7KEuH64M4w
X-Google-Smtp-Source: AGHT+IEJ6C+tT3lQ13O/ujw6DybpJgFFAsQagfNPMzMRoqdC7wnIYtMInpTFdyrdduDjPcsOYW3J+g==
X-Received: by 2002:a4a:ee8a:0:b0:5a5:639a:2fbc with SMTP id dk10-20020a4aee8a000000b005a5639a2fbcmr1307542oob.1.1711383137022;
        Mon, 25 Mar 2024 09:12:17 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id ay19-20020a056820151300b005a5631c1624sm186034oob.14.2024.03.25.09.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <79c4d09f-fc1b-40d1-9655-3a9e166918cb@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] cherry-pick: add `--empty` for more robust redundant
	 commit handling
Message-ID: <17c00de527e3a0c4.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 25 Mar 2024 16:12:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Mon, Mar 25, 2024 at 9:38=E2=80=AFAM <phillip.wood123@gmail.com> wrote:

>      @@ sequencer.c: static struct object_id *get_cache_tree_oid(struct in=
dex_state *ist
>       -	 */
>       -	if (repo_parse_commit(r, head_commit))
>       -		return -1;
>      ++	const char *head_name;
>      ++
>       +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NU=
LL)) {
>       +		/*
>      -+		 * Treat an error reading HEAD as an unborn branch.
>      ++		 * Check to see if this is an unborn branch
>       +		 */
>=20
> You are only editing an existing comment here and it is not worth a
> re-roll on its own, but for one line comments we prefer
>=20
> 	/* Check to see if this is an unborn branch */

Existing in v3, but new with this series. Since it sounds like a re-roll
is desired anyway to address the line length issue below, I can go ahead
and fix this in v5 as well.

>      ++		head_name =3D resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RE=
SOLVE_REF_NO_RECURSE, &head_oid, NULL);
>      ++		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_n=
ull_oid(&head_oid))
>=20
> While we don't mind the occasional line that is a little over 80
> characters these really are rather long.
>=20

You're right, these got a little long. I wasn't able to identify a
definitive wrapping style for these cases, so I'll include my proposed
update here just to avoid another re-roll. Does the following diff from
v4 to a proposed v5 work for you?

@@ -776,11 +776,13 @@ static int is_index_unchanged(struct repository *r)
 	const char *head_name;
=20
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
-		/*
-		 * Check to see if this is an unborn branch
-		 */
-		head_name =3D resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_RE=
F_NO_RECURSE, &head_oid, NULL);
-		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(=
&head_oid))
+		/* Check to see if this is an unborn branch */
+		head_name =3D resolve_ref_unsafe("HEAD",
+			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			&head_oid, NULL);
+		if (!head_name
+			|| !starts_with(head_name, "refs/heads/")
+			|| !is_null_oid(&head_oid))
 			return error(_("could not resolve HEAD commit"));
 		head_tree_oid =3D the_hash_algo->empty_tree;
 	} else {

> Apart from the minor style issues this all looks good to me, thanks
> for working on it, it will be a useful addition to be able to drop
> cherry-picks that become empty.

Thanks, I really appreciate your help with this series!

--=20
Thank you,
Brian Lyles

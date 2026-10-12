Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30749BD88
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820118; cv=none; b=J+rPWa+dG7tQ9FYUugm3P4ZGvA5fTF9pjzTB7nbkRIxJmasEXsHiUYv94dua9adDgjKeZOz/3IRVmoL7Cxjmr0YpSfy4ZZFjCNYTQM3ThRrc9OIYfywYHUlDGxwCAt7aMD/o8+3GJuijs207Dnamp2dRoOTh1gihNlmkZGaQ9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820118; c=relaxed/simple;
	bh=HTiH6H32vZvvJLXlMdoAng25SFjnS+pOBzzk4p1ttvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kw2Zt1wqyLFtwv2+kKR0cqcksceTJnMP4DRp9ZDn54DQQ2K/r1n3QaboW0+/IkAV8LsNHcUOSYjaWe2DlwcECAUv2/2T8lmmr26xZcXnx5c5jq83kyCNvLC9qk3WFDqqT2GlyDti5h63xcFP4XyxdQE3BD6pXnxGoocnsTNi3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufBt3bBq; arc=none smtp.client-ip=209.85.217.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufBt3bBq"
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c15deb3794so129519137.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791820116; x=1792424916; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTiH6H32vZvvJLXlMdoAng25SFjnS+pOBzzk4p1ttvk=;
        b=ufBt3bBq516hlqGxZU5/t/F2FE7Mp0OQTEEowPC8N9rCDNJtBGDa1M0bnKi76DlFc6
         JE1u6xf9+36TP0C3Itk+Zx91rGmjyPlTioKFarXf/jass4Z/rV/ODCarsf6wLE+PQ11P
         WKUCM4yitJpv+8PkqKJS1WWZqlxussKgzUo8qWmkBproUxXi/sAF6EGK40l8IADLgcYB
         dB3wk/1j57+atFsesKCkRfUjE85ZQqkHUPHylppKZihIfCgjamaPOtQF5GfIczS3ts5G
         DlrVJsNv9y59Uc2MwwTXlhDMy5UIwNZpXt+pwGd0shuOrc7Aso0MIyWv/Q3HwS5b6fjd
         gCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820116; x=1792424916;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HTiH6H32vZvvJLXlMdoAng25SFjnS+pOBzzk4p1ttvk=;
        b=j1odyhnaVtB4aggUa9jZl2GUqaLZohCSgRmS9mlhB1x7DHDNIaUcbPLWHlCszur6YE
         Y2/fysrwNkglbidH7fPrLemWtAaMoaOmNkTrQYoM1avPnSJu19NOH6vvwx9vtLZ3fxs4
         zJl/9RYNCGt6O9uhjP+rvqkDw7VsUr2JSOG7UsrC1SyVUgioc/F34Jr0vfU25AOGRIn1
         kjVymk3l1EEcvpedFzVxk89d2lkgEjgeOwX8OuWIRMm2irsVHbRlsVibyd8r/M5sKZfJ
         U1RWDMiSmH8NJBLn8Y1pDSmK0wbRwYJaa2uKvE/H18Y/StgLxjNpRYDjBfVm8BK3NQ+d
         nN7w==
X-Gm-Message-State: AFq9FYIuFz2k3K4QIlHQTIk5ztCxAT+pLpVyHNz8dDm2cByfLqh8uzRh
	QaH7TXaQ304xE/M2uPk2hFVQWQ9fkiz2a8weaufPcHskpdXf8HSZWkuWsR3xcC40ASdmr9XEd5I
	vj5o1Ek18ew==
X-Received: from vsve4.prod.google.com ([2002:a05:6102:f84:b0:7c0:6db9:cd8d])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:6894:b0:7cb:288a:b66d
 with SMTP id ada2fe7eead31-7cb37317528mr2235805137.20.1791820115384; Mon, 12
 Oct 2026 08:48:35 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:48:34 +0000
In-Reply-To: <e3b68210-7558-4f95-bc3c-eb57b1065790@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v3.git.1791757294.gitgitgadget@gmail.com> <72a87d1c34bba81cb760e47436a39cb249e42278.1791757294.git.gitgitgadget@gmail.com>
 <e3b68210-7558-4f95-bc3c-eb57b1065790@gmail.com>
X-Mailer: git-send-email 2.56.0.rc0.2.g72a87d1c34
Message-ID: <20261012154834.622130-1-rmistry@google.com>
Subject: Re: [PATCH v3 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, gitgitgadget@gmail.com, 
	abhijeet040403@gmail.com, code@khaugsbakk.name, sunshine@sunshineco.com, 
	rmistry@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Phillip!

Phillip Wood <phillip.wood123@gmail.com> writes:

> I can see we'd want to use the committed version in a bare repository,
> but it seems strange to me to ignore uncommitted changes in a non-bare
> repository. We don't do that for other special files like
> .gitattributes. It is rather inconvinient if the user has to explicitly
> pass the file inorder to test the effect of local modification to
> .git-brame-ignore-revs. To me it would make more sense to automatically
> use .git-blame-ignore-revs file from the working tree when that path is
> tracked by git.

In v1, this patch originally read .git-blame-ignore-revs from the
working tree in non-bare repositories. I switched to reading the
HEAD:.git-blame-ignore-revs blob in v2 based on Junio's review and
suggestions on v1
(https://lore.kernel.org/git/xmqqse2kma4o.fsf@gitster.g/).

> I did wonder if we wanted to automatically support
> .git-blame-ignore-revs in the root of a subtree, but I don't think there
> is an easy way to do that without visiting all the directories
> containing tracked files which makes it too expensive.

Agreed. By convention across the ecosystem (GitHub, GitLab, and soon
Gerrit and Gitiles), .git-blame-ignore-revs is read from the root of
the repository, so only looking at the root keeps it simple and avoids
the overhead of walking subdirectories.

> One final thought - do we want to limit the size of the blob that we're
> prepared to parse as we do for .gitattributes? I had a very quick look
> at the khash code which is used by 'struct oidset' and it seems to use
> 32 bit integers for the number of entries. I did not spend anytime
> trying to figure out what happens if you try and store 2^32 entires.

In parse_oidset_line(), peel_to_commit_oid() runs before
oidset_insert() and skips any OID that is not an existing local commit
in the repository, and duplicate OIDs hash to the same entry. So the
oidset (and khash) will not have more entries than the number of local
commits in the repository. That said, if you and Junio would like a
blob size cap in parse_default_ignore_revs_blob() (similar to
ATTR_MAX_FILE_SIZE), I am happy to add one.

Thanks!

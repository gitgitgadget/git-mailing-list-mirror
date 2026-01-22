Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA038B9B2
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113031; cv=pass; b=oc+c6IaoKrrjy1LsFbvkGeJc73Ns1+Sj9STjJ/X6nlMSUGt+1z9ZWFycIJH35mqYhMkei+buyxyfehx3SXbo6gxgvmWfzDqy7ZtiBwei7Xf7EtdK6iNj4T2I8Xt2+2Em0QGXIYDWEocYkrquQJkdB5n/JWV0JPhnR8ysb9HteRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113031; c=relaxed/simple;
	bh=W2Lkznq9jeTD5UB1fuMvGCmEbFTdKG9f+ozNqyhOeT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT5vtUw4q6TE66fiyuvKuNwE+/Y3JkNHQEis+t+WGlJ0NwmCP8p+SRPDqnytYdKIh/fNdwTIJ0G3OdSzGmOuQMgSVas5WtkgifwAXLadeBWdaoYY0pjKWf807lTuZuLaTkrZxPCngt1UCi/yI3zInKqpDMlUr0lFADDhZCpsHkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXyNozoI; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXyNozoI"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45c8e85deffso479531b6e.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:17:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769113022; cv=none;
        d=google.com; s=arc-20240605;
        b=NubtSYjLVv2rnS5PU9mWkBN8CLiqi9bXFibBjYufriTG1wbNUMTLHu2xgzZooEakRe
         1BzugGgmqjFohwRMCcYKlbC2vRs3gvJDKxbnkTjDy13lWq80EKQdlMdpYPG3x+ojfoEm
         Wb1Ayb74hvT7lXAi6biQcUwsr/QmY0VXDbenvPbmfT57cZRB6OXNk/1zRwq73hKzqihu
         lH7XQdIDOxq9ExLVCvG5AinmRvmK35F/TWpGjsxBLtW7QZTXUZ4i5pUarzSUpqj4E8Zn
         zmkpwdXU9rcRH5oTvoauTZMBe94pAHMokFP+wWINGz13gaErK2f6lwQ5iFjnGDl16Ohh
         mSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=knN4pEcHHNd7w5zVRcr1GGxrJhyZ9ywkFVBapW9+yns=;
        fh=E9h8LrGAHDx/zooHAiFPwfHTR2hlPNN4YBtZKRhFAtE=;
        b=GkxGsDsdYcS++YRmguARjfWx1NE6uUJRit/IYAGI+zI3mexH8uDY4sdRw7dwm5LdXX
         lxVzq528f5dIfgmv4QA0RlGqwWyzTclWVZfLWwYHjbYyiwTeJ6pgwMPQwRHu7cr597rD
         1fnBirIe2H+V1LJAE77wD37d5hUYFEFpziIwNMDY1BHlCytswVtpq75SkauJjVT4DEYI
         nOB19BYT0MF8lNi9boQLssAKvkWLY1kC/+KaGZoi4rkWeAAcmhzbBbWVIu50jEbUjZkT
         J7JDZZPb+rGMguQ3jnxA1lUKheeEEQH/VxCgQXi6xl90NDOnTambHfErQLdw5k6VW94t
         34Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769113022; x=1769717822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knN4pEcHHNd7w5zVRcr1GGxrJhyZ9ywkFVBapW9+yns=;
        b=RXyNozoIOR8ThQBdOMt2NJDna0qZzqvpHdG/BhwwH5wmxzNkB5ePmWCbdXCTfl/XPT
         OtGMATBHLfTHxx3Fvx0nGtzxv5f3j8CgeNd4GqUCh+8kK+zqqQCP0SutpQVUMxckqlPg
         O+z7QM0RY8bHvqDFofCTRk+GArEhPtZkU30bTJYTMLyqkDhPDElgkc1b5Z11ib7dXCFG
         JbFIsWyw3aHJe+bV/aXsmjC0ECITTDbh42IgzyBZF3f3uhVnfC0nqb+ae+ee9uWvw4Pn
         HEqj1vLZtma7kfwo/stylSEbZaYeGeYkfLsaGIwggfk5SLIMA2gJ62DFamXDzAyPCIp0
         tIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769113022; x=1769717822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knN4pEcHHNd7w5zVRcr1GGxrJhyZ9ywkFVBapW9+yns=;
        b=dUeCHGCErQ/7eH/NYOIuMY+a9XPu4Kan5mcFF9ODLW+QD+aRGlDdGyqyMaSxta7DZG
         xtPuwQQHMBNyN4m0OdkGJvvZwX34GzHXUdLoKBxNGjeATBEn8OeTmwRqZ/cKJWShqCm+
         4Pf5xURXSuJ7SpOc7ZsxuAQakyFEh5KVy77jTK2wLRA1jhRt96JPjD26SURfarUV1Nxr
         6tQ6f/BxY8hzSnCkeqHPd87RvH5GFsmqIystkSE0hz8UTButXJAcU3O7FbfzfO5EhCaf
         lQho1ef4HgwC3Xqn6Skra1pJMzey+dkzX/jKE6JN8CP6w/UfC7JZJeeSHKzJfR5Aqqic
         15Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUb7SFPChySK8aKJoY3F/B1oDQ0llykgNAU/1NhMFU0Vy2wPZZBhFJJXLavm3zSW0/yci8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpzUzsgwJcPg/0sQDeuNjUxbvTgwRB4FedF5SRkdyTOxViagH
	Z69UABPn+1zXno3b2QA2AzgF0R5UZcjeWaNrvVNiMqk4cBtsBNro9VFH6U0lCeUTvimkiHzX/VQ
	tiGjju4D4Pa7ZywfVUJWOegJNbb/MEmuObsOU
X-Gm-Gg: AZuq6aIjb+YDGwY744n8R4Mh1UdGS1yAVRO1vhbJ/pXpy0JB+w+jgbF/Lm2RntcYg5Q
	7oLMvCg+Wu5REP1Jwf0DxTzBt91z5AkRhyloxnzoYPr7bR6qRXZpoOdQbCwkbNdwmywaauSGoqi
	F2RUEQlEecaY6oduwmdzsgB6O0yDDafofiaASHril90BrZIX+jUDY8zbn0q6Mo3yNeXEHd9xJ4c
	7Lf9NeLC1fCS0mPhv+oVhxKugK0JDTUShs/elyVssPgwznp4IXuaSPog2Ds27jFOrkq+ngGFkgf
	RqQO
X-Received: by 2002:a05:6820:4489:b0:662:bf3a:ea6c with SMTP id
 006d021491bc7-662cab02f7bmr411918eaf.28.1769113021858; Thu, 22 Jan 2026
 12:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
 <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com> <xmqq5x8to53y.fsf@gitster.g>
In-Reply-To: <xmqq5x8to53y.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 22 Jan 2026 12:16:53 -0800
X-Gm-Features: AZwV_QgAEl8UkXlvS6Ils8_CSrOnnfBkB5yd0eN7uVbswNDcdYjgYgbcucp9RME
Message-ID: <CA+P7+xoYA6zhwVeCV6d5yW4ZxOKNLam3r-ayEDHpYpFqWyLduw@mail.gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:
>
> > When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> > added support for fetching a missing submodule object by id, it
> > hardcoded the remote name as "origin" and deferred anything more
> > complicated for a later patch. Implement the NEEDSWORK item to remove
> > the hardcoded assumption by adding and using a submodule helper subcmd
> > 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> > succeed when the fetched commit(s) in the superproject trigger a
> > submodule fetch, and that submodule's default remote name is not
> > "origin".
> >
> > Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> > t5572-pull-submodule.sh demonstrating this works as expected and add
> > dedicated tests for get-default-remote.
> >
> > Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> > Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
>
> Thanks.  Jacob, this v3 is not exactly the same as v1 that you
> reviewed (and range-diff relative to v2 does not capture what got
> changed between the version you saw and this version), but I just
> checked that they are "essentially identical" except for the
> proposed log message.  Are you happy with having your Reviewed-by on
> this version?
>

I re-reviewed the patch and everything looks fine to me:

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B88F4E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491612; cv=none; b=WA4L+t/3ziwu+q7SUWYhXRo9OnrXBZGnO0UL/u4kGInllgcknRG66nPiztwlE4X1Fm7P61Ex7cSKnPCe1SlXYjDEtJfIEFFhtAAvDZjquVa7Utozbb1Fzyk22+hk6ELJmPCITlwV3g/0AMRAd2IIrb15mUiwbnGmGc9YsGIm5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491612; c=relaxed/simple;
	bh=bdr2R5DvOc9JlDeQYFatzT6I55Mh3uxHiWXdeoXOb0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egl1pkBCIp1pjAMacsiXYKuvDbDotLmjbK71r+fK0lFs0uKbPCcJnPH4LIWpXu/sgceWIK2KdpS/SjrZ2uYFV5BIrHkV7ejo2+zb9gXsXuGNfQZE9WWf2K36Etq6Ruvs8C1aEr67rveK3a+i2yJPDVIr/zTmFHmH+V8JdkDinOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uua3Yp7C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uua3Yp7C"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so3314023a12.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717491609; x=1718096409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG20IorKCMvE/R82qlb/meJJCOuZHF2vvefgVW+mN9o=;
        b=Uua3Yp7CveoiLwFhEJy4BmDMUM78MsgznoYWbjd0G8s6pHyRREHxQnFoYQv3VU+sMV
         njILbvFdYUnUO5b7XJA0fe90Nc5zfi43cYTP49BV+LrXy4X68xJwK1aUFnJpPp32BfkB
         XukIg4NPVKp1dLhE2QkE2l2OuHpUYqtcFQBaTk8Z6Ki3kDPnGZr97Q1PMltxpmYLNCgi
         AoCiIjs5P9TAKnSX4pgKtvhhhYbrKfJ0l1KqHVpnDq8sNJrJc5G/lb7v5CNtivU3cVUC
         OXEbAALVyONlC+1wiu4+YhFPX7tFtz8TDN8X0zV+HHa2BZPy4grIhZIf1ZIs2R0sUvKa
         i6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717491609; x=1718096409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iG20IorKCMvE/R82qlb/meJJCOuZHF2vvefgVW+mN9o=;
        b=fnTMz2kZUXDzRsDicwnp67nSEvq4tDTGUUp9LJw+J89SnaN5j+HuRbkYHRaVZx3CIX
         y6NfefL5XyPmNp3TVgT5hK3gXUd9rT53dvzrWTmeF6ZZTMG3DT7Q9md6RTDqlWTeWUV0
         JffBe7OrcDhw5mJHiN3l3a9vK67zihUOKXQhEnWlFC9bhYDEm5ry0sn+Z6Y4352lvPc/
         v3gEexYwYwtKv3Y7LVlc89DZv9GObtzFS12LKGWSxklyITNmcuV4KPtVPeoGQkMIigA1
         M3+J35do86cKZmde1yP4MXkeV4VcGsYDxZxUY/3pOdktX6aME5hFLBXPJWyyQe2EPIiN
         YGoQ==
X-Gm-Message-State: AOJu0YwqEFPa7DAfaRdfgFOeJdq6BU3HbsYBPAcFbf1ZdFZQUsSQFm43
	6V4Sg4MXL5MS6uogymkxrkA23EK+fhEkqbWzDsOUDbb9EcHd0Sr50z1OIlBXycJPcvwWcCLKURq
	mFrEeGmTvssMLD3IGBQnyZp1SHamK6SVA
X-Google-Smtp-Source: AGHT+IHUK7rNPN5BMEW/kt4CoXcGjqdmmo0vYdQMOLq+6uFNM89T83ARHq6jje0NRLG9bJfSigIACFybDE92k5sQVuw=
X-Received: by 2002:a17:906:130e:b0:a67:7649:3c3c with SMTP id
 a640c23a62f3a-a6821d62f61mr939289766b.56.1717491609272; Tue, 04 Jun 2024
 02:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo78h1bdg.fsf@gitster.g>
In-Reply-To: <xmqqo78h1bdg.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 4 Jun 2024 10:59:57 +0200
Message-ID: <CAP8UFD08BaDTt86j-X87Q9j9q1bzbB9zODqAOV5d9n2Fy7Jd=A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 8:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> * gt/decorate-unit-test (2024-05-28) 1 commit
>  - t/: migrate helper/test-example-decorate to the unit testing framework
>
>  A test helper that essentially is unit tests on the "decorate"
>  logic has been rewritten using the unit-tests framework.
>
>  Will merge to 'next'?
>  source: <20240528125837.31090-1-shyamthakkar001@gmail.com>

The only nit found in this was about how tests were split. Josh
Steadmon recently said that the split is reasonable as it makes things
similar to the original code, and I agree with that. So I think it
should be good to go.

> * gt/t-hash-unit-test (2024-05-29) 2 commits
>  - t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
>  - strbuf: introduce strbuf_addstrings() to repeatedly add a string
>
>  A pair of test helpers that essentially are unit tests on hash
>  algorithms have been rewritten using the unit-tests framework.
>
>  Will merge to 'next'?
>  source: <20240529080030.64410-1-shyamthakkar001@gmail.com>

I agree with Patrick that the v5 properly addresses the small nits
Patrick found in the v4, and the v5 LGTM.

Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A10762C1
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641502; cv=none; b=eUHlXOSnm/V3Did23gx4+h1yGEmSSWw/XbUnzbtOt7tM5wjyZGvRVgFuRyaM/bGn3Y4wdloBBYBytxAi1KWXgamV8ROnzF/REzDnDiHY9YGvmwK46jH99bwzCoe0qgse4OjnwC62Rcqi8KwKyv/NcKLXluV7KU4qoYUl5qpeiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641502; c=relaxed/simple;
	bh=9TmDXuUe+Py8k+NA9vSMrZn5zdKqfF+xyO0JCV22IPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx0ITDw2TR5s4F346BFYWCO9k8eVOV5OeL8Qt3E90sz8kIf5FsIjXkpXjDWETZQB2d6TS24ZpkbDt8pnAOD9d3hOeRUYuyXag9AX4vXmOC6C6KWOMr2NR+TftE3yplGRfd5WIYZi+6Fhnll2yFqbmleZnP8cQuMClz7kcQuYEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXIiAkVy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXIiAkVy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29026523507so3399440a91.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 11:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706641500; x=1707246300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y80t/oDiVXyUmQ84jJkVhx//00R2CpHmW5a7Y7V9DWU=;
        b=MXIiAkVyBHHI3qFup/IeHyQz1q8QS+oLF8UmDU9MxOMcYI07MPSUJmxn+O8T/xqTo3
         ap++F7X2a/77hkj4+y/lQz5JESZ5u0UvIjw6QR7QTPocDapgJScKYC8uJ2anS25Td1Pl
         mqbylI78SfC5B8kC0Mzh55rrTRzo6CZbiKX328MHbI/l6NYiCV54yuireZ391N+6Nkha
         hDiO92FbhJC6YSCzMYFNLNJD/GIDQ4dc7A+7jkvXDUnKlAAcN3rifFDeoRIYiFk1ONym
         bY8FMnWMJfye0ti/Kzuk2n9DUS2XNW443kNPWk+ukkAkD6TmQczVAkAxfBdCL40ETJp7
         c4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641500; x=1707246300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y80t/oDiVXyUmQ84jJkVhx//00R2CpHmW5a7Y7V9DWU=;
        b=FEydFnS9h9LUzauXS75/O8bNCvoMMqfontFFlunPmsFt74Z2/HXEXls6GlWpXMaihw
         JiWFGo4Bk9Wh7V1TB1QiRjTtxNFWpo1j/mXOR3gsP3UsA5l3wn+NGzAvQC+sx/Y/+Ya+
         yVtF51ErhdLWOnoXyw+pY7e4htGy/DCOoUL9ujNcyc6RR3ousDcjvhJ7W4z9M2gyRor0
         ELyAnJnXxrcbZRyLeaLoRjo9c0SebsrzEfsPtXogEt7029j3yUmam6efhORg8UcnaIZh
         1a3aI5J/Z1FmPoXBG6+3svDTVQtUsRdQ4SouhdUKs7ITOFgSakzCdhQWBGL2wU4T1ZzK
         dq9w==
X-Gm-Message-State: AOJu0YyqZqF/IMY6cAy5qhb6ChvcD9nQghdpB149RMhwGk3MZYOh5QbQ
	KNMHL1iYsRpnWPYlppbH4AmL1oFMcaMgfb9dJT/RPPkqkzBvSOybHZVlIbiyK6CKDFzM+gZ+P9g
	7Y9KHz889duQJBa8lj1IyRfxxaDM=
X-Google-Smtp-Source: AGHT+IFJ4o1vPl8yVv8q3g6YYvbuAq8770FdVFgkbH7PmQpZ+Ehm+RAXIwwKpPfncqIB/EQmBe5xsJIpmrB76nd7G3Y=
X-Received: by 2002:a17:90a:4092:b0:293:da36:5778 with SMTP id
 l18-20020a17090a409200b00293da365778mr6429078pjg.7.1706641500593; Tue, 30 Jan
 2024 11:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7bdafc9bd7f53f38a24d69a563615b6ad484e1ba.1706592127.git.ps@pks.im>
In-Reply-To: <7bdafc9bd7f53f38a24d69a563615b6ad484e1ba.1706592127.git.ps@pks.im>
From: Justin Tobler <jltobler@gmail.com>
Date: Tue, 30 Jan 2024 13:04:46 -0600
Message-ID: <CAGAWz+4wyd13UYRH3ZSSZEq1Y=5HE_p+qaXeOJS-ENMpWoLabA@mail.gmail.com>
Subject: Re: [PATCH] reftable/stack: fsync "tables.list" during compaction
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:23=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> In 1df18a1c9a (reftable: honor core.fsync, 2024-01-23), we have added
> code to fsync both newly written reftables as well as "tables.list" to
> disk. But there are two code paths where "tables.list" is being written:
>
>   - When appending a new table due to a normal ref update.
>
>   - When compacting a range of tables during compaction.
>
> We have only addressed the former code path, but do not yet sync the new
> "tables.list" file in the latter. Fix this ommission.

nit: s/ommission/omission

>
> Note that we are not yet adding any tests. These tests will be added
> once the "reftable" backend has been upstreamed.
>

Nice catch! I noticed a small typo in the commit message but otherwise look=
s
good to me.

-Justin

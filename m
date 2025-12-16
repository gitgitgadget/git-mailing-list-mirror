Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B533555F
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914267; cv=none; b=E1TlKu+hOUnY8oUAQ+svcCprO5fF2APMwIwc8enG+borAudIcx/Pwlqd4Q7yzLV3gAHswHNBhGVnsag4usZdcQddy5ECEve7J7c1J/PDgeaKoJeOEDPSmCE8M1EZA0nqAeZ58ZZPMMPIKpIkM+t1OnZ8wqqqvRR3CcDPOfBzAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914267; c=relaxed/simple;
	bh=Yj6jyrcPruCJIs+HjqMe0JGPptDyJVXRqai7D2DhNHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmsuPq1mkPcF7YUPg8IZuqxkKLgaug6KbjwDuNMtMdb+IVTofsIZUDtyYt38zLpY0LLeE9t9f0Ny/vue5ZWlOOG6A7sYWGNoJRBbvEktzMSA592Z/lf9cv3jtRkZC5IM/vEC9POyq6TCi38qhPJ42J26nHLMMLJJTlDOJuM3YfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaXyWeXM; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaXyWeXM"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6592e70b629so3147870eaf.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765914264; x=1766519064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SoxGc4VM4WuRZELiyyCcLp5RMqpmctkqDzsRXDDUmw=;
        b=JaXyWeXMJe3lQ2Dv7c/xYUKbSlVznyKOJJzCJNX+ulxwjKyqa3X9KAMZPeyVr5QAe2
         8fuX6IBQT6ZUBRjYjfTKTS4tS27rZVV+wXFSRnhVjdsRQKN1DlEYwJN4xurAlfS7XhQG
         pLvbyNSy8a9djNzz2yGVio9etKW9Mt1eEPHady7TWw9PZJ/oOzvJnIb1iB5h42SSQIhe
         mxDznyuaH2Z8t6b3XNycDj+MZu0ytReFy7q+c1tLBTy69NPIpIXx8vBXVGQ0O3o1wkSs
         UZOmycNtBvZYPZgxHq65n1BsB9FcmQBVfKiy5Jjb6qDVq25Z2lkOX3DgHQqQoZ8j/mVf
         9A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914264; x=1766519064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SoxGc4VM4WuRZELiyyCcLp5RMqpmctkqDzsRXDDUmw=;
        b=caQdf2CwkBT+GEVM6uCQnpJ829uzDWpTIdyQMLd16dVBODuf6wfh2gsWfI2ilJm8Wg
         O7x2HzI+W+YBRgAepQhcHBp/M5/nUIhEXIP5NB5BpM2tIRh7k7QpCmbtNfK82jZHw0ZB
         fwVsNFR0NB/wsxeU4HWGh72XVzYPK4617/t7rrjavSNkiq/ogMxqJ6FxBIbBigBJSl5G
         1LMnTlYjZRV66IUcYgE9LHjjpiztBIZTbDX9Owlz114iY7A7ySoc/ynDq1O3NuIMkC4o
         BeY0uh+vGa5kre78E78S/jg3aNZl/UpAHQgP5axjhVdmAf0eVMfPlixy22aYpKhc1sPP
         xoxA==
X-Gm-Message-State: AOJu0Yxfb2oCF1Oe2glzIkGl5ae2lqdMvtVlxjq4XI2g6KgyQ66h4oSZ
	bMeZ6Jxn813+LbjjnM4u4Pu6jib/7lSZPjMxmoWMGFeXxRvPN1DlZzA9O9PhWLZsd1ScmrbIbIB
	doKfko74TkHruw4bdtrHCfsvCuXEV7rjZg+QP
X-Gm-Gg: AY/fxX54pBZpdKqrVslyUtr9g0lu+aDrv5nJ4BLLIG0tQoYkPvKGphZF7pD7MMSuFcK
	Ja9ABfKIxynUu0t10hGcg/QSAIb2dq9DkZcnFMobuF3pLsv0jFuNHdrNS2WCqBOhHqhHJst6k58
	kwbJpTrUH9HNd7HhLFb2jqr++qKpdVkEBrHYilHS/z7+6w3hANYzmDTqeoJz+E4PzGwsvWBH30X
	RCGtfPaBW7vxHt0Dat7KducjA1KVwMqaPLcHecOmiSrPTIheeHZsc+tx8bpUZQkObcDh4qQojTh
	BzQ5BW+5pyGMKggz2FGUkBxuDivYWrNtJ8WwPyE=
X-Google-Smtp-Source: AGHT+IHCe6+EtCSzQtfLxxiC4QKfCTiTM+VIucmgyTlwIhhRuxU/VY+xO7p79YDoIIawHuhm6EgnIL+PO1bRCS51PnA=
X-Received: by 2002:a05:6820:818d:b0:659:9a49:8fe1 with SMTP id
 006d021491bc7-65b4516cfbcmr6970652eaf.14.1765914264390; Tue, 16 Dec 2025
 11:44:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3742e7de-7d88-4e77-b711-9fed867a8c23@gmail.com>
 <CABPp-BH80R4LJDRKQnPmh5Am_HAcCgxWiA8vRoN8LgLRUMz+JQ@mail.gmail.com>
 <d7135cd2-e577-4f96-8142-cd9c7cd6995d@gmail.com> <CABPp-BH1qgQNHJzJZ05Ckru2PdYxRnWfQ3xVPrqGG5F56bX1aw@mail.gmail.com>
 <61700785-5421-4fa8-8277-c0837b09a737@gmail.com>
In-Reply-To: <61700785-5421-4fa8-8277-c0837b09a737@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 16 Dec 2025 11:44:13 -0800
X-Gm-Features: AQt7F2obnYpuUlIqHdIZq5tk-xqohGi-mNhDs_Msm9cXM6w0qE31w6hQCbJhBM4
Message-ID: <CABPp-BHTnP-3erFTJ23goreg=UJGWPwCwdN9LNKsVbB3Omjt9w@mail.gmail.com>
Subject: Re: Different behaviour for --find-renames between git diff and git merge?
To: Luca Balsanelli <lucabalsanelli@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 16, 2025 at 5:15=E2=80=AFAM Luca Balsanelli
<lucabalsanelli@gmail.com> wrote:
>
[...]
> In the following example, I start from an empty file and I modify it on
> one side of the history and move (rename) it on the other side. The
> rename between `branch` and the merge base is detected. So, can you tell
> me why in the following case the rename is not detected during the merge?
>
>     git switch -c master root
>
>     touch aaa
>     git add aaa
>     git commit -m 'aaa'
>
>     git switch -c branch
>     echo -ne 'A\nB\nC\n' > aaa
>     git add aaa
>     git commit -m 'A\nB\nC\n > aaa'
>
>     git switch master
>     mkdir dir
>     mv aaa dir/
>     git add aaa dir/
>     git commit -m 'aaa -> dir/'
>
>     git merge --no-edit branch

This is an interesting case where --[no-]rename-empty option applies
(the same option you found a related commit for in a previous email in
this thread):

$ git diff master~1 master
diff --git a/aaa b/dir/aaa
similarity index 100%
rename from aaa
rename to dir/aaa

$ git diff --no-rename-empty master~1 master
diff --git a/aaa b/aaa
deleted file mode 100644
index e69de29..0000000
diff --git a/dir/aaa b/dir/aaa
new file mode 100644
index 0000000..e69de29

The merge machinery runs with the equivalent of --no-rename-empty:

$ git -C ~/floss/git grep rename_empty merge-ort.c
merge-ort.c:    diff_opts.flags.rename_empty =3D 0;

This comes from commit 4f7cb99ada26 (merge-recursive: don't detect
renames of empty files, 2012-03-22), and the commit message there
explains the rationale.  (The name of the option and how it is set has
changed since 2012, due to commit 0d1e0e7801bb (diff: make struct
diff_flags members lowercase, 2017-10-31)).  merge-ort copied that
behavior from merge-recursive.

So, although the merge machinery calls the same diff machinery that
`git diff` uses, it does pass slightly different defaults.  (There's a
couple others too; I believe the differences include rename_empty,
rename_limit, histogram vs myers, basename-guided similarity, and the
possibility of cached renames in a sequence of commits being
reapplied.  Users are unlikely to see any of these typically, though
you certainly did here.)

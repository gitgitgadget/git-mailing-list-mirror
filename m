Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6E1C75E2
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915950; cv=none; b=TyUYjtC1lK0tW8PdF5ixEGYWSNB1r+Sn21OJVg1InxBFskbIxXwMeYM6UVceO02Fcg15epUosm6PdlmZzPDJtw8W83831m9a3GBYX+QZqC5uodVdsf6pVL2ND6iPVJlRXhNiaA2oHce7QtHH7PVec7qW6G7vUP7CjlYo36mgLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915950; c=relaxed/simple;
	bh=IaFKHjMFl9F+vKdwiBMtqJCrMV/cSr+kZn8cBVXJmAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCgQpSpAGfiX8YC4A5AKPVVc667suispZ5CEWh4XsXC/sCgpNah8GBIzACi6u2TBJo8EFmnImKG66SQix4Ii1Zv/nkAO7x6rNIx5nTA3KiDFXinh5iPnA0yF84frCDzEXWhOesFJnp+/8j7lIAma19bb8/9Xyq88thptem7pspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaPEtArA; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaPEtArA"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8558f3cc093so166685339f.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 13:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739915948; x=1740520748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5YK1F5CGloHe/kTfpODnI2d6vwQoESoOytrmYvywkM=;
        b=IaPEtArAgot47ATEOBuv3JmR9jqtisyFvOn8fs421jZMyHqP3IsOfiUGaJjGluRwmN
         E1tfzxL+7As031jre3yeZcPlWCtPlT57O6q0OJtYUP4n5q5NP/MRmsba3V1vRaKQjZut
         s9fbxOgOTjgECRtloCS97vexTQUNgCi+Vg0BnoxJJ3BnKwWQwh3HSHstAfWKhbz+3UvQ
         7LDThEGSmd3QBEUCk93gJPCme7E3SpIj6Nze5mV82cJFoRPh5P1dE1wzUK/DGWHx3Hv6
         M5lbHbvuUNJITAPsBoOW0mgu5kTNMWyLLlk6x8YfYjUGI+3iqbJl19N7giYThY1rIIHV
         0Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739915948; x=1740520748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5YK1F5CGloHe/kTfpODnI2d6vwQoESoOytrmYvywkM=;
        b=cHRO//U/GDa0pipSE7cCE/GY99N1+yntReIp5om/h0BbTGrJa2xzdMWxrIEez1s6vU
         Xpp8Vlu0PX+qhe/BJYLEFcK4mxsJK5vqT9xRh+j9GYYv2FOkLHpDL+r7WXDhLTbefCmX
         kEgeeq3PHicPfbKizNBV7UkCTNVcrvIAB9rlvE396u/WySV0r5RfhTy3LuYIVut0AaU0
         BJLD8IzDdl5oApAJN0MD1xQ1adBGz63mQWCREORtj5b9paLYKGcC/ltWc9jdcGulWdkS
         3ImODce0MkkMKGFG8XLe7KbhvjPWIc7DyBbIf+5wjxfVI023NdL6YHjlFfzt2SF8Iqh9
         spOQ==
X-Gm-Message-State: AOJu0Yz0EwTFGAPCT3CKKBdHGivyI+74O3CByvbgZtAf3EunUzKqkFeV
	f4dhPqJal76tAdaK6D2tRFyNDce9s6KBfEt+lwYZ1i0YCmW/il1HLJa8KNsbwQASoU+uFC8PN4N
	GH653JHJCnlLDJBGVg1VOdlxTX5FtxU9T
X-Gm-Gg: ASbGncthos2+loDiee7052lQqAJ//NDOMc17Yp9vZ1P9MeOtJY+r7azMt16EZwPBxzO
	2IV8Wt9ycC2t4gJYhQCB/tuww9n62Ud17lmUmnS7UXc50d9xQcgYuA72fNfXNAypEWAH9A+HW/N
	cbn3q+odrxYKB1w2a1wShXO2XI+ydKaw==
X-Google-Smtp-Source: AGHT+IG0xS1EpjJnY2CB2m5zoq2MOxIZDyI9Wa9MriOtOMOLke7jXDOwgiMbHHETC5Cus+C8P1vIRNO3W+dcvQxajl8=
X-Received: by 2002:a05:6602:1542:b0:855:ac69:32bb with SMTP id
 ca18e2360f4ac-855ac6938c5mr305511039f.1.1739915948377; Tue, 18 Feb 2025
 13:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217232847.8567-1-lucasseikioshiro@gmail.com>
 <CABPp-BGpOi9ZqrPFwxCiRLFjozgnYKV=zbYVAA5c9Z9yDUTBGg@mail.gmail.com> <EE88CF05-9120-4CAB-A097-84CC5EA2FACE@gmail.com>
In-Reply-To: <EE88CF05-9120-4CAB-A097-84CC5EA2FACE@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 18 Feb 2025 13:58:57 -0800
X-Gm-Features: AWEUYZn6UbJKiVlV1e9Lqhq2WiBBQKD517roflOz-3WCqBzHuQmBENZKrohgRP8
Message-ID: <CABPp-BHvutRL80QiTYx6gJbYiATOD32DrvXgQQtEy=u5oUZ9Zg@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH] git-merge.adoc: detail submodule merge
To: Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:55=E2=80=AFAM Lucas Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> > It may be worth referencing the commit(s) that introduced the behavior
> > for other reviewers: commit 68d03e4a6e44 (Implement automatic
> > fast-forward merge for submodules, 2010-07-07).
>
> Ok! I'll inspect the codebase and reference it in a future v2.
>
> > "referred by it" is hard for me to parse.  Maybe something like
> >
> > """
> > In the case where the path is a submodule, if the HEAD version of the
> > submodule is a descendant of the MERGE_HEAD version of the submodule,
> > or vice-versa, Git...
> > """
> > ?
>
> Perfect! Actually, I find submodules a little abstract to be explained
> using only words, but your sentence is very clear.
>
> > Also, the references to HEAD and MERGE_HEAD do tie this documentation
> > rather directly to `git merge`; the basic idea is applicable to all
> > callers of the merge machinery, but none of the other callers use
> > MERGE_HEAD (some use CHERRY_PICK_HEAD or REBASE_HEAD), and some do not
> > assume HEAD points to one of the parents either (e.g. merge-tree and
> > replay).  So, if we want to move this somewhere more general, we'd
> > need to reword it a bit.
>
> Given your previous suggestion, what about:
>
> """
> In the case where the path is a submodule, if one of the versions of
> submodule is descendant of another, Git...
> """
>
> ?

That seems like the right direction, but I think "descendant of
another" is vague/confusing.  Perhaps

"""
In the case where the path is a submodule, if the submodule commit used on
one side of the merge is a descendant of the submodule commit used on the
other side of the merge, Git...
"""

?


>
> > Oh, maybe we could put this information in
> > Documentation/merge-strategies.txt?  Hmm....
>
> Looks like a good place to put this. My only concerns are:
>
> 1. It would need to be documented in both `ort` and `recursive`. I don't
> think it would be a big deal as most of the first paragraph of both
> strategies are equal.

Yes, until `recursive` is deleted anyway.  (At which point we'll just
remap `recursive` to mean `ort` and not have to have separate
documentation for the two.)

> 2. Maybe it would detail too much on this specific case, while not
> covering others (e.g. changing file permissions, symlinks, etc).

Yeah, but we don't have a way to resolve differences for those kinds
of changes when neither side matches the base version (unless
something like -Xours or -Xtheirs is passed, but even then that
belongs under the -X documentation); submodules are somewhat special
in that regard.

> > Thanks for sending this in.  It's always helpful to get researched
> > documentation improvements, even if I can't help but nitpick and
> > complicate matters here and there....  ;-)
>
> Thank you! Given how deeply you understand the merge machinery any nitpic=
k
> is immensely valuable!

Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032B14884C
	for <git@vger.kernel.org>; Fri, 16 May 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409546; cv=none; b=ooxJAaW0WU/L5kwNZGFDwYPsvq7b99xAAoMdhq2LFn+FGi62XZbniNfNoqT+164CPRFg3KrIYcaWFvv9NM3byevANgxgdFuqy0499er5GMl+ZDrx2iY/qMw34+QA6aSNvcT+V8mExeZeNs4PMsds7hKvrYIeJvbahtSUUPRDE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409546; c=relaxed/simple;
	bh=TK9nUDqtge7B+r0f2ELd+tR5+1dBFmmBfuiZEItOink=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxQoeLrIFCyRqkq4zWa6N/pODiFaPHfI4ebuNMuj9oxAkBGYLYKayVbzi/ukMwgLdxcbglPw8qXc3nlji4lQljFzHAzgqDTif55//y6tVklGSNaDSKQP1l88gcZL4oOoynVyNROtJqpn+ZlSIcGU+hNsus+VmR0/1r5dygYZ+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCNfcJAk; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCNfcJAk"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8647e143f28so158876539f.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747409544; x=1748014344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUBphId4Iob49c+LOo57y0a8qfI5AAm36YRP2nvSAmM=;
        b=SCNfcJAkBhyW+DgIzjy//rLXlf3DHDPHvNPf2EXyILjiTBbAwgfDoHOxaRQXLxXBU9
         R0GlDg1u7qvAidIvvUkrnIHbK83zsfTrJ33ZLQZ1br1XvTjouZteQu83hMI8jhW42SDn
         XDhVoe6RW+PBoWLo55vDQ7+fjIqmocj3VmWgSgOkiuAEtCHhjBczag0vtppHK6pn1OCU
         127XGvgQp6+SDxB5RNwvWM39pwQtaORVRbQkmVYEFe6nnGvTqMOY2X1AZgaVERuVzjxk
         0QbPyhd9XRViwtqxJjtunYnvYWz4JkcnsoJX6kq0uX3dsaK3SpoZGydoDzM76QxWOSQy
         DLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409544; x=1748014344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUBphId4Iob49c+LOo57y0a8qfI5AAm36YRP2nvSAmM=;
        b=oJuC+33VK8Z3eiljF8gdyjYe1qMYMwDu5kM7NudxACcfmcyvncZl3zKUc4dNhsa7RI
         Ulytb1sp7rTXWogZJH/lDtWoXOW+9UxU8Te0uyESIM3g5vpvk6mjNp4eepae06UPCY1B
         yxUg0/pbx+ZVtQ8ZyFneJhwnCrjB5t1AXZeqvR8k8QVBb2mEt0MhjR4vTk/nDlvxKOHu
         SY15T6JIBxfNN4/CcC2pMT+zgwOhaiOKXwAo8jtQ7ItP/FJpZu3c3db2diK9bGfYpwUo
         iztlR2hJkgpRmb4JctEd583ogIAw9IZZJutsj4++nu/z1Ads6F4WGQ34jZM61aNXeqOs
         s4ew==
X-Gm-Message-State: AOJu0YymFdqDovDMJjNWbHsc8roxs9hyRkH5GRv3tOZkwcWN5yzZWhun
	wljKu8IbViG0mWH270Qtd9Pq4elRl0cFIsW8HlCv+jd++u5NA7qt3OhdXMoThCKxM4zwcIVzRWa
	IdYJ2FWYqruOevLKkbdSivZvG1w54Tkk=
X-Gm-Gg: ASbGncu9V+q//WnFPKwHvgmxdB1IcJmMAPZXaJm7g28K82pF6F77ZmYbu3gHy077TLP
	R7wPz32EZ0ejYGTKciZaeOsH6kVG5xcTA3KTZaaSeTiLOn9r6Iyf3/ev6htno2aHD9L/xzrlRJe
	sBgZd33x1hXqQ8VEy3JnilE2KnAQ185W7ZvrYtknlA+j/2BHvlRYBj5qYEdOjWqJgMtw==
X-Google-Smtp-Source: AGHT+IFvqKrj4DPHKMZMKdYeZ3cPOd7nSo3Ns257UtQ8zewUAJ5XOSoBJ8n7hoB3q233jffaqaH3TsL+7NIWzPra1BI=
X-Received: by 2002:a05:6602:4192:b0:869:d4de:f7 with SMTP id
 ca18e2360f4ac-86a232579d7mr601080539f.12.1747409544067; Fri, 16 May 2025
 08:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com> <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 16 May 2025 08:32:11 -0700
X-Gm-Features: AX0GCFu2PPGZRtClnB2TMTHVC_fhTNrK28-aZ0WAS8s89CrKOW5144HsIf5FNqQ
Message-ID: <CABPp-BFmgAsps=Y+YE=dTUxnGSKj+49jNxODdQDOnvuF7XzKZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Integrate the sparse index with 'git apply' and
 interactive add, checkout, and reset
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Phillip Wood <phillip.wood123@gmail.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 7:55=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
[...]
> Updates in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks for the careful review from Elijah and the pointer from Phillip, w=
e
> have these changes:
>
>  1. The tests no longer have different expansion behaviors for 'git add -=
p'
>     and 'git add -i' due to partially-expanded indexes on disk.
>  2. We now test 'git checkout -p' and 'git reset -p'.
>  3. 'git reset -p' needed some changes to the builtin (similar to 'git ad=
d')
>     to be fast.

I haven't looked at the new patch yet, but the updated patches 1 & 2
look much improved (though there's still one problem with the new
commit message, which I comment on in the range-diff below).

However, I think Junio already merged your v1 to next
(https://lore.kernel.org/git/CABPp-BEukTWwsuC7MMR8D5_UAhyw-LgT=3DDsPKAWeR_Z=
mVVhjzQ@mail.gmail.com/).
So he'll either have to revert your v1 in next and apply the new
series on top, or you'll need to re-roll as fixes on top of your v1.

>  2:  63caae87634 ! 2:  0a2752721d0 git add: make -p/-i aware of sparse in=
dex
>      @@ Commit message
>
>           It turns out that control flows out of cmd_add() in the interac=
tive
>           cases before the lines that confirm that the builtin is integra=
ted with
>      -    the sparse index. We need to move that earlier to ensure it pre=
vents a
>      -    full index expansion on read.
>      +    the sparse index.
>
>      -    Add more test cases that confirm that these interactive add opt=
ions work
>      -    with the sparse index. One interesting aspect here is that the =
'-i'
>      -    option avoids expanding the sparse index when a sparse director=
y exists
>      -    on disk while the '-p' option does hit the ensure_full_index() =
method.
>      -    This leaves some room for improvement, but this case should be =
atypical
>      -    as users should remain within their sparse-checkout.
>      +    Moving that integration point earlier in cmd_add() allows 'git =
add -p'
>      +    and 'git add -p' to operate without expanding a sparse index to=
 a full
>      +    one.

Was the second 'git add -p' meant to be 'git add -i'?

>  -:  ----------- > 3:  d1482a29d8f reset: integrate sparse index with --p=
atch

Other than the one comment above, your changes from the range-diff
look good to me for patches 1 & 2, and the new 4.  I haven't looked at
this new patch 3 yet but wanted to comment on the merged-to-next
issue.

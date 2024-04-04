Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44663134721
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260874; cv=none; b=Iwoxt9xZr0px13OoPrLHKN8/P2fXuPkDFGFDm2KD2pEysGrdEEPNepYK6gpVGdBJS/t4omeHfj/BJrnKR21Nx8K2AVWW84Io15S9kUlX1m+3Cjd8K515Py3A8PzF/gdAPTm4UDwhixwgO3Fmm5jgKkDpuAgYKdygKxADyTQ0kTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260874; c=relaxed/simple;
	bh=+ZaW8A34Dge3jPkqN7infhbYRQ6H4rNrlmfMkB3ms1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kC8BKZ9teXEf0MYmlpBnr4LRY3lNHUWlWKXNC70SZb4EI5dzaAp06TcH+j+BaaxVJXKfpcwjfKCpBr5YhRwatd402aHvyM0GBP1osOdtEjslZokB76N1k5yxkDPwBnppfxo8cjTx6vQORkcLbP02p6D5HiKrGoxWCi7kSeLKbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvFtl/v6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvFtl/v6"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615404edc5fso15551907b3.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712260872; x=1712865672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dArNbHeId40MufDfT2pKY/f0hWLCO/dS0LV3O1jOQ+o=;
        b=KvFtl/v6HvqWm95xuQiqKDgH6XJMq/ICHPgNL7yBNbw1Zi1aySf6LBrxxLDU+L+tYu
         yHgagDFy0Ya7ZQm4k1gKkTYQ9L8PGyd7PpBUz0iC9VanSJS205XbMdxe5qZP6JWvTFGU
         HGqfDjNf8JrBv/GxpI3tFyfzqG68Eg6S0GN59pRLRC4+b31sW1sEyO3z4UUXkP8I9huE
         gDdzGQUMhkEDwByhJa3mfjkN+kXabHCOZQSusIKJ+8eu4nCyhxkgh5OqwBjRw1htfWq0
         rUBcVNqrhUdGtHzu8CX3+C+5sJvwIVZyCVeYWE6IW1Ru3d0EH4AHBjXFxctk1AwuTlrP
         SNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712260872; x=1712865672;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dArNbHeId40MufDfT2pKY/f0hWLCO/dS0LV3O1jOQ+o=;
        b=GlJ6C/CnuNPaKd8dhdIH4MKm/Pbu6EJ40MgYzDIW4Mw9QHxUqjPRykwAzOTm2ORcVv
         HpS+qXh0H6fYDAhI8jZdIRnVH9SkoSeBiXVjlbRWUCGcdLwpSdwlAl0BeoXE6aNv2geN
         TqziAoZ3s5Sw7tnDFCb6MZGsYXeBipgdhhNjF+mU+ZgU9asMo4Mi3HumljqvE85B+Hkh
         /llHBm0qvsZUVOG1UMMHMdLon/PH7lyPm4Zv5EPi4qV7E7F63LZg/ruEZ5B25b5XIVaV
         qAwrB5kmGpd8VKY/Rc+oEROhLfPZV6aCtJJAuro+7x1CnoGrRhnngBAkydArCjjivyUo
         CmSA==
X-Gm-Message-State: AOJu0YwnD6AoD5NoDywJnQ6M9WSA4BBCGHlNiT7VtJPAbKC21pP85AWh
	oUZrKTmglQ5w04FBSwS1uyaM+yKUVmPVjcTDsqE8NrKY5Z9kDItgI0+kActNQhlAczP516RzEOi
	fLA==
X-Google-Smtp-Source: AGHT+IF0AWrzpBKoFsTV2PNBl7vuPnHh9cHi3SQCSyzlZ9pzI5xh1WywugZR8qjEZqehgHzWoMzT1svllfY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:eb8f:0:b0:611:3077:2de7 with SMTP id
 u137-20020a0deb8f000000b0061130772de7mr125945ywe.3.1712260872365; Thu, 04 Apr
 2024 13:01:12 -0700 (PDT)
Date: Thu, 04 Apr 2024 13:01:10 -0700
In-Reply-To: <DB9P250MB0692A99BBDC70A0E65B18A1FA53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com> <DB9P250MB0692A99BBDC70A0E65B18A1FA53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Message-ID: <owlysf00sxrt.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] docs: recommend using contrib/contacts/git-contacts
From: Linus Arver <linusa@google.com>
To: "Matthias =?utf-8?Q?A=C3=9Fhauer?=" <mha1993@live.de>, Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>, 
	Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>, 
	Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>, 
	Matthieu MOY <matthieu.moy@univ-lyon1.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> On Tue, 2 Apr 2024, Linus Arver via GitGitGadget wrote:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Although we've had this script since 4d06402b1b (contrib: add
>> git-contacts helper, 2013-07-21), we don't mention it in our
>> introductory docs. Do so now.
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>    docs: recommend using contrib/contacts/git-contacts
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2=
Flistx%2Freviewers-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/list=
x/reviewers-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1704
>>
>> Documentation/MyFirstContribution.txt | 3 +++
>> Documentation/SubmittingPatches       | 4 ++++
>> 2 files changed, 7 insertions(+)
>>
>> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFir=
stContribution.txt
>> index f06563e9817..eb1e27a82df 100644
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -1116,6 +1116,9 @@ $ git send-email --to=3Dtarget@example.com psuh/*.=
patch
>> NOTE: Check `git help send-email` for some other options which you may f=
ind
>> valuable, such as changing the Reply-to address or adding more CC and BC=
C lines.
>>
>> +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers yo=
u should
>> +include in the CC list.
>> +
>> NOTE: When you are sending a real patch, it will go to git@vger.kernel.o=
rg - but
>> please don't send your patchset from the tutorial to the real mailing li=
st! For
>> now, you can send it to yourself, to make sure you understand how it wil=
l look.
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingP=
atches
>> index e734a3f0f17..52d11ff510b 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -459,6 +459,10 @@ an explanation of changes between each iteration ca=
n be kept in
>> Git-notes and inserted automatically following the three-dash
>> line via `git format-patch --notes`.
>>
>> +[[suggested-reviewers]]
>> +Use `contrib/contacts/git-contacts` to get a list of reviewers you shou=
ld
>> +include in the CC list.
>> +
>
> There is already a paragraph about this in Documentation/SubmittingPatche=
s=20
> just a few paragraphs below.
>
>> Send your patch with "To:" set to the mailing list, with "cc:" listing
>> people who are involved in the area you are touching (the `git
>> contacts` command in `contrib/contacts/` can help to
>> identify them), to solicit comments and reviews.  Also, when you made
>> trial merges of your topic to `next` and `seen`, you may have noticed
>> work by others conflicting with your changes.  There is a good possibili=
ty
>> that these people may know the area you are touching well.
>
> Could we improve the existing paragraph instead of duplicating this=20
> information?

Ah, yes of course (somehow I missed that existing guidance). Will update.

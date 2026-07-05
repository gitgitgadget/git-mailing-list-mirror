Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2412279DB6
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783273149; cv=pass; b=ZalpAEuR80xlxP8nioFvRGOTrhhCwSk8vtJq1lzDAElXrAXk38p1vkk/AvciCgpub/PE+VmfuUNOFwAbz2LG52KVN6veJqTxbVbIh3liHiYcW30IN7LWkhKNPEmMQGiD3l9l1aHF9DDXJj5l2Oqh0AHCrHD6aJssIOZbwNkG4DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783273149; c=relaxed/simple;
	bh=bFipwSKg/9bUlRjBxPzaFr5kO6s72imuSNg+oR766P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zytf/sD2hQCBRX449EfNLOjOG+qbAO/cSIjdT9Tt+GMvfqTxTdi3taL4Ix4OxoTi8LpQsz5L0yxSgNEQI4JAIdEtblLeCp/ORqe35uO81UJUFIiMKrheJM1SO132BHgph0MemhkJCMjWFiC/9UBcJvDOtajPC6ot56cu1fyBUf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdQjsSap; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdQjsSap"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c81db32393so406075ad.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 10:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783273147; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhQH50Gjnb6+yp7YwH8RGYCKM5nJScrTxUtqN1QLVbkCIhz1HVdAzsPh6CMlyESV28
         OYC/yHbcAKZFoiKWmVtay1GgoAGR+BcAHXpG79LtW85VyJv8A2HVosQH/4EQYHfgylTf
         8do7yUHkiEkqJUuq4XTUCT4Ma4AV1TDjJmHt61Csy5sQS5jjaoDnAk8ojsD+JeYOGKhm
         jKqJtu8FUr+bxMbreznEV9yPTEnckyW2lR9dVpmwjG1uc4if+R7jW4DeRCBpOF8W/mEd
         hTflGEI32zrgqVdAHAtbSuPTCfV/p5NtQMOkavMFFM0f8iv8hqiNSP3O2tswcGDXLdPo
         31fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zreK96Ib2j+jkKg65mpNWY2+c+hHEUOKjkqdgLXEhE=;
        fh=NVnmcNRLLTczbQDcL8qJZqm6W3jeotjnCyMUSlXv6w8=;
        b=VMf6g64DCkSMdUFLWSMejpNJb6JN7LFFNzDDBEVwf2JF9IQPbKiCUddVjE0ZND/rm8
         CMMLq/+02HqZeG9E7m/0G2rJQMUFc6GHHsvby5k/9++2BI3vLiTpt2g0RHRgAaOxAfrC
         gISXqHEOz4ZtQ7uZeFAKfNLtv+rUS1Ni3kUlxBNQHCBbm4d9l+r0wZmQtTXjRmRLpQBs
         zNhteGEGleP36tCb2JTWzUJCVg8OY3Gp6Zv4f90YvrALu0GUoOqK37MR4ECj/+F588up
         44gn9I9Y75VU777Z0xpxpqsSEhVj/HIZW9Xi7sV3uJo9sQqXIoQH9IPBilFrh2lJFJcE
         cE1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783273147; x=1783877947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zreK96Ib2j+jkKg65mpNWY2+c+hHEUOKjkqdgLXEhE=;
        b=pdQjsSapOZh56WrgjTPwjvBWjqQ7+0pTPEtIsYP1Oy3EBBflQGtb9eQrb7CMctj3mF
         5n4TgSw9CkC9NM0/EfDl4zib+3uIDQYvHeyoX6J0DOaSsp9lwlYBORSJZnBXxChaInK/
         ZvLRUrmB8vq2Fq+OstM7Ywik57ohknVSsz9XBC27k/h5lS9Huy4NzyAJHftxI09GQB/W
         EsYgnC5GWWDESpskGAEcwmRC6f6c8W433wS2K8eIhW9Q3EC8W9FuqIzb9xrFsrN3K4F1
         GAWXe6R0H/odnFwxnq0VXXYgZu6z4vtVrIGPeecaTXjBRJFT2M/EB/PkTN2RZACHW+i5
         xrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783273147; x=1783877947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zreK96Ib2j+jkKg65mpNWY2+c+hHEUOKjkqdgLXEhE=;
        b=P2sRJTPHFDrDMyHmb4bECInqCLQcbdi5UW9FeNh4ghQbLyxVQXF8HIap6QdFkvtmjQ
         R7YqSZMSUv0dvuZd+6GGprHcJjkt/yGSqKHfTo7EKwI+YXe8BgroxclMP+6a2hkgIw+h
         cN/UREoDN4YpljfDAsYRY4VST3tfpyDnKBmBIZUFsglRPr10J96UaE7/qmliX0czchR7
         tT344dAfoExrMsqqByoz/eqCNCoSsNZQit09SWgUzvo54MjlvmzpMr6NiI6sRRiaVVQd
         ZdKDD+RLDaoPr/d7ahYwvOFTs6LUaiVWxXXxJBKln1OUX1nnYi6mxc32Gdko5SBxD5pa
         r0ew==
X-Forwarded-Encrypted: i=1; AHgh+RpY9qHHzAcb7RuMb7whgyXOv+/blFQDl1x3e5b5jw/oWIicBKmVtZkM3A7VL7AYeR7ht0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0QmsmPeXicIxdqFyqvyAd0FbVsMVSmiq87dI8aIjeyY1+GKc
	NysP6pOq/FYUXR0iCUINIw0YykoLl4SZUT4q5a5QPH9tfFCRNmUWahvWTHNcbmhSLQkVMA5Y366
	YbHGbwFq/VaVYg7WdV7jfHOA3H9arSkH2x89GuQH+
X-Gm-Gg: AfdE7cmIfW7TT/ddoxH3l2peJMhEHFPW9exMaP0ZRBOqU7noinGUgwGH8rfw5euZC+L
	c/bCapBFMQaJQ9qP5vH1SyiC0m0XtPV1Q/K1vkok9Qde04dAny4aHMlMw1UEalKbA9GI1KFYhO7
	OtrmjjTHreaYRRfDFuFviH+Ujo9Vz7lwFX/AooU9lEGX7ZgqjxTp27vh8kkn/5tFjjme5LSuFzj
	Xlebg3zgqgS6YDoMO1D70ZEqFBe3S7i3gkQanWkX3++12b5Z9od+XH3zu4GzJC+k/1bcOZPGykj
	kLxF/+aiUR/yVa/yGTI5sQqsfZ4GiA==
X-Received: by 2002:a17:902:f683:b0:2ca:e134:acc4 with SMTP id
 d9443c01a7336-2cb2b825218mr2594055ad.16.1783273146596; Sun, 05 Jul 2026
 10:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
 <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com> <xmqqpl12dqot.fsf@gitster.g>
In-Reply-To: <xmqqpl12dqot.fsf@gitster.g>
From: Shardul Natu <snatu@google.com>
Date: Sun, 5 Jul 2026 10:38:54 -0700
X-Gm-Features: AVVi8CeovhoLjOdUX9GmeraNow5r-xJUYOw3yNpRlii-meMDa5R-K9MdVST0XjQ
Message-ID: <CABaQWZe7vO7iWuQAosGP4masmTg4_RKA+bWCJsAfSiq+MsHDrw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Makefile: link osxkeychain helper against Rust
To: Junio C Hamano <gitster@pobox.com>
Cc: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This was addressing Patrick's comment, which was already done in v3;
> hopefully that is now settled?

Sorry, updated the description of the PR!

> It is a mystery what the third bullet point was ;-)

Remnant of thoughts! Removed!!

Thank you,
  Shardul

On Sat, Jul 4, 2026 at 9:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v2:
> >
> >  * Split the original combined commit into a two-patch series to separa=
te
> >    prerequisite bug fixes from Universal Binary features.
>
> This was addressing Patrick's comment, which was already done in v3;
> hopefully that is now settled?
>
> >  * Added $(call mkdir_p_parent_template) prior to invoking lipo to guar=
antee
> >    that parent target directories exist.
>
> Obviously correct ;-).
>
> >  *
> >
>
> It is a mystery what the third bullet point was ;-)
>
> The changes relative to v3 (which I looked at) look good now.
>
> Thanks.

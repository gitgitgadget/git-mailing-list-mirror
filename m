Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C033595C
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966223; cv=none; b=P7jCCZLcQvi/HGIRBSoPQfaHoh9t/GxwSqRJtsRBJrqbuCZxJ4mRCKJ+PJzxAejKaQZcqqitAZGkjJRljpveZHzkd/FqOgbydi4z0lenYv7PuGTxmT+gUP5emVu5v3ovhuO9eW1+LrFysPNUskEJikEjPc5DNe5q//U7z2L1lR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966223; c=relaxed/simple;
	bh=B4WSNN6fPpHTu64NxKYxJpmtcTj2IUPcsjstP1IUvFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyjPxe7zScsuc43oJUDeFgvX7DeGR/UYQtGJX3Xb4WAFvhnbLUKFfCj8j9Az8Leb1n5J2Jb8EnJ/CsSRTrpbFXyNmVsXEd9IZcuAiXVtY4CM+QPe9PEdMdcnFJTI9RImnMHXTVI8pMGaRrEFYbWDxss2PO2yLYtClcd+G4Qn8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUB/DSlB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUB/DSlB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adfb562266cso653333166b.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751966220; x=1752571020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm2NK17R6/+4FEs8zsm7myWR2la7gnbk030svY/Rs2Y=;
        b=PUB/DSlBFT29xTn3F9hNfhZv36D6w8vjYAAp84F9OO23/Y0cCVsmozwFyRRdXfKXpR
         AHWjyzI44cvS/t6RE7uixQr+GBvNqgTHLeussuKZRQpEkKj9tLNtttCwuKfjtaDi297P
         tKHmm0hdWIR4DBZCnhVrOsOPcxCR8QfeNVcQF8ktQArk0tp3dUa2Q7yNqm/wjIN2TFYO
         m9qpKM+KQJ+FwsqVG8Tqd1z3Xjg/ghdOh2PgncSPeHenYR3wRq4smeP9WAnPDJRKbLlw
         EkYr2xGZ2e9w/p2ZtCF4LRSc767Hs/Ce2WgeZlEtwFmrqqqajhvZuyLTWvPxSiAllD7l
         PWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966220; x=1752571020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm2NK17R6/+4FEs8zsm7myWR2la7gnbk030svY/Rs2Y=;
        b=IT9y3MOkHt4I4yrwI18bn0giP/AsDsoKMFYXr+80tORs7kSrL4wvQ1CWXtJd5Sesyl
         8ytxDsgOe30cgoPcXdsPE8e7Dsb8zKMpmug46S5+Gv+M3TvLLVDwkuDp4kxr7lVLoBy+
         LT3IW3HPIVBM/xueDgETdrijXphX2Rb1bXayEX+8J9rco1m/KShHpKG/OJ8VGx2+KSrW
         or8eRABCXArsHsTcUxMBn4mzlDgv/xBWTvtPR+5JUTN+/EK9Gswy8s8gGZcPxVne0tdR
         zmQXOnHgtVgeIyDRqdf+7eV3MJ2NN7DPeYmyemE/TCreEbgK/ZLfIsx0UYJCPGl/w5mE
         lIuw==
X-Forwarded-Encrypted: i=1; AJvYcCUMBWYn34FNDLf1lMn8szCUt7e7xvxgBLjuxf/SDSjKQ60jb66eifsirarcNbrbISs2FBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrY05t4M9ro+guRfbl2XFpnpHh5dnJlDgu8glOb9bvmSPSWZq
	O0NRT4CEQmCPrLueyrYQ3ayOWxbNhc4xqy2jqcqzjUp1BTUK55WCcoh9qrLteyY8CqsnxKou/0Z
	QXcThcibAdExtPkgB0prp3w546+CJ80Q=
X-Gm-Gg: ASbGncu9dgLSOWXzkbWf4f74QcwXU1tutWGDIlODA7jZTfG1au1/O4oGNvrwAb/Z2wC
	AqTsVQ2yWxR27DU2naLv2Kv+KRzo+AF8y9jKSPdlVFJyPVQG3rzauflDac4y04+DiceE4TPqrAO
	wDlNgUs98xfUXOFKgMFkQdhupw+hegkrvCGesHzAjTgI8Htyk63X7kgCXZu/RCWHPa0dO/3qmI4
	VL4cT5hUhivbQY=
X-Google-Smtp-Source: AGHT+IE6fctGcsMv9P/pJd/i2LgdlF/PSnSIw8Nw0+sIiWi7xK2Jrnv+1JiLbpGx6jMzhEK6e0PF5+IyjgN1My+TwD4=
X-Received: by 2002:a17:907:7f93:b0:ae3:5110:28a0 with SMTP id
 a640c23a62f3a-ae6b06e8bdbmr223274466b.44.1751966219433; Tue, 08 Jul 2025
 02:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <CABPp-BF6ZjfJ2MSHkhXQwv00=63qG3wLU8ie=_WVxnWTffFpRA@mail.gmail.com>
 <CAP8UFD24LayEi-=PREqbiyC7PeJbYEP1ghOZ+T-ma=DZVaPtSg@mail.gmail.com> <xmqqfrfu2pa1.fsf@gitster.g>
In-Reply-To: <xmqqfrfu2pa1.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 11:16:47 +0200
X-Gm-Features: Ac12FXx14l81EiQCWx3STr-c6PaHb_M0fbI_uXVo9zGdXzeF7pPe0vfh4GvjDAg
Message-ID: <CAP8UFD1M2UTnqpd5KG=GQfofUiJL3Z3ZvJBiTe2nZP4a2i68Ow@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 9:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> tldr; 2 brief requests.  Please
>
>  - Be gentle to people and expect that it is normal for them to be
>    off of the list for a few weeks (or even more), not able to give
>    a timely comments;
>
>  - Fully stand behind your own patch (unless it is an RFC), even if
>    some of the idea came from elsewhere.

Ok I will keep these in mind.

> >> Why would it need to say what type of signature it is?  Don't the
> >> ascii armor lines have e.g. "----BEGIN PGP SIGNATURE----" and "----END
> >> PGP SIGNATURE----" around it, which fast-import can read as well as
> >> fast-export?  Is the idea that we strip those lines and now need to
> >> replace the information we lost?
> >
> > In https://lore.kernel.org/git/aAq1nvcPRlIPal5l@tapette.crustytoothpast=
e.net/
> > brian said:
> >
> > "These should be separate fields: one for the hash algorithm and one fo=
r
> > the protocol.  Alternatively, we can just keep the hash algorithm field
> > and parse the protocol by reading the first line, which will differ for
> > different protocols."
> >
> > It would have been nice if you had then said that you prefer not to
> > have the protocol.
>
> Let's remember to be gentle for those who give varluable feedbacks
> but may not be always on this list.  A late comment on a topic that
> has not hit 'next' is much better than a late comment after the
> topic hits 'next', or no comment at all.

I agree that the comment was valuable, sorry if it appeared otherwise.

> Also, even if the idea came from somebody else, if you agreed to the
> idea and made it part of your submission, then it would be better to
> explain it in your own words, in the most appropriate way to answer
> the question asked (e.g. the original from Brian and the question by
> Elijah may have stress on different aspect of the problem).
>
> > My opinion was that it was better for tools processing fast-export
> > output to have the protocol as they have to parse the "gppsig ..."
> > line anyway. So it should be easier for them than to parse the ascii
> > armor lines.
>
> And if you do not agree with Brian's, perhaps discuss a bit more to
> (1) either convince yourself that Brian's idea is better and rewrite
> your code to adopt the idea, or (2) explain the reason why your "the
> importer reads and parses anyway" is better design and stick to it.

I actually agreed with brian about "These should be separate fields:
one for the hash algorithm and one for the protocol." Anyway it seems
that we all agree now on this.

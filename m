Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A419580B
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151967; cv=none; b=KDpAC6WGOtetOdaUmXkitgFU6A0XAxe9CoqIbIMDErY2bOkpsVyekl/Znhq8g9oOw/ODAg2qahyHToahT6U1FjslMJmX5OaItW3MB1M2d5NjIEYmStl0sGuyEYN+4D4G6K/TBdksF0RVUKIr72/3GNASkjsoSKXTtx0N4OmxpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151967; c=relaxed/simple;
	bh=rW1sMAgRHpw8JvZ9iP6uu0kljQejZGBucfpcqXBwYL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaLFfEqL2UJTPNd2mqV6Csd44arqAwkfR2M9WcjI7bSgdMOTIdzcMFloB86ky25w++RVy2JCVheLC2/7OHa6tfS6boIV7c9Y7uuG4AFws9S9pz2RvaKXNiYi7UaF+WyDVCiWcOKOEQYfolngT9+17ucah/d5v0wCIITwlViJnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrqFJsre; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrqFJsre"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso860788a12.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744151963; x=1744756763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o5o1hv9pB9DYwe6RD1CGw9hpNaf79CqZC7SllpiX8E=;
        b=NrqFJsreSLt0eZnQ4OEoJVR99W/Yr8iiKXWrO+r8Ij7Re7YG31wclHxpScii0OEk/v
         XMFUEMdfsCR4/0HyykUoe1VW6ykA2xcfv8fvvIz/qAnlxI7QZE+p4vMz4WDdP4p1B2Pu
         onNRAOndc532RtYJf1ZOj0lMcVvLg8iGs5gDA6+UC69Ux3iUb684XIu06Ithto+eTWYn
         oQNWrp846otcRxrxKcxuP9nc9qN2dz1lzayJmR8D6Gtne+vOdx075dKkeNCpg+IxCUjo
         0Nm21dITW2N2SOLQPhviRzv5OBOZZtJV4y3XnmbZj/2M/rSS9LSACXTkmSxBPQ8Ofx2G
         BtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744151963; x=1744756763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o5o1hv9pB9DYwe6RD1CGw9hpNaf79CqZC7SllpiX8E=;
        b=xRZSpBE80DcOMhchuEYEkopPEWK7i18umsbnPLZlwETJCJ5Kl2/f6iGz4sdePKoi2B
         0pFSpJ/Bid52ycT+PzzlAAfEd4ZNxcM6Y/tErDscg24tvxEPL7e0xn5OEsIOR4NHifZP
         iwuEtF/yOA6pmbrsT4wbzuEB1XH2YJEHLDVp+sLizAFh2HYcH0XFF7uvkH6T0M0dxbKB
         7vZ0cY019axNxwHz1Tw7aTetuQmeCUwABoZ/r8iIFoqbDvhuilBvGLnwos6pKr+AKExH
         q/N6Fp4qYvoi1YW2Neg5JlY4TRIOUCwgxVd1+RlAqolk54uW8jgAm1Ni7Wawl13RaTcg
         NoxQ==
X-Gm-Message-State: AOJu0YwEoogoYR3NQRIN11rHaBF6OyfjQRkBrOuILNrMgN71sqpiPjeQ
	xI3IAboItwAVtkIhb8dbQYkEko4cyLanYKDBVWm5Ugns36UnxUXVPr4n4FnFClRHlXgdgs0vAKw
	85YFwnWhlpwvJ9MZR+wIQo36rGOQsi22W
X-Gm-Gg: ASbGncvL+jsTx/mcc1Y6vPnuOdJd35vKhU/Zaf1uHC9l8AbDnpGGCV+AmzPePhJeg9D
	uu8bvbxbtpZTgrELLLufroQcKxxAlbYa3235pAodwRmbGDyfeeMOldnNU4z2ZCnmDRUyYiQO/cH
	vFupldQ6OBnV882R63+hzQL52yfq1iVhMiQOLEf72yEQ6r5uf3FWTAXc8r6fBD/YZWuQ3ssMY=
X-Google-Smtp-Source: AGHT+IGr2JLfJG/bIveAJY6kMDFsf8/EJjh2EZU9gGjLl4Q2GlwlSWM/OK54dUizpuOrAp3m6L6N/3hLe45qCX/zqyc=
X-Received: by 2002:a05:6402:2756:b0:5ed:6535:b6d2 with SMTP id
 4fb4d7f45d1cf-5f2f8657f76mr263088a12.15.1744151963002; Tue, 08 Apr 2025
 15:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqiknwhsdz.fsf@gitster.g> <CALnO6CCcE0zyqUtFOkBZetj9HCzg_mmnWq=+gOEaRn9Np32UKQ@mail.gmail.com>
In-Reply-To: <CALnO6CCcE0zyqUtFOkBZetj9HCzg_mmnWq=+gOEaRn9Np32UKQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 8 Apr 2025 18:39:12 -0400
X-Gm-Features: ATxdqUH9JBPVn7Ry5j-cYpHglj9HKRQyDXm7M0k9uCmwyoeO7tTzLa-THFC4Vts
Message-ID: <CALnO6CAzCANvC_BGYNV7a704Tmar8XyqE+0L_HEyDr1WYKo1Xg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2025, #07; Wed, 26)
To: Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 8:34=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Wed, Mar 26, 2025 at 8:46=E2=80=AFAM Junio C Hamano <gitster@pobox.com=
> wrote:
> > * ib/diff-S-G-with-longhand (2025-02-12) 10 commits
> >  - diff: docs: Use --patch-{grep,modifies} over -G/-S
> >  - diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
> >  - diff: test: Use --patch-{grep,modifies} over -G/-S
> >  - completion: Support --patch-{grep,modifies}
> >  - diff: --patch-{grep,modifies} arg names for -G and -S
> >  - docs: gitdiffcore: -G and -S: Use regex/string placeholders
> >  - diff: short help: Add -G and --pickaxe-grep
> >  - diff: short help: Correct -S description
> >  - diff: -G description: Correct copy/paste error
> >  - t/t4209-log-pickaxe: Naming typo: -G takes a regex
> >
> >  The commands in the "diff" family learned longhands for "-S" and
> >  "-G" options.
> >
> >  The core part looked mostly good.
> >  source: <20250212032657.1807939-1-illia.bobyr@gmail.com>
>
> I'd be interested in seeing this land. I think I can read through
> review comments
> and split the cleanups from the addition of long-form options (both of wh=
ich I
> think are generally improvements), but without signoffs in the original c=
ommits
> I feel like I might be overstepping on the intellectual property---and I
> certainly wouldn't want to cause licensing trouble for Git.
>
> What's the usual way to proceed in a case like this?
>
> PS enjoy the vacation Junio---I'm hoping someone else will reply so that =
you
> don't need to :)
>
> Cheers,
> Ben

Looks like maybe my query got dropped during the vacation time: I saw
the newest "What's cooking" said "Expecting a reroll"=E2=80=94did I miss an
update in the original thread?

--=20
D. Ben Knoble

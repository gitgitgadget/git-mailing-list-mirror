Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9B1F561B
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780360; cv=none; b=oGb0DfG2tMNNw28/z5BItdNsmcoMJbYfD/CUGCPpL4O4ZVs7j/ZstZvjdNIerFz3OrEL7igBkouXMsz4pIQcfFLTt79q7zYz7UjTNyiukIYPiHglVVfGu+SHpqQ+IN9yPsvHFbVnwDaCB8QdeQl0mADrfNL07kxO/rRfa3c6FNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780360; c=relaxed/simple;
	bh=eZrY49ehuqntnOhnPGmbzGLcQ5BhkCcSVm9LZuStCu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIDvsx9gAm1hNSoyUEpYsFTV7OJQ7cmrAcrfSd6W2JjNXbRT1NgwDlan63Kte5DeftTnEA12Mkro37+QB+XyT3PSJ3Ao3GgJA+GbHVNEYRoR5UkiI7l4dXaQIfWMKp1e8oIY+/9e58omTirkPHa98iZzBSjRXZF0DAPRkYuHDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHhpMAEl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHhpMAEl"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so2038759e87.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743780356; x=1744385156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yrlAKPI9I8iD5js62Cm6dKPtpy6iYnvTRmLGZF7rLc=;
        b=eHhpMAElAy//1X9X9yF1smcswdMKMOhWMF+cEIM/YSEMYhl2sE3G9gQbjCkL1tAFTX
         DL0oMvct8TZUtR8RH8wQPblC2c0JGQQ+J94LuhHqPTtW64UjNAr1SnEXv9SvhNObzto5
         CV6iV5ZWXMc4SH+4nSKIARftS2qZi/hTItC58k3unTtDlYFM/cxJQ+hcvzuqaLahrsn1
         Hk7ZZCVriM8jLDnjkfZG8Ciu0rLA0GtDQUT7J9Sx8cKhwNevecHEyCEAKyk0S2gZ5U90
         DoHOoZPPY1/78UGnyPcQXez/ythBH/JVPBi/u7r6Lwd2syWXes/IvgRYfr2EjOIG9TIy
         28kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743780356; x=1744385156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yrlAKPI9I8iD5js62Cm6dKPtpy6iYnvTRmLGZF7rLc=;
        b=vfW6GgMPV7GvaPPnlsBhezOMZT+9SS9kZknih7DyCiIRFMqzN1GNjGcKIhpZY5imIm
         3DPN9kj8c5ll1KW3M03MMR4iy9s+go3zrPm/Y6QzYJqlvIoaPQZDjT/q9E6EKR/vNEgv
         GGk7dFxJK4D5ELtRkBTRz/OFUV+k/o31bm2zSHgKYMUFACdQEIFiPAhS3yLNojSb+6Be
         3OgpwSvQHeZSY06BOeBwsAGch7a91H335jSoDEQR+IpObp9ZTVJ/IAcu3fDocR86GxWI
         oJUZnNppuqNkDxa36jZl7zWEnqBQSlgBen+axIJcsgUxDWNauutPlwLxzYWh5muNGbVb
         xIHw==
X-Gm-Message-State: AOJu0YxKGubOcjOv8qmmxqPupCH2szvh01UgK5GdZ3+7FbKicqKzsTQW
	GzTqy9Hp3+Umz5/wjFe1FtCN7t9tF2Y64hJhjObsFkXsjs6V7d7aGMw67/rWNU9v+JflraF+Eaa
	5ejL7DtCYyY7cQw/EmHN079P3dJM=
X-Gm-Gg: ASbGnct4m0hjyguNUF9oHYtjEUj9IThc9EdotjvcDlgl2ix4mJJTlpHHHP4sZ5iUr0x
	JMIODrNHIzPcoSHWKaCaKkyvhqM8u9J2AkuLwGY1/163tOjeV9TVTGmddron1hGU+sIhjn6KJG3
	ja+0QK22hzI3yt+FY/mPfpqkdfyg3r8k9GRKsbEx637vRMRIsr8RXZnSaNKvfL
X-Google-Smtp-Source: AGHT+IFsRQKyhg1kIvTywXLSuHfqADC6QGRTDgEH1QnBYqPD5W3TsWaajY/rBCr0nHJmV4ZiZJsTL/M4ILIGEHXMk5w=
X-Received: by 2002:a05:651c:1545:b0:30d:b49d:7fb7 with SMTP id
 38308e7fff4ca-30f0a124f63mr15013331fa.16.1743780356275; Fri, 04 Apr 2025
 08:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329150248.2274482-1-05ZYT30@gmail.com> <20250403154404.3459805-1-05ZYT30@gmail.com>
 <CAOLa=ZTTPuNyaE5Z-bfkQougmKQSrRZZwLaxJUL7mdmj8uHoFw@mail.gmail.com>
In-Reply-To: <CAOLa=ZTTPuNyaE5Z-bfkQougmKQSrRZZwLaxJUL7mdmj8uHoFw@mail.gmail.com>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Fri, 4 Apr 2025 23:25:45 +0800
X-Gm-Features: ATxdqUEJNOxw1BUHixLrRm7mjSRRFLDf4NGf7soLvCt-sRPyPBRxKomahuuxaHE
Message-ID: <CAMvj1+paWq5LV1imUz0HcQh1eoGvdfkYi0B5FPV33Xt-OUe1Dg@mail.gmail.com>
Subject: Re: Discussion on git-refs list Implementation and Possible Approaches
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply!

> I would categorize '--sort' into a third subcategory. Filtering refers
> to possible change in the size of the sample set. While sorting is more
> of a presentation utility.
>

That=E2=80=99s a good idea, it makes my plan more clear. I will separate
the =E2=80=9C--filter=E2=80=9D options into =E2=80=9C--filter=E2=80=9D and =
=E2=80=9C--sort=E2=80=9D so that users can clearly
distinguish them.

> This is indeed a special case which applies to both sorting and
> filtering.

Understood!

>
> You mean complex from the user perspective of having too many options or
> from the implementation perspective.
>
> I think from the UX perspective, it is a good time to rethink usage and
> need for the options you mentioned above. , for e.g. with '--format', do
> we need to have '--tcl', `--shell` and `--perl`?
>

I think it=E2=80=99s important to discuss all available options, and I will
submit another
email for further discussion.


> > 2. The performance could be worse than `git-for-each-ref`.
> >
>
> Why would it be worse? The performance difference between
> `git-for-each-ref(1)` and `git-show-ref(1)` stem from the formats they
> use by default.
>
> $ hyperfine --shell=3Dnone --warmup=3D3 "git for-each-ref" "git show-ref"
> Benchmark 1: git for-each-ref
>   Time (mean =C2=B1 =CF=83):       4.0 ms =C2=B1   0.6 ms    [User: 1.9 m=
s, System: 1.9 ms]
>   Range (min =E2=80=A6 max):     3.0 ms =E2=80=A6   5.7 ms    680 runs
>
> Benchmark 2: git show-ref
>   Time (mean =C2=B1 =CF=83):       2.9 ms =C2=B1   0.4 ms    [User: 1.2 m=
s, System: 1.5 ms]
>   Range (min =E2=80=A6 max):     2.0 ms =E2=80=A6   4.3 ms    909 runs
>
> Summary
>   git show-ref ran
>     1.38 =C2=B1 0.28 times faster than git for-each-ref
>
> What I found interesting was that changing the format for
> 'git-for-each-ref(1)' gives it a boost:
>
> $ hyperfine --shell=3Dnone --warmup=3D3 'git for-each-ref
> --format=3D"%(objectname) %(refname)"' "git show-ref"
> Benchmark 1: git for-each-ref --format=3D"%(objectname) %(refname)"
>   Time (mean =C2=B1 =CF=83):       2.4 ms =C2=B1   0.3 ms    [User: 1.1 m=
s, System: 1.1 ms]
>   Range (min =E2=80=A6 max):     1.7 ms =E2=80=A6   3.6 ms    1070 runs
>
> Benchmark 2: git show-ref
>   Time (mean =C2=B1 =CF=83):       2.9 ms =C2=B1   0.4 ms    [User: 1.2 m=
s, System: 1.5 ms]
>   Range (min =E2=80=A6 max):     2.0 ms =E2=80=A6   4.5 ms    833 runs
>
> Summary
>   git for-each-ref --format=3D"%(objectname) %(refname)" ran
>     1.20 =C2=B1 0.23 times faster than git show-ref
>

Thank you for the reminder. Once each option is implemented, I will test it=
s
performance to ensure that it maintains=E2=80=94or improves upon=E2=80=94th=
e efficiency
of the previous version.

>
> And what is the expectation that when you want to do both filtering and
> formatting, would the user be expected to do `git refs filter | git refs
> show`? Generally users want to combine both of these options.
>
> Also wasn't the idea to already implement `git-refs show` as a
> standalone which simply shows what value a reference holds (without
> derefence)?
>
> While I would think Approach 1 is the better option here, I'm also
> seeing how it is complex, perhaps a good option to get started would be
> to implement a simpler subcommand as a first case? Perhaps the
> originally discussed `git refs show`?

I agree that implementing `git-refs show` first would provide a solid found=
ation
for other options. I will add these improvements in the next version
of the proposal.

Thanks!
Zheng Yuting

Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B915433DE
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153974; cv=none; b=DsXeFRTflSbd5r29ormvnnVK3HrluX1ufBWh1f8buxxWSkL9psU1FM9iyTcCDKSFY3wRlMQTTPBqZNzFHvOPqPwfX6UVjQInm5QAKch65ZS+P2TzA4vpZeffN5nQ//XDhDoU70daxie0PHsVh6jKCfAAH5r9ZyJ0dU5I5P7cuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153974; c=relaxed/simple;
	bh=d55X1DfB7v/TUJpFa5rRTY78p2OmJZRzrx28SJRLH0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC2IeBdcBovTfFpub4rW0wnxEj2/VMUgXOhlPnDstuLUK9pO/Fsvlmd0ETsHaT4j4tIGlKQPQtEoLTGC3VK51oRzVM4/sCjrrZR3uAvfY7HekCbPPnVCGPel7a8pPp363uC6ROF8rBzMjvKDSpXsk2EijXwVrCYv9Qg59ZitMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ff9W6LJK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ff9W6LJK"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-472098e6e75so300781cf.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740153972; x=1740758772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl6O0W0MVy8NErFOAUdnwXE37UtfmuR7p13sFMk+msI=;
        b=Ff9W6LJKKmAlwNg1+ZC2ltpLahcU2Dvb1k6Z4EHqzY2Fj1g0+8RC7seKY7vRXMUUbK
         g/XrhXkxHyWCbC3azvUoNvHVabibdYA5qWbm8RL1nTfQEThJ0BoUrPENJq0AOpV2gaOk
         rw1OE4AIjn7aSy8B5ySSWioElTXRt/F7EU7FobOtFIIGA+Ftodl+N90+RrlaadL5opcA
         N28YVBzFmmDumtWTCuKiD3Yl4rNW5iP7XUen6iNtXH6HsZL8YquGlQM43o/VFzzxVH0q
         xxpgmclz/BaQqTvhuqmc7KESlDIFJAMsZmqZdmqfXHj6ONRNG5oc+C1l7/eYCusS31TE
         n6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153972; x=1740758772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl6O0W0MVy8NErFOAUdnwXE37UtfmuR7p13sFMk+msI=;
        b=hWpvdzKWZgLSAOcO0cl1yOwBIjJAsIxu6g9SI/1A32RtF07vuGwiCYWEvX8BNbFr42
         NKN4kkhda4xCfCscqNp0va1IL5iy6adSGkaDdwIkjodjzDTBActC6eeG+JnG14LDwmu6
         c9M1YpqGmquvcsYiIziUJTq/MnFgATk9JnBy4gBcphpJJVD1xcPBdp+llQ7BVdn+BU/l
         yKYtdCAlknb/P63+oW8m6AulmSFG9UVuCOT4M1xem5Llq4cP+0WpSmRZInNRFKZ/sfQI
         avVzsYJ/Ik+7inbv+ojdLp7ZvlVMHnABe0S695rYFNgiwHuFl3YtyxQKxiPwSwWXChLk
         7BCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVczRPmsEefhhXUsVWyATzH8NG64/GZXMNKBY9uQw5/ccaMDMgt+udxhxbUjo6mVgR13kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIorTz4CsbemlLc7M1Ojm2wamSAtvoyVUnrw8AfmkFhHebz+x
	39G3+pMI7PTSiqF/IKFuq2Pyk0WYMaYtsWs+YJs/COWbW1heT6HBkOQe9xfo91ksAiAEOZTdAF2
	AjjMyicgShzZfKjGi3G28gLggchcXbGgsI9xm
X-Gm-Gg: ASbGncu3M0xdUJ4bc2m0r3x8n2cR/oYzDbDsUIUrGWUZb+CHqotCsNi/HFG71zHdeDD
	H8Gg398vcL+9fSQLzZTmQU1JYB8H8Gi7dXt4mILGYqa4xa+draK7fN2iglwdheI1xyMTaH5kicv
	Cb5GhdMw38Ni6l12WsLP6AzM0m7701eQ/+9MJ9KQ==
X-Google-Smtp-Source: AGHT+IG6o1vbJC+aQhihNYxTaG5UoR116oEoyhGi3q20MIeT9VOquoE8TPHPkmfbrUzb6j+kqXeflRCFJIts9t8XTqE=
X-Received: by 2002:a05:622a:609:b0:471:ead2:1171 with SMTP id
 d75a77b69052e-472250fae22mr3044281cf.27.1740153971633; Fri, 21 Feb 2025
 08:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOW_YOkX8K=7i7w9c5oH5Cfia0kCzwC3=ok5E=eUwYgpcOKTRQ@mail.gmail.com>
 <Z7fGQalzCg_Fx-ub@tapette.crustytoothpaste.net> <20250221-intrepid-furry-wapiti-eebff0@lemur>
In-Reply-To: <20250221-intrepid-furry-wapiti-eebff0@lemur>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 21 Feb 2025 08:05:59 -0800
X-Gm-Features: AWEUYZlqsvctl5zBNHJG3Z-VMVbYzrJGAATlwvud8tac1K_A27mJSwpQOBDeiFU
Message-ID: <CAJoAoZmsLu8DukvMugU6z6C=gKFP=dwDhZAT=_jE6h+dO9V55A@mail.gmail.com>
Subject: Re: Deleting first commits; maintaining last commits
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jamenson Espindula <jafesp@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:18=E2=80=AFAM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Fri, Feb 21, 2025 at 12:18:09AM +0000, brian m. carlson wrote:
> > > My Git repository on GitHub <https://github.com/espindula/br-blfs> ha=
s
> > > about 23,500 commits. However, there are several old (before Feb, 28
> > > 2022) commits I would like to delete and maintain the newer ones
> > > (after Feb, 28 2022). So, Is there any Git command (or combined
> > > commands) I could use?
> >
> > No, Git doesn't offer such a thing.  Due to the use of cryptographic
> > hashes used, it would be impossible to verify the integrity of the
> > repository if it could just be truncated like that.  In addition, the
> > goal of Git as a version control system is to track history, not to
> > destroy it.
> >
> > However, if the concern is size and not something else (like removing
> > personal information), then you could use a shallow clone to just
> > download a certain number of revisions and work on that.  The full
> > history would remain on the server, and you could still push newer
> > changes, but the size on your local machine would be smaller.  If you
> > need more history, you could use a partial clone instead if you're
> > willing to be online to work.
>
> Another approach is to create a new repository and use a graft/replacemen=
t
> commit to indicate that history continues in a different repository, righ=
t? I
> do sometimes wish this was a bit easier/more accessible to perform, becau=
se
> that would allow creating "epochs" for very large repos. Unfortunately,
> shallow clones tend to be very heavy on the server-side.

For hosts which support it - which I believe includes GitHub - partial
clone is generally easier on the server and a little bit less
bug-prone than shallow clone.

>
> -K
>

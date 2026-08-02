Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C18242D6C
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785709224; cv=pass; b=tE6XkgrBtSHBqmXLrRo7T0CB6a5/eLOP5gq8ucoTmURIlki43Ns3eeLWSbh4iSaIbzsWkIE6qV4t8+cqDvr8lndB96jzXMir+Y5Hr/ityAFNiELU2m+N06pAhAXMvuh7k86BMlzNuqKYdH3+HS0x9DAZc46Xd0hQ6sXp4zCzM/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785709224; c=relaxed/simple;
	bh=BxE1nz+R6RMaEHB92+iUtzPq38urHZsvtYNiMGTdflo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HEgEx33aRCyhwGfwWlwAR8NTbHPUkCaBifBnBdCi/SOEkdF4lopJD1HtwLsVTdl8j5r3rf/EosVG9aQCl5ZgRe6EOzov1k1uC4qEilN1Shvch4IojlXuUAn+9u3R0VK20/y85qHVdf4CvoaArwEpynbGTEsVuXwTxZEY0u1KUkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=effectiveailabs.com; spf=pass smtp.mailfrom=effectiveailabs.com; dkim=pass (2048-bit key) header.d=effectiveailabs.com header.i=@effectiveailabs.com header.b=XtB8LWDT; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=effectiveailabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=effectiveailabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=effectiveailabs.com header.i=@effectiveailabs.com header.b="XtB8LWDT"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-668c1b780e5so4273757d50.2
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 15:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785709222; cv=none;
        d=google.com; s=arc-20260327;
        b=DOypBJN7NiBKRrWAOynkqBaC/INmHPT8G6rMQJ/g6bJK+NL0oYgHZ9Iu+h1a3flXoo
         35WoiXnXYoojfbpzgrfEeAbU/84PlPkGTtaDwelhVDB/ZdmKdw6MAWZCrD2bCtslrV76
         GMubq/8bUo7ELE7YpE1WQqsg0yGDLGbenAUfdw0fxyha6ExdJNb1iNSC3m+IgcmrPBj+
         nynw8LxSaEYIfO0nPlhBzkUntjsavCAM2KxyH2jSrmM9cIfwOeM31ObW88XXJesE8lSh
         XsveLUuiirqpse824RsLsoEBu3N9LQtkwE55gP9Db9BJ0PbzZZZG/2LW3J00Vp8+bul+
         XzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SDfbedrpwRQ4+H8RQiJpjRUzM3NdFsEUNeB945/bz3I=;
        fh=z97DsKCKjkYjfuus9w8mjXn42K+tSoyuOhQYFex4yiE=;
        b=hF84CRnrmdXSZOOg03KRiDv0i0sbbR6fXgOZLVDtN7zVTJjAutnkjJMn7TcGMcvWpH
         yjCjT6xgxChW9XKDdGCElfVfDFBCFxbWVpX9HMLy8RdIgY5u/EwkIfj7QduSOYhsXHQf
         6S6BfRr/8pwH67RbyKFKJUh95wg10gVdMMpjkyftDL0GsZfPLs8k9G5KyuHYjkzerS1k
         iZcDNj5qMNOxEAhL7lPMzDYcEeU3YCMXEdkTpJoE8vMw4EEzd84VnhuxGrNrinsEEkIT
         pXd5cDJ7eFdmV9A2EtTDkbyRBAoSgTpEpVnEKifytIjeeP36DF5f56udFJl6UfURVevu
         lIHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=effectiveailabs.com; s=google; t=1785709222; x=1786314022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDfbedrpwRQ4+H8RQiJpjRUzM3NdFsEUNeB945/bz3I=;
        b=XtB8LWDTnVryeM6/nSXt+wSiwJSg895d5YWE4ALAEoHsqG9DE0Q30+pM3A8aCAb5v+
         uZx7tCkBlk+9tdy/2ZHonqzeODC6YcDn8Gzm1C4ZJ/KOflBgbOeNPPA5sexg40glWCJe
         hL4bPLxWqNnBTSC/3fNKM2ms2Q/qHOZMSNMo7oByfuBmux7DhefxI6Yly7mjQosbnTzu
         yKPW+VdJzca8tvQvf+FaF13gWmbrAVCNSFiCkjFTx9WfVfQyTGoZmmb7pWTtECJcCVs4
         duVq6fH4iHcTq3LW3yUKwqJ22kkRBBvyodu4r64+b8ShtRApEycdA/ve/dJNPuR2mcMF
         5rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785709222; x=1786314022;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDfbedrpwRQ4+H8RQiJpjRUzM3NdFsEUNeB945/bz3I=;
        b=N8BDsx00bEFy4Ao+XyOWXjzuWtd8AwbGORDTv8l8pfNsgDlaZ4LFUDO5IkEz/Kh+oE
         WucVRuqYpL1IGbBYP96NdQVCPm3mnXQGOB/DD5eBTnfkZT1yLkRQlR2orx+T27S/3CVB
         SWA2exQzlszoBCe+ICPwqnwIeXxcbX2bzfRvTAzCGv/Ru0RJ1lnidg1Lacjnp3hVUfMs
         USMWEc+UiRGSF7MnWGdkQwIMnGe+VzKyPizZDNpC88dfHvV5Oi72qy+5XicX/DHH1G55
         8KAy8Ve5TEmPpQcD4nduxij/4d84Wh6Jzw4c50Jlpx7gP7Du8w6vgtyFeCvpD7WJZocs
         na2A==
X-Forwarded-Encrypted: i=1; AHgh+RrxDgORiaS6QIWj94UIddBSyRVTVtAmDW0AxASduoSrbAu3wHu2dr3S2YmDqJUXlcHBgEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPw6dhagT3Dj8eyMAVqsm8Uo5clK3NV7z3ZTINOfNMPGTYq1NM
	Rk8y5FOzTbdkMqyRsGq6rGsPttc6szvKuRWVCzEPowSQh4Y6aX84toVSFUhU9Q5csFom3UEXQ/T
	hH0pr/qY9u7spFLrB/ilq8Cqy9/aR6CIQzQxRa7fTjk0=
X-Gm-Gg: AR+sD12F1ZVRK/XQFh08ebpVMOtmKFsut/MXtq5MeXQkbT5mPmk9JvEwutBVO0nd5E5
	+LSwoF3LXuEEw4cfave8vlRkzvjsNxLIdH2TyX5qzDQiR/XGLBYGhUeWUxmUjDFVwTvHnSiifr0
	3zA7bV6UupYjdKk7CeuG84jgj7nRXBhUAX7oMWyURkowURiUyrahuiopev9fmoqTRvLEjfHVeCO
	5GrzObRYMleqXCaRRbV1wd40Gh9G/7E43NKSnYiTBbe8pBn8KYURcp5wrM4UWPxy+JMyL6BNIzF
	AgXAcTpa6CB5S67QJ/lpBZzIOnYrTXoRvG0nnr+dF15bJgLYqunNPwpfbfsaPYUixxbqdADdMSF
	+T9aWtxoxOXm+EweWGkXvzRllZvlInXbYjA==
X-Received: by 2002:a05:690e:4845:b0:668:1c09:aef1 with SMTP id
 956f58d0204a3-6694efdbd6cmr7597129d50.6.1785709222132; Sun, 02 Aug 2026
 15:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com> <am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
In-Reply-To: <am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
From: Arijit Banerjee <arijit@effectiveailabs.com>
Date: Sun, 2 Aug 2026 15:20:10 -0700
X-Gm-Features: AUfX_mzZNbPzZ9G3NYHwSiKTazffNRU6LJTPDXx74IhC-cop4J_PvsKM60D8AX4
Message-ID: <CAFwoC-5R7VLHzXQ1WY5fMe6Od--VcP0FzR-AQHk2OEt6WVLSEg@mail.gmail.com>
Subject: Re: [PATCH] index-pack: speed up promisor link recording
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Arijit Banerjee <arijit91@gmail.com>, 
	Arijit Banerjee <arijit@effectiveailabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026, brian m. carlson wrote:
> This doesn't look like it's a trivial change, so I don't believe this
> patch can be accepted.

Thanks, Brian. I am not trying to bypass the project's policy.

I do not claim to be an expert on this topic, but Codex appears to have
found a material performance improvement of about 15% on end-to-end
blobless clone times. Would it be appropriate to treat the current
submission as an RFC for maintainers before deciding if the optimization is
worth getting in? It seems worth trying to preserve the technical
result.

Thanks,
Arijit


On Sun, Aug 2, 2026 at 2:52=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-08-02 at 21:33:15, Arijit Banerjee via GitGitGadget wrote:
> > From: Arijit Banerjee <arijit@effectiveailabs.com>
> >
> > When indexing a promisor pack, index-pack parses every reconstructed
> > non-blob object into the shared object model to record its outgoing lin=
ks.
> > Since parse_object_buffer() runs under read_mutex, worker threads seria=
lize
> > while allocating persistent tree, commit, and tag structures that are o=
nly
> > needed to enumerate those links.
> >
> > Read the links directly from the reconstructed object buffers instead. =
Keep
> > the strict and fsck paths unchanged, use worker-local typed oidmaps dur=
ing
> > normal promisor indexing, and merge them after the workers exit. Transf=
er
> > entries during the merge so that it does not temporarily duplicate the
> > complete link set.
> >
> > The typed entries preserve checks previously performed as a side effect=
 of
> > object parsing. Reject malformed commit and tag headers, conflicting
> > expected types, and targets whose actual type disagrees when the target=
 is
> > present in the pack. Preserve commit-graft handling and the existing po=
licy
> > of recording only subtree entries from trees.
> >
> > With three runs per version on Debian 12, median end-to-end wall-clock =
time
> > for a --filter=3Dblob:none clone of linux.git decreased from 156 second=
s to
> > 133 seconds (15%). Trace2 attributed the change to the initial index-pa=
ck
> > --promisor phase, whose median duration decreased from 121 seconds to 9=
8
> > seconds (19%). System CPU time decreased by 46%.
> >
> > Two paired spot checks against GitHub showed end-to-end reductions of 1=
8%
> > and 26%. These measurements include network and server variability and =
are
> > therefore corroborating rather than controlled results. A third pair wa=
s not
> > interpretable because the baseline request encountered a transport stal=
l.
> >
> > A full-clone control showed no material change, taking approximately 25=
6
> > seconds with either version. This is expected because full clones do no=
t
> > exercise promisor-link recording.
> >
> > t5302-pack-index.sh passed with both SHA-1 and SHA-256, while
> > t0410-partial-clone.sh and t5616-partial-clone.sh also passed. New cove=
rage
> > checks malformed commit headers, conflicting link types, and mismatched=
 tag
> > target types.
> >
> > Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
> > ---
> >     index-pack: speed up promisor link recording
> >
> >     AI assistance: OpenAI Codex was used to identify the bottleneck and
> >     assist with the implementation, testing, and benchmark analysis. I
> >     reviewed the resulting change and take responsibility for this
> >     submission.
>
> I don't think SubmittingPatches really allows more than trivial changes
> written by AI:
>
>     The Developer's Certificate of Origin requires contributors to certif=
y
>     that they know the origin of their contributions to the project and
>     that they have the right to submit it under the project's license.
>     It's not yet clear that this can be legally satisfied when submitting
>     significant amount of content that has been generated by AI tools.
>
>     [...]
>
>     To avoid these issues, we will reject anything that looks AI
>     generated, that sounds overly formal or bloated, that looks like AI
>     slop, that looks good on the surface but makes no sense, or that
>     senders don=E2=80=99t understand or cannot explain.
>
> This doesn't look like it's a trivial change, so I don't believe this
> patch can be accepted.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA

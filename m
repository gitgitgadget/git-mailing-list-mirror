Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF243CE083
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937098; cv=none; b=F5LQ1Y3I59o4JUIXQFabj1AFefoLjz/E5rM2HeINSCC2HKYnb+0RfbgC3DvcHrnOyIkMjrKkx/UQdpIy11QXvSHQ91qPJMpMggkmupjPr50YeZPDBneEf36SECXDsPM70E84NqPwa7mw8iQxXA/uYJFpHTKGRHEge/Q4UmL7CRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937098; c=relaxed/simple;
	bh=le21AweH/rfFpy3DhJdsFXZQHS2qM5BjXNBJ3k+0goU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ZSVCPn1BkQAx5gOknGTktcQsz+CH04Png59pBuHy6UqyWSLgkhYFHTni3iMPkP4vk0QiG4Wze+UfE2gl1kVHekwfeMSUXE5r1ZWeN0V1XFRc0s/NCwuGkOVh3pO7tTJhHkrcs+hD/XGIX5WWeB0wChdtOhszGF7l4cMdWGIEsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IptEpeEj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IptEpeEj"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e16f05fd79so47942647b3.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937095; x=1781541895; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l2AeNuj9RoJPc8WHepB0gQDfqAH8lmaKKVnscoK0Is=;
        b=IptEpeEjdmW9uCo31ULvKH+KKlJZVV+TDw4QEP7Aik3ANBtllohTyFxLgbwe50BXPd
         kUpXdrShspiMg57nHoq8tDLcjabjcKv3eujxJlvQ4EnSMhN6LZtJ9Rwyir+cBDz2/zCM
         wibmxyn7uoTuknZq4kVVcys82Jf312Z8D+lp280SF65a4vFZ524e6nW+H3N1HUhb2l+f
         aJMIONBAGTQU7ZynhPKJ/O2wM5MtK1wBiUE3SFEJZW3yN/dZZx6bNXnwZYdoJoErFimW
         m/5sPYB5pzP/rQU/w9YDvyZpkQknAm85H6u1OIbSqHAprnqdYf1lqossEHTToX7/veHv
         xzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937095; x=1781541895;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0l2AeNuj9RoJPc8WHepB0gQDfqAH8lmaKKVnscoK0Is=;
        b=aBddCy+NK3A7L1V56nUnxlwBP1EAdiSN4Wta5a2Y2/W0t/IEZAbdgYGE/yfLDP549e
         Dano8f1Rd486Lq6EzSLjHMo1jZVYuxWLCfnRLbJeLG9BI8AaAw+plgIa2QKcnVfdJkVb
         Nf+U7Nt7qf2LpCF1Se2wg8YEd5A9o6OXF2+2sHl2T3DWo/JFjMExVN9zVYvsiKt0cW/y
         V9u5T3ETWn+UrZGpEV1ZwhwyY/kqhZp3uPzimJ2ppsSdG2wRk2mOU2brYzIm43uLtHzh
         KWx+EUcwr7XpzqRXvfJ5atURFrNheOS2PegTLNsnleDO10xlOVDHmfZ1Ab6w6DMwM9tQ
         SDhg==
X-Forwarded-Encrypted: i=1; AFNElJ8Wvs4DvHep5tmuVJ6tgvv8LsER1TjuwBLy9kj+GCj78/58RKI+rcUtZhLFvj+FmKV+z0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qmJcmOZKig//p9J7SUXVku4raarMmtPS9XNqiGIx0Yi0Ijel
	jTC7ZJ4FX/Cu4rVr3l8c60toZlPCzEMWKGULquCRpUsBJY+GkEWwfyI87tBA/g==
X-Gm-Gg: Acq92OFriZYi0GklOWwEnWdcS7KuJ//0+BA19zFuTQVdKTmueIxs8xXVk4wQsBQRgKz
	vm8YwtSbEqUQXva+BRWrzmC94QCPA3abkVSwtqHyoSwgE0/I9qORGQGsd0/ZA8KOmImP2qhCTKg
	JJrlytqlhWCUVU/zc2CKJv2/nkhbhhk7nmyipiZoOL5O4ZkJXa/YmIio9wicPoxruMdIv7gD9as
	fsZ9Da1o7nTxvR0e38KdG/xe+JDnUabr5k6/GHwS4H+u8rtNQ4GwsBPtKB2L9j9lw3NqXTZddBF
	PoELx1FQf8BxR4tzicqwJpRhM0XN/scGnADKH1zmXaAz8DLD8fA6dNh+D9XH/0y5r9IPXVGiXNh
	Ay9QmxNP5rqTPjg/ejZLdihEwQVyk0BCDBX7JDLphAJkMZQn1aiXOF6P8zSwBgENaVBiWkbJRhz
	n6Xm32cSgo+WdgHclwibkvlzhX5bW1V2+/8Tg4XuIxjifvb19KK2TaHMpba4b/kCzhXMSno/qFP
	RPV9hSUVJtGo3KTjxgsbwEuF8Debo9wB2jdqVgO2Qhj55gnobqvUhS0
X-Received: by 2002:a05:690c:6993:b0:7bd:a4dc:c25b with SMTP id 00721157ae682-7ed1147f07bmr158180387b3.40.1780937094858;
        Mon, 08 Jun 2026 09:44:54 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:4dd7:1401:a55e:b40d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea9878sm85794547b3.3.2026.06.08.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:44:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
Date: Mon, 8 Jun 2026 12:44:43 -0400
Message-Id: <3D9034D8-C38F-48A1-B637-4342BE4954AC@gmail.com>
References: <xmqqmrx5z0po.fsf@gitster.g>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqmrx5z0po.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 8 juin 2026 =C3=A0 08:23, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
[snip]

> Having said that, I personally think that the current behaviour of
> `commit --amend` and `history reword` are both _wrong_ [*2*].
>=20
> You may start `git commit --amend`, and after staring at the
> existing commit log message for some time in your editor, it is
> quite natural for you to decide that leaving the commit as-is is the
> right thing [*3*] in your situation.  It may have been a better
> design for the system to notice this situation and leave the commit
> as-is, with an override option `--force` to allow users to forcibly
> update the committer ident and timestamp in the commit header.  I am
> not a `history reword` user (yet), but from the motivation you
> described for this patch, I sense that the story is the same there.

FWIW, in this situation I abort my editor (:cquit in Vim) so that the amend g=
ets an error-valued exit code from the subprocess and aborts itself.=20

Perhaps there could/should be a better side-channel for communicating that, t=
hough? I do not know how easy it is to tell other editors to =C2=AB quit wit=
h errors =C2=BB.

> [Footnote]
>=20
> *1* Besides, doesn't "--update-refs" in "rebase -i" allow you to
>     adjust the branches?
>=20
> *2* But it is an established behaviour people _rely_ on, so even
>     though it may have been better if these commands behaved
>     differently, it probably is a bit too late to change it now.
>=20
> *3* This includes the case where the original author is especially
>     difficult to work with and would complain any change to their
>     commits, even if the only change you made for them is a
>     typofix.  Fixing a small typo/grammo may not be worth your time
>     and unpleasant exchanges with them after touching their commit.

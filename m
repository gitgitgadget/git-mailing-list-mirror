Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A53B6360
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136821; cv=pass; b=jqCWA8MDvexJzVtAdeewgks2S2nPR7DfeG4hqklSb9epBfwL6RY0odNWN6PHseOk1orKXFYucSunUarim1BJ5wfqzJ+jqo+U0w0xOk511zc0dK/c15INLD2l/xLPsZECenReTSSNBVQ8PAK4KXh6CmXoBWC+tBvqnexNWwSBGHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136821; c=relaxed/simple;
	bh=5sXHVc5dAlDqtKnz8qR9vQjhZHdT6s6zAmSzrhptg64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCPgPaxvFX197eP6X/FcQDE+w4luxYKb2xVehxQOFrqNuKjewXBnS+hAIAExAh1l+hp39fKpUz9g5k0A/JrS60d4nyMVAzGBURlzXwVlYXiSNiqLsjRu7TpK8zGSORB2T+tPrxJO1mFKl+7w67EjZYKdtg3LseMq3G5qDn28yDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XB8BNG3u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ie0h2sRb; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XB8BNG3u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie0h2sRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782136819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1B1ygF9G932HZ/3Ncbzy9tQ/ofpk1FE/Bs+1Vbf+TNs=;
	b=XB8BNG3u1ATPrJlS94ynhiKrKfvTb3zGwQj7v0+aUt+tMwQeBDl+izTzFRqoRZnVfSsKiC
	J9y7E0j7ewjiGenJJcnImADEVFbp2ASQdRQ6zGhxx9R18BRMI3zrYfDpb/vqzQMjGOl3zy
	ELhTMT3YIOUDAO+JYcVkmzzbGHAx3jc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-N5e7R26fOey8OrzEUiE1PA-1; Mon, 22 Jun 2026 10:00:18 -0400
X-MC-Unique: N5e7R26fOey8OrzEUiE1PA-1
X-Mimecast-MFC-AGG-ID: N5e7R26fOey8OrzEUiE1PA_1782136816
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4924a7ae480so20784805e9.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782136816; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3clFKxHuq73Kmn8EN9+muqduFJ3IVdEP9HdvwXzir54cRRCX46CEr1nvUcbBxWbnL
         aOrzpnZShJGsMrvrZ9S+AJMEcRT+1ELg+tLmBkSYOrZok7e9yDEUtvNQZ7K3mzStUjqL
         /em1wYQl5W+bcRXHZiaRUcS6ynQJLC6D7NYwv6YWRILLjujdRLAIG3ujqzgqQA7o97+R
         rnubT0ZZLx9sZ1Kz6RZXHYzmxB7f20L3VQY/QzT+MMiV8sKwzNkawxLo0aUKtrRV9eZ6
         wYLmWa8WfRg/8Xrs/dd0e4YFJK0dGWsCbw7pZFO6FrcjRkU2amVMFsC55kaH0SOm+8Mn
         wHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1B1ygF9G932HZ/3Ncbzy9tQ/ofpk1FE/Bs+1Vbf+TNs=;
        fh=dohbMW0R73j5838vZ0AJBQvMZvtogSCngb/knVLF7bQ=;
        b=FDBoCoItJhc73yIHh9i7wA5auTGYCQJ4PEvB1feO41zgcQYpSIG0EHFxK5Ao1B3Cbi
         aNM3pwZV011P7CplNjSy2jyetJluOr4dYYb4r6HZLKJfWpOVBMoUzTsXhRJVwKnwGham
         inbU06fb4Q6MelwgZnbzQ1pHSIJ4xtuITAN0WFAsGJjXLaRW9QrjQfzUunBWcW5tnZHF
         Z5K2cKGvv489sO08lbB1sg8KkFSdsjKxeNkBjfJPZkfJgzGOkUbBLhcFhczTTpXwFjQs
         7WRpN+fK87Ydahwb9zFAi3MMcsJJ2AlNzh8KpjC4OeO6Ynxba+8rBAiP3EnY2txm9fwQ
         T3aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782136816; x=1782741616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B1ygF9G932HZ/3Ncbzy9tQ/ofpk1FE/Bs+1Vbf+TNs=;
        b=ie0h2sRbWzOLn/iOZHTn4abIn4Ej1Ap46Q7Yda7a8BwNxJpMP/vudGRT6LJZWvKa/8
         qdbASxzm6UOLyPytfyCj71FRE2OokFLJ1sEeTZTKQjUQl+vTlEhqCmNxZB4UZmiXEhlP
         ktwQgp97NFdlg03EVukD42uHHlPu2ORUkln4VQrVRIg1oaad7qBa11uITvJfWBSvMTvg
         E9GyKMG+7G4j9DAK3PA2XA3PF0OLIeQZnxZilV2qrHXr9FXRyDmiExwvds8QFt+DXDoy
         sy/KPXclx1snwtmWELmBv03R4la1f9IRpvoRBd4pi9wOobov+c6POAS7RCdePQD7f92b
         PWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136816; x=1782741616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1B1ygF9G932HZ/3Ncbzy9tQ/ofpk1FE/Bs+1Vbf+TNs=;
        b=Tc9H+EIqQGj/8IYmZOTwEFAxQL8bjm1oYIej0ie0KamA+92YQrmNph5kVEHEtNnGwn
         LfKwfG2dIndlbqk5uYtX+ZT+/NOtxB3bH+wgJ4MbuEQG0i7ZwGJWqw5+O5uta6HNUROZ
         FyqqbKLKiC0KVfbg+EVG3bsorK4DUmuAPou8+C0xyfRRcWTBo11nSqbYIiZpYY54XGyE
         +bC8x1NSM4ez7rK4siVQbkwR+hTOV/nI7U+1tE1Arl8wvfEjkGIlrmi9qL6aHyO7aX/D
         SMKBvo72uLbUP30WNDh5w9ktDBbmVrSAiPVw53GxirGRWGuJjY7ciTEvjqybBIKffyqX
         gtOw==
X-Forwarded-Encrypted: i=1; AFNElJ82CkeUqR4eVVUMQrLzUw9mZAaSbU0U/Lmea0QP97+WRH+hSlbppVyUE+3wV+6rv6H+Vtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW++AUUFzZ2HwicNYeL90d323f+CR0Em3ChQVliSRZLcmLDqJw
	kP9w8x19PFUnnvKCCTdPxImt0QlE9HyWYjM6EjNI7X+UwP6/PiJhusXzMaIdJeAsBa9gw2V0ea1
	0NjhR+8TiV2mjAXl8Ua93AgP3aLaAOflR5uOVTFbw/86N3JOg+RQpot5sDHXVZhXvIrgw1IxAWF
	OGnF7OsLCQASot1WWw/wHolHGweKrs
X-Gm-Gg: AfdE7cmkTJQE9AgtHzYG+Q/vJn9NyJ1uu6VP82cb2zGqoZZxaJu1v9f8oNH8sIl8Qv5
	Re01nlHVbtwRTPr5vc4p8BIGzdrRZ/p749ydjeT89viqHzlgqJ0z+xd+o9Px/2451bgmHjEkhaC
	jgC2hnxtRLDcQWuo8kii2pm67iAcughbXvpNFXAAydM6F3YhXZdg1aPZO6I/WNJ/mY5mTDtz1jL
	JW+4lr+s/jDEFglSCU1ADFbKc7Kw9K7St8rUaqZ2xf19qebIgr/HqI7zzRsvyvKOP2PFyER
X-Received: by 2002:a05:600c:3b10:b0:490:44eb:c1dd with SMTP id 5b1f17b1804b1-4924257c817mr212876485e9.29.1782136816165;
        Mon, 22 Jun 2026 07:00:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3b10:b0:490:44eb:c1dd with SMTP id
 5b1f17b1804b1-4924257c817mr212872565e9.29.1782136813278; Mon, 22 Jun 2026
 07:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
 <pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
 <xmqqv7bei2tf.fsf@gitster.g> <ajjspU7lJ01GgrBw@pks.im> <xmqqldc63f8g.fsf@gitster.g>
 <cdb16758-dd92-4b8c-8e82-8c607151449f@redhat.com> <ajk6QGB8raf85CPo@pks.im>
In-Reply-To: <ajk6QGB8raf85CPo@pks.im>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Jun 2026 16:00:01 +0200
X-Gm-Features: AVVi8CeSIodgHES4aCk0b_B22_oCRjItwZCHWGNeId6SAzaQwr1faBddqH3MDX4
Message-ID: <CABgObfZUKFgpxeKjVWpaBRCFGa1BSEh36-hkaRjZSUQb_n4=oQ@mail.gmail.com>
Subject: Re: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:36=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Mon, Jun 22, 2026 at 03:13:05PM +0200, Paolo Bonzini wrote:
> > On 6/22/26 14:57, Junio C Hamano wrote:
> > > > [1]:https://github.com/mesonbuild/meson/
> > > > commit/17d1cc60ed8246b8e7f0786421bf1cdf5cb19254
> > > I took my inspiration for -Wl,-no-whatever from Paolo's other
> > > attempt, referenced in
> > >
> > >      https://github.com/mesonbuild/meson/issues/15553
> > >
> > > which is
> > >
> > >      https://github.com/mesonbuild/meson/
> > > commit/7c901d7a8af214e31788eb6d1a1edd5b75124e66
> >
> > Yeah, it makes sense for Meson to disable it unconditionally.  I wouldn=
't
> > bother adding a check in meson.build though, since as Patrick mentioned=
 it's
> > mostly a nuisance.
>
> Is this something you want to implement in Meson yourself? Otherwise I'm
> happy to create a pull request.

Sure, please go ahead!

Paolo


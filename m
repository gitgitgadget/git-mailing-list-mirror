Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047C1798C
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScYgADcR"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D67E119
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 03:13:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1255491266b.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697710404; x=1698315204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMeye4ShqfIEzp/fI0NaVhjrUm8WQxtk9YWecRoPdHs=;
        b=ScYgADcRoVlUXcAQRQhdA9/U/WfXTsTjG5OOwCpAkfWhzZjRpYKxEpsJC3k+M2Nr7b
         T3HdiFtMNWmDkSXOm5zzcs38DfyL5D/aMG8DdW6F41t5P7R000d4AoQvagorsD5h0AJV
         HoIEA8wUj9pRUMyiVq/FLylGDgqZISUabOGhDRuITOutvBttvJtI7d2IqD7xEylAg539
         MooF9AECd/1NzR2pOY8h6zt6HOYfjQe25qKRDc+IE7yLaqbrNm5C7vrAY/FierhXQqXU
         9dzEKVsuhtk5Qf8omhQIh0ChDS1GTX0ZxeA3bSms2muZPmE36xmf1mVY/D15yTw3S1y5
         wXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710404; x=1698315204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMeye4ShqfIEzp/fI0NaVhjrUm8WQxtk9YWecRoPdHs=;
        b=Dkkon2tU1nW1gbCNQ5Lbn2hs7lwktJovtL2KCijQYOQ7T7QtW/E0cpxXMwfs9IwRN0
         lRTLc+j8G6r9sKjL8yd9vzk02Jf5naL/+urEsX4d7kX5pSsLQxbiwJK6M7Gl0uId1yLI
         0tm1E+Rse9ZkepYQOyThDMLI6e8+hW8Z7jKjgBpjBBGZFYjus0N6xJK83hJ/qU5eETAw
         Uwoex8AKYC8s9TPcSBbE2WAazrt5b0anqbvPNss2ySarAymf5zYDLQnsY9wSgCbh+G+U
         FgEhc9wAbkhsGAVBlZyG+hgFBwrDsomWEETTQM6LkQkq+tQS2304ZfX1PB4N5bkMGPPD
         4TRA==
X-Gm-Message-State: AOJu0YxOCYwUiqXIFwzZ2XVTPD2Xifi3Bk+hhUlFL30bm4q4I+JgnPBc
	S9Y0w63VlcwkdrMyuRaYebfwyt63xB2cicFiOlbXPlnU5KsyCOGlqKI26Q==
X-Google-Smtp-Source: AGHT+IFooLY5Pmu//TwmZ2rqlJTLkCbZ5aZQJKuVRM5L0qy7+0mJvst5Z4KQLw1NyJX6Wu4oSYFLlCuJtRMPK2/zxqI=
X-Received: by 2002:a17:906:fe45:b0:9be:21dc:8a9a with SMTP id
 wz5-20020a170906fe4500b009be21dc8a9amr1250650ejb.39.1697710403813; Thu, 19
 Oct 2023 03:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697607222.git.ps@pks.im> <xmqqbkcwuetq.fsf@gitster.g>
In-Reply-To: <xmqqbkcwuetq.fsf@gitster.g>
From: Han-Wen Nienhuys <hanwen@google.com>
Date: Thu, 19 Oct 2023 12:13:12 +0200
Message-ID: <CAFQ2z_Om724+o+EG1FAhC9VrvJECnQ5UA+Z04Rzycpi_mXvMHg@mail.gmail.com>
Subject: Re: [PATCH 00/11] t: reduce direct disk access to data structures
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> > this patch series refactors a bunch of our tests to perform less direct
> > disk access to on-disk data structures. Instead, the tests are converte=
d
> > to use Git tools or our test-tool to access data to the best extent
> > possible. This serves two benefits:
>
> Laudable goal.
>
> >     - We increase test coverage of our own code base.
>
> Meaning the new code added to test-tool for this series will also
> get tested and bugs spotted?
>
> >     - We become less dependent on the actual on-disk format.
>
> Yes, this is very desirable.  Without looking at the implementation,
> I see some issues aiming for this goal may involve. [a] using the
> production code for validation would mean our expectation to be
> compared to the reality to be validated can be affected by the same
> bug, making two wrongs to appear right; [b] using a separate
> implementation used only for validation would at least mean we will
> have to make the same mistake in unique part of both implementations
> that is less likely to miss bugs compared to [a], but bugs in shared
> part of the production code and validation code will be hidden the
> same way as [a].

I think it would be really great if there were separate unittests for
the ref backend API. Some of the reftable work was needlessly
difficult because the contract of the API was underspecified. The API
is well compartmentalized in refs-internal.h, and a lot of the API
behavior can be tested as a black box, eg.

* setup symref HEAD pointing to R1
* setup transaction updating ref R1 from C1 to C2
* commit transaction, check that it succeeds
* read ref R1, check if it is C2
* read reflog for R1, see that it has a C1 =3D> C2 update
* read reflog for HEAD, see that it has a C1 =3D> C2 update

Tests for the loose/packed backend could directly mess with the
on-disk files to test failure scenarios.

With unittests like that, the tests can zoom in on the functionality
of the ref backend, and provide more convenient coverage for
dynamic/static analysis.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian

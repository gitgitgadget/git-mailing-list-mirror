Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103A125A9
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632124; cv=none; b=A2vWkOpup7b8X4LYzbN4tMX7jyZpHptBzQJaKdqGTcL/td6OEHojbIp/YnbSn+7f7NY2etFI+FQX+jE/U7XB8Htyh/ha6+3PC24hnQ/d5iiQRhzN+kt3Twiwe5W57lyL2aW1DORW5HRJf160e5wtLptYnTOYlFSl740/pZJciWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632124; c=relaxed/simple;
	bh=MnysYlbWmYi+6VtarMYgHJlMzGpzcVVd9AqUOYGTMF4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u/XsRbL4jjoo558dru9YJ3RxJVhfeZSJnv9BmKPb09uWZrya8zWEDMbHBEuCXRtdQuNHsbBdUEj0y+zz+jhHW1c95bDY6rrmFhj06pwaKuQf2jYo1UfSC1i35tJovCXhdQcqOBpQrUOb9LvFu5vepvxA/juX4AQd5O8oRwJZZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=RPtVTsxS; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="RPtVTsxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727632113; x=1728236913;
	i=johannes.schindelin@gmx.de;
	bh=MnysYlbWmYi+6VtarMYgHJlMzGpzcVVd9AqUOYGTMF4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RPtVTsxSTZJ7GNXhrPhIxgp9iZ4IRk/J8mfAzZ0RO/MWw3sRtBeC9mjBJeyjjw2c
	 8IGN+sKbY8W/eOl2H7hjfyQFdXijfSQD+H6z1+JVaR6EOe1qEMMy14cCEgi/3reDm
	 5zkE2No9mHyA6au/aBesczZf9OuZBwab+YwkY6xFTBhtRU/vSYJ+yo8lYL0zX1CES
	 t2ILtvRNUnK/WmpE6zPgpuiyzYfvs3vrme5ReKGnJ/2eWCeWW+mUxzk30NYyGM0YO
	 57piVWWso9PF1IHnQ7gyCG2zIAyRcg7t//a9PwZbkRoo+eTkVsvYU/HP1f7HOyZW+
	 WMwSRQV2NNQMHaEQuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1s13vK1asx-00sIf0; Sun, 29
 Sep 2024 19:48:33 +0200
Date: Sun, 29 Sep 2024 19:48:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] cmake: generalize the handling of the `UNIT_TEST_OBJS`
 list
In-Reply-To: <xmqqsetpx16k.fsf@gitster.g>
Message-ID: <0121a34f-6a32-aef7-92d6-e11521fab2d8@gmx.de>
References: <pull.1797.git.1726687769585.gitgitgadget@gmail.com> <xmqqsetpx16k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+/eE0cwJ+m/2MJUdg/udrJhWbrFlTiz7MDeWJ9JaxJzMnc+0Bx5
 i+TXfBHkfHvyay7vlSVmBbNBYv3pqqbFPxRdHrBr4ynqqm8q8Wq5Zq9yx2zjXWN0B4hRWPz
 oFLA+Rzc3y5u6uHZZlgOAgdTJtGsUJdadld0F4qQqBmyE6SgVfthmpRCGQIiSBfk5sLLL+H
 DlOtMSXDRgQo8CsOZqihQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CjdwljEQ3jE=;VKQO2Mt8APCIVspyEVTuKaWIS/M
 uQ294/PTy2MGQtPWxLM00h2H6Iwkga+HrDn6Uhno5an25UDfOoijEkfCZexDoTnBX3vL3SGVX
 wjGpwIHMlYGdYdoBiQE+a/EFjveEsmgWNFYz4QmJM935GRNOoRBhdijZ5GLZtb44A4ilM1jyp
 pWGN/w1MHVegEwVmWXEiW+jKy+GDjWJOWAqm06vAwKpec/ce0cJNzjd+4v8RXYPAmY+Tir0Dl
 xVkd9re7auSzkVFqW4LYqpd6wQQIezRIV9ioEiSCfgf97eh6YKKdZ0N+ukvQLb+waJ0Yv4I/7
 tLOAIABz+rJQZ1EntxUEX5a+2Juq6/gsXyXHOOcBS8ySEpLY2Qlst/2xEydKSguB/RIZnedtk
 PSoTtn6R8uzO1aMK3ekLbS/xH1ZeDGDYfDjIBrgo42dCgfL7DxZo6tj2Ic2IgbA8Jhoo22zja
 AOUrQIvtSkio5j/1gma+jnw3d2OJgzkYxuOoFndl67gqR9ZnZh11Dpqmd7jpFXdg3up6X6QOw
 DfPRfMFEBVv6sjZzRQgXP+Q0lAmseHxLB5Lqw0t34O0kem/eBWBwZpl/AgjBEnrOi0Amyd9FN
 Vk36tdziSVBYnMXH6MvARRdUYxiD5M0HLzdpprkfvJ0b0Gg9npPU5n1wV0Z8KWAw4b3sQ1exE
 DTXLo0F//knq6vKTqukT7Mdmqllg/XmJeMU2QTIoBWpyPbpBA3LWyRdXfgG7RDUXnsuTil7al
 Sk7zB0GJvZ8bopzqrmexxMIkytdnsxf5vZMjAvitJ7rNRjUaA6gh+i9K53KrdNvMVuEKgKs5J
 0/wokWY9fYX9eg8DK9muAvmg==
Content-Transfer-Encoding: quoted-printable


Hi,

On Mon, 23 Sep 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > With a4f50bb1e9b (t/unit-tests: introduce reftable library, 2024-09-16=
),
> > however, the `UNIT_TEST_OBJS` list became a trio, and the CMake
> > definition has to be adjusted again. Now that we can use the
> > `parse_makefile_for_sources()` function without many complications,
> > let's do that.
>
> Am I correct to understand that it is not "trio"-ness (has three
> things) that makes the approach feasible, but the fact that all
> three things are concrete values?

No, the fact that a third entry was added made it obvious that adding
hard-coded equivalents to the CMake definition is too much of a
whac-a-mole thing and that the `Makefile` parsing approach would be
preferable. With just two items, it was still kind of okay to duplicate
the list, but three is a trend.

> The longer-term aspiration is to migrate everything to clar-based
> unit tests, so the list will hopefully keep getting shorter and then
> become empty (https://lore.kernel.org/git/Zt_lLsnylKJ9uoqj@pks.im/).

Once it becomes empty, I will have to send another CMake-related patch
similar to when the `REFTABLE_TEST_OBJS` list went away, as the CMake
definition cannot handle such empty lists.

Ciao,
Johannes

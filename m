Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E94DB564
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620648; cv=pass; b=GAPx85lutHAxfd4Lf4GOlWIMgwTPuTKmuaMdL/5sBQ7Go0uuqbm8bgn2YnblhycrbcIWEta0i35aeYtIWwjb4FNIhRlxkAf1hadlBLPS43YK6/EcU6ES/LhzoGLAQIetyvUDKfeF7MAap/XPFEKUswRt8ygENC3Fd8rWTtlr3H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620648; c=relaxed/simple;
	bh=w5+ZhT1IbVHImQiGevO4qiXsXfuOF4AhlqFcxUIvGvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9XCF/PLv2aHzhaCYNewlmS19Vu7geq57VYKE8b/T8FzWTlAZZHnYAFA/FQY497guf6Eo6/NFtIgosnEs8992RsibcVM8C2rcrFmQE9X8B3EUYH67OMWba6MFT1iYP/6pZkwpHqvw5bw5GJBvJk3wtYCfScuY2xTVI6d5T0tGD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8j651Ad; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8j651Ad"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a17e36fa79so88948eaf.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 11:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783620646; cv=none;
        d=google.com; s=arc-20260327;
        b=mc0NI7ds6I34sIF+z9zBfoIpZh0Q3Aw/igrc517hAJbN/TDpKtP94VT5G9Hgn3/JXU
         eMfzMlCKdzPInBxH4FNQKkLfQ0g45OkKmpOaIg5MPGuJOeX8HuhB+H2VX12gmkrlUhC4
         evNlBFDowj0Go7O0ivQgsrINXzM9cwXe3znIh7U5GJLCK8G4CBWm9se0/BdQMtxn/RFY
         HIVuyQcV/cXaCpchUYXFWjtnWtM8+Ceq/bpAkvBHRnzbn/InFTfubb7hGSN0aeibunjG
         3tXm0YEluUvDeputPc5rOCpIdi2m/xYcL3KdtngObPXHEjTD4nJe7o0A8NohFdWEjrD6
         Em6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=avfq8ANmZXgxainKBC4Rl0Ii1Ovk9lMs1qs/5YHkb3w=;
        fh=WyEJY81f/SZDvT0g21X8N6FF2dNeijB81cqNX2/QnsY=;
        b=fx5379+5/cDiQIon4+TWWnK5RU8zJzxW4x9hg8yvHRsI5oQp8VfOnk82PyivLEsHLm
         gqMVOHsX0AodeuUlz1baJ2LM+5R8y03mlZGMhL3KP+60Rc0kZjz5U/zAteN7+DRUDHoa
         JW3Vb5xGWRLJlIlU5mcEmlbpPRg0Efe3u2g331VBoI6gxpIQ+GI99V4SSZ33lLN5xDSl
         wte3MM8A0n2LERFY3kcSSifj3RiJGI/oDbMbKTOEPKtz+p35h5NctE2RatlRChcAZVbI
         iWho9gqUoGGVThS7oOvbzxqJ/9a4+VMoO0Z4/IBabCdRsT7rla5uFyHmwga1ijg1RX68
         wMvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783620646; x=1784225446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avfq8ANmZXgxainKBC4Rl0Ii1Ovk9lMs1qs/5YHkb3w=;
        b=q8j651AdqQQBwWJ8iTtLT/03L8pe0WVR98g/bLp6DPsyKkzfYo9/BTKXOhhv1Q77gZ
         iMjXd8rVRxXloTRS0UWeOfphJKKGAlppWnuNyrOyJuFW61wy8EvYiNRx+Vm4xOjiCJ3g
         XTLaAoD0Rdx+3Tr4M5dGTr6tk1a4oQXBU1XTip/MTTLsOcPQMjKecudKDDlmMrOXeZjQ
         K9D5cU/r463uZNfOzDMzFVCk3fcmydq61T/SvnKFqfmSeTqXzppFG034K9r3kRcdSEWT
         g6d2GKQn4hfuA5aTVxxzZp3iLUmtinpTk9ebFXYGIIyN3ZXsRi0RnHjOtOrjsmFrFnKn
         zc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620646; x=1784225446;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avfq8ANmZXgxainKBC4Rl0Ii1Ovk9lMs1qs/5YHkb3w=;
        b=mrmt44isL5SUj3obZfisoZUW/XPxXgzcpeIXfAPDTSJkZR19S2tRIwzLcQ4UDY4xS/
         kc4TRnp0T3Yh2d9fefMyVmkDMOofvvKec0Q3duzSTPCCdTJvtWRyCry3XM7GZ5lrjR0J
         eFnKL3qhJQqkR+Wx6aPKS1hvylNl/WDScIwiesGYTFzejjT0y8J+YgOVg07cjyYMX+DF
         VtoQ3Rlp4Lj8VUAxy+1ar79Nlphqs82LVHXFHm/lhzyLffhL/SHQzq2VJTDm9O3omQaU
         CZd5sn9E0c3QFApP5MKKlBvSeATC6mQqoJMiRxyGqKQ3GtbVThgjmn/VztuExrZIMIom
         3tBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GCCzQrGJ1oMumkZOSDySVQ1rMluBaR1K+4Glaa72q261o9LwoJ5ITF0WQ3xmPyj7w4aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4RIxac6li9AStm0QHhW7/0qHacpNH2QWJtWAiXEpOLWUfk744
	Dqkb12yn7tlds5b9LYNAxxfAbbIHT7BOPJGg2T/WGC7SFjIdsE2JZZ2RxGctYiwgF1Ah0Bcf3pG
	G8WcOsVFnp3LpjyWFQ1w+2CRztmdL1VU=
X-Gm-Gg: AfdE7clbXn+QaNmCEQrHzgKUOs4OyRDyJgL1jAFvoctSpryog17c8451r2tV1ZEtQwu
	a3jE1Xg2/epZ+UQeO6V8oCfYHFQq/As2IXKJ6v44WkLTW1UPQamCf5mjoKHrqrvM+Hmhz+mbdkq
	TCRgBjMMRrZUzXPn+CP6W6axOZRejr7fYwJvdjeqxHIedVcr1BAS89C91X3L57p0K9Po5Tur0WJ
	pFB/dTVw1rA1oraFOWFrKpbwLTNDoFnhxjC6LSL24z2d2AgvNDj5aa3rO6Fl1lR1c2NUcVuknJ0
	5MYIruZLA1L32VtZm1FAGrwPSkExCXbmvfXV44q7islp3lVMHLuJ8EkNLQUo0Y8ofLAa76OQQpe
	alLv1Eaizipx/a08UJy2LkxNA9Q==
X-Received: by 2002:a05:6820:3405:10b0:6a3:7470:9af7 with SMTP id
 006d021491bc7-6a37470a02emr3029878eaf.6.1783620645847; Thu, 09 Jul 2026
 11:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <efd34c17157b3183cdc851c8b17e7967b6c85506.1783479584.git.gitgitgadget@gmail.com>
 <xmqqcxwxtfkp.fsf@gitster.g>
In-Reply-To: <xmqqcxwxtfkp.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 9 Jul 2026 11:10:33 -0700
X-Gm-Features: AUfX_mxC2rTjuQ50FUMsgqMQlc1NLqrUiD3_OvqEChaCnjvi8v7o1Ky-dHN1-s4
Message-ID: <CAC2QwmKuHUP6_287T9SOLdjLdb=b4EqV4qJ_NnYCkGP0-d6qHA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t/lib-httpd: make http-429 first-request check atomic
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 1:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -# Check if this is the first call (no state file exists)
> > -if test -f "$state_file"
> > +# Apache can run this CGI for concurrent requests, so the script decid=
es
> > +# whether this is the first call with a single atomic "mkdir": it succ=
eeds for
> > +# exactly one of any racing requests and fails for the rest. "permanen=
t"
> > +# always rate-limits and records no state.
> > +if test "$retry_after" !=3D permanent && ! mkdir "$state" 2>/dev/null
>
> I think the last sentence in the above comment was meant to explain
> why the new code checks the value of "$retry_after", but it is not
> clear if it is needed for correctness (in other words, the original
> was wrong to do "test -f && touch" but also was wrong to do so even
> when "$retry_after" is set to "permanent), or if it is a mere
> "optimization opportunity" you are taking advantage of.  In either
> case, it would be nice to see it explained in the proposed commit
> log message.
>

It is needed for correctness, and I agree it is not very clear from the log
message / comment. I will spell out the reasoning for the change more
clearly in both.

Thanks for taking a look at this!

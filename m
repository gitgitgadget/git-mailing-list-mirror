Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C52D0637
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871913; cv=none; b=h90WhNVT4eIC+nzyjoG5Y9hcvonRJiYymhXihoZKjrYLSCe9UM8BVBKJydsyXCTJ1q6geoI/h/h6MO00hGgO4Qf5byxBmPBGFzPrNfGtDrSiTGobbh1TQgWftNG3ySHZPO+3pGAaj6V1FSQKPWltEl6P++Z7cJ390vQSUOAvrCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871913; c=relaxed/simple;
	bh=/HlpCGE68bPFAPvZpl0v4LKRcl1YIzcs1NIvGM1iZWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrMZtTOlm883dOgWBmsAGpRmHn8NxVlDCSxAYJatrGYBRgSbg/vP2OZrc/Fbi+Rhsc9RPl3ZZMgJqf5Ik7NN8yKVmIknl1fllQSM23n8UlDUa326TEvMJ6F/Ge33WbwLiZEV9pKN9qkKKFpDK2r2XpfbdBj5yZZjjVfKEtDxBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2O1/s/p; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2O1/s/p"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c53892a56so5308486a12.2
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 20:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756871911; x=1757476711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Su2K8gPMzstSttbiXUoREKTU5uyoB9vrArXvylmJ16c=;
        b=X2O1/s/pZsqy4rT7EYY/mTAH4lg9zyTvKT2k4QTeP9qMfP8biNmZ/fVPlq7LbZOUSD
         GL00SFBC6gtFqNrvzPR9LiMlUb8UOLcpkWjaj/nYPAEr/m5YS4TV8UtMwn1EpTpyttcV
         Gx9NirHSNVuo/46cO+guVbXDS9Xbs59M67IdidbK4WVBLOF+1JMjdHn9D07g6kW3x8Aq
         0hpiaCZNeIE6ssq9KZ3S1vP6VAdrwzpKcx046+lUVXbx2z6oAbXoyYCeWjw0E3wrDhkz
         PrUhpedp7velMsauvtTP6mZ9m/RE6wiQBML6nnEMNpj7nqUiuXLF/QawYfIKGdl5Yz/q
         ymqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871911; x=1757476711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Su2K8gPMzstSttbiXUoREKTU5uyoB9vrArXvylmJ16c=;
        b=cXCFSFqpYhPMSlW32fdBetOCTJX9A3jgMM7SBYboBmGiRZq8vDJScGOs1eoNi7N5R3
         hXepiXC5gf/jiKJA0VlTurBmzhMGZTOyFdvEvly0PmLm2ZWEcYjyyxRzpMvP60zhxDmB
         NKiU3dTQgIjrlec3muqW8s2oN68NlG57ukVPCElfQ4UA0wAv1enplDa0tmmomXicnr+d
         AGFab7avAZYRMJXFcFlS0pQ1a+1EeU+p9uivmgh73EWVfWfNJM2bZfPyov/3OHkQ0YHi
         muO/ijJUjRGdnm8SmdnTvI33Gt8YAjigbjGrUDZSKho3RHCaiQE9kM72LASF5r6nOg/h
         mdBQ==
X-Gm-Message-State: AOJu0YynkKzigaD0sUcXYBl7pSGlLUKLPSj1ak5jOOwZ27lbSvoua14O
	XhrIeUAfl+ji//p7s4Tn3g92/f5ze8jIBwvSrOgyc6X5muf0RDt6bsFyAXX5Thvu8nTglAplAOa
	xXG2nHHgD5CRgWYU7b8EBlQMrQ71U0LY=
X-Gm-Gg: ASbGncuV2H4gpo/uTYVyj6WG2dT0WoqtorMk5xhxo8WW2lFHZaquoyp7ENUps6QhUln
	9B8EcF+EAAPISJEt6Yng0kiGuD0RbFEEaQ+MNsSit0QoNjnWNQrnke3O/swjSTWxK//qZPGe08y
	ke0j1kY6NQD6KnOezc+iQK5MWpknDwqEPiAbJ/sDjetCuDlWxYciwjkQfTR5reOnq1sTT1YYAcn
	KYptrAk72qbhQra7q6B1kw0w8goHw==
X-Google-Smtp-Source: AGHT+IFa9Pdi7j/4ij/h+LlL95Eg8Ft2D8yx18rsfJ3GZBdaN88yGsvrf0YmkpmBt9mwzep8hn+PaxrOPZdXFIe4XSI=
X-Received: by 2002:a17:903:22c5:b0:24b:270e:56f4 with SMTP id
 d9443c01a7336-24b270e5a46mr47334335ad.37.1756871911347; Tue, 02 Sep 2025
 20:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-6-meetsoni3017@gmail.com> <aLbEZXusJEM9hohP@pks.im>
In-Reply-To: <aLbEZXusJEM9hohP@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 3 Sep 2025 09:28:20 +0530
X-Gm-Features: Ac12FXxCHViUagZzu5oTGDS02T8ihmnE_DGfI7wFRaqZ32lnHiqAuclvpHiifSM
Message-ID: <CAPhwyn0p6TFp5nhGBVL9eBrE809HYdWKh=nHbY5Lf0HboDLSoQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/5] t: add test for git refs optimize subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 15:48, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Aug 26, 2025 at 01:06:45PM +0530, Meet Soni wrote:
> > diff --git a/t/meson.build b/t/meson.build
> > index daf01fb5d0..48f83e12a7 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -210,6 +210,7 @@ integration_tests = [
> >    't1451-fsck-buffer.sh',
> >    't1460-refs-migrate.sh',
> >    't1461-refs-list.sh',
> > +  't1463-refs-optimize.sh',
>
> What happened to t1462? Is this due to the parallel patch series that
> introduces `git refs exists`?
Yes, t1462-refs-exists.sh
>
> Patrick

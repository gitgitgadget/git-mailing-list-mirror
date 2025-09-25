Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1B31328C
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821653; cv=none; b=cOKaDVUfde4i6f36qqfFoc7k4vyRvpykT6QHHBBvPPHTl1fqGhC7h9D7hYbV6SpAsoEUDTjR8WeskTKhDEYECRRYMfyoTWSIR8o39gayGihy9lrZOIIyrjFB1CNPx7fBKxUOiIYSCUh+W/uUgL/cYG+IHKQeqoMGRZUCWloRFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821653; c=relaxed/simple;
	bh=zn6PxKDzEiow8zQVle9veM8suYZHNsCC2vfjXtPnI10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFr9qPV01nQzb8i40x92x1L5KNLkt6XlmVo+pr1Uidi2GxzcZIX8NDZpWc69JZ3NsOCssoSxM4WfiOvnakkajj2re19IkoMXht8Cy3bi3FzEdC/RH9T/W67z5acrIbMcuZeRj7/SZcA+jvR8mR/uLsjADz+MWLQKc9BArUegPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVeZnsh9; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVeZnsh9"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54bc6356624so1611475e0c.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821650; x=1759426450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zn6PxKDzEiow8zQVle9veM8suYZHNsCC2vfjXtPnI10=;
        b=jVeZnsh9MttxjHHy2DRonpSeLlDRz7Fn1LZlRtwtXF/Q+ERvRLFTyA+xZlkivpOIyt
         uaPArWYRUDhK8CP8YbeViSscS31HTGFE4tqMxax1tl5HwIQ0/F4AkVl+5T89bAcrqhFH
         CDNxzIL6JzBs3xoMH0RP6LupaUu/sKBOm0Ei6AJBFA3yR8PB6y8kR///v9AKrmTNe7ms
         R7XEc5RnybYLnk4la/qRZDmnxC2rfwre2oVxeqQ8PPpIE7pZmTiUTQ3vhhKc1fecqrFc
         cZPglvm0lPvxrnhblv17D813pqjTdTjPkrFl8WBl3z9bLOrniybUhSowGNH6Z6TuLGls
         5pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821650; x=1759426450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zn6PxKDzEiow8zQVle9veM8suYZHNsCC2vfjXtPnI10=;
        b=X7gqU9cNE1IFtQWcbVq97cnLXjyvbmCCFdYYygrQ5r7xhUU779mMJ1JGGoPXle3y11
         EcgKGVwYGkBQhRFKbOOzuZ07TxU/vdtEeE5BTU/3a9gkNMDm4ubfd+Vx2i09D/PI6WF0
         //9STm7p8PEgY0C/3iys+d+zQgt1oZruu8pvzcfDXSxfiDYj3R6kLVsf7MKyem2Xu0KB
         eGphFko0W3X48mYvSv/Hk4KHQQfDuRxjGvWnHSLZxD26H4JOumx4imv4Xf1vFshUssh4
         AZRzdIPvOp7IAf7mC+Dmfx8dPXnmL3nQ/mj+y3uM51Gniydcm/Wsb3+aOIK75/MdYB3b
         xJ5w==
X-Gm-Message-State: AOJu0YzRgxoss38SJNPF9yeGAHeGxnrpnAbx4/C/zkwml9epWuvV653U
	FePmjNFYj/Cq8Y5mKo4bXtXoEvgGsO5n+OSO3DY0pWD4u6a81wk7xOYzGN27u9zMu1jwz2ysHrl
	cQa8nOobi0FDHEoJQBKrDejOihz0OWt8=
X-Gm-Gg: ASbGncsPxMvjwqhlxIDwc+L4UVldUVzZp+jcKdRqeENiutrT4pmNev86SVhkB56z1js
	jLMIDzs2yfvTnpvp1yy7e6TjHQwQBdNaNNwGPECc2tbRKmbUyV2h1tLD8amLV1w24wuUX86Ggzb
	9kxQcuTY2n6yr4Ug+6cn+R12DpfdWU/DFJyLZ+SopAjZJZcflpaASyNqgRYFcLr7rtxbkU1nRQF
	/k+A6tsan5g2hNcAHX8JL6ya5+AKtAXS3rC2YU=
X-Google-Smtp-Source: AGHT+IFU4pCtPEnpjBXzXLqSG5fhC1fRwfsECt+T7KrjwdAjbsBSs8e0TjM67NgrdXnyPeVJx/acviuoc5gGvi/Dkug=
X-Received: by 2002:a05:6122:da0:b0:54a:a3b1:db63 with SMTP id
 71dfb90a1353d-54bed4b4facmr1536951e0c.6.1758821650464; Thu, 25 Sep 2025
 10:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
 <CAPSxiM8prcfrnm8ktMG+DqguuNXvZukg=RQVV3oWdU88RNsiZA@mail.gmail.com> <CAP8UFD0ygkJ7v5Q2BwxuqsuAi0-+Htx8Wqa9JXALcVFh2q2_Nw@mail.gmail.com>
In-Reply-To: <CAP8UFD0ygkJ7v5Q2BwxuqsuAi0-+Htx8Wqa9JXALcVFh2q2_Nw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 25 Sep 2025 23:03:59 +0530
X-Gm-Features: AS18NWAGq2QmpB4cX15QnV9KATP5eoR2cc5jYWT6PlPPAb-008-G32fBVX0wn6M
Message-ID: <CAPSxiM_SHQ6HnLkKgP3B5MufRs18uOrz-0yhWR27X5aF89ZSGg@mail.gmail.com>
Subject: Re: Participating in the Outreachy December 2025 cohort
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

>> Hi Usman,
Hi Christian,

> So far it looks like we would co-mentor together a project about
> removing global state similar to Ayush's GSoC 2025 project. I hope it
> works for you.
It works for me.

Thank you.

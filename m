Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5B4C96
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387516; cv=none; b=AqFkfp58VIg4HxbxoCTbCBasUK37lJsdvP4zOb8RS7xQMtWlpBRnsG19c+rD/8tzs1fP+U3+baAjj0UvCysMuQWTkQRYjAXGBzDgxOb6IG6pJ9gHm8yDmAEddj7rDtC377TH2q4fsS8eaIW5MWOlyxHq/DlrHFfrFIqDD2JiUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387516; c=relaxed/simple;
	bh=Xnxo2hUmHrqMHrQLPAKj5IBqC4TfO+NzJTlkErWYfJU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EHrmqE+w6MVPGln/VaOTxODlM+B0QFYb7QDudgpJW86qn79lW5kvcQeZjCqcBJZZmkop4LFUkgpgJsqam7xNg3QoC/JVnVOgKXykC7l/Q6NgGhkG3Q/dWVxeoGQlVGpq8225Ytz75gZh9DvYNM4AcEEJS4MyCNkkxPZ2wwUKKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVMqzjVv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVMqzjVv"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6b75211ceso590738b3a.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 20:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710387514; x=1710992314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xnxo2hUmHrqMHrQLPAKj5IBqC4TfO+NzJTlkErWYfJU=;
        b=QVMqzjVvlXUH1bpEtJremPMoubY95L9nyD3ampHC0/Z4L1ZoIUM5JJEvedD1H2DJpJ
         O283EGHYsWeWALesvDDFUBI9mXnGiHBHZ3ex/A3RnWPAPchvhzWUCBBUcT0GTFkWPwe5
         FUs4ITUvcU3I/MDzMEPW9Q96twN8mDfef1tPi5dVKw7G5woaZw5BPjOwH4OCGSr9c7YD
         CiqmvsUU/DKg+jZR2flrfMvcAulR3aMaZO5+o6NWDhAMj5F8mx3WhfS+L371HX75EVYE
         Dmkepk5kj3JziGJI0Qe4FcMh26T0mY0Ppse/SHaF3BiIKvvRvHI+lSB1viOmS/Qx85pL
         0Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710387514; x=1710992314;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xnxo2hUmHrqMHrQLPAKj5IBqC4TfO+NzJTlkErWYfJU=;
        b=LcJ+gNCAn/KoNsxtHwyN6NizrkxdD5mu41CHtIClwQAOWAM+obcyFBjVVdDjoQqdFM
         aHUwW8PdvWPDzui8ELPrXoh2C7hUmjH9UdJaxEde+2PLu0O47naxZsATNur+5yIY7k96
         OeDqG18YF0NvqKUnuTvVy793G6Y/s4XuSWXff4krhRuOKDtUxfKIbwPQ5CpYM9yJ6zgR
         obx7UU2stQPtUnlLTHU/c3y4QsjupbyegAol93bkTA9DshmfAG8i7b3Qb3CjtEwtEPKV
         NNQAqlmDTljimMuLoBo1lg1W/mujI7+MicNnAF6M5PS9SxOFlUNVTxQajQJxutNeWGLh
         +95g==
X-Gm-Message-State: AOJu0YxHwtMnBn3YK9llFlW1sFMuAsbVIkAMAbmb8djEPHawmMWILzUm
	84snDg/b6hGCArspQMuZaBxuZkL1Be6ch5U4p3WSZPNJ3SBJvNJM6emERgBK
X-Google-Smtp-Source: AGHT+IHzY0xCtl3JjEL0Pt14RvOmVY/Yr+KXiLmDhnjaui6MrNIwB/JPjNr8H7cRMGqoQWsgpa7c1A==
X-Received: by 2002:a05:6a20:3c91:b0:1a1:66cf:c52c with SMTP id b17-20020a056a203c9100b001a166cfc52cmr1148720pzj.12.1710387514117;
        Wed, 13 Mar 2024 20:38:34 -0700 (PDT)
Received: from ?IPv6:::1? ([2401:4900:173d:8d82:429a:8969:49fe:dd48])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001dd0a41447fsm396996pla.233.2024.03.13.20.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 20:38:33 -0700 (PDT)
Date: Thu, 14 Mar 2024 09:08:28 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: ZeiBfVyTCHUywliI@tanuki.smtp.subspace.kernel.org,
 shejialuo <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>
CC: git@vger.kernel.org
Subject: Re: Discuss GSoC: Implement consistency checks for refs
User-Agent: K-9 Mail for Android
In-Reply-To: <Ze2E_xgfwTUzsQ92@ArchLinux>
References: <Ze2E_xgfwTUzsQ92@ArchLinux>
Message-ID: <04793E15-8C44-45BE-8B17-744EB94B245C@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jialuo,

Just wanted to chime in to mention one thing=2E

On 10 March 2024 3:31:35 pm IST, shejialuo <shejialuo@gmail=2Ecom> wrote:
>
>I think I will at least implement the generic part and files-backend
>consistency check=2E I will then read some specs about the reftable and t=
he
>source code of it=2E If there is sufficient time available, I think I
>could implement all of them=2E However, I am currently interning remotely=
,
>the response may slow=2E
>

Thanks for mentioning this=2E If your current internship would overlap
with the GSoC period, kindly clarify the same in your proposal=2E Also,
if it does overlap kindly clarify the amount of time you'll be able to
allocate for the GSoC project in the proposal=2E

This would be helpful to set the expectations right=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888975809
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244416; cv=none; b=UQ+TmZeV3/WI811zg1wPcrKqnScpfXSx7hlYsj7CZZvZ/Cv9kapCLBEgvlVc7YvxvvlguZS4gY2bY/IyB+ktY4YOnbVHm8QZ9rbjadGs7xvTcKorpY8xdFaUW0TSWv+7J6WkbVDbI/3vbmgn45pFSZVCo8cbKSLQMXuNO7PAw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244416; c=relaxed/simple;
	bh=GHg9UbiIGaCCWkEFSvSOwGQYwHT4eXIriolz5yGyUcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fllF9Y6ifs98tvgRvHa7etJ83QPvBd9aJc+Z+z11UukqTJAtC/dS6FVwxpw6WauqP30ffFqFTaZ6CH1mtxw9ibQJz7Gvi2JWg5bW1yq9zcMcE1p8Gr28usFVXTot5msv8olh7THWtgXEVC8mFVuNKuADRdPqFsICA68HYzSlTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlvIjyHS; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlvIjyHS"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d758dba570so1230386137.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763244414; x=1763849214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/2otsfHiCtQBUOwKUEekAd5C9aQbtDzWB00QjU/GuY=;
        b=jlvIjyHSTFFz9vhSyQYAoiXmsdJSRjrADqFhXPQMDjGFwlEMy78K1EAmMvs0opNsxH
         G+Luo2EEM7q2xV/tHwXrXOX+rcA3FPo7kEMoybfT4kIXUaC5UHFbJUsIJeHfpaHe7u3T
         UXW9Oma4a0xP8iDct03X/q05FPDuXBlQ0zGMYZJQwEiyRS43PiZZhyY/PXfnGXqplQQK
         HFSw1zfzqoGs2AsBvmfztO44rqfiM5iY0heLGPpnwoMLQEtDxX4O0YYEO0pDP0oXBjxa
         ydsFwPT+g67VQwWxEZy6bCedSceMjSKq1IYIEBjHXHUAprckFrgViWlTji+m7n9LNm4a
         Ra1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763244414; x=1763849214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/2otsfHiCtQBUOwKUEekAd5C9aQbtDzWB00QjU/GuY=;
        b=aWJc7rhOYmeLOcy4vqETRsyNCTb7TGkldIzGSO5PfDgmFXwB7YPDH8ompRZ0OwDi2I
         pEPH/ll96JEpMT8Mpro7DYu1MRPzK3U0StELwNVeVE97BVG4BeLD2fvgnemRkKQHwpwe
         L7H+tN5+UWvZy20/WgSXDfukvCde1GJTeiE/JGO/2VJ7lk8BCv2Ss7lF1fWnbPtW0XHV
         PqBrTHp4Tigdqe2hlG3RALmwOLwxF64X59XLcmSXxdhDtm63Bl3VM83YafN4r2Ml3DgM
         R3k1G9fD+sDqxlcUQDsJo1qGSBqfdKjpmdFON9nyVCGFaER1AAz1azDvaqqDgahOhxsE
         t7Fw==
X-Gm-Message-State: AOJu0YwkAnq5Dd6Z44fGGGd3ZA9gNdH+Gu1Rkm+W8fhF3SNE99irDJs8
	yaYcU4djeUhvXpU1htFrpivZ5jn+znUXVCpNbOYFO3ag1e8J9u+/Km/VazUVaIOalHE/3w0W7sr
	yCYWArCogSBNEruvcYA8A9dOKueGGwpL6ZA==
X-Gm-Gg: ASbGncsOGuGrABXb0PR3KfjfJ1Jx8ZbEalaxYZ2AEhnl8AxC29Db582UFuU8sa0C5p2
	Y5OoXQxOhVjhCGQ/pwNgT0QaRaTrRohJAj/5ldP00zYRKl1YB4PBKQfGFBpvv3DrvtzT+lFJk+k
	kUUZo2GFqr6ut2MQhkkuMBgvtRr2CFSAf6LPxk48QzSJiN61qy2Qu0BDGNjmHLZsLVdeRvCjOk8
	g+jJ5SK7uvgmfYq/C4ELhNLVpXDB89y+UgU3Xc7qH8Jdy3OipPLctoJQRjb
X-Google-Smtp-Source: AGHT+IHkY0mu9/01e18WhENuh3CyZvXsPZsCdBpCoBurgUqGOyq9QyAIJBYmjPQ+MkNb8EDwQrGnjjc8uq/nIX0FnLE=
X-Received: by 2002:a05:6102:2d07:b0:5dd:c5d8:13e5 with SMTP id
 ada2fe7eead31-5dfc5b8e3dbmr2323880137.44.1763244413661; Sat, 15 Nov 2025
 14:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJESqkrv9RmimXn+6SUhRhih3qEsp_MQk0+BH2FZsFX-_uD1oA@mail.gmail.com>
 <c70c4605-8c14-46b1-89c4-736165432d07@kdbg.org>
In-Reply-To: <c70c4605-8c14-46b1-89c4-736165432d07@kdbg.org>
From: BhaaL <bhaalsen@gmail.com>
Date: Sat, 15 Nov 2025 23:06:42 +0100
X-Gm-Features: AWmQ_bllIKJFo5LEB2MOxOcEyH_NOkWCwuUioXNRg_pWSVKLLvmxazNS27FPXPw
Message-ID: <CAJESqkrfjhSXmEc54JjX1bctG7JC2CtJF5KbUzPn4yat=FJ=7Q@mail.gmail.com>
Subject: Re: Ref list fails to load in gitk when stale tracking reference exists
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Awesome, thanks for letting me know!
I've sat on this report for a while, and only just gotten to send it
off (after an update to 2.51.2 still had the issue).
- BhaaL

On Sat, Nov 15, 2025 at 11:01=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote=
:
>
> Am 15.11.25 um 13:33 schrieb BhaaL:
> > This error message:
> > ---------
> > can't read "headids(remotes/origin/testing)": no such element in array
> > can't read "headids(remotes/origin/testing)": no such element in array
> >     while executing
> > "commitinview $headids($upstreamofref($n)) $curview"
> >     (procedure "refill_reflist" line 16)
> >     invoked from within
> > "refill_reflist"
> >     (procedure "showrefs" line 44)
> >     invoked from within
> > "showrefs"
> >     (command bound to event)
> > ---------
> >
> > remotes/origin/testing is a branch that existed upstream, but was
> > since merged and deleted.
> > The local one still exists (pending deletion/cleanup), but has a
> > tracking reference
> > in .git/config:
>
> This is fixed in the gitk that is included in Git v2.52.0.
>
> -- Hannes
>

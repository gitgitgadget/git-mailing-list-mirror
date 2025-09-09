Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6C1F3BA4
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401124; cv=none; b=eHVjWSLgmM6+27hEvS4pX1sDt9kjqKmUAlOT7kP70N6K3x1o9N8Y/bF/tlRJrJIqRIMoLQ3d7+s3Cch/EtqZFendF5naG+ObSUw/Q+nFp7RJRIIv9jhreiGAfCNlh1BGKx3H4TSsKppa947WtavECmRhJ3BeTLYfo1eiZDJh3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401124; c=relaxed/simple;
	bh=C5ChEwwdEgQeEraR5UjmwY1PCnEKsIRwgVaaT9yzKT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdMwbBXOOFC13AXYV8unsh7voxEOEtiN+s96w9fKqyPI6LtenhMszfLeiVRqSltR0mWequJFoYbn0zwbiiS7+o3KmoJZpQOfOhRjPkAOICh6uk0ZDukIfeEz7ySQcsIMV03fol1vNCZw8eVrI5ABWXdMCjPAZlq7RHYhnSyIlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyuTsrtD; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyuTsrtD"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f66ad3fcf4so54432985ab.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757401123; x=1758005923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W+xRxWw4dZ53O5LSsQTjmAn49nSrpop4XLcMbRHUKc=;
        b=NyuTsrtDy40nOixGdt+JaXnl3vo3yWRwEwoF71rFG3Q14Pyij08SI6k4Ktu/th3VOu
         3Ok6n9Px/UMvoZ7jK5sUJK/22lqOdtoKgQdoTFtDgMA54kxPDUfaQcKEbI1uKcjblrTP
         wKB4e+kn+xBnk4q2/nRsb/nf64qqfmBsxZ06I3rvv6KdR/tHvW5OYgff1pRD3ZgRfhzl
         KZouy0Qd2LPc9D9DBSk5e66Bs3a4t+psViP0DqlnpRJWnPZviewxeA+2x8rQXGIKPpyd
         sevTm9JT6Vt7BJSvTGb1xgoGB23G5F+ppmSE/SwbHIKo7zng0Rql0/cpE6/tlR/kzk9/
         JS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401123; x=1758005923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9W+xRxWw4dZ53O5LSsQTjmAn49nSrpop4XLcMbRHUKc=;
        b=nR8TaRlrkyPP3XYtqFPzmT3URT1RSeEs5GI1gyHaZBg7Dl7Qo05JlDUJ/l0nStE+RU
         Av5PSx5JYjiD3xxBasyNgm3bimY/nWo2T/1YOh1RXGe0V7sA1R1fkgy3sbBCJhnF9Sla
         dPqPygT96kA7ni5jl8ibg4LiWfOrQgHQWtWOYXwupY8rhmhUQgOKC/TfWNCkxob0YoXr
         jI1VDxYe4RkhbsF+0B4v/yw5cdil7/SAEaNhiwILmnkVxavikLKcCNRkfvqr53WvULGB
         V7L/wRpGNiQMbqnyBhV6uOdl2koWMRDU1mMYyeNHKsVi+e6slRUs0FPbLo113Jfi+h8F
         by7Q==
X-Gm-Message-State: AOJu0YzRhIQ6j22bEPFx5Flqjv6sTt2b3ePUIVT3Fy38lzq798Xi2SlH
	6Ser0FjaEq6a/ePL7wThwQPeNSVv8LRqFGtTp+rTqbA+jdP1QtxllqQKLO18YOQNnrEze5xLj0E
	AmXtMGteBqpDflOvQ//NUA6WmNRPHc+M=
X-Gm-Gg: ASbGncv4qyrNlUS8kJRTC3+LIRAoWe/h8lXTsR2F1cVlOUO5od+jVSOO1nIpyR0KQZW
	fIKsf7nbnWAZx0s7aBCRW8OVMlepC0BoKhRM8uMy8U0ZRz3B6IHmBevwOYWnBmfQGefpwn0ltu3
	R8av1emTHwLf17clL/D+9gfUIawldSh4S4dQIkP5e0GdYBovmlt//043qDDEbWADQuhJeb6qgh1
	oU6UtupuC3mR/23a7FZ++FGQO7fm35bNGQfphy/+pvhpmRfmw==
X-Google-Smtp-Source: AGHT+IFwGewk2RsFBn4bnj4oBUVGMfCrKp+Z58UK7nJXXNI9l8Ca1mpGWPLoqlmFNgoWbrTcp14R5J6Dac2A7oDnTFY=
X-Received: by 2002:a05:6e02:1a2e:b0:412:5782:c7bf with SMTP id
 e9e14a558f8ab-4125782cef7mr5039535ab.23.1757401122674; Mon, 08 Sep 2025
 23:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjz28v21e.fsf@gitster.g>
In-Reply-To: <xmqqjz28v21e.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 8 Sep 2025 23:58:31 -0700
X-Gm-Features: Ac12FXyewamJgt4eolt6AD4p0wW-X4Eor3W9Y8AVyWG0DtPoMWde4M84X4iKgB8
Message-ID: <CABPp-BGxzRmkqdkpsVE=b9hQUsA9QO8iTNL=Wan1Vwatq5bMMQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> * ds/sparse-checkout-clean (2025-07-16) 7 commits
>  - sparse-checkout: make 'clean' clear more files
>  - t: expand tests around sparse merges and clean
>  - sparse-index: point users to new 'clean' action
>  - sparse-checkout: add --verbose option to 'clean'
>  - dir: add generic "walk all files" helper
>  - sparse-checkout: match some 'clean' behavior
>  - sparse-checkout: add basics of 'clean' command
>
>  "git sparse-checkout" subcommand learned a new "clean" action to
>  prune otherwise unused working-tree files that are outside the
>  areas of interest.
>
>  Rebased not to depend on ac/deglobal-sparse-variables
>  Will merge to 'next'?
>  source: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>

No, please.  Responses to review comments are still needed, as noted
over at https://lore.kernel.org/git/c3c0fbef-f395-4972-8352-dd89af6799d5@gm=
ail.com/

Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858D178B60
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980109; cv=none; b=IzE/Qmn2lqeHqH72g2zKtgddkDVPAUC57K1uemEZUPoyF0tjGQBRSZC7ae7qgBMWwQ+msPhg7QYnbkPabUvx3erzeAtVIVIyF1UUX+8bw4LmKp6Xh4uauJvpjrwhlzPUstQtxK1wcrjOVB7Mpa9gTwrbYTeeVEVEO6yWVO6BBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980109; c=relaxed/simple;
	bh=esKlNdmDyo1bEhe8Yl+FJWeJ6cU3IypdLMPq/N2LDmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ryh1zrcwzc1oL0YtUOg6JELEelVjl5NYaekXgo36ef+Zs3r/ZkKpn6Lln+gZ0wIjJyEjJlLeDL3Ewv2tt6orkJ12lLiAj+Ek4etUg/JUd5A46ePJoNQ6zeBAZtlEDGQBWsCpVoAv8t4QG8drMfwmlh8UrtfeMN0ap+fiqpxUkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVDgp4j2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVDgp4j2"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25cc9c93a9so1250918276.2
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727980106; x=1728584906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE7Ab+NrKF9Rar/eQWNHkly53/7hnppwPnfIWJ/91Sg=;
        b=nVDgp4j2WM1t65Ou7ismb3X5DUTxr+GjR+dUPQMOHSFLTWh4mbmFTgInobMhxL3b9Q
         eiojFHNegaD4JVyrK/a4Ro6ObSrjbH369KM42zUXIfJhcrRwNyiOJfrtY8KM2oHE9aPg
         sqSIxqrgtUKRHbXza4dgyi4oyeafMntTXtdRTaHyoL41KeMptHTANgj15Hf+QdPUMzCA
         +RXCneeMlD25+vOJpUgABS/gWNoNSlt8xr2eQLadyWOPZ7X4g3+ln4dyHM0ZzgeHmklw
         20ntoJ6fy92oyFduAMjKNL1iBIksSgeC/zahsTn8UguUL91g2LZ0pcny2M95id4LZHr8
         JUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980106; x=1728584906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZE7Ab+NrKF9Rar/eQWNHkly53/7hnppwPnfIWJ/91Sg=;
        b=dpKZbUmUxn5HRTfmWtUGryUQ0d8Z+j22NSs7dU6jXorbXUGUh09EAG+h81SO3/SA4f
         IdR2vodd7dD8lyrV2qQmm1LwAEGaVYEBrmqFRzBU5mFTfEl39yYbWZN1WfD4x/Vx2l13
         TNkj05pv0h53QxyJsymz8+VnJm6WDpks3PIkHh4nKVsXjQ3pxNVZbEuHPZ/fqrj/jDNS
         Q8lTcLOAJrLGK65N6p0ROLwdQ4BbDh9O4cFXMJOx3ck/BrpADZpY9H/M4PSUdIht5DGZ
         R0qYn+pmOX+hL+V5yUzzfat/NzRr+QvYJqXqzHT7+HpJqyvZbnMis5sFFOcUgZbQq2q3
         49ew==
X-Forwarded-Encrypted: i=1; AJvYcCVYZoHTtllFSBX3YEOaWE2h3mQNGQwUkBc7fn7H0WVh+IKopEQb6s0GsbJXOklx+pYgYy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhGjK68tFuuFsvnqzDsMMnoxCk5vxuI4Nw+23PbaKvOEhXe71
	S/ADKiw57/tW1VF++d0+1b2CRvqZhVyKOmB2g9dqO9YrLsFIhVbZ
X-Google-Smtp-Source: AGHT+IHmcK79XsgNPh6+dyGbcrxf7hAjE6tPX1qNwoHef0Um8s/OhdN18UByx0UOp6ZikR9EKEjNIQ==
X-Received: by 2002:a05:6902:18cf:b0:e26:ab6:e49b with SMTP id 3f1490d57ef6-e26383d8008mr7548978276.28.1727980106495;
        Thu, 03 Oct 2024 11:28:26 -0700 (PDT)
Received: from [10.37.129.2] (pool-173-70-63-30.nwrknj.fios.verizon.net. [173.70.63.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937d3068sm8590246d6.102.2024.10.03.11.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:28:25 -0700 (PDT)
From: johncai86@gmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, shejialuo <shejialuo@gmail.com>,
 John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] apply: remove the_repository global variable
Date: Thu, 03 Oct 2024 14:28:13 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <DCEF5258-BFF7-4667-A538-0BEED2CB70AA@gmail.com>
In-Reply-To: <xmqqwmirzr32.fsf@gitster.g>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
 <xmqqy13852jk.fsf@gitster.g> <ZvuBduVg9TJeULpl@ArchLinux>
 <Zvvr1_9syRh1McVA@pks.im> <xmqqwmirzr32.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

On 1 Oct 2024, at 13:10, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> I disagree with this statement. If code isn't prepare to not handle a
>> `NULL` repository we shouldn't fall back to `the_repository`, but we
>> should instead prepare the code to handle this case. This of course
>> requires us to do a ton of refactorings, but that is the idea of this
>> whole exercise to get rid of `the_repository`.
>
> I agree.  To me, the patch was screaming that the author was not
> prepared to go the whole nine yards, though.  Adding back the
> explicit reference to "the_repository" as a fallback is the next
> best thing to do, pushing the "problem" closer to where it is.
>

Indeed, I did not do my due diligence here instead of assuming all layers
that look at the repo argument do the right thing.

>> If a command cannot be converted to stop using `the_repository` right
>> now we should skip it and revisit once all prerequisites have been
>> adapted accordingly.

Looks like it’d be preferable if I just drop this patch from the series as
it will require a larger refactor.

Thanks
John

>
> That is also a viable approach.

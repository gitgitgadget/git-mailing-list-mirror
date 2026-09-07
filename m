Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26EA421235
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816300; cv=none; b=TTHrWwj5tXODv8BiHlPcmPH0xLSYGNnH8SYncHEpXkv94ZpyLtUAJqTWhz/5mlBt21/OcBB6/U+HW+wmsB5IoLNwl2TLwXRkx/ksd3/AxAeShn3ibRqjWOPBAccVTESCMMx3lOy2nOD/vr2nDv8StdZBy7u5ba1kEYV9x6ciEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816300; c=relaxed/simple;
	bh=6JQ0YowaKeVa16lD55wU26mDfsrzKSfdYzM27udS4As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6WjAoyFFm3ieEennjsc9up7vTzM/rTF7x6ja5Lu32CTzJVski8Zuo7XIfO1/f8ZNYOzsQL6mYKutdl5J3W53BxWvTXoexFxgAXlxVHCsxZsAbwTBT/4Dt8+GDLGl9fEm0k04Xwqmbta6oOuwdmW4jxLu9OsD0LHIyDOIR7vaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=OawNuSbL; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="OawNuSbL"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306a4c5a04so1192381cf.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1788816297; x=1789421097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6JQ0YowaKeVa16lD55wU26mDfsrzKSfdYzM27udS4As=;
        b=OawNuSbLtFBsFI5bSYmxHVqPfGiRsrNN94m1yigKCFGT90TAl7Mx0ZfoKWHTrBcLht
         vFtrmBNYKWydwHqcz+Q4Jl638QDE9D61XxfeCR5JQDkJulplhmwSl0pjkdOOeL7ogmZ8
         bOC+6JxtXZ9rY3PHOR1yYlIoZaTxrkv08y+ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816297; x=1789421097;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JQ0YowaKeVa16lD55wU26mDfsrzKSfdYzM27udS4As=;
        b=Q8+dODTl6GUqBu3TTyYiL8cPLmzQux5lxyy5BerIHtaHHSV3nEBnXp4nsqbTS8lfGj
         CTP5AZtMKDDbJX7zWDsS/f6RdyVW1gI+DpKdLYyFK+nAi8orE+Lzy8QlrZi4Fo/R4wA6
         qafhT3TKwSsPi1yp9WV/MRKQX3oeT38cCzNRJRNk/Qyh/clly/Ohr9kpvJZfUXL10zdF
         i0UwbFPkBHYiqWxujkAJ/mhfAmxjE3syb9MyY/FdH9IG4SrWpIcg1Dg++Wl27wZF52ot
         1IFNX7fMlVN+MQzonsFFkbR2ouL3CHzlAF3yWZCurH9FqHUTM5LCmOmGcxZuUDsXdEw1
         Ss1A==
X-Forwarded-Encrypted: i=1; AKwUvBxukexBiKgfZLUhmh6dLQUfmijovKLmTP8x9Gau1tuJ3ZafilGFGdTWRRbBj3fVn/pGxvg=@vger.kernel.org
X-Gm-Message-State: AFuF++liLqR1SHZstFqt4I2uSTU5fG/bH1m3fnyxSjhp+Z0BocoAK2rf
	6H662w8d3ZwTbrZwb/8vEtRJVnhUzqOEeGR+oro9nNP8cuMcaOK+A4BHDmNPcfta1Z01JkIKzyP
	PIkIXHko=
X-Gm-Gg: AYBFou3Bgiv9cZFVScKzHQIR0a8atiwafzWJhxZePaY4ipHSXU46bYTDUemdCj+BoMH
	wigPJINJYQxQoPs/d6uGQpYEEqDYxq54HO5BUOX5v57gF/SYsUhG9sdLIkgDYTsq6MBaDj/wKoj
	UfKda22BgnTlTVGNY479HYU4+dsP96dTdUXbJUc8Dp7qidZ1ZFMk/2qDxFpLtVJKysKFfCxiGJb
	Ke8kGtYE4nP8Y5uYeWq3n/9RGRNbUvtxydsiiakdMOrxfZznCujzZsMrGD4cRzVImjf91Ax+Vwu
	WiWB6hr2WI8a9TpU+AeqqMQP22kSOrQlFXBZvOTsLFsxjLRplO9iFNBgTIcq0M+YyRrFJ22P38r
	VGqjUz4iYQi6L8no7T2wGQKOuCYqdaQXScsuV/8Jbg+SO/susZIKchyqSmxPblYNjTCZvhCT1SM
	gwcmgaPM1GnssAlCIIWnqVvFAfeJ37CU1clp20Y8NyQ4dgEMnQTGpipK35f3zCAb25cpHpUvMfq
	RxFfzxj3kW0JTPqny9IJ/TMQRr8T4mHq+9VkyqX3NxdB4RCpPRxLq17VtLYYi/Wo/woM7LJ4kfC
	qpyVGzbbBmJ0RG5tcCuE
X-Received: by 2002:a05:6214:2b84:b0:90e:969d:6ea1 with SMTP id 6a1803df08f44-910476b4a1fmr182506786d6.1.1788816297440;
        Mon, 07 Sep 2026 14:24:57 -0700 (PDT)
Received: from com-76773.corp.openai.org ([199.47.143.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406496e5sm100151026d6.11.2026.09.07.14.24.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 14:24:57 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: trace packfile URI downloads
Date: Mon,  7 Sep 2026 14:24:54 -0700
Message-ID: <20260907212454.80627-1-tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anskQP_xB-Xw3nug@pks.im>
References: <20260726083310.16180-2-tnyman@openai.com> <anskQP_xB-Xw3nug@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Aug 11, 2026 at 03:31:44PM +0200, Patrick Steinhardt wrote:
> Anyway, having this in a separate test would've been nice, but that
> doesn't warrant a reroll in my eyes. So overall, this patch looks good
> to me, thanks!

Thanks for reviewing, Patrick.

Junio, a gentle ping on this patch. Patrick was positive on it and didn't
think the test organization warranted a reroll. Is there anything else
you'd like me to address before picking it up? I'm happy to split out the
tracing checks into a separate test or refresh the patch if that helps.

Thanks,
Ted

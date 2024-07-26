Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154B184F
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024997; cv=none; b=Oisi2qfIIpsTkjEUSyWjgFCk7QOvxgtuIcwJbdMHtoo089F4Z/EwXYhlNdl1ErfLIlHyjgR7nwduAsFNa63fy7YwgEbJBs/bmTp72bkgh+qaO3HYxWFxw+LSdNgbdSCpPp1rAcp7HHGK76fXIz8O0SQj2VSqLYsPvYowL7jQWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024997; c=relaxed/simple;
	bh=OUmQkQmOdqLBOYVENPY62BfZvXOV4eKIfPr6tcWLBSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqJxxpc9sXaiSTAw3YWgwj/iFIrPZdGlIKrYf4eBtth3nCsoGkx8lq6Gits1eEfy9I2YgYwbmxmnjVyJZBuMbr3F6R/5HaleqgINb9DUJiozlaHHqqPAYlao3jAEhizXfeg/gAylbDlRVu7Y2JQBsunvihUlE4DGwsM8//G+K4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrKd2YmI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrKd2YmI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3683329f787so43048f8f.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722024995; x=1722629795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9yOTmYYoC8tbeFqjRqb1A2ddAvoMIZQAob9M0eLRkk=;
        b=IrKd2YmIe80F1b2LEQqo/tXGLsjBJ1fS69hKMbYUQwLI0zJoMtgs+00nPoL8XZ0Q+o
         hNWXjeZzmsm4FXKs12zUESwitrLYG4RcUX0ZHCIrkAWkhbCMubFkveybQVD4BtQqeDld
         LmtbNvhnXR+NSHq+vTMS7GcSYQUR0CFJkGPl9BB3RNnMWFbhREbELldKPL7Oxrlircyi
         LakXS72NXBUFoXFYYI77CuRGZVGQdc/O2hteA1RENvZLessZp3kPKjQXUXRgYG95fjwK
         cqxbkv/Sxn2YzVQk/9IQyu7pv+Gl0BsC2e/H0rsTuDi4Ox4NBFkdygOv67gjK9DUZU2t
         2ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024995; x=1722629795;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9yOTmYYoC8tbeFqjRqb1A2ddAvoMIZQAob9M0eLRkk=;
        b=TB+TqUEBPC99hyxlXIk4VYNE5at9KtH69fdRkPe48y1CdS3/diQRvRHtE0HadPvSvf
         auYwCz7fMUZQX6UNfS60OuiiAh502PsCmdJ9eRUusrTtStiEeasF9vu8Z2KYKBjlf6Jd
         7gLOvoC/98Vyg/qSWtdWdrtruUuER0694gxq8hm/fzpiiB0ZbfDvcPopsnvVt1kXMFBg
         F3oCfRpziFhXeUnIZ710yV6kG8hJVHMzkIKxgCyJ7ZHg3W6XS/cVxELMHDBOsqxKgCIu
         XXLznd6aBwnaX/SE1r+6oICbraohEQ+85Pt3MVU7O63ZpbtabkjKFQ7MG9KBNKZxCGFn
         4d0w==
X-Forwarded-Encrypted: i=1; AJvYcCXeE7qYLq+EmrElgMjRK+iu71LUbmNRZN/fnPHCqwvHMkDMtaYbSl3nmiPf0dt3a5/PXwlrf2aox8y3O+VFX4UE/XMR
X-Gm-Message-State: AOJu0YwOTM9Wl0V3jf+vc/2Ka4TiOb2Gk9cK/e7LPFmu1yg39NmecOqH
	CJDYrg8FSfud2PuBcAtyAyvs0pMIBsMW01b32tw1kpf1PFj9BKns
X-Google-Smtp-Source: AGHT+IH8+sNNaCNZp56uQerBW3lDrMz4FnVxkIwzhFKkXZ3OuxPb8dQS0i0MPhRw4LQbBOYc7EWS/A==
X-Received: by 2002:a5d:5052:0:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-36b5cf23d76mr457777f8f.29.1722024994428;
        Fri, 26 Jul 2024 13:16:34 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36861b29sm5936255f8f.93.2024.07.26.13.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 13:16:33 -0700 (PDT)
Message-ID: <9f4c596b-cd6c-4f0c-bed4-dd6febb5e697@gmail.com>
Date: Fri, 26 Jul 2024 22:16:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH v2 0/2] add-p P fixups
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> <xmqqcyn1lcjo.fsf@gitster.g>
 <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com> <xmqqsevwui31.fsf@gitster.g>
 <1dc4cb5d-966a-402f-a880-42280750b949@gmail.com> <xmqqle1oszn1.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqle1oszn1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 26, 2024 at 12:48:34PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > I thought it wasn't necessary to modify the first two, which remain
> > correct, and I didn't want to bring them up again.  Additionally,
> > keeping the dates of the first two different from the two modified here
> > could be interesting.
> 
> Then at least you should have said so.  From the receiving end, that
> and retracting the first two would look the same, so there needs to
> be some clue to let the receiver tell which one is the case.

That was my intention with:

base-commit: 506f457e489b2097e2d4fc5ceffd6e242502b2bd

But you're right, I should have made my intentions clearer.

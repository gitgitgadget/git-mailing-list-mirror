Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B63D88F5
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105332; cv=none; b=twiIaSiOo6Sya/tm7/67S6ztCimVZbzLC5lCIoEx76koe9iwZTe/D0iX5eJpLZKNdkb9pX2UWnyHFkN6EwjFDYibJBh5kl4c09scEi4Sz20u8csJvuG/KYBfvkYLXmXQx3MafY26N3V7BcJH/wepGYumMydrxydEh7j/tQlvqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105332; c=relaxed/simple;
	bh=5sCVxp+1duTrgi/3ygbxcHbor+5S8/NO/cq9H6K3Tzs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Tf8JwJuu5o3gwRdbc1ltd1OO5A4xuwAsN3OWDXMfMiwUXVuGs0awA2EXVFoQoTed07vR2f5GhWqFa0b3cpz9OFUCL+Ye0UVTOwf1TuRZG6ppnxUQAbIhXug1ESzW8qexIw0S+/yybJk2imc5GJ3KVOHaDdpV1hpsTNfL8mDF81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKjnm4+8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKjnm4+8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so3850962f8f.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105324; x=1784710124; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BCeFo9O75fA3UoB/+Pj0CPq9gvozkT5wqKXTIw4mWCg=;
        b=YKjnm4+8Ng+BvdFje7f+bXlBZroXa85fI4pVZT4uVi7sK0Byg5dT0rdoNh5n3tWfd+
         2Rb5JzjXhXg8FYgUKwEgpW36fDKeG40psCXXG7ULV3rP+5DCTitgutHHNnawuID6sw/O
         fBpK1OHFyNPFHACzTB6XDzHj2r36AL+2itCzcDZiPLUW+20If5mMw+p7hKy6AWwN9vLa
         jYOUHosCwP8p5LsArRyXAxw8hoyfqCcSDglRJOq8MJuKxeX/4cqutzg8NRNeR7Fev8I0
         +NjSPZ62mPTFxGihtChFfwsoNWSEzt6u3J4/BFGgOue2yqrGvVZ9oD+u2bRJBtBZasvF
         nABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105324; x=1784710124;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCeFo9O75fA3UoB/+Pj0CPq9gvozkT5wqKXTIw4mWCg=;
        b=BHPZozGlzDmk9fPZrp5CPvaQYbpwI5LDOcd4Sdz04CfWvEMKtHG+l2r3AG28+wzIeU
         uttnbYmPI4spngDSoie2uI0FMfag6ZeBFPMZwOrzB5CVsvP/FWaYLB5f4g8TDhtKkUfw
         j08ykrInR4UqZDgKzhwa34MbgDQskeAjdY60wZc8fZpPwuZxYsIlI5ANkO8CtsJFOc7u
         8wfXameQqh0zmYnSR80M139H6aWuy2Oxf1tZ/ndaXjW8MY97OK75Ooqgs+e4AtVszMoL
         F2z/xnGVM10gcaRcXJnvwuXQCpAIjjAk2tE16uS2LyVN26OECEhYT8fZ6MzGyH5uAC6Y
         r6yw==
X-Forwarded-Encrypted: i=1; AHgh+RqqUrVWnGnqLOp9eHOetVvqfVZmVcTAhT/w2miKgCR8jiObg4dLbkdiLGdCckHP88mg7xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk59fsIil6jKook/QyTM/lVA/8UFzopkxWn0QuIpsVzi+mo8UA
	7WeL84LmjZ1nRQH+wkz0rmY7mzqao8SiITgXRZ/ng3uMfwhy+vcP+kRO
X-Gm-Gg: AfdE7cmbiyRbXdlKsRcymL+1nvVKBkhPcbxGMQU2JDpS6OGzPwGTV8whpcJ9BivXefl
	Ys+8S8KWTy8djIdbbGaTq0OzouHD/VYnyMQHqJqCrbG1TH5LeKi9DkgoiG7kchxZOTIH+FfjPkr
	8PUGZAWy9kbkBCzHagEluJifNQypJHgNWbFMLxTdanCBnh3/KwJv1XODj9NxuB6+dlUpURdvVBl
	AL4NoU9PortDtTycodVvAg7WVhs2l1tqUDp5IxAobncjiZEIfMB7gQWEEBdABtB/T+XfBj8flgq
	f49KY82EZNazynaIrG6/eTjU93p9aFMybtWY6fXVMSVOfYkdFPpKgmQf70LshHEjprHa2+HC9qs
	p8mqU57ZEk9bHe6iim8nsG2EsWWgY+FoS6gvgCuGgi9y+SyMg0ehBWrYuf0Ld8ziWEOtf13oEg4
	ed+bAwHCXcTReqvUMbFtA7fX41NG/PVD0OwrvJPIVyjSVWnGsjnZIf3kaynjWQJLuAz/bHuw+qp
	fDXpGTCMfr3Txn9oW4pSDCeC93QY3YMjeyl/TdeZ/n4gmgl1vd3M/nhJ4EEf/ImuFy84lhdKYuE
	2EPsrZ7nMwv7BSFJE9Ohn0ZHNCbC3NRYyExuh2aR+TfEzsO0SV/EyeiuKQKZqHgQsNSCmg==
X-Received: by 2002:a5d:64e5:0:b0:47e:81aa:3822 with SMTP id ffacd0b85a97d-47f4fd1fe44mr2000532f8f.42.1784105324077;
        Wed, 15 Jul 2026 01:48:44 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm13632590f8f.15.2026.07.15.01.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 01:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 10:48:40 +0200
Message-Id: <DJZ0JXIP13UO.DH1ONBDEVF3N@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <git@vger.kernel.org>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>
Subject: Re: [PATCH GSoC v17 00/13] cat-file: add remote-object-info to
 batch-command
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <xmqq8q7dto8d.fsf@gitster.g> <DJYNU7D4A7C8.3Q2Q4DX27RXC0@gmail.com>
 <xmqqpl0pqdag.fsf@gitster.g>
In-Reply-To: <xmqqpl0pqdag.fsf@gitster.g>

On Wed Jul 15, 2026 at 2:58 AM CEST, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>> You gave me feedback for v17 10th commit:
>>
>> https://lore.kernel.org/git/xmqqik6htpv4.fsf@gitster.g/
>>
>> Should I send a v18 or a new patch on top of 'next'?
>>
>> The fix is simple and I already have it on my local, I just want to do
>> whatever is better.
>
> I had v16 merged (prematurely) to 'next' and then saw v17, so I
> reverted the merge, which means 'next' no longer has your topic.
>
> And v17, as a brand new iteration, is not in, and will stay out of,
> 'next' until we are happy with it.  If you have an updated v18,
> please send it as a whole replacement.

I'll send v18 very soon.

>
> Thanks.  How close are we to the finish line, by the way?

There's one month left. Final evaluation ends on 17th August (more weeks
can be asked, if it seems too rushed, but I think it will fit just
right). I have the other series that supports objecttype but I wanted
this to be on 'next' before sending it.
I expect it to go faster because it's on top of all the
infrastructure built in this series and it's ~150 lines.


Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149384FCF
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816465; cv=none; b=bm03YTfh2XSoiDN872Z1EQtJTVeEDYLsNADcY88341Tckm5wKRa47++nIgUw0PN9JkZVzA/MLU8+p0batkkES5/4pDQPiKnRrMVcBFQfMQc3u8h5NlzmjZexA5g2nMzX1hvQawA6b7vuK/+ohwKjKD8ktm652Q9o01aS1o8QUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816465; c=relaxed/simple;
	bh=sV1+L+q61Ut+scdATI2tbkBJjEmPwoVFpoU3LfNbBro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw+cX+CyWjJPFNjbgXa4sD4mT09K3kRKd29WWtpwvExlpx5tyNZnHJwn5CGNQAKJrJBtU5mXA93FUTfNr+3KFtNSXxAv1n6eGSUTuxSj+LZDxMpLsY5N1aUB+EC/DeqrWXHmiEtMxKwPCxjcR0rI6N/4uF8+KRzAhvP+e4/ED6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvB6IgGS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvB6IgGS"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de28744a46so988130b3a.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 11:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706816463; x=1707421263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umCUqt/ggcHL2zXSyLY+5gfcCc22zN5nYu8ThGtj7zg=;
        b=QvB6IgGSdq+JDmu15tOhGfDzFfLxmH1Md/iLk9+Qj9G6mtFpbXrpZxs5Ht+NgFm4ZQ
         ZDiUAZ3sl+MQT0wiexz7ld7or1Jre4bT7XV5X0Nr7RKnNGaUX2BkSNiaOmzikl9/eEQa
         5zI5OspKr2AN5pQMDBx5jgbRZjcbQaPT4cl6ZOH8RxDjL0wS8PeYoKhmwiwXUkrAlf1B
         r4H7B1VWn8A1NqKwfkZU5R1FwQOQHnOM6XG4mGEFe8+6RzOiMvvXYxzIf6BJxE+9A2my
         L9VPwPiRn0Noj1UneRsJjGkuIgnuumQV8nsiVWeeK6sW3PjOkCWk0q3X0N0lJYPDZ1D8
         e9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706816463; x=1707421263;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umCUqt/ggcHL2zXSyLY+5gfcCc22zN5nYu8ThGtj7zg=;
        b=nR4ZNDwNiskw1TxQDyWVk9OrzUHCCp+Pn/im9PCDXH7KZphitfwWue6kBBqSwGc0RH
         dYlIdNIJ+0N4wwsg1C+n3U25iskozZKVvn+DJBweaVNCwTf9GkfrHdM6aeVqewFODm2X
         yLFuO61cKjEzfwVlYACn8F/4RBTQzgHsyZ30wgkE29C+1Dt864q9zDtFv0V2lTtXItli
         B5wiVoEFeNygT5oLptEXEs4Um/NjjBlpiPmzKjk9g4rgHosXwoq3aTu6QDX8cziDJuBs
         beA6ZZH0BUz4BX4s5V9fkhD1CMvYi26aeQ9bWPhfrpWBwzmaclWJXt4F2IyUppLFYa6H
         32/w==
X-Gm-Message-State: AOJu0YynMA0SpRvn+TIeC5LC0xH03eqsBTSxRtp/H88VjgSY0mI2IgQA
	mP+EHmrOGBmu05bxD5G9AJv8SqBo0WfwCML+mCJ8lnXt+ErtK9g4bn74dniVKh3M5TRpcUo0T2X
	LNg==
X-Google-Smtp-Source: AGHT+IFiIleAG09GbjDSZyZxCAm07O9/c0rF1qGGw2Yv6S2ayGRkEq4Q7FOS4ao8blEdy/tRyca5Zg==
X-Received: by 2002:a05:6a00:451a:b0:6df:c424:7949 with SMTP id cw26-20020a056a00451a00b006dfc4247949mr8114691pfb.26.1706816463269;
        Thu, 01 Feb 2024 11:41:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXhJ8hNos/dEQwJM1FlXLX3OZ10uzGkHv3D2BuQFSo7yf/OC0tyiqgoL3qOA08yV7eymSjnmwzeCkVa1wSRFujRICg2gn22UMpLihqrYduInFTaz+52h9CXSO9FlInbTDxZ5t7xvQmlZ684iIjeVFfDDkIjk0SS6+lp+6M=
Received: from google.com ([2620:15c:2d3:204:a0cd:4622:c199:928e])
        by smtp.gmail.com with ESMTPSA id f32-20020a056a000b2000b006dde023cce8sm117263pfu.57.2024.02.01.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:41:02 -0800 (PST)
Date: Thu, 1 Feb 2024 11:40:58 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/4] t0080: turn t-basic unit test into a helper
Message-ID: <ZbvzyqpvVlVhVi2Y@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <a9f67ed703c8314f0f0507ffb83b503717b846b3.1705443632.git.steadmon@google.com>
 <xmqqa5p4yjmq.fsf@gitster.g>
 <20240123004306.GA835964@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123004306.GA835964@coredump.intra.peff.net>

On 2024.01.22 19:43, Jeff King wrote:
> On Tue, Jan 16, 2024 at 02:54:21PM -0800, Junio C Hamano wrote:
> 
> > > ... so let's move it to t/t0080/t-basic.c and
> > > adjust Makefiles and .gitignores as necessary.
> > 
> > ... this conclusion.  I somehow thought that t-basic part would be a
> > good test-tool subcommand, as it is run from the suite of shell
> > scripts for end-to-end testing CLI interaction.
> 
> Heh, I was about to ask the same thing.
> 
> In particular...
> 
> > Do we have any precedent to place programs placed under t/tXXXX/ and
> > get them compiled?
> 
> ...no, I don't think we do. And quite often I exclude those directories
> when grepping around the code base, because there is often code there
> that is purely used as a data fixture. E.g., t4256 contains a copy of
> mailinfo.c which it uses as input for some of the tests. That code also
> happens to have out-of-bounds memory reads which we have since fixed in
> the real mailinfo.c, but of course "grep" finds them both. :)
> 
> So I would prefer a rule like "no buildable code in t/t[0-9]*". Barring
> that, maybe we could avoid using things that look too much like real Git
> code in our tests (though we sometimes do need fake code for things like
> funclines, and even that might end up creating false positives).
> 
> -Peff

Ack. I've moved this to a test-tool subcommand for V2, which I hope to
send out soon.

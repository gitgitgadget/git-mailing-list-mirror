Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A11D9A5F
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886844; cv=none; b=VS3P9l+3BUty3K/U9xXmOYq094ccEnZ8dt5dYGj35dlDA1HNQ3A/Yudv+sg6Xh9X8VTyLivU9U68objgBduXsy/BLDrlP6AxgV3KtPehJEdohAn2sTRgIEHUSPyy3piEvlYnE74mZ9QvC/6aQzST5ECC2tZhfAJDVB9Gim4tZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886844; c=relaxed/simple;
	bh=SUd4Hq81NmlQtTQF3iaKRONHZlT8e+4iyVXA3Z3htmI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BZRk1U1vYy1KZzG8C9qCOPQaSVUSRKN37IppA8p5HMBRkYDc2DdMDaQgkOGyOINWPoTZa/B2rqtF2/u9g4RhnknyYfV9D+eDY6nwP3QDM1BVu/7A6nK6qK+ah0wmnyYyWRVYRXB5WTFH5GBtCixjKzvDYttXatODTgoxRfxi8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3xVJfia; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3xVJfia"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f75f7172so2442885e9.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784886841; x=1785491641; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zTqw6X7ebH3Gcm06nE5bQZ5WmGBclWS16xM+IIgQcYU=;
        b=a3xVJfia+dLrTuHJeWuRb1ktbq0lOhp/7DW4qFzbSDvB378gVzysmHTqdtVHPK2cpQ
         B5jNpGzrbc3MPAF+9eeH+3g3238waIqIcESmZ9CJPiD38y5wvT9Fdxc40yfP7Z6HFuU5
         OYC6iqPvT0Df5U2jt8n+vvTfhzMd+5YKtycmdPtov0pDWkGLwKjz6N8tNMrG3xJrMbJ9
         iBIdGSt+e+JE2Bv7kQnKInKchAgXuqfygn/YDuKh3q3Tems2JUc2abceB8fR7wSsQKkj
         qcaPM58vqfgJEnwYHyJ4/iE/E9idEKaRzr+g/FjkSKFlXl2a85H2NUJcqkZJw8WsFL1W
         tjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886841; x=1785491641;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zTqw6X7ebH3Gcm06nE5bQZ5WmGBclWS16xM+IIgQcYU=;
        b=DFV0iBSw9xLWgQs6nqjAKT3NO/eka2e3EUqX9KrG2/0wH2iF25WfEzsj+g5wf22I/8
         2CjlVeGFPTbsxp5qsD+oGmAA5OBG+m0/MqqlHsx0KtKJvmPxnjRcO61b2/u4vFd2JQmi
         r3btAwIoFBIFsIjWft9vY1yJNKou1aaf/Nh3ZxWMHzKqoQbTP47pU/51aDCLP8GjtryE
         PIlBhYh2JKz9lj/zXTF/5xL9e002d0Bcf+MvK+O+KmRlxlOQrHy6hAbaCyWwHs9Z7rrE
         MSzx4RaUrRE5Jne797X8u8PAhh2WRVl1C1FTXvdmxCuK8U3qdp8qG5O4ZUhVe9WaD1mc
         cBkQ==
X-Gm-Message-State: AOJu0Yw9ozkDY0Vb7ZYtU5Gpn6p3CJ/6SKdDkyeT8y9CNYVg0SSHL516
	LpKIzj26p/MUta8HjKuQVrGzkj+qJoMO2THiPq/nHXOjIoXzi67BmXga
X-Gm-Gg: AR+sD11id3sisWLBs9f1ux2jPeJhXagYUqJF9MdM3Wpc3qZwAfpBV61e32EmVysp3yT
	MxxfXoEpfyCkNriPZOwG9t71U5/fadZQIMh+QU47i6sBfhtYjHZyqvsXP5YLWK8n7dfIv58csRk
	5fPJ/shO99t9m6FVMrjGQKvez3UCq61rwmurlc2K3Cn2X8TTf+MPvRbYc8FnC7EXZkjH+9pZN6b
	s+aZ3TGBuey2Y5e003I/HRzgOc+SeSWli2IDOmS2MK03OTsCw7PzTRAoxtFyULXBe3bah+r8yiD
	LUs54/g85Lktuzrx/q8uDSQLfa175JnMsGYw14xu6VVKvWexwk5aoJeHqzSByBt+Ew8gPvCNKrO
	z6agovf8PCgFWBcx0JeAMkL4CoCSOzIYBbiApjdH/qV4b83QpucV4W2mmEoeg6jN3zdKPgSMSBg
	4VpX3JMehZn4BoHv14ci3ozSsWP9nR+R/kGN1khizoIK802NFYRvdbZeplPg6KgzVVyfboBcIOy
	vhT4lVtAvZ7he4S405ErHiWITfd7DE5OPL/oZQsyx6O6Sr26j+JkCThw68Vc7HgZc0BfDTfi1FQ
	PzjBRxl/+zq3cMo=
X-Received: by 2002:a05:600c:8289:b0:495:3af9:4cfe with SMTP id 5b1f17b1804b1-49573cf6d89mr78172985e9.20.1784886840854;
        Fri, 24 Jul 2026 02:54:00 -0700 (PDT)
Received: from localhost ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af6b049sm65546975e9.6.2026.07.24.02.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 02:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 11:53:58 +0200
Message-Id: <DK6PKTXUEQRC.2V4RX2933ODCY@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2026, #10)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <xmqqfr1amnvn.fsf@gitster.g>
 <DK6AAT0NM6G0.3SP94VJYJWPKU@gmail.com> <xmqqqzktb501.fsf@gitster.g>
In-Reply-To: <xmqqqzktb501.fsf@gitster.g>

On Fri Jul 24, 2026 at 2:33 AM CEST, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>> On Thu Jul 23, 2026 at 4:38 AM CEST, Junio C Hamano wrote:
>>>
>>> * ps/cat-file-remote-object-info (2026-07-18) 13 commits
>>>  - cat-file: make remote-object-info allow-list adapt to the server
>>>  - cat-file: add remote-object-info to batch-command
>>>  - transport: add client support for object-info
>>>  - serve: advertise object-info feature
>>>  - protocol-caps: check object existence regardless of the attributes r=
equested
>>>  - fetch-pack: move fetch initialization
>>>  - connect: make write_fetch_command_and_capabilities() more generic
>>>  - fetch-pack: move write_fetch_command_and_capabilities() to connect.c
>>>  - fetch-pack: use unsigned int for hash_algo variable
>>>  - fetch-pack: drop the static advertise_sid variable
>>>  - t1006: extract helper functions into new 'lib-cat-file.sh'
>>>  - cat-file: declare loop counter inside for()
>>>  - transport-helper: fix memory leak of helper on disconnect
>>>
>>>  The 'remote-object-info' command has been added to 'git cat-file
>>>  --batch-command', allowing clients to request object metadata
>>>  (currently size) from a remote server via protocol v2 without
>>>  downloading the entire object.  Format placeholders are dynamically
>>>  filtered on the client based on server-advertised capabilities,
>>>  returning empty strings for inapplicable or unsupported fields.
>>>
>>>  Needs review.
>>>  source: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
>>>
>>
>> Hi,
>>
>> Karthik reviewed it a few days ago [1] and it looked good to him. Two ti=
ny
>> nits came up, which don't seem worth a reroll on their own.
>>
>> I think the series is good unless further issues come up.
>>
>> [1]: https://lore.kernel.org/git/CAOLa=3DZS8J4t12ab1=3D3-LRYNuZOwqSHG861=
iYm97JjF3mGprvJA@mail.gmail.com/
>
> I was silently hoping that you would fix these two nits, saying that
> one of the alone might not warrant reroll but if we have multiple,
> we would better get them right for the final version, or something
> ;-)

I'll fix them right now :)

Thanks

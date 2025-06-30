Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F728F51C
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297615; cv=none; b=EGtAQNVrqVbk8g2uvYC2eNS3lGiUGK0zIlnJLHAlrusB/f5jbxU9Zox+6dhkJ6mjNaJnaHEg3rbwjfhOPeqz3Lgr15wt2TcmdWh5n4crKvDMbxjeCZOvQZq92Ewjb55L2p/e4CTiGoGGHPAxTmfG0FZ/FM8OV1E2rh/L81+Z4qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297615; c=relaxed/simple;
	bh=3zyRkloxg8oNBl3QGoD1SSaauwSnu0Kcezf9CN6DzUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KGTxfNlFnfLVkpt7f/VGygW/As+Ee5SmnC5Oxdm851cpHn0wWEjV+nC7o6fOAmdIebYVKtAq80EXa9bkMSOG6f0Jlmod5O+8iFaQXTSaQJEw65ONk8DLSzVfGybfVJqZILfbQc0gnxSZEaEaQGklq8QsRbaUlw0yIp/TZiGxcuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5/eQfhE; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5/eQfhE"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31c978688dso2863661a12.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297613; x=1751902413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZsVi57wJyP95lShxOFkW3l0S1fRtm+sqLaD7OLF8Dp0=;
        b=I5/eQfhE6CU+w7y5d07uoJ3QMpfxFMj6y5BI0RRGEgMnB0ZMlWDLWmirmVq+QCXBmF
         Iv3WC9b0CRrHxhLFpny/lTYYaZGSz7cuBQiuVIwHWKE+mbbWrEUI2kFR+gkgLq51RhH6
         I9AHTCKwykQuCD2X7eA0SVqXfPWD0uddpxnF/bes730kN5IoU4oguFgK1Fn3MfCdrwOS
         uKu1qry+9AMKAb7nnzRCGEftme5yI3m+d208LAGW3lyDIjNrzsYItRd3h5e+d1e+h0y0
         IaW0UyYJVjQwIeNDJgcyX1Eh315+fJgV1PzLZnxaLecViYILSe7Eti4C/P9Rtyb0bSoB
         GU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297613; x=1751902413;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsVi57wJyP95lShxOFkW3l0S1fRtm+sqLaD7OLF8Dp0=;
        b=Q/cbWc1QFplx4jDn0cwE8jYDHQ+WOm/iJbfraNLBD2i9cK4LmQs+6JKT4iiwlX7sXF
         J0RuT6LC6B2Ajw7KGTpUXpcu268mZ/SvynXakc1hxiwB8z9RuS0nmONemnZmseh9D9pe
         hLuhVzjncm5QFzQquHCHnMcM5Fsldtzq4y0xTqI5GJIndPuQYIRlO85nO9TgKxNZNffT
         acVmNl1IOqKclH7XyaCFXcmugE3prdvQJ6QDyqwMwSXJmKyArahBkZfzQlOzrh6cuVk5
         EHKSeaEU+SXdq3fFRZexGbF4yAYJIRJFtpmDiIUbGHpJ9x67j67AE1pIXdWhPXbQ2LX9
         VkPg==
X-Forwarded-Encrypted: i=1; AJvYcCXA7TB0pZzBjJY1uRyuu6+7g3WmeNU43B3kE22y6ucnKMKhCafitiNMFbMTfrQJoRvCdmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7pi7w/A0VcMmVdp+Y/pGi3MFSGJLC1LwOzqt/o3tE9E9t/q0i
	bHc89iZy1/goooZ38yVPKryhKK+a6CKP3Yt3hfEhUz718eURxOYNVRL5
X-Gm-Gg: ASbGncsfN15+PuOvUQ69/5/qEUc7WvGxdaMsHM8Y6rvHHayzLx4qUZGUWjxMgzGXqjx
	vOIr3iTqcwo7xTX66hOqQrKo++8tEpSqBjUPBZ/tZV7RiIZjUTuhjxm5yheKWmBDVFTZqySNU4G
	kXm3Ij2rF9QmShA5GEHX13gB98r4KClkEVWuUxx3GuOGHAQXDSA1LDyYNNY1Q+ZcrRTj4xdc39s
	sH4F93TlGbtFZ2FI5hsOHH9u+qFn6mh0pJGmVpxa8H7d0gs2ZDOnyvK/3Tt0gUK/9OjUGHrqtq6
	wgluLlc0QC0mh+iHhZohs4uL5E2dWLQNsv869AjEIqNEyuUi1jYNwysJBdHnGF89qimdEQRMG0A
	Q0DDF8cKc/+9QuOFnO0WsLwOrGt8=
X-Google-Smtp-Source: AGHT+IFB+Ry6TxBm4/67CnW3Nw/nSa9bpEh3TG3XGybgRCO3HFwOQd+slw/exwqPaxBU4D0xkmF14w==
X-Received: by 2002:a17:90b:2e0f:b0:313:bdbf:36c0 with SMTP id 98e67ed59e1d1-318c8cd2734mr23596637a91.0.1751297612583;
        Mon, 30 Jun 2025 08:33:32 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3afc70sm85554805ad.146.2025.06.30.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:33:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  git@vger.kernel.org,
  yoshfuji@linux-ipv6.org,  kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v3] daemon: correctly handle soft accept() errors in
 service_loop
In-Reply-To: <0d507273-8b8c-42d9-a14f-27a5da0dac27@gmail.com> (Phillip Wood's
	message of "Mon, 30 Jun 2025 10:00:17 +0100")
References: <20250626172159.87204-1-carenas@gmail.com>
	<20250627231404.27100-1-carenas@gmail.com>
	<0d507273-8b8c-42d9-a14f-27a5da0dac27@gmail.com>
Date: Mon, 30 Jun 2025 08:33:31 -0700
Message-ID: <xmqqv7od452s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Carlo
>
> This looks good
>
> Thanks
>
> Phillip

Thanks, both of you.  Shall we mark the topic for 'next', then?


> On 28/06/2025 00:14, Carlo Marcelo Arenas Belón wrote:
>> Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
>> 2005-07-23), the original error checking was included in an inner loop
>> unchanged, where its effect was different.
>> Instead of retrying, after a EINTR during accept() in the listening
>> socket, it will advance to the next one and try with that instead,
>> leaving the client waiting for another round.
>> Make sure to retry with the same listener socket that failed
>> originally.
>> To avoid an unlikely busy loop, fallback to the old behaviour after
>> a
>> couple of attempts.
>> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>> ---
>>   daemon.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>> diff --git a/daemon.c b/daemon.c
>> index d1be61fd57..9ac9efa17c 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -1153,11 +1153,19 @@ static int service_loop(struct socketlist *socklist)
>>   #endif
>>   				} ss;
>>   				socklen_t sslen = sizeof(ss);
>> -				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>> +				int incoming;
>> +				int retry = 3;
>> +
>> +			redo:
>> +				incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>>   				if (incoming < 0) {
>>   					switch (errno) {
>> -					case EAGAIN:
>>   					case EINTR:
>> +						if (--retry)
>> +							goto redo;
>> +
>> +						/* fallthrough */
>> +					case EAGAIN:
>>   					case ECONNABORTED:
>>   						continue;
>>   					default:

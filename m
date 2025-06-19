Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997C19D07B
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297494; cv=none; b=Is1bXtaovttnjWFJYKuhtz5dXNr69+zqqRWoIQa7KddotkXna83Yps7h9p1tw6JV6x75KYV1jsvBE8KioAJxND4OOJghXNdcVzsSb/2TlHR8QLJB6z5o8BQgyz/5zPSQd64qN2HjxJtzZBDSIEOHuiZIW78wvpbuu9Thl6Xa868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297494; c=relaxed/simple;
	bh=hzJSVZXDfQrM3N0GpOmIh8vRfTaGzO80exKcT2vM9FQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qEZRihiSsiHLvCRG7uau1CcqnH85jiFmhVg8DkcAWT+dnGbBZOnmFt2l6Dr2NNPQ/MY1xuzwu4L4DMSiM/OyWbH25B2Ji6p0T9BInxzb6swBufwW5c3GB8QNkH8o6XY+sTq1bGcGHYS9Wq/NIDVd3Qw2LOMSTohZ2JmvXsAXaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HytD/mv+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HytD/mv+"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748e63d4b05so124084b3a.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 18:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750297492; x=1750902292; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Q5soJ+BXDrjG0YTOdji1h/de2yP5SM4TQKzjOypPA=;
        b=HytD/mv+X01SJ1fC57rgbACHB5ZJXijzhyiS1bIoQYXFPD7V758ai5DNgo1nFzTCo3
         QgfT35anwwm0GkffCf6HTp774UJRlmE07G2IexWa+Cvj8Pde+qJDdQY/JM/i6bSSLsQm
         dsglKjMZ1XKZjE5lN4FNntHjRgfWcjknx322YYO2YNLP8ME9AYaPloG3JN7m+m6KLoAh
         YhXaXbWsO37Grns2uXFVzNt4IgC2USjjM28fFNOhyPzHTK/d90JBdFO+eYZvsF2nay9/
         45E9bIfUE7i563v2/9qnMBHavXZEQjR+i8oyUfYWht1avO26vn4jVL7t5M7Wr5p0JHQ1
         wpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750297492; x=1750902292;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Q5soJ+BXDrjG0YTOdji1h/de2yP5SM4TQKzjOypPA=;
        b=fixkYVX095OdHmzQPQfWB7bn0j/dPcOuXxwi4qvhlqnkPGz8Auq5dB0sOifrvp2DBQ
         tDcHrLuI62k2vErNUQvAIwepg5j2rgxmiZEYm3aG9bpb1/4bCYYW7887G35cI/b9AXZW
         O+y+eKAS99EdVbv6V3Quhx3uzr7UhhzYiwiIO7xyiRTmsIwIl7TxK1CrHSldQjHYfNRL
         04CYau57vvm3phnfyqA3vI7PZdJmnw89zmgtIagq++CdSQspHp9iNUN1Hss/jFaQIGEL
         AKIczh71ZxUN/LXh1f7eQa1+sXeffs2Pm2TsWuFgr7fzakbl4RzkW+gaxqpeaGhv5/O3
         9a/A==
X-Gm-Message-State: AOJu0Yz6gaFoL83YpHDjYclCEjnfg/7WYThMJta4T9jovTVgyUGQPJpV
	UuemW7xDFJW8YGdBi+3lLe5DKPQ3CFvDWryJz05gpqmE+68k+whPmMSA
X-Gm-Gg: ASbGncuC9WbdScCceApdte6otLyZnnWV7m0GpyTLz3L+v4SVBma/Cu+E1y37k9oNjs/
	72ly0aBh7vIAOE0n6wJhITemSHmchWCzSwHOEsjARCY92PwypcseiqpLrl14elwqsIQS26lJnuS
	dcE2bIOBJUfg4WTc5Qux9bERrzg1gj1G5qHCkxbK9EYoz9bJJPZYcsIT826GABYCV/C6BvgFM3Y
	4xw9ZzmfxiKz77vS588qOUkHQ8rMSWtH+rGhwFdWXP7RViIR6IvnestVxUo+ZgK3lqenExcxpw8
	eqE6RDl1N5SO5OJdt4RUqICtTn50bxgQ9ftaO9u9b8+oKPyZC58guge4nYPo1eFPgx8WX45RoYn
	9WhF9TPbqL9c=
X-Google-Smtp-Source: AGHT+IEU/GTzsdkRw3tRwokRa3HsP5Zd5xCEkijJVe6pjeinGEU6i1ljFjx260kMBUfWuvO1nYyCtQ==
X-Received: by 2002:a05:6a00:b95:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-7489d00473bmr28533839b3a.21.1750297491781;
        Wed, 18 Jun 2025 18:44:51 -0700 (PDT)
Received: from smtpclient.apple ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890006367sm12301109b3a.52.2025.06.18.18.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2025 18:44:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqfrfzz4xq.fsf@gitster.g>
Date: Wed, 18 Jun 2025 22:44:34 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <110154E5-666B-4093-ABB0-ABAF2E3E107D@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <xmqqikl3mtx2.fsf@gitster.g> <2EB72983-BA77-47C3-9331-B08760B092C4@gmail.com>
 <xmqq4iwkd68p.fsf@gitster.g> <C339DA52-F88A-4BC6-98DD-1586A1B4A175@gmail.com>
 <xmqqfrfzz4xq.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> But I dunno.  When asking a single item from the command line, it is
> perfectly fine to respond with a single value, but when you are
> showing multiple items (especially without any "give me this and
> that item and nothing else" specified on the command line, in which
> case nobody knows in what order the value is given), I think the
> calling script almost always wants to get key-value pairs.

Ok! I'm polishing my v2 and I expect to sent it soon. I already changed =
the
output to that format.

> Also are you planning on later adding a long-running server mode
> like "cat-file --batch-command"?

To be honest, I didn't know about that feature of cat-file until your =
comment.
It seems to be a nice feature to add, entering the keys and printing the
corresponding values.

I'm adding a --batch-command feature and the removal of the dependency =
on
the_repository to a todo list to be considered in a future iteration on =
this
command, after delivering its basic functionality.

Thanks!=

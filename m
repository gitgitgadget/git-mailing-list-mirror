Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E536E466
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170022; cv=none; b=THs4zWjeNzGcOSPqtuMrzEDtaGr+m/x+Ivhft27J3rNR62jhaePrw7UEHPV8FyNwGplok6MKTa7l67wMVFKBhQD2X0pNAF7shqUjKL6Bwk2S52oPwbXydzDfjlbhY0B2BCDxLoEKfmAf2ssAvvh/DsP0zWK2xVdZ06Iz2nnkenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170022; c=relaxed/simple;
	bh=90PiDERvdLl9ZVqxqIyBtYq7G+XRoaIg5ap+ibI+kHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBfs/3CoW3kbi+PbGAoXYOShmU3tLEWwloRQhEvcc8m/u3Rj1Vy92TW3FpHdERodrNScZvs8+lWd8Dz1ZWa101r6fFkxCf0hLXtQ14s27+I/BHOmscWhnhzaDwF1y5caoYE67pkSYGs1qBagWgf9Q03pCCDhqqHQQm+Z8cjBnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9yWazQS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9yWazQS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824b03d9787so55885b3a.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170015; x=1772774815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zqn/lZctJlrrA8TjDluh1wB4pu0ivfQI55+iE1nLVPI=;
        b=V9yWazQS0Rmsl2L6tpTYrr97t+9k7AA72KeaGyiDmPO1wwci65vc3RSKJ62Z4D0otD
         cu8hstHft0A5jMPMD71LZoP+vshpqjoBw82ODrjZjAhuJwaXGd3RfNyV2iddMF3nCF8k
         Dx23sFs9mpt/bkMNjXq6SCLN3uNjSyZzIfz1lo6WmWiUMdaDn3uYHf/IXpAT45x3DMpH
         xsYx8seiRo2MXinB7HEOPaCl3M+tTzBAZLYMGDYNoidhq+TZkDp25gzGwCakJVIPdUR7
         2LdmyLgnoB6ZylYVX4dgsz1b13tw410WdqfvJvi/giHu7F0q+BOwURWrA+CkE48lyeYx
         oysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170015; x=1772774815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqn/lZctJlrrA8TjDluh1wB4pu0ivfQI55+iE1nLVPI=;
        b=tIgKe24OrTXEsbCfQ9+eKSg6PiMKsRBONDFlc5gx8BRF6VPOnvPX4dmxYwAkE0IIwL
         /AZ5IqoKLVEs8J4MxvySGGqE6sM/l1CJHnAF1OCVYo6uLfNZIaZbdcsyiD2DqPM/Tu8x
         7sedmZl+xlxqS1y7NYpA4MYg/myYxqYO1BzfVZmR25l9tQtpbnWOb1E45rrIGWilF38x
         MkEoGJR6Ken8I9nBiz88yXVy3SRWqdwivDVdjPCijzK/k7X9u7mcSD0KIa+73gUhTlG2
         U6tGbU3CeyLO5WJ15P2zrmzm+UKqE8AIvfVFO1r1xs/Z/ETh9j/4SjEqdeyO/KS4yJCE
         NOpw==
X-Gm-Message-State: AOJu0YzcxniUOnfgpLRpVDhH8TzAjVIIfKRf5QS1YytP711XLmYpWW3x
	EkLzCQ12GoWbbPhI4wiZrgONqDcLVcHJS3/Blg4XaQoNo0UCeOP0qf1S
X-Gm-Gg: ATEYQzzrp4IixszO2+cVcgBGY3QpD5zC1jClPvtden1FgPqawF55HMmi+MNntGUUjn4
	DzFxXuVG2Ero6Wx4vKzqJ6N4NufHxDkEOL5e3/TeUX0NkCRaLUvLvXx0p2g0zwlnClWAyBCGmCd
	Xh6dWe2MkG9f4ex5IzKFT8L4wcPLNUjLNJg5x+Z5SZyyus2nILuDsbiWLL0QKIYLIarGlCGid/f
	hbhEbmasP4UNhJdnnfThHzXnoePvf/MBu8eiMSCtc8wyLEciiPsgtRTPImr+354krE7JSc3gkN8
	QXdI8GQKb4auYJq5XoUiFjD2qt0EGezXqh59jtLXqh+25rezTzfMVBkqEcdibjDcV1JdGcKzrAR
	ypJHtLTbOMY4pozymfGZpUCk/q8bwTxxadm2FVXlDrZrHk7351f82IGdVFd5DGv1+MbJuI98F9g
	G55rv5fFmE9ankxZ7AWzuBq6KdDAU=
X-Received: by 2002:a05:6a00:11c7:b0:823:b2c:4aa9 with SMTP id d2e1a72fcca58-8274d92d7d3mr815361b3a.2.1772170015225;
        Thu, 26 Feb 2026 21:26:55 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm3895386b3a.8.2026.02.26.21.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 21:26:54 -0800 (PST)
Message-ID: <bcf64540-fe84-4fcc-a969-6927f348608e@gmail.com>
Date: Fri, 27 Feb 2026 13:26:51 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260222102928.377519-1-a3205153416@gmail.com>
 <20260223074410.917523-1-a3205153416@gmail.com> <xmqqpl5rumy0.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqpl5rumy0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

Thank you for the error reporting.

It seems that failure "fatal: error reading 'nul'" matches the 
'die(_("error reading %s"), path)', if my understanding is correct?

So during 'git diff --no-index', the test passes 'GIT_DIR=/dev/null'. I 
highly suspect that 'stat("nul")' on Windows fails with an 'errno' other 
than 'ENOENT', so it falls into the 'STAT_FAILED' branch...

...which can be simply fixed by reverting 'READ_GITFILE_ERR_STAT_FAILED' 
(and probably 'READ_GITFILE_ERR_NOT_A_FILE') back to being non-fatal 
inside 'read_gitfile_error_die()', if I'm correct? In that case, the 
logic of the test script should also be changed, shouldn't it?

However, I'm sure that this change runs counter to our previous 
discussions. I can't think of any good ideas since I'm no windows expert 
either. So you can pretend I never said anything :P

Regards,

Yuchen

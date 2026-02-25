Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0913E02A
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978492; cv=none; b=bTMHBOdsZUhBQ9c/HBFIvQOqMPC4JiGORe1XWhHYK0mw99dprXNBhb+vI34ApV+uApseOc2FL/oal0LkPstn9xKV2EgWcvU/U6Qsf1j7qYHWdu+Q5w2FPRnLfaOsV3NXuGEDjjeTrCW0BXSY7gdXKsg/x7QZP8eQKZp0ZjDoylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978492; c=relaxed/simple;
	bh=JPhZdV2NoNbVaN7IOjQnAJiMY/U8DLbNmwJCsUGtMcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1hvvnQpVO3xHZUKUfCEY/Xb+rEGVOuAaaSqsedqvcUgWkcDk/HIUZTTtZgMwK3p0O1j2HWRIjOUbA5ESd0xtOrMZM2PQQBUj/8spofPxxtP6kdzXlCa8eJREgdmr3VIh8udyIEEgD47vxnsgDq/4DNSTTdeOVonxDuNIsIuLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU4wgHel; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU4wgHel"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8230c2d3128so2599583b3a.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771978491; x=1772583291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y70B25JV8VVnbbmYi0j4FP9IQjmOaroWCkMdqTBr4eQ=;
        b=fU4wgHelrar71JNNQCzVSWrGB+zr+iBYASLw2jnOnDypAlt8KhCCohqCqqUBkIt08c
         Oieqa1O9tAYuOuboVtak9ondUQT7MitdPW1ENtZLgx9oK6fDcOnRKiGP6h26wzraaJ/4
         DbvGViRFzemkktCTlRWkohd0QatZO+TRk7I6IiDDpfwqb9tLweJAvbqMDVuwQyIpTu7O
         PF1J/sIfCP4XVttOCYgL0Emij8oskiZ+hP4aAvOjb/O1zBhrZ3pxyuygAvmvWTnJjAf7
         R5xv8ZlDSD4wXYv0xi8VVAwFKTq1yGTLFIcFwZE2lSUgpEr5jMi3XIH+EZ4MAJJMUPA6
         H9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978491; x=1772583291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y70B25JV8VVnbbmYi0j4FP9IQjmOaroWCkMdqTBr4eQ=;
        b=OxuwXvZWJcAK7HnJa2QrEO4VLQ/SAKdFQZDMJ2U181j+jjIGXO28Cyiq44B6o2Xxl8
         yAl2mX+X7IS02s1s3viSBkYHtm/q5S3ykhr07UycXfYp8K3W7cSanoYphmr7z78JZDWb
         66GI2YFOspfo7W+6dXSNf8kXIfTzIdZZwUyGb46QcVygPKimmuG3UTH9Lx6INQdfMcbT
         O070USIdaQ2c6CSI7p65aUWDJZ/IlE7bgifZfzswY0CjtfdwnPEJxLFIMiVka5B3AcSy
         AylXu6a7IYqPPCXYO/7Z0wypt/MT90/e0M3yTEFWsQ7wDhVZ7WncqTCXk2FW1wicDRXE
         pBGA==
X-Forwarded-Encrypted: i=1; AJvYcCWGp0LsZyhRfwc50ANyl1RZQcaS4G5XaN9IKCaMq1vDoZcxtvX/VFbcGzKJjyZNPDRvdxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPbHsHY/TzdLaYsRnM5vkfE6N6kXS2H4Vh0COgZRVMcpl/Fh5
	6t8nDQrfzL2+PPALR7JKNDYqE2godYqM9h57/0NmrYmmSgshCOesg1ZQ
X-Gm-Gg: ATEYQzxAtX2az9bZuDyAJFn4+9VohD6T9rBLMjVUCfFpOdWj4RA5Eo6s1ypiZ2j2q34
	Yxb2grPfhuJ01E/rz6XZKaNIgP2BFljujbIBpb8+ux/O5RVOUuca/FykuSEuza4o0q3wPsE/GDj
	F/lozx7fFRu4qlatYa4eVYzbeejgLCCI7Og9QXXePTB64wMHMY7kpXH9USM8QmvBAKIfg7+v7LH
	uigRsT9gfIYo4KrVw3JwhcKJ86CKlXCpvbKVN5iXufZorKws4cpEBAx9OkKD6gDdBSyhIgohtqy
	i3URrHaOs9Xq1999KNQKUiWTUE7QTG4EObN0ItDnHzEuWQv9yDxQw/sjdR1wkn1TbFsJEtEsM2v
	ayRsWhRj/7xIuHRNrfpSd0tAlSEYdmixidv9766aPacFDad02DvnWAEHESkcQn4usxU9Dc3fyoo
	y4ZC3YCK0i7OmTam3ft+eGXiqidUcu8YRONUAS6CC9qGdRPBiF0ogVGFeb65V8gD9R8+28cwqOL
	Gq+rGzjmL8AYrcsa4x+xONhhGHYXKnm
X-Received: by 2002:a05:6a00:929c:b0:824:16ae:9ec4 with SMTP id d2e1a72fcca58-826daa8a3b3mr12251301b3a.63.1771978490839;
        Tue, 24 Feb 2026 16:14:50 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd6c601esm12888661b3a.29.2026.02.24.16.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:14:50 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: valusoutrik@gmail.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	lucasseikioshiro@gmail.com,
	siddharthasthana31@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to show all fields
Date: Wed, 25 Feb 2026 05:44:39 +0530
Message-ID: <20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224220833.17730-1-valusoutrik@gmail.com>
References: <20260224220833.17730-1-valusoutrik@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> They do not matter plumbing commands intended to be used in scripts.
>> What matters more is being predictable.

> My bad for this ... I did not know about plumbing commands.

In the Pro Git book there is a chapter which has a very good description of
plumbing vs porcelain [1]. It might help.

>> And it is more predictable.  If you ask for two things, you get two
>> things.  If you ask for one thing, you get one thing.  If you ask
>> for zero things?  You get none.

> Got it.
> Thanks for the clarification.

[1] https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain

Regards,
Jayatheerth

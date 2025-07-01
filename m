Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35801CA81
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407848; cv=none; b=M6E+pmETGxw9zg5Z2UZFVTxBL190PXg9OeOnlFxhQqHNPYGqgfXqvl+BLB+tl31i4BZwJ3iqi1a0MYTS60RAKzQEeTzXIYR9At2ZaSZbhA9cTTXNJCHEh2YK4bhkGstrwmqj6qGjtgnT6QycOVU4BI2XrAGQO7Mp+wLUOmT5DnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407848; c=relaxed/simple;
	bh=d39OvYdOH+7kUWrq7zf/6RAbHi0Y/agTcr21QHOl0bA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2HO1y9vy2kvXmBsPzgnYp2fNx3fQKe6OBZRwhnLG4WRUZ2Vlrxd/9HWe5WsGJFlvvx6DCJObD91MF8IhvmpW/iff4Ekc6QLkdwufE4/FhULo87UfahpTaUkHgh/hEyHcaONuypnG2LPlnKUgtg4KJd2KOdwxy7wByZSabZUn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUg4JxfX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUg4JxfX"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso5377575b3a.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751407846; x=1752012646; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d39OvYdOH+7kUWrq7zf/6RAbHi0Y/agTcr21QHOl0bA=;
        b=OUg4JxfXhpuFbNg29hDit3HuOswSYR8Oe23+6njBjtWuuWlWfEI4TO9r1MQzhMQaUS
         neE67VmQltOsa4EcUkrhRfoL3I84O4hZbp5LrmfocpORRKHhrdKDSFaYp4crD074gpoA
         S6SOJfjUIuOAHsUW2NlB03pQr4iaP/dy1GAdNk0jOp5dfgAKD2rFknQ6gVSpgzNiSF58
         dFNX6u+sVZv0Nu8csSUWC31oNKE92KWFCCG8l5P4RjN7W7w4q8Yzs8PrxKSM8LJvs6TV
         7ymdgBz2eS6CWg6CC/y9JrteoZVv8XtrK/5EgyEFO+6nvEHCXTeWnI43YMJ2SmgJNmw5
         tz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751407846; x=1752012646;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d39OvYdOH+7kUWrq7zf/6RAbHi0Y/agTcr21QHOl0bA=;
        b=MKzazw8sUZ+mO2Zsfm0zj0jGi5ftcgcynFN3kyPoe+nZN9WfxqHTP5C3gWUVTkCqtT
         yva71q8yqNGUUiMyPuVixYGWWR3FBq5p9TmsZ4QaqhdqUXAe7YDEWJLw9HpnxR+ohRj5
         FS8ntEqnlmPZIVccB6HXRTT1Dhe8ENDSYCBfFhlGlKtpzasSpwywRa5cAgFe5hJZOXKu
         0rV/6Z/yfr9Nrorf2Rce2XVuoUU/QFV+U0OkFANzQ/yFwXv98vf7sR4rXMIUYyxkIMxU
         vIgvGO4vgVSmAhHodPicORmyaAbwiIvfzunQt46D3I8a2l7R+wgSe7Rpjdi2UhMuK9/g
         tMYQ==
X-Gm-Message-State: AOJu0Yzeta9hkvtBGMZjIx6PmRP+VEd3qn+qMjsfRGeCANZHSC8Rm4uM
	vWnKabJy5jwxfZ65EuV6DnSNL8oWgyGiyI1U0YToub/zpA2YSBydvGcg
X-Gm-Gg: ASbGncttsYFJsm0jE2dv80dNKQmsIVVv9+w23/HGJAnGRJYVSnbes//1G7gII4AMCw9
	VEDzF4mXcT/ExHQEQ3P4o9LUCgkO4fkNB8ge1r9sIzQEgxTd1exwBMVNHX6BYGgR2FbXiDC+fT1
	KDgKaVyUXCVVjlhDSqjEFnaqguImqnh9fV4i8jkBHPIGd7broYybwE5fnD4TWiIj7Cs/USQuup/
	hzp7ucw0cV7ISM/Xn+BTz6ZxEUxuASaHc8nzIdsjA6mrQt/xIyIeF/HQXUeC/TEUTe/DcvvmWgQ
	AzyHoBn2aIEz3rtNzBblnD8UAZkhDiuaLe+fA1bAkvmwyuc/MddH5en9pLjOq+rmD4rKVuOZGCG
	r6cEIZ3+9c15cHBRVbHgrTYWEUWI=
X-Google-Smtp-Source: AGHT+IEr65x/ranPWHsEgBsj8L8fhDq7WybZNUTvf8YCszIKQF8lfv7MNSMQWQsG5GisB0AcUhA/bg==
X-Received: by 2002:a05:6a00:23c5:b0:748:f6ee:d1f with SMTP id d2e1a72fcca58-74b5126bd46mr575835b3a.20.1751407845912;
        Tue, 01 Jul 2025 15:10:45 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af540ae2bsm12059674b3a.26.2025.07.01.15.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:10:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/11] Add SHA-256 by default as a breaking change
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 1 Jul 2025 21:22:26 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250701212237.766774-1-sandals@crustytoothpaste.net>
Date: Tue, 01 Jul 2025 15:10:44 -0700
Message-ID: <xmqqikkbimu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Changes since v1:
> * Add a build option for the default hash and use it in the tests.

WITH_BREAKING_CHANGES flips GIT_HASH_DEFAULT between SHA-1 and
SHA-256 as before, but the choice is now exposed via "git help
--build-options", so test-lib.sh does not have to switch based
on WITH_BREAKING_CHANGES and use the build-options embedded in
the binary.

Very nice.

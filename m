Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D94C85
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749699750; cv=none; b=k2q2kTTBSD2Nxh7hmID/OCQqtgtrPim+ZWdy79KwF7xbsLsBB7BOTrvN5L2igmbDyw4tP6Qrb6rUGFAKX7HASf2IFT1tMEQWxowsU0LgJvzB70fEBTLzP7oeveL2A9AV31No4mX3jawYeURy8GoQox8+f1GsoqiK3mou5qJA/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749699750; c=relaxed/simple;
	bh=rUhwNyDMdFx8eICyJvzg2Iz1HpiK7tWw4yP/N9wcAAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V1w8Xh4New4vanm6/RA9KsyEEQTyc/u7UYz91Cm9CK2pAhT0DM8NuQyI6RO/rioMUNw0utGvVFTLK1tSSx933I3VbU7LANQQ2VQzKEY9aIBn9FkcuXlDO0s/F1ZvL2UtEEsYYxy+AGgdRfQkC7ftIBLAHmLGrqBcUKKobpFYi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guV2JIl6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guV2JIl6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so1557787b3a.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 20:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749699748; x=1750304548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUhwNyDMdFx8eICyJvzg2Iz1HpiK7tWw4yP/N9wcAAI=;
        b=guV2JIl6KLrowBMHUI16fPQpyhsRYTlE1/ZbkimWrmeV240BqcCDsTdAaPKJEpcRpH
         0gpmQj/AiYwc0/agbB7vdP5B8Eyagrt9JI9i7g+UHz6h47KcEubOyqw2XchTppB6EwSc
         ah1YfLXwPp6AW85HCWuZ/utMnzzHESzXtu4EOA3bN8X4iKnmi89y6MUiTUddiNmJ+3kb
         LUArsK2qt8k1n4iawaeq9jeEy4WXDh6NvVh/NgzCsKHMCNEQ+C6tAkVaY1Z+11Ml735l
         eF2FaNzZF5YWfldWIjr6PuDa7PMud77uYdUWPoPKPoqA8bXoaPTclPewRivfoR+xiivt
         meUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749699748; x=1750304548;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUhwNyDMdFx8eICyJvzg2Iz1HpiK7tWw4yP/N9wcAAI=;
        b=bWaTdu1RuBw4q1khnpVE/yIeJfB8ehhkZfUBfj9ZWrGCIMaFuV7JDEBAoHFVVnioY2
         UwPPPiVO0tGEEmnO+cRlbVbgDGLo5xGb/knRPVFaMwVStYW1CJZfE7c/3a1boZ4FYnXR
         EoW/jcoDsvp3JhDNkdEJsEXOz8eGqiaE/lziw6Ln9qhKIQTNgE0WUVt2YOoZa5gn9spO
         rTITy6ZOxwvViTKjSRFl7dGjftMao9GIl5YFYm4okKGja7A/7r/kCagJEh8tUVXvNaN4
         h0G4I3GMMqnckXIksIdaGokvxU1BadrYPlz2+T1VuICg0EXdbmFDxLNOZFDsNXGzJaai
         t/JA==
X-Gm-Message-State: AOJu0YxfLoKLWFOzqitTi2J6rpOnwmt8zPJ4qlo7TihH8N+d9wspt8N5
	S3vI6IQjGmWTn46gtAicph1B3yCM4q/rzt2JxIgPRtM2nNl4YXGrwKweFKsrzA==
X-Gm-Gg: ASbGncsOTJbBN3CWRaQlFNWeBKtJGOEdzlTnK4lLFM3qJvPVEsY9i+zWxqtX+64+NZJ
	X4LMk+AoptV51zUDKuMIRgq4CkqcOSn9FIp44NDQlYxrkVfR50to0KX3Xy0m54EZB/7WVBht1zP
	2S7g/JDegwU69EBQM2p1/80Ql+EHQGybTr5FWRnYyRnhwJm5YMoWQDjjvFsTqT6K7+Pj90q59VN
	FoqiiHgqUu/MSXNJp2t+V47fhxVMFdg5Sw86MNwsEypkbevZQEd0Y3Qhq+0rHxEf5Okr8v6WKsi
	UwbBVa8IXrd5X2uyp62Avisg4wczvKHmSOunuSjhNuhBgBA5MLR1zA==
X-Google-Smtp-Source: AGHT+IHq+OOtkxlYBeAJVKr4YRrj2jGcxv6tSAMw8WoW3n6MvlXT1G/biEYy126g6lvN4+J1Oj+teA==
X-Received: by 2002:a05:6300:6d0e:b0:215:d64d:412e with SMTP id adf61e73a8af0-21f99106bdamr1543349637.20.1749699747675;
        Wed, 11 Jun 2025 20:42:27 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::53de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488089656bsm392397b3a.69.2025.06.11.20.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 20:42:27 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: Solaris sed
In-Reply-To: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
Date: Wed, 11 Jun 2025 20:42:26 -0700
Message-ID: <87bjqteicd.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Brad,

Brad Smith <brad@comstyle.com> writes:

> Building on Solaris I noticed the following two issues with Solaris sed.
>
> =C2=A0=C2=A0=C2=A0 GEN version-def.h
> sed: Missing newline at end of file standard input.
>
> =C2=A0=C2=A0=C2=A0 GEN config-list.h
> sed: illegal option -- E
> Usage:=C2=A0 sed [-n] script [file...]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed [-n] [-e script]...[-f scr=
ipt_file]...[file...]
>
>
> https://github.com/git/git/commit/e1b81f54da80267edee2cb8fd0d0f75f03023019
>
> The second issue being introduced fairly recently. Not sure what would be
> appropriate fixes. Just pointing them out if someone has an suggestions f=
or
> fixes.

I noticed these as well, but just ignored them since it seems to build
fine.

The first one seems like just a warning? Probably something to do with
POSIX defining a "Text File" as "A file that contains characters
organized into zero or more lines" where a line is "A sequence of zero
or more non- <newline> characters plus a terminating <newline>
character."

The second is more tricky. The '-E' option to use EREs was not added to
the specification for 'sed' until POSIX.1-2024 [1]. Maybe the script
could check for the 'gsed' command? All of the (few) Solaris machines I
use will have many GNU programs installed like that.

Collin

[1] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/sed.html

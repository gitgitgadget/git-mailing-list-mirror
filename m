Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB21F931
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761211; cv=none; b=kXolZ9tv+QgHQcwAqc0k1se+YSi5j8mP3m+QgQLf70HR9g5ajKOZK9iwz4wveL6c8lJI1Q5fYpiwQm+Z+LWhgHmCa+BK3sFUzaEzoA4SkB9ilNAdXzfyGuh+FmZJoDUciJ+Yx8ilV/Ev9q9wcum5tUW8PyWawSD/BayyiQAEetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761211; c=relaxed/simple;
	bh=vG9+ixBfaGvQ+A19/B+QQr2/C8iH/5wtigzVEzezc2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/dHtWVR5+lc3vqoP+1DflmdJkISokU1fPxK41W2DY2ZcWG5/ltjdAlhN/LGjAfzbuTPBLC442uqGJb3MPtmSKCtiO5vip/S+HB/tEIQwEYYkANMzJ5Ht5w8JVkQ2xBaEpxqX+7z0/H+Or+Opwc1n1pd/a60D/pzvH/vf8cqr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehmDRScj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehmDRScj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725c24f3a89so2446987b3a.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733761209; x=1734366009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG9+ixBfaGvQ+A19/B+QQr2/C8iH/5wtigzVEzezc2A=;
        b=ehmDRScjqIYFv5DeBjxnLSf3HNKQX9Eh2/AOzI+lUwbcw+bnvVDPWVoJ9N94QMql1f
         EUtswJzJe3/UDLxaAxJ6goCdcely/hljf27Rxylll5wf1SRHzP5LLNixGudROXyMc+a1
         I3BizbL6I1Fh7v/SQnzKijTRBktbh7LtlUTUZmE/E1bByCHgUcxW56iagWd6GfKlexAW
         UKaACE4VpLRXugIMItYYbOfG8+ba5DDG1F5WyG/Mdq3KKEa2rTYX6487apffAqnjgiXD
         TJaLCGU5xHvYUvYklPiQxiP2ZBZOGpcI5zv+lDvWlOKd3pnCzh/IsAsdo3uIRjI0Tzdj
         S9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761209; x=1734366009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG9+ixBfaGvQ+A19/B+QQr2/C8iH/5wtigzVEzezc2A=;
        b=E4iB3lWuWnHDQbD3whxiIJqawU1UcXOWJZClmssVwIYNFPsj2z97yD92UtbMdqLyQX
         snneUZ5rp9G3WF+EYCIomRFz/y7UzdnTKXjA5GrjoXFvmvEDwBnEFisQjmJbOdp+K6au
         GQ4rNhjN9lvebGhf1LFNEqXGOpxIr2XqCpAXxdt+6OGckcsUzbqnCEKrmvuL4HdoKf1w
         4DgUkXGu71uUgBK7swJzrKjQYL5HE0HvLT/BFYyB4FLACv5VLcmFBsnVVQmmU+WnHvXx
         N/FYUhW+K/Z/liGrQ7xbWRY1obo8olP1RQa2hbwak7vIfBMvPT6BMTvH90VPovdrfFj/
         oEXw==
X-Forwarded-Encrypted: i=1; AJvYcCW29SmoUJSOXjQxyPgxFxE7WIqJ/mSa+D76JX3MHFE9XahNjMcYSyaIkZHSc+sB8N1NyDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkSrr1izk5c7vn3q/7jlqH+TH96vR28Ss6gNSnjQddzJeT/yih
	MmrYUTQ1U44OmL6w3F4P7POU/q4vuK/mWnMMmH8dXtZW8cWNYu1q
X-Gm-Gg: ASbGncslaZ8Qpp3t5qA1UrfSZ/403gFsIjTIWSsnLxFD1KAWqb4WiVDf5tPzitn+JFq
	U2AMhyeMquhMcWRT8snaQkN3HE+K+cO+UXyyqrPu20BZ6NkUhqIqoAkXKNijlkBCKifc06NA+PL
	JpzLuJ7oyuMuKANVg8aQkiv8PGHbNksf/tARGs1eVQniKpZhXJyBvETaepl3yHGdbXidj6FQuOB
	QJJQua4AQs9gvXzuKhwO7qvxX4qzrLxaEchW+Fu6XcZDZIunnvuq1KJaNlTlAm2MeiXanjeUZE=
X-Google-Smtp-Source: AGHT+IFXUSBZunoqAxk3gjI9pYvhJK3+y32+kFC2KKFffAQy22hJqOXHjAZ+5Mbd1a4ZDO3O2cGaPg==
X-Received: by 2002:a05:6a00:2e03:b0:727:d55e:4be3 with SMTP id d2e1a72fcca58-727d55e4f87mr645174b3a.7.1733761209065;
        Mon, 09 Dec 2024 08:20:09 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d30e6959sm4243463b3a.88.2024.12.09.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:20:08 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	johncai86@gmail.com,
	ps@pks.im
Subject: Re: [PATCH 0/3] Advertise OS version
Date: Mon,  9 Dec 2024 21:44:44 +0530
Message-ID: <20241209161445.10321-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <xmqqfrt7y3xp.fsf@gitster.g>
References: <xmqqfrt7y3xp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Thank you to everyone who participated in this discussion. I am Usman
Akinyemi, one of the two selected Outreachy interns. I have been
selected to work on the project “Finish adding an 'os-version'
capability to Git protocol v2,” which involves implementing the
features discussed in this thread.

You can find the full discussion about my proposal for this project
here: https://public-inbox.org/git/CAPSxiM_rvt-tkQjHYmYNv-Wyr0=X4+123dt=vZKtc++PGRjQMQ@mail.gmail.com/

In summary, this is an outline of my proposal and what I plan to
implement, which has been influenced by the discussion in this thread:

- Send only the OS name by default while allowing a knob (custom
configuration) to specify other information (e.g., version details) and disable
 sending OS names and any other information entirely.

After discussing with my mentor, @Christian, we think that adding
this as a new capability (os-version) is a better option compared to
appending it to the user-agent. This ensures that we do not disrupt
people's scripts that collect statistics from the user-agent or
perform other actions.

Intentions of implementing this project:
- For statistical purposes.
- Most importantly, for security and debugging purposes. This will
allow servers to instruct users to upgrade or perform specific
debugging actions when necessary.

For example:-
A server seeing that a client is using an old Git version
that has security issues on one platform, like MacOS, could check if
the user is indeed running MacOS before sending it a message to
upgrade.

Also a server seeing a client that could benefit from an upgrade, for
example for performance reasons, could better customize the message it
sends to the client to nudge it to upgrade. If the client is on
Windows for example the server could send it a link to
https://gitforwindows.org/ as part of the message.

Please, if anyone has any suggestion or addition or concerns that
might, kindly add. Thank you very much.

Thank you very much!

Usman

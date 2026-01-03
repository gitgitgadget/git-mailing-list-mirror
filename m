Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2814B977
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445211; cv=none; b=jJE6Mu5QCnR0WEnqqnoJFaGEol2Xq/L0evOhFGZYPCuKAt6E1LxQP7CaUuqCydw79+fJanrREqTjA4xL5WaHfoJMVxUIGH7BlYJOI9WyQU7ZNYCaQWf8stzFjnZenQER19vRIFddc3ALRn+n23J2j2bvOujrqbETR36cLmxZthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445211; c=relaxed/simple;
	bh=C3NtF7JKCPvf0uZ+45a7zXOtNRuNmqbXXiTxfiRpFQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLy7D5CsOQTqkYIfxZCl1WAmtrF0WhsKCT+OOiDcCs4LxpPb6yBSoAsoa2EZKPA+VUKr1LW4/Vuu5+oDQLSpMGoxFMGlxc4F070fYzBV+xH888pOrHj5srlIUG5dtzxeVIt9HwL+a+BF/uKoB9s32RsB1+5LdYGvFX+Dk6Oyb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHwyYdJ+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHwyYdJ+"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59584301f0cso3728564e87.0
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 05:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445207; x=1768050007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3NtF7JKCPvf0uZ+45a7zXOtNRuNmqbXXiTxfiRpFQM=;
        b=DHwyYdJ+lDi405qFftC9JIVs3Mbjqi/9qlGN/SYU2+6GJTPEkXBJbkjhnSWv0+dG23
         ltW7BfcGo8pKDj56tQEM/8flO9zpBn89r4IsW7PTfm4xq8l3uBNH34bummnOU/CxllI4
         EDg+ZRy4On63Y7qhEa+q2aR5W+9SZracW6/puhyNLAkKa1+TeT6duNxCTob88h+6SM7w
         T8BQu958w48+MIE5JAuxjyshN/Qr4qtYbwHA8Hm57MGapM1h9CdWpcE+VhfBka86yNtU
         /GMPEqBH8As1AIKQpQiMneDHocUywBKNpFNT+NkIx1KN8O+wCG/8S66MZ3HRKQCq9mU2
         jLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445207; x=1768050007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3NtF7JKCPvf0uZ+45a7zXOtNRuNmqbXXiTxfiRpFQM=;
        b=gpPMbKTlvLi+eIQQKeVNFuq/sHVoMfmSUC02+25ZoeQuySvu3k0DYGwl8IrWNN54md
         JIs7aro+mdW0bskiu2YVdVV7sAnitDC27aVKe0BJJRJ5X0z44RuEMXmogvNVrj3ZM9uq
         WX0I3Vc7m5gySgbwDzYN73tysma1A2KsdHWNVuMzoAm6GV6c46z3lB8p0SzyFZ1pFdMS
         2kvS0YQ7eGpaSO5zFNVkvgEHhP7LiYnb1aED3I+zbc7k33Ijh5lCUNK81yW5B9S1g8i6
         JE8HXXnI/43v3i+oLgx2+2/4q+7c5NhYOtiEH9SJ64WCyU8M4fPZ5HE1h1P3V8ZtI/2L
         MRHw==
X-Forwarded-Encrypted: i=1; AJvYcCU8bJXTwG7eHmgVePnpX8g3Kn7lvJaTd1k1pQslhhVvG0KpB1apXLVneckI9j1/i4+MUwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ItiM55hMttMBGar4IKNrxVfLLsz5GCutwLoXgEaZzm2LEpT/
	Nj5v0dKxx5ZG6XyXF6J4sSf2J1/aMe95sx2dG+totNq+ppXTw9RdAdsp
X-Gm-Gg: AY/fxX7GwBuY2+akd5oVa7aB8b8cRLTzJBora0l2skwUbBaBjEr8ybx2yKT4zci9KCW
	71puHX3HkzOa4kT9PEp+UJMG+mOtuilxdtWmvcymgMEnW+9M0ky1vEhENMLVR7r4bHwCEO3DoBG
	PRtTX6Pt4pQP7TEsZhxUhmlT7/jr4eNK/n12rP/dhUH55vb1mTVAvTto288FuPBshMXXdNkcgil
	m0Q2ToFQr9CNX0b3FVcQ0Jk87I+LhtVONBKEFrPVeN4MHNafpp0ePuJK9vLLs6J110+vwaHuZ1u
	NVGZlX/8KKJ8uCOm2m83jDujDl3GMJET5DNQFGAudYuVH2SubXXrGGRrih512tIeAq68HsX0C02
	JPDGqPPuJ3Lh4hagQNp6AUSItvaRpCZ/aeTrI7jQa6SFRaPpYrS4y8Jpx22pgvNNH9Vm4lLQQNd
	dxRoToDs8ERjoCeUEBnRBxnWg8SQXksC0xDZbkvcupaOlaV50cc7+hc5SSiAZ6ScjuMF30CLU=
X-Google-Smtp-Source: AGHT+IHGxRjXPpD3O3pI1FiClfRxU33e9K0b18JrVy3n47Q/v6MHPvkIj2ch/W0OXI636USnkODJ2w==
X-Received: by 2002:a05:6512:110a:b0:595:909d:1af6 with SMTP id 2adb3069b0e04-59a17d579dcmr14033421e87.28.1767445207229;
        Sat, 03 Jan 2026 05:00:07 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812251cfffsm124447621fa.19.2026.01.03.05.00.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Jan 2026 05:00:06 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: Another look?
Date: Sat,  3 Jan 2026 14:00:05 +0100
Message-Id: <20260103130005.26640-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <9d3407a6-7d88-4f30-9961-5b21b059e1b0@gmail.com>
References: <9d3407a6-7d88-4f30-9961-5b21b059e1b0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You want to display the remote tracking ref that tracks ref on the remote
> that we push to. When git pushes $branch to $remote it checks if any
> of the push refspecs remote.$remote.push match $branch. If there is a
> match then the branch name is mapped according to the refspec and that
> it the ref that is updated in the remote repository. It then takes that
> ref and checks the fetch refspecs remote.$remote.fetch and if it finds a
> match it maps the ref we've pushed to a remote tracking ref in the local
> repository.
>
> It looks like you can find where we would push a branch to with
> remote_ref_for_branch() and you can map that to a remote tracking ref with
> tracking_for_push_dest(). We could use branch_get_push() but does more
> than just map the refs as it checks push.default to see whether "git push"
> would actually push the branch.

Thanks! I have updated the code and added a test for remapped refspec.

With that said, I don't 100% understand what I'm doing with the refspecs, so
maybe you can give it another review?


Harald

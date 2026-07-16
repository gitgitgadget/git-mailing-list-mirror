Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C48330641
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185992; cv=none; b=ibF8IKhSeuVq+/2e0e4+g+1pE4jSspTVeURodjKmtj5kap9iMipm8pkmApSzcEnnsnhEIz0SyzNHJddUnpJp0jeyhd/DwvON8hhLob9jf9o6QmaA5sZ2FQR2Y/0iW5p5LZzyEWsubR5VAXMyxv9pPZqJIr/QQ1ynw/Pezjoev+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185992; c=relaxed/simple;
	bh=1E9txTh8UQ5d9TcSWjaF+6pYFeuqwXm38aNTXjmE5Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibC+BRrDRY4fPIXhm+nARszHbDnCU9SrrxdDP9klv7wf3v8QIrqRy1Se5Oy28Gz+Ilr0WPwVma7E+DPed7mGgeYNKrEV9DYkq9q+BH2ejZX975HSw4gYfqheM7j7uPPr/0/bT8R0owvStrVv20lpBGuiUL36swWzS0pSC56ehxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK7lmCJN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK7lmCJN"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3696929a91.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784185991; x=1784790791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J7XSKxyjunSoNsu76ny/CZIT6wIHcQWJaVjOGQ2BZII=;
        b=WK7lmCJNXJKIlo9lfnIGLuzETSA250c1MHCh/wwBVtJeDjWbOXw85aYA2skt2Z49jq
         YX2bX+KllNJURpi654WPjVGMUdSHrWtFlHtFoadYF4djy5DqrLLM7W75meoFjv2ATgzp
         E6yT9/9Q6aqFlVeAqXUm96Cr46TP7rjSKmYs0uYA1vl1SfHl/3HsQLwdVKEZwMPtLAJN
         xgrvbXMkSG2UGc99dfAsj8EenSZWDtkqBYeVkw7k+lPUzlouWzyM0aY3tlsqYGLZIGk5
         3gyxBzGxu/HV+CqbeB8sy1VTUFCsyZpfFmz+2WH7VjSdB0j7P3IhUcpjqfj/HbiPBeba
         vAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185991; x=1784790791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J7XSKxyjunSoNsu76ny/CZIT6wIHcQWJaVjOGQ2BZII=;
        b=KR/MHeWMex+4kP2md/lbnSAC65SDHnhnRpinc9FOdqUcXnCOmj38NJ3xuYJ57jdClE
         susm5Jh/zFPO8ELAjufZiVPn0cMg+pW4N2Q1isp6t87tVZu8CjJvF+cK7Az3ExQdkZld
         S8hC2r+oMC7jbBHQQDKeALKCH3md6/wfVpvIxQrvseyHvAx9tzlUI6wgmRsRj6Agl8JE
         fVgMiDyzTaf8PTsMsvr4VmGxdlBe3boGU+6jqrePj+y9KIky4/NPcZ/T7Em2jFJ8cJ+Z
         RqbToxXybMLSn7aT4RA2Xo04FZbzCVDI0GdDL36oY2fV6oWwJ/c8yncsYdT80MqLte3F
         j7ow==
X-Gm-Message-State: AOJu0Yw3hPfc69WzImgOdQgl3yA2H4gpWVtWyGmS/EoALlMct2HlkAB7
	2C6VTMr2pZxr+xIZGG0ld/7X1zZM88IwrW4sYfqoO7CsZ1uBVtFv7vzh
X-Gm-Gg: AfdE7cmHt4OTNQpbNsnuCQUaHLfp5q4E5p7b5MBt8uvXXhlPCI3I0ITgnl+IJD26ofe
	RrWFCllgf7l2fQF77BSwiKlwR+K48nLw4ESbeGjWf6yRNeX9a9nDra+f8XjFfEFOL5vPl8D7VmO
	0mLjB7NDZgi1vi7tqnO5KOYxTKQrM3a7ayVoECsm9p3o26gjIvP8Nmck72/Ip2/6GD40Ke0Rm8y
	29GvsHEf2h2akA2Z7zTfearmDAvXvNWljn76CFDcg5fum9waCvjaf1FnSQXTqpt92tIOOGZKjn/
	BYCgphjaHmZwNJ/f3vHYK2b0LIkXM9bEBmbDl/4xjCfjn+azg6qSONof8nGo9NMdkn2QJH4M+OI
	ws6VrgukePDtq9qhoMizqF0+IVmFVByzjYNxadlFoLu06av+64YRaeEFbuE4nDbYObnmNb7p4Tb
	pqkNy5EU7YZY0rIcWqDtLBGRKOweY=
X-Received: by 2002:a05:6a20:d818:b0:3b4:e4f0:94e1 with SMTP id adf61e73a8af0-3c3571d0443mr11836985637.39.1784185990778;
        Thu, 16 Jul 2026 00:13:10 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4359166sm7693164c88.14.2026.07.16.00.13.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 00:13:10 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: Re: [PATCH] t7614: avoid hiding git's exit code in a pipe
Date: Thu, 16 Jul 2026 12:42:54 +0530
Message-ID: <20260716071254.14953-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq1pd4m4ea.fsf@gitster.g>
References: <xmqq1pd4m4ea.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> All look trivially correct.

Thanks for the review.

>  * This "cat-file the commit object, and strip away the object
>    header with sed" pattern appears quite often throughout the test
>    suite.
> [...]
>    or something like that.
>
> But again, these are clearly outside the scope of this patch.

Agreed on keeping them out of this patch.  I'd like to take up the
commit_body() helper as a separate follow-up once this lands, and
convert the existing "cat-file ... | sed" call sites (including the
unnecessary backslash before the dollar sign) over to it.

Thanks,
Shlok

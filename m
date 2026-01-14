Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A631B814
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432327; cv=none; b=IxZ8ugPt+PbQKndwl5CJUnhO2ktqafnBKA3ZmRb2UMjgqBDS61ffwmt4Xe92xT+OLVyNk/ECbPIwS7kK2McIfCJSQLWfbqdKFGuBpSUotXqnqPkfJ1BtVBgNB2IGaMwYNJ0mCO82AtmrBBaWO/Yv3L8rXKrMEE2LxD1D4mOqB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432327; c=relaxed/simple;
	bh=nVUN2zJJAC3P1NYMsdOQUr7Hy8jwjoiTITKUV6G348M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4757OXYkF3Os3Hz6rgr79cfV9NE2ylShEpHvfmz6TGfv9WLvO/eK8zKc0aFo5EFvDm39bf7cDyHIfqm/4GDJ7h3Upf1wPAMSuLZjp+KAthZ3x++nGy8GxaerYME91Lclyj1dOrkt9MJPQ4LArI3lAzhgm5PEP9Rw7dnCYj1QU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgTGeXcp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgTGeXcp"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-598f8136a24so411036e87.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768432324; x=1769037124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGT8HRil383Rr9L6I5CmWyaElfxghRksY5KqONv/sQw=;
        b=PgTGeXcp8BTlf7XEMILCRnxFH92xgUViGy+L6dytiO1EzjOn3bwOMyAc+4Ie1KtjQI
         wkgaxodl2NaqCa+yzZTm8GY5vyDiUx4+aCVw96LdjWS98ylU9WriEKYp0Uhw4vnqRRcz
         jzKxe7QjS4tfnNU9lnseAHV406ouFJzVMae/bUE0veDkodEqmEmLoDnRoOPFBWOB7t5U
         9jBPpS7VLT/r21C2AuUjbXT5g7KfZQUaFGL3vCaXnOZLC2kDdL0NCcNO0Fx3MDR8u99z
         PTBjdCz/AVqUR0ogCCE9KZs5dGHOkFqsY50QAxf6YjQN+aYmV0YeJUdI9aQ1B0qSYPCv
         vj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768432324; x=1769037124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGT8HRil383Rr9L6I5CmWyaElfxghRksY5KqONv/sQw=;
        b=Zx6nWLNpU141fipn0rCPJAmNPbvTRZQ0/HkBNI9VELceM25OP/e5toB1ylWAcOyH+b
         pxCvSY33H71Tqcm8cYcwa0ScPBY3H3ErR54yy94HFJFjci0B0DSQ3J2TsdA01kINe9va
         9a8qonOYoRCnOwkN0LHSlN+4qxhYdNtZPc6vs8rp13ol15Y2pvkAV3SgK8pl1JCz6F72
         vdPqnbm8GTVqfoVyp7HsQGdCfV4oh2jwuCEbhnaik3t7OIo1ZLECmaS/ZZ5Rj9zsI/vX
         Ce7DURsX1Paxhof66A2UkJwzo/9T+5Z0l7G84e5WkeJSjlbqOf4mf09mH3XuuZzSFFLs
         6dlg==
X-Gm-Message-State: AOJu0YzXIymMhV1UzaiepVJvYSzgesFEyegPuc3JCq/g3+B+tF8CC6GZ
	KxvewlPZh9q9a/oeqU5RP9H1vhfXNti2f1xQMk6a+2A+d87a6gmzPxKK
X-Gm-Gg: AY/fxX7ob7rUbWxcuCoJoORjudGaVRKzGFmpcZXI8bVfVqUrFveZta3qUaQZErZyfc8
	wg5u/lUKhbW/jbMgTQQN3rmVo/00ibaLtQ1cSej+ZB+/vBc5PXPrxuOM2hiSmeeAJC/kTii3xLP
	waTUilKiKgGdPAUiN0rH1u3VNTql585zOhw+EB3uwVZoJaRcyd77IL78If7134mS9rBx/eNvU4V
	Y2jVof20gp2Ap9DHoAasg2jG1blf6Ek5TM5GI0cqp71yEeRSXF1/yohgtiKp2YA7fShbEwQ/nuK
	FRewNiMwb6iSw+fcPwn7qU6rAE/BtOD1Il8XxXMvhUr8dgQo3mYZfe1Jiu09UG1hHgvsTwZpd6d
	GlohjX06kqLd0rhM+nAHHW1m0DtEtacZ7PDcw6cMVYRpLfU5AMK1P1R2R72EiVSAEXMktam3bBg
	a9aZUlM+54bBUSQ1FqyFF/GBv3yEmdFTVQjPkY9igY+k9Q0eeTr+4g054RNGiWBNM4gKbZP+9QM
	p+zU2bqrA==
X-Received: by 2002:a05:6512:3050:b0:59b:7291:9cdb with SMTP id 2adb3069b0e04-59ba0f80f5bmr1383200e87.24.1768432323941;
        Wed, 14 Jan 2026 15:12:03 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59ba1020726sm1092938e87.26.2026.01.14.15.12.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 15:12:03 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Triangular workflow
Date: Thu, 15 Jan 2026 00:12:02 +0100
Message-ID: <20260114231202.61271-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq8qe0f2iq.fsf@gitster.g>
References: <xmqq8qe0f2iq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I wonder if we can come up with a flexible and
> extensible notation to specify what branch(es) to compare with, so
> that we can use it as the value of this opt-in configuration
> variable?  Something like
> 
>         [status] compareBranches = @{upstream} @{push}

If we go with that, then it becomes trickier code-wise to show push/pull
advice for the correct branches. But not impossible since we can check if
branch is the same as @{upstream} or @{push}.

Philosophically, two main git commands are 'git push' and 'git pull'. So it
makes perfect sense to me to signal that those two are special, and not
allow other compareBranches.


Harald

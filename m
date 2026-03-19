Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26812E0401
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933827; cv=none; b=losJA47fOQUP3aymYi0IynNSU/o3G0YD6hPAe76nwjsGLVyxTPTtbPH1s+KSZSR1FixmntcgCo0WBj6oDdU933Q5RELiuB79hlMgvKluTo1JeE32hgud66a93WltzOdS6nMgL0BJuQ9iubksC8V/mPiu9Sgy5Sn1Kw2KTOvC32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933827; c=relaxed/simple;
	bh=6n2WsDjtx584jGGLftt4hEhDGA6DE1+ZGL+oCdHojTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsQGX2XcVUI0Py1Zzr/rhNGklgy/kRBlLMaaqI/3LDKTCXkm/XwMv1qBuvDo9/c80fgJZRL12MnNmEX8ZKYq+RLk5tUrP+TJfhooCHNK4Nke77XN3C7T3yqik0dbztxg3iSb+NaWDxSnGsTDz3uYEc0hGQOlz/0GwRZU2pTghco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDDC/gU4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDDC/gU4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so12960105ad.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933826; x=1774538626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n2WsDjtx584jGGLftt4hEhDGA6DE1+ZGL+oCdHojTw=;
        b=IDDC/gU48lXqS+q7bD6D+7sXXphWx6mdT4ZzgAseJYPVk2WkK09w2lfarSo2eD1ayG
         lS+2Jh/PyvDzI3qLZCbSB+D5Qc0yoAGkJWc6JBFVQmSefb1cuefGtna6qN6GWrqhSXvC
         QTW8fuZQspXCmnVx6W4IdW5cGx+I6Gy/L1D2e0aph6FaLKHq8lYgYp5gh2ot7HnTmk2G
         xQS08ocJeLtwTSzJS8Bs3+n4YrMW8faJCMY5TufCrwMUuMa0z+2q8ixW0xSaxVRSoCMk
         YHgZ4p3UCzpq9roGrutgt4lluA/Z7whRM5j/3+s7D5kCHbCe6nQ+2Zz1JxVQolc84iAR
         34MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933826; x=1774538626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6n2WsDjtx584jGGLftt4hEhDGA6DE1+ZGL+oCdHojTw=;
        b=VM/nf2xSFphPR5xCdXqEAaj+L+3b7goFQLi9l+2vg8qZZP0MhZlH5bMufHrZC6IXPN
         39vj6wqsQl+Kd0wqLr6u4YM6HozQgc1el6Nv9hAORgL30BpdTHuClT6yB8WQS7YiD0iu
         UNvvac89kGgS9g+9dOyTEKqTMX6GXaF6gp9KUkoDMPsFmqOV4iLZyZkXDy1QF3LK0lGS
         L/1WHSYhxAk+kZTME2vdFlipkEQOvniCN+1EwXNJgyALrUbV+EBJV4q1+dHZ0imPsDCO
         +XceygooMYEu2/2IJ4zIVrM04uUVfrrDIdUc++ugSsljhbq0nWMxhTd+bCSYdcwyU4Qs
         c4mw==
X-Gm-Message-State: AOJu0YzN2ya4C/TntoZR4CrmK224V3rmZ95nfkHTgDZ5bjgP0ggKm5U9
	WBeefpBtHC7bxEVFz5qvlEnDmYylYEcGYtBHhwKH1PjvzYS4xN9nFc4IEwlWUA==
X-Gm-Gg: ATEYQzwDqKAZjXu7cPHrsgTh9wYkPqyh6Qtfl6s3ORjDZHZnxJMCmujP4qvfG+Kf7/T
	55tF/5mVqQzoO805G5NiiPlNZSijjg6DXxhofV+LISHrJIrsZw70CE6C9M+fydQwoz5Fhy3XahS
	fCE9RUYhixgrQohzXVfDOHY1pR8aE9n0lC/wC4KgDkpQrL8U0SZOIGM/NywuozG9JVwGxePys6f
	sSMNzde4Jgaz/Xb1H5x5LQzssTY6LXOsFag0NYnxhTLce4wk8abwkEj6ZJqSlwl/9xiID+e9wCM
	wX8WlZH3r43M+4dJ43eNIFgLBn8IbTcMsF5tw5j1h8eiQznmpUdQ+TuYSBjSnjpwJXmQEbCcF2S
	TB7rhseXp1H7DZvgl4lYTijL/yvG6nH4ZOVdd+ii/waoHIdrPfsM231vLFnkW97t+3yyP6BBTpF
	RMwshTvmry8aOFFo0iU8aoB74aFrfK7bPVXgqYNKEpQpQ=
X-Received: by 2002:a17:903:2b04:b0:2b0:5050:261d with SMTP id d9443c01a7336-2b06e43b1b7mr73639765ad.50.1773933826015;
        Thu, 19 Mar 2026 08:23:46 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:76df:bb95:3ddc:3aa6:6dd2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e4199easm84465145ad.5.2026.03.19.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:23:45 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: [RFC] git am: apply patches directly via message id
Date: Thu, 19 Mar 2026 20:51:11 +0530
Message-ID: <20260319152313.1324081-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqy0jolyte.fsf@gitster.g>
References: <xmqqy0jolyte.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
> > Does this sound like a useful feature to add or maybe any kind of indirect
> > implementation is already there and I am missing anything. Let me know what
> > are your thoughts on this.
>
> Sounds a lot like "b4 am -o-" piped to "git am" to me.
>

I see. Though I think b4 is an external library, and I am reckoning that
this functionality is used commonly so would it make sense to add this
natively in git am ? or it is fine using b4 for this.

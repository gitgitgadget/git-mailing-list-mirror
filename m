Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803C4C97
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297101; cv=none; b=Vg5RUWtslYy7VqQoFL7l0x/rkwDjZQNfCLnk2dpKgRrJGQCMjJxhxuyL1sU4H3AV0Accbk6wJcX0YwvxLMsIFOlTxfz74vq2xhhdTYxwrTmrI5scWug/dUNBv8Pdl5WQREszzMMvpX5z9UQmtnGduAneeOalEMKKBma7x5TLC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297101; c=relaxed/simple;
	bh=EY70wA3gYLMMHzyqUqQf5PYHOBpt09KFJShNm8lwniE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLiPidc5w7yNcGeN4K1UB6fvxx15/xLhffxgxAIOu6nJp7fwxS0lOCkVEYuabarflFb76OsDtEYpKYtcCJ0lNmdxGRef2MU0M55TEBrdRo0YShqHbI+xt4igCvodpW/teyJDd9KkE5Xay5dNsHvqslw3ZMBC93sJB+Y8Iadi3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCUIJN/E; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCUIJN/E"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-354a4ef0c1eso330678a91.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 05:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770297101; x=1770901901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/SD2Az1Cs6wsGAITrX97zM6QmJOfIR4J/BbJCEGw8w=;
        b=dCUIJN/E7rvAO3i0Ru377BkJc6R0gGQ7vXoIY/QJzn8cRWHSfFgtXend8mp8L6aRmZ
         yalLp/BhX9ORCgoA5GKJdGYl/ryLfMqZF4iTW4tEDFHXnS0N2m8YKHoNFpm2Qda9K7zg
         EjsKIZvbWkghRpulPALpDHxX5Jt907EkrQjsi3z+Ibn4syZ+U2eGDVCW7vQ44YCwuon/
         6oZX5556xl+J5nlEOSCQ1KSn4rRrXLuEK5RJkelut+XGlaHW9vxnywsVnUQYjRXiexKW
         HWhgrV6SZSSGzVmtzgx7ElvB0o4LJIo8ODWhAPO9WZ8IFJfC1YRC051xczMuXJfySwrq
         Kg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770297101; x=1770901901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/SD2Az1Cs6wsGAITrX97zM6QmJOfIR4J/BbJCEGw8w=;
        b=sH3K9Af9i7w70v5Z9MyYvsUlFw5E6lWOLGQub36MVzD2e2ZEWeTVGxRdvH9wkMpmxD
         9lAsDZkFTNZSeK2mLfYypbl9p9RJK7H/nX9cklEEWWifxuRb9oal3tYSdFihPw3wqyVU
         WrDyqT+umjlCqRrclroP1lskBVxixsxZ336NH/PxxSzvvskNAw7i+IM3ew2iEBxQO44N
         fJzbMNlYhxKNwLpFifq2TCDufHGvSAh5LYtqZdatfQRUEL60SSYq++Xrxm+VwCtpXIvI
         c2+QMbjiSUWIZvMFFtpKbx/76kS2bboLrhoIvVIKHJwOfZX1wMw63ybD1cS8zBRhQSqv
         Ju7w==
X-Gm-Message-State: AOJu0YymZOVb/385t1h012IxmoyjGvhtiRBvTmyh5A71BjobeoH0i/3z
	fCTif/uCS3CmB8PvGAbkxbtFXHGDcSskEVYI9FE2NWguxOyFVomQzdFzhS8wFg6N
X-Gm-Gg: AZuq6aJaVp3idlbT8tMIgsptTDOr80lgUCEED5auDw6rH7yxV2Tn1wHBalLRCFpJlGQ
	rfiTh+BAB12mWdN4etarBUlGUnAgJ6qBPWYQWLkq18fWjet/xUc+cl+5PmVhAO+owJ8FJVi3nnj
	6f3t4Pdi+8HSna1DHYH94hH/kDNiwaNdPGqpPMJv41ke48dLD/yGWqJ1KeUvuO/BpZkPocW0Xxc
	jnmiGEC6+/f73eq+G5NEO7HDSmp2DsDHk9Tjk+p4eJwW+eOGiNczZJetVv036kCPTVJMyE+Maat
	DM4bjHQ2uJGrtBx3UrquV3nnogWDBietDO/UD3nwFkDK0P+APAbzQ7XDZI6ZziUjksc2VSNjtSw
	SqaaIzzrGERgFIqgpGPAswcnfQOMyCi1u9ndRrm3CRYWGmjx10nG5v/f0bVTyDw4cpXtoPCc6xm
	l1D7nvXnSrot3Cq0rPOGor/ATea5j1QHSjjNrNMdQhLcgSAhW0+76hPUDA
X-Received: by 2002:a17:90b:5823:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-354a57ccc9amr1150985a91.20.1770297100845;
        Thu, 05 Feb 2026 05:11:40 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:955:7bd3:104b:5765])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c09adffsm2562873a91.4.2026.02.05.05.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:11:40 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: valusoutrik@gmail.com
Subject: Re: [PATCH] doc: fix repo_config documentation reference
Date: Thu,  5 Feb 2026 18:41:25 +0530
Message-ID: <20260205131132.44282-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <pull.2187.git.git.1770293021383.gitgitgadget@gmail.com>
References: <pull.2187.git.git.1770293021383.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since documentation was moved from Documenation/
> technical/api-config to inside the config.h
> This might help newcomers, by pointing them to the
> right place to get documentation about repo_config

Some suggestions,

* s/Documenation/Documentation

* ~70 cols is the practical followed line wrapping, so you can follow that
for best readability.

* First describe the current problem statement which describes the
current state in the present tense like,

   In MyFirstContribution.adoc, the link to the repo_config()
   documentation is invalid because the documentation related was moved
   to a different file.

* Then you instruct somebody to make changes to the code to make it better like,

   Replace the path for the repo_config() documentation from
   'Documenation/technical/api-config' to 'config.h'.

* Then you can state your additional explainations, references and/or
advantages, whatever seems relevant for the change you just stated.

Best,
Shreyansh

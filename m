Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1928B400
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262323; cv=none; b=DQKjCXZ9uCZTQwqTOsJ7D7Y38lZqpKt/165OTyb4dOS+5dmjy/U5+WZfove82HAuNVLMgG+JvA/BLmm7C5y4GoNFKnzCdnwqSKT2oBayCShIBkKJp9Ti8W3Wb6m+RDVS1qQFyxUviuO7bzqrdSTCFRbFaywZKRbaNaHItbGxDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262323; c=relaxed/simple;
	bh=ulBy5lYTJTcLIfhvwmiarU488LU6KXU77mxX3J4DKXc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uXdZ6TuFki851dZjQXmXAcc66zflxSayx2LCHOQbF2Jkuz1q0h6kXXLa2I57Op0o8R29yaSI3LnUEJHBIZmPJaJ9/QH9v5FWp/I8qPcDYSxq+mDciiY+piOFFSi3R9n+qejSXph+UhBkAWY5ZpTN3wRxSnGKo9SFBtBRxdyxCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwRW8IAC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwRW8IAC"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7811a02316bso3630394b3a.3
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262321; x=1759867121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWzMACl0gDCpdMfTo1qKW918JugqSilkQYqnRAmWryY=;
        b=KwRW8IACWqcJT+Vd/vN/Kk6dHoRSqyzwonuw+ExZB5nb4Mfy1wfN76vZ+Rh5W3Z2KI
         Cn/3msdgzaRy/2sIV/yW8WLuwF2ELQ7+xi278W3irUtT/ErTEGX/khPWUPQrNojX0FH/
         9fZiChzBW+WI+/yxDuNTwTqVVYVGHX5KTZ3s0hOJLJ6x7Oc/53gDkuRSoSlaZ+d3c8Ro
         5y/rBFlg/pT6Mk5mwcogT2f8jRIk17SNH8grXcOVMtExtd1AWZ6XDZv/EHZrULgzc9dB
         aSDtxxuqT/4an8h2kFPikBIpkxOnh6XZjeXmMEgk1wTEsxYktAGL3Sxsmie9cCUO5mwz
         Wuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262321; x=1759867121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWzMACl0gDCpdMfTo1qKW918JugqSilkQYqnRAmWryY=;
        b=Whi9h1BnpXTls2BwPGlHGKMP+UQ1SDsVacgnIc+CI1CN+/Oz9hoGwelgoIvhPZcA3d
         QQRRH7sW9cM756mgp7vIxdYi/FyOrYDZNp8ZmQ6qQ5cQjI/NKAivt9HMHDrM9/ZuhWw/
         knbzmDiqyNNhxgZK0B22h2/Iwq0KNmCHPwbZYCzjzzA/YHn5wUfugzbVQMQlZEP6leJF
         ApI7wWlHXZFaD+E7CTd8FoJgIcWT8bGy5zB/CS2sajySN+SjoxBDnAUpSIO3SiaeIKal
         kfMHuvF301lznBrK6HMfOIKyEfVnQ3XU//Fgl2xxnHxAOzfTYYyqDtY7AIiMsWEZGpD9
         8C2g==
X-Gm-Message-State: AOJu0Yze+KCVeuYPnJuJKaiLIxayltK9+M/oKYORAI4y99oRczQNc1Ls
	wexoLkg2sDFUoj4+op6wukfTySmt0+U0vY1uFyaJJucdHHR1Q3rJvOZjJYDYtVyY
X-Gm-Gg: ASbGnctnvfnmFyFyVm1iOANYWJ6nHQXB0nyQCFKtx7ZghnuSWtFVnE7DrnUjl2R6yQB
	bvrvvv7PBolV5qf4cMaD1SduhvRNFDg1LIKLmXGd418oxxs+ItVfUDeq2oSZSd9jisiivzr0DIh
	UYzQD8lX82bYceiAXXRqTgg4bKmgquqrUsms3CULf3TKolfypDQ5Jh6zyFjWOD8na8tH++bWfLG
	6lljD9sr+lVYsrfHGP1HPuqv5slDwLN0fxulqVxVrZV0H2UbVrvy1oqrizmm7w9UK5UcanvJhzM
	TVSn//vp6hfDY24/a1VhgvGM8N25ytkG3MyQtYO6ZMnlbQx1hbsm/oIa8y3BLQKk++KSBhF3nkr
	IfFoMPHHdsy2v0q7ezR09bhCQdGe2e3nbYsRJvfZsAiwLLU6liD1daVGDhAb6
X-Google-Smtp-Source: AGHT+IEKa2RsJnmhJLgQ8+ad9cmI04t0EXjKwLwTB1pnM2Pzml0dqmOnWODCP2ZeasUO+m4WKh0i9g==
X-Received: by 2002:a17:902:e78e:b0:28e:7e7e:fb6f with SMTP id d9443c01a7336-28e7f2a10c6mr10903555ad.10.1759262320633;
        Tue, 30 Sep 2025 12:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.210.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm167095885ad.55.2025.09.30.12.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:58:39 -0700 (PDT)
Message-Id: <244c35ef2bdcd211800798bc694b194c8feea1bd.1759262314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 19:58:32 +0000
Subject: [PATCH v4 3/5] doc: git-push: clarify "where to push"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

It's not obvious that "`branch.*.remote` configuration"` refers to the
upstream, so say "upstream" instead.

The sentence is also quite hard to parse right now, use "defaults to" to
simplify it.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 25d972f248..acdf25e5cd 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -23,10 +23,8 @@ Updates one or more branches, tags, or other references in a remote
 repository from your local repository, and sends all necessary data
 that isn't already on the remote.
 
-When the command line does not specify where to push with the
-`<repository>` argument, `branch.*.remote` configuration for the
-current branch is consulted to determine where to push.  If the
-configuration is missing, it defaults to 'origin'.
+The `<repository>` argument defaults to the upstream for the current branch,
+or `origin` if there's no configured upstream.
 
 When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
-- 
gitgitgadget


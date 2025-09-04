Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336353002DA
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992285; cv=none; b=P4Va0VOY5mrpx4PvX9kT9MQlLxTHTY2K16qQdxsxEZFxknj1NVO8xA8kezRoU6JZ0/AsHtzfq91YP9jz75pe9ZlZ/m8pzJGY09UDP+I90Hij/qC9uzy0WiPI5bAauw369qWCkQ84UfqDAaOX/Pa3cHHIYIHUX2pKP2Swd9GyUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992285; c=relaxed/simple;
	bh=Z1yBizTrDbmeuQtz2knrZIJMKV8v/vjy931BuEdwX+M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DBDtuzxSBukjHvvUS9A95lDsUp/dgnuK8E3o6ycCCKYDDF8oJYEHxwL0JmMJmEIM3m5qZPxJJgsqIQP1ltlPjUpAGUjccGOVde7LU8Nq02ASySSAfgWHfbMyeDWGgvX4jbMr4V8Puwkx5LfGyroHIb/xG8sILrDhsMzXDkP7u94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3b/JZ5R; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3b/JZ5R"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-53410d0f4e7so914285137.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992283; x=1757597083; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A6DGkcCsFkC+L8tE6D8VsHAuYk0xXCMm7m5ewYgrpM=;
        b=b3b/JZ5RIUNFyvNhHC1mzdYxPFo/SpJ928zoIInw/nR9+BPHd5D+q926ZkoHqKPrTN
         z0Rzt6IYiZvEaNA2NRihjXXR90PmfnhWHKv6k7bqlupXEfBOLgE2fAz/h5IX4q5MPK6f
         w7BSRbE5qq8fK7Tjx4cQ7zZZDwDhSPRPXCUigGB2dxZE1VtxC8ULSmhhv4yObkA/69hW
         8PNr/c4vDbc/onznR4lZfGFWlYA4nW4+9QlVFZuQYsJhrgsQ5VyWJwvSf6G6c22DEau8
         E8gSPdU2KIgLkDsJCJUn7CdwQ/7xhfeqNomouY949AVQtLm+zeN+pEOWkoIT5pbLJQb+
         QBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992283; x=1757597083;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A6DGkcCsFkC+L8tE6D8VsHAuYk0xXCMm7m5ewYgrpM=;
        b=tuPuPzOW+FJLgR+he6abP+YoZfsxuJ3kNH9xfBVWECpcjCMfpu/54x7mgNW9rTMBwE
         br9olil4Hx1ZtMPDV4L8fAoRRyRq0e3Rj08gfabidUB8pn+EbyIoA1+Ix51JlXbKQ6Go
         1i4hcinpTmsaF6GQhM7zzxtxDxCun62W69WkXH0+RYuyB+Wv+bzt33l0cfa7+5bMRCKa
         /wObBqKPcGBrhFUJ08FIHoa7rH8T0g3kUkhK0h5EcPLXG4rHvMjHPZbtNJ6//oW+tXdg
         dHaDtQ/y6qCAVg6TKHR2vl8LVNv7vs8eiprBhM7RmiXtgbnkldu9eKavhCjbdyung5r+
         j2lg==
X-Gm-Message-State: AOJu0YysqK+F0NvnV7LpGzDuxLihhwrNRmCU6oVvGPqpua0Bo4Dws9mp
	D3rW7r8qJtHyve3zeQladJDT85q2cTSntw0z+zB9zqTKZi+mvE8mgwHv++WUpA==
X-Gm-Gg: ASbGncvcVor0Ce2BNkyFOMYL2rSwabHWjA3Yp5EghTsXjiBn7U+1T4D4f66h1VLWlfF
	3F2tKHu/IFwtp7RFxMiST/scmmfycPgZqtgtvPAQUzRnfZuH/3DpYlFv/h80IL3vJg4f1jr/lnF
	i4tozAOjMzRIDuTaMm43DiCKOapW4/k48ZCUcHEEFANT7f31/mwfi4/EELbuxHxXnSNv17IieGf
	l6ytDSFRhtoKWSUZoCPqDnivfjkzOgAbIbeM8ezW9jXodGLOVPSqU2E5PJguRb1ixQOTtD/2Veh
	BI91OVFsbxNLO6+mvmsyz6AlE3wheXv+1aujII20lYUPTtTdg4jsUUkgWv+tazgA0JDoZ2LL8n8
	WI4yIazZ/2uYrd6IpxyxXyEv7IfvcnQ139yEDX2PDhtdC2MAc6z1HL+eJ
X-Google-Smtp-Source: AGHT+IEQ6XPvHe8ibftZLxvtKOpZ0hLkQ/pWmXCL/WNRP4yel93kXOrtFWxcvoky6WsAEpo66SvmpA==
X-Received: by 2002:a05:6102:5f04:b0:51b:fdb0:8f90 with SMTP id ada2fe7eead31-52b1b1f3011mr7259922137.16.1756992282965;
        Thu, 04 Sep 2025 06:24:42 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f0:b77d:8aa:3d64:69a5:cf8e:268f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899a902b2cesm2600543241.14.2025.09.04.06.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:24:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: What's cooking in git.git (Sep 2025, #02; Wed, 3)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqplc6byai.fsf@gitster.g>
Date: Thu, 4 Sep 2025 10:24:27 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <66233596-6A16-4299-B00C-ED86BA4B2DA4@gmail.com>
References: <xmqqplc6byai.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> * lo/repo-info-step-2 (2025-09-01) 3 commits
> - repo: add the field objects.format
> - repo: add the flag -z as an alias for --format=nul
> - Merge branch 'lo/repo-info' into lo/repo-info-step-2
> 
> "repo info" learns a short-hand option "-z" that is the same as
> "--format=nul", and learns to report the objects format used in the
> repository.
> 
> Will merge to 'next'?
> source: <20250901172732.98845-1-lucasseikioshiro@gmail.com>

I found a codestyle problem in it, I'll send an v3 fixing that.

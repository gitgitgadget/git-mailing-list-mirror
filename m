Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470A33A03A
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740841; cv=none; b=knXePjUD3BtUfzwTzpGA3wkWjPDqzulqN3bRO5lZ3+7Yaocs/o/c+wuVRbclKnfrPh8EN2Gby7oY2xPszUY9+x9Fnc4A6dKq1TR4j3eklsN0cLPjxL1zaUMgekk/8vD0R+QBk07gEQBMEgpWckuF9XSg8RdkMJUeZzvXWqKRZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740841; c=relaxed/simple;
	bh=uNQXuwZZMu89IVOhOIjf8y5G0Fz4wfueQFIawudqqvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGDPgGXy4vWQj69fVTQRTNRlZt6nDp4SBpSMIfTKuocTJW/mdhCs/ejiGhtGZnT23Ny8zLvuKe657EtR6B2uXaIztVFZ2trUo5EnT9sEFlScqEBd11iwr8B+D3g1zkyp12tPdkmlDgJ+c4syuKSdbUTp4Oqcj0blxL3HoQiIgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0f+HBTU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0f+HBTU"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38704f70ea3so45499391fa.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740838; x=1774345638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p02vJhJ9DTQCFt7KY4bOAcpBIY2/oTgA+hUv5pF5Kng=;
        b=Q0f+HBTUjqMuJ/qoxOfSpif/LhzYXeqdgIhfopBxJ7Ggbx+vbTyF/JyAOK8TpyZTrS
         tb2OPPbLpbmftNnjsfzAb45VE5dxFF7DD+auBW/4NwDbHa14JRMK7zONBs7juB1nc4vK
         YUNace3cX3ZatN9eNmGwwEi5TU+Lonzh3VYr1YPGrm1EgQe4GxzNbbqevb2Agedd0jjD
         mottC5MdL3ppjH9CX9BKsfCnT9EF7RV6M0FCC3EEi/aKmibRsapmy/7mEFQNu75WGq5Z
         UZsCSkSEqVfEQQjilE6ab5NQELDdU02zL2mKykC9FpfUIYNokUROFV4hRENIc/wW8QLE
         1rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740838; x=1774345638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p02vJhJ9DTQCFt7KY4bOAcpBIY2/oTgA+hUv5pF5Kng=;
        b=OcQZ8xBylNHVctFj7eoJvJobc2ImE0IgUnjLVX1FRDMGYUp1c4oszIxD7olu3S0r2o
         y6wZ2+PEB7XiluawBDsncMg0aVoSH0DO5AbHEFs9Fc/UdtWJVQon2jsfit6q1tbR2ohg
         M8fRaLqFL0tK0kTvMSoJXakdA6WpEiKDYB44nDuZNS+km6A3Q3jcGRGSPOhdJ3ntF7qx
         fHZYz1eUWFtr9jzkfBS3kEu0YTQyrQ8V9tICsRv1RCci9U8Y677l+HUOU6ycmJn3mdmO
         C7P/oFKfltqWp6+A/nwnaDfG+dw/yzXdb0VsOdzSg8GuNuMMMF7XCo7V4BsBrVpwuDN2
         +FeA==
X-Gm-Message-State: AOJu0Yz0IkD/2vGKQlHtByt8UKSTSLXEWCVMVGuYiGkQ28m0wapUH00y
	rHoxkST5tFiVr3/bIpLioYRXEWE+6W+OQ9QJSgDASxx2HEINXZz2FULn
X-Gm-Gg: ATEYQzyU5fQ8BiM7v9QTAxeEfObHhZ5y0W+1oksEGm++e0F9Whrlawfmw77l/G+O3Dj
	Qbx3KcWBMOxZK8qTJfbvGYyVnzediJq2reg8SET8mOGoyQ0325U3cV2oEf3VkLr1fS7JVVaJl2+
	CUVRFfcy+hMGStPp7nMiJ+gvevnMdocE1JNrnsMxmnDzwDvN07be3lr3HKp8g/Kn+5IIlY6oVBK
	rKoGr4yTulTjdZeNthdO47Dd1SfJgI9lzbzyUqLUD1CdS8zR0Ym9iGWSB/5f9XBQlks4UDM0JDB
	Qp+g88HEVewlPFzA/oFZ3szhUNcBB9XZAf14b52064KQDNlAxuqFxflMhgcASuwrFVtBOU7Ava4
	lzl0XgDAU+WxVmsAyH/mneY66VpKS8G7hAvgcc5mjSbvmyvkfnuEQ5djJsLnGXCM0PPXFl73ZiG
	1TN4is7s32RPzSysGYTQzfBaZxqRqtG11ihk0l+zp9sBbDJiNwAFNMUsoEbnVmDCqErswLp/wLp
	wcdFInlAY0fZA==
X-Received: by 2002:a05:651c:411a:b0:38a:6acc:85f with SMTP id 38308e7fff4ca-38a8983b635mr30922631fa.36.1773740838147;
        Tue, 17 Mar 2026 02:47:18 -0700 (PDT)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ad29fc318sm2790911fa.19.2026.03.17.02.47.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 02:47:17 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 17 Mar 2026 10:47:16 +0100
Message-ID: <20260317094716.43654-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqcy13o81b.fsf@gitster.g>
References: <xmqqcy13o81b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Why is the dry-run of unpack_trees() not an extra check? I was assuming 
>> that it was because we do the dry-run and then do it for real after 
>> possibly stashing any local changes. That's why I was wondering if we 
>> could avoid the dry-run by creating the stash if the non-dry-run 
>> unpack_trees() failed.
>
> Ah, I didn't even think about that possibility.
>
> Try to unpack anyway, and if unpack_trees() branch switching
> succeeds, we are done.  Otherwise, we can trust that unpack_trees()
> did not do _anything_ to the index or the working tree files, so we
> can create the stash at that time.
>
> Makes sense.

Interesting idea, and thanks for your help with this! I gave it a shot with
this simplification.

It passes the tests, which either means it works, or just that the test
coverage is not good enough to detect new issues introduced by me here.


Harald

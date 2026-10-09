Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7113BB112
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554233; cv=none; b=G77eVJBugtdbtr1ZJn5/81BQGsKaHX1BBwGY3aCEM1puhSubbOzCYw06nUSRgDpP1jKXKkKLvqun4ccvIyiQtyS94J8/pDqaxIPuD8KwpyZL/rJzVzxbmB7PjhQcOtaBJ/Dk6JirFXqq4dDDUxUpEemg+umm53LWiL/t8qPuITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554233; c=relaxed/simple;
	bh=GY7BvXzX/lZ6HgRfVLIpvJpIW9DLsU//YiDzq9/XOoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5f7L73zsmA3qsfQqvRhIdInwlm4O9gyg+T+8FmeqWyASWlcTq1wTpCAHXN+ZbtsjH7VSvhC/Eouk8aJhtSQLsRAOGlNjruYaDzc/0Qcv2vBAqARiPlalJRIiGAOGNmBAn965SMZGaka+A+e/tUv1g6kADMKPv9mFe1wFn4xQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO7oEM9k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO7oEM9k"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-872024e2b4eso2094360b3a.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554231; x=1792159031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GY7BvXzX/lZ6HgRfVLIpvJpIW9DLsU//YiDzq9/XOoM=;
        b=XO7oEM9kbEBl4Ap/RGEI0+u8xzllfmIpSD9KIvMAj8sspBMckGUJah7/Yf1c2lHxht
         9IciP+JuqbETxyw+TcPQUNKNxHBLrOpQp11h81nsC3irjyzQfn+sP2P3Q3RtRLARi1tx
         JWa/ssANZmMODEB9XPH+03ikZGCaSZklZnqTysUUXq6xpjwpcWS2Id99dxhdooApIptF
         fRZYfojr99BZqv6inEQos7Fv7nfk6MtEs2scAthtjb6zB64busl/GcCggD2PB4Aji/id
         cftu+BXya4iPuTdp5Gaii47lJi74njNRBgRielsXPONVB48GEzP+u7B7ONd6WPVMm1xu
         4FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554231; x=1792159031;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GY7BvXzX/lZ6HgRfVLIpvJpIW9DLsU//YiDzq9/XOoM=;
        b=2R2exlwNP2ehxqmg07UnnRXg2hkNG6fsup1JrIRf/sAIJp3icxV+2wCM0Exaa83iT9
         kCqA6Bpx1EUa+FK5t0WcM1+a3QCznQ+XMkW8ZM9DrB2nsJC7K6OrYW3PmYk6tS6Osed8
         9IdWMAgFjj2Ck7EJFOY8FXSF/eHpzb6Daj5FHYI+g5WXhJFr+mu8537gcvdtM27r+rAs
         8gbgkC6+ktSttrqGGeuGrEOKeKksjadehilGEum4sOpPcvFzeQOxc7KE4zsKqzN18wt8
         6hvZUSL5ABJ4IejaPT08LazMUI5M9ql+E6TIVZMO4chTrjDLtbSZeH4hjI5Krqo56yXv
         oiKg==
X-Gm-Message-State: AFuF++lawk1tMDTolJOYIHs6szEmW/3La0cD2xxd571LNS3EWeXrJtSp
	Rkt7H4ire+X21o/wIotR7f5KNYUm8R7KjN3DEBRd7tftGlmhMslr2+1C
X-Gm-Gg: AYBFou3VX2Jw9BR7DlMZvDLmwpeN70hvSRYqqFESX2yX2yPfKsqaZE2p7at/6d+fUL9
	FxwuQ9hQ7bmC2dWOubVgXBkfMz8X48SWGxznnhh5akJlOO4bgny1qVERmBNK+fMyOzrwHpsLhW5
	3tpfMT7iymMWUsZt27h0ARsc4fv7/8mhkkeEwU8ZerK3Q5HZUyuEocepxyWo5f+HTi7IK+7KtuV
	NabkH1zUX1VpGE/jvpu3D+Ij5pjyj8hhIgrYLlN8m3UfEHrIFgr56AGqZDM5wCD+MHM6x9YVe+8
	XgxiMQsDuZeCgxtsF46jkrdI5lNfV0IZNH+CrqejqGW8xlOQVlBt3fWaajdLIZrvQWfAjw6nBda
	Rc1T36hZdC0gRHca8KvgpqhMAaKlECwhWZrrCEIBi+VbLmuoAXs1+j6RCOL/g332Q+7dantGfnR
	fpNTjiwhU2P6TghFyPf9Wi3BZzjke4iPW0PB+LxFzwayC13DsQrbHmpof0DCy7dNFPgPYMQpi+s
	ogdbHPdotaI4cWQ
X-Received: by 2002:a05:6a00:238c:b0:886:3d9e:aac1 with SMTP id d2e1a72fcca58-897c7ccb7d1mr1764186b3a.45.1791554226030;
        Fri, 09 Oct 2026 06:57:06 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c49901fesm1059258b3a.57.2026.10.09.06.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:57:05 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: Re: [PATCH v2 0/3] mergesort: move tests to Clar and retire the helper
Date: Fri,  9 Oct 2026 19:26:54 +0530
Message-ID: <20261009135654.141970-1-dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <asjVkwUYJI6wERWf@pks.im>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com> <cover.1791365181.git.dilsheddilu123@gmail.com> <asjVkwUYJI6wERWf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Patrick,

I'll keep review replies separate from the cover letter from now on.

I'll drop the leak fix from the next version since that helper is being
removed anyway, and put the new tests in a separate commit. I'll keep
the cover letter focused on what the series changes.

Regards,
Dilshad

Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBC36F905
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863811; cv=none; b=I8uC5Ikb5bHkgCHYY3BbJQpWWysMPX5adc9D55nlykJw+xIiOn4vKuMyaxUGkshBycGnodQT3KlEOrKzeDIgr6v/Ov5QztiXRm/Pboy43whl+pZvivydA9HspYYzIR/ubEDSekqyo8S4dBWPA3r39eitLIHtZ7rsmF1F/LcNocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863811; c=relaxed/simple;
	bh=BQ0J7VXjvfkyRkcf0VZR/BSkUMHtm/2ThEZDS8+Xv6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OciVCGfwJJxTJ+ePXV/lmCHOFnaoBxxT+7yY+YK9iLE33IuFn6w/QdzSvw7XxoOMVtZEueN070EnE4eEjAuqTISvJr79xyHPQcdrRYdJ1usXOAKdK3shuhW7O5Kqv9RuXg0FuP/6/HB4UBoFkYFWspBAoDBnJsAU41giKBTE8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqligrBl; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqligrBl"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-38dcd98e5easo683966a91.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 20:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784863809; x=1785468609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nj+SNnDnsieGLByL0EHHlD9RkIyAAZIbXSQpEsRZkZ8=;
        b=kqligrBlawASZFXUylnWUDbQRWX6dAm0ejw6M8YtXOKhsCSjxrCoV0wIwOtMLGt5eJ
         n7G3MnNMTCGUntDfpnWCjV+AUjo+KjYCB37ZUSEa19oImmCyBgxvghG3A3ST/Fm1JM26
         oU2fq+C7ZP8t3bnXC/lapLjQ6xd0U4PSwBA4U0BmlkUYw1PFDbVcPaY8qCqcB5e+BVLx
         uZWaY3uItb+eCf3ZMj6s9eynU63zxJbanddZgQsU5HuEnMaP5/u5sPBzjra26nFRMBuU
         bx8sXUURrqD4dIN0CfMQltTQ75MulZgfxT3EC8aPSg4vNTxPCMUN2xU9Tzez2G0Wx1RN
         42pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784863809; x=1785468609;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nj+SNnDnsieGLByL0EHHlD9RkIyAAZIbXSQpEsRZkZ8=;
        b=c3y1R8B8d4FzOssaOk0lWC6A8Vf3nCTBF9+vWmljrU1Z4bulRvJ7gEgRI0iQZMueIs
         VJtpcy/pFxM9LISM9xBY8j5GYWo8Vw7CRiPuSr412SRgSsNrdPTePgcMvkngmPBCx+2f
         xb3ZN5hFV98hHbM9DLsxWfbaaa14pehYsCHsSd7qOF62qHFBINJCiABmXIxnvJrKefs3
         6x2BZdnXPDJtECUvi8QOvJAm38Wbs/wy+n0tuDOrRHajx8ygPJS8Sg4YW8F/+rn+ylmU
         QueKCrWSO22f9begupvBOdGP2B56+Rl0KFhjLbDanG/XfMCIbBRpSoqlQq576KYzsUbU
         5twQ==
X-Gm-Message-State: AOJu0YwqA5npn+AdijdI74tXBp5IGZTPdy/riZETPjJ8B95Pkb2/UJPJ
	Id5qcXzDmnifOZCQzIPgv/MFkKbSkyxsNQtFGck2M9b+YdfHfPJTTi3C
X-Gm-Gg: AR+sD10w3YDh0J2862e9RJzphiUbwVwX+2DeyEoQQQIPYVKDIUXSgl4Spgdmiag2Nq7
	xq7oAp5abPVx7x518GUh26ISyYWpQmI+Ow2Li6uY2+RsqbfYQlzLfxUK4G6PxA4Ga6TYk0vsIvz
	13zxaWKhHegaQCefGIom+l0/n4ONUO9okQcbEixajDSBOoUNT4oiWpJvEQ92SGpnWCnkdy98gU0
	5rzQfUJvCqDgHrUj4kJNC75a60AtSlws225adMNWrs0WT2SOcFDdFt6jD6ExK5N8I49sw5fzDrP
	P/cuPoymvOpZkUKgywFh/bJmYKjvpGTc4UDA1ymITNuywl6xEmKAfxHxfX/Wko5kEBzM6RovEDi
	cqx/2d4CJut7NSqzXiA0aKGPMgTT4fPsico6la7kLidnzfyC2cCOv6Mad4fe+5XV2YVT765qRFT
	5n7mkp57LOEPgOwtJOorfVxXfs6Fl/1JgRnngQI3O7IAzJPmY=
X-Received: by 2002:a17:90a:d2c7:b0:384:5dbc:cba5 with SMTP id 98e67ed59e1d1-38ec65f90cemr5956377a91.26.1784863809317;
        Thu, 23 Jul 2026 20:30:09 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm34329417c88.2.2026.07.23.20.30.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jul 2026 20:30:08 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: Re: [PATCH v10] show-branch: convert per-branch flags to commit-slab
Date: Fri, 24 Jul 2026 08:59:59 +0530
Message-ID: <20260724033000.89682-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723213316.89081-1-gatlavishweshwarreddy26@gmail.com>
References: <20260723213316.89081-1-gatlavishweshwarreddy26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While waiting for your signal to send the next version, I reviewed
the patch myself and found a few issues I want to address:

1. show_merge_base() has inconsistent indentation on the continuation
   line — has_all_rev_flags() is indented with a tab instead of
   spaces to align with the opening parenthesis. Should be:

       if (!(commit->object.flags & UNINTERESTING) &&
           has_all_rev_flags(commit, num_rev)) {

2. int _b is declared in the middle of the parents loop body in
   join_revs(). It should be declared at the top of that scope.

3. Regarding the {} block in join_revs() — as I explained earlier,
   it scopes commit_is_merge_base after mark_seen(). I can move the
   declaration to the top of the while loop body and remove the {}
   if you prefer that style.

4. Regarding test coverage — your footnote mentioned a gap since the
   test suite missed the basic crash. Should I add a test that simply
   runs git show-branch on two branches as a smoke test before sending
   the next version?

Please let me know what other issues you spotted and what signal
you need from me before I send the next version.

Vishweshwar

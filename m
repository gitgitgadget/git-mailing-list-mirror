Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406C145354
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885984; cv=none; b=LYF/aROTmd06Ps/QACG2NmQSeAj9lWDPvGO1ZcNUv+vy9+qK9ZxAKIsszT+96dpXlrvnUpi8Gxipy+MT5RQLA/X0qo7roPXRn5DBcAvfhYi/glB6+6lb6X38Pni13njLI0tHrtQ0YeyoBud+O1fPDsVuPg5PhkHYrkBM8ofsdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885984; c=relaxed/simple;
	bh=XaUMOSEGs2LIcv37NYadYw9e/nqtULtdIX2kgjy8xUk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fkT5FcoFwqPx6T9o1IMgUACc/0IjrHOVRq0T9wIWEJ7CHh5QapACq0xV9UaD/JGh1WN9kNOyq4gu7Vz1aOHDU8mQ17IjBrLE1nemhUsHoBD4L/yJYcL4Z9qX96O+8GV21/2Robwv9Be3jkWxsG3AQ1CGgHQNp4xMKe+TjCDQxs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qocohmy8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qocohmy8"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5101cd91017so2735237e87.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706885979; x=1707490779; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IePLtzWvuONvPeUGsrwqu0tYogfUbpsB4H9K2VDXD8=;
        b=Qocohmy80nea33hvDvFLJE/E/INV6r7T4azJL+InGjFCVzfrL9kDR//HCL6nNAtGSM
         2j/eAAq8oyR+r2P0tPk8lbj8G45jtRCaoOSKPvfzKjBGvgnBGR74Z4wQhddwzAynTbg1
         1F2n0i+RO+A5a5sLxt9XjdtCyqYRWj7WmNOjWcPoazD21Q/kaNLcDy+g8QXLyOumxnIX
         kHeMFX0RJx/SxPFVyj+y5JQjEOawVkxBd1vf9Dc2Y0BuGQkWXSl5Sk2sMqD30kmIiKTc
         pOJ1CLJqQYmLLdaOUWGj6P2LnTQ2LODld2wCH34lYpZUMiAg1Tski3fVnNt+wTEJcDJO
         CAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885979; x=1707490779;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IePLtzWvuONvPeUGsrwqu0tYogfUbpsB4H9K2VDXD8=;
        b=c98BinCkR3IT676e6laWMuLcw6EYAkYR1uJlZ9NPCUc72bP3S9SFn68ZAe7pMT1Frm
         UaWlDNhz3IOY1/rfI4VFs1xkar2TtirhTFC4ePJZXzO+gwbN2pw1uPYEdhDyGGJHLu8M
         pB91gpeZdprrkDZEpgZqhbll4h5LQvWGPTePDwvV5ghVw03ssOIxO+12o15f6PdwbPUU
         I9/8K0Og8OJz1bCdcFH795MXBEhVzpG4qElhDJ+cjBCdenvTFnVKH+hyF1VzSg1p+JjL
         kQ4WMRe68JjPuPU8oHhtt+eRNaxV26KhskobIzmc83NydfVvbpF8TLxfJOdDbUMXg49z
         tCUQ==
X-Gm-Message-State: AOJu0YwiDvvV6HOGD1mSLAoF6MnLfr6wNN0CoU5ULND9hEo9fqIGkCdV
	BM5k0dLc8r7DMhOJlw5bLh7GJz5IaGBd5JBND6neFI4cT7D0jcknL7jxACXe
X-Google-Smtp-Source: AGHT+IFLSUpIcGKIQogIbYU5pl5WDOJN7mmNnTsFZLbpKm/Y/kessDR69h/s5Uhgq5IoxIbdXCPpRw==
X-Received: by 2002:ac2:5f97:0:b0:511:35ff:bb8f with SMTP id r23-20020ac25f97000000b0051135ffbb8fmr1547593lfe.0.1706885978715;
        Fri, 02 Feb 2024 06:59:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24826000000b0051119c078adsm328410lft.231.2024.02.02.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:59:38 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Martin Guy <martinwguy@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: single-char options
References: <0e88ac8ad60d2da689d0a308cc59a02d468bc15f.camel@gmail.com>
Date: Fri, 02 Feb 2024 17:59:37 +0300
In-Reply-To: <0e88ac8ad60d2da689d0a308cc59a02d468bc15f.camel@gmail.com>
	(Martin Guy's message of "Fri, 02 Feb 2024 13:45:55 +0000")
Message-ID: <8734ua52ue.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin Guy <martinwguy@gmail.com> writes:

> I'm sure this must have been thought of before and rejected, but us RSI
> sufferers would like to be able to say "git rebase -c" for "--continue"
> not only for speed and ease, but for all the other RSI sufferers out
> there.

I'm afraid you'll have hard time to bring *any* one-letter option into
core Git.

That said, an option here is to maintain suitable set of aliases,
probably contributed to Git to be easily installed, containing, say,

  git config --global alias.re 'rebase'
  git config --global alias.rc 'rebase --continue'
  git config --global alias.ra 'rebase --abort'
  etc.

HTH,
-- 
Sergey Organov

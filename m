Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCA40855
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766707; cv=none; b=g2i66A6paf1olyWFmX/dDE4RS4tevXXKNbwElUhpOHZO9DoLz8u5iI4e+McUXSvoxOGI23f9/3c7zyujV3sJNgEy11BEwN1D5qtJBNmoreuZ+kfISGeHWWZ8Q7D3UdbEcakmRDvNjnZ/Ip3zbh7hBN92Jf0Er4zZKy586Zw5nMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766707; c=relaxed/simple;
	bh=pgYw71IuBkJbomKJQGrDvyklB2LbJRLkmuXpTPSr36s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQyLiU/gDgHD8Oie7WKDlINDceCutoZLemDijRY+f/6PZ0/0lanQa6hTy/vvifJaX9AOCBtxZCGdb8I70uF92UVtz0zCJC6xtvswCXl7sg6+1UpaaBH65Ft1x9oQFUrEUnC878ZOD6TSAiXow9ZYEAWNRunLZGabZbT/AkKeiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFG19Ypp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFG19Ypp"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2bd236adbso1432189e87.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766705; x=1776371505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMyBa5XeMQZnKoJ1H5ru/BujrVegBPxHwpJDKLBRtdg=;
        b=PFG19Ypp47buwQz/VR4eez69uJfFx59F/UtOsFYyWqc9oKLsVQclEAlvLXghWc6bSD
         A/X+rqSQz4fierHXu/pLzMzLc9aLwZGbwTqsnRiZyxBkUBX+cGrN2L2TZYw5XIW0N0Ly
         UteOlgESMTmh1LvMrpHP/tVjQ2eHrfVCvd1e8Y21B/pQ7tJdMRpjuJqusr9qZNextRW8
         p3QBz01CsgE6cPIrS5whZcw9aEg7JjyOqCRUYjqJTPQGtA9v4SNploKAiUrfkY6gjvzN
         zq/u/f4nbd2wdrfJKSS6OSORmns5CsiFMpiqodZ91/ELCEObkxLJoD0MuRcCAqEbvYCg
         +aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766705; x=1776371505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uMyBa5XeMQZnKoJ1H5ru/BujrVegBPxHwpJDKLBRtdg=;
        b=SQoxgq1QFLXqczMzHwBzz/3v/fCYVnwsgHplUuwtv1q/sqjsQ54GVYzF+CG9uKntaD
         nFaTwHHqC2xyglszO4kpJ9/WLVwOnAzFT3eMEeTYqmHDYl9ZiGcN+I/xTHB7Hv0X/bhX
         D1k1nyksHSMZESfbFEuD5iIetpTVpXaxEJMNk3ITewu26Xubomh72h+/ITKXkPt4uiYZ
         iYfp1gaVa/6B73bTWRxiR3lUD4AW7o/3tknlSZFrlYtzBuUzhHsp+jRspCVwxXV0LcEF
         1n+Jopw9UDKoDkRFqx7AWV/IJkjPg2k6HXy3xwcTxJ2xbtyacMAov8hm60vEKYTZXUy8
         uBqQ==
X-Gm-Message-State: AOJu0Yx2Olb5NxwJyfzZ7JUIKBwb+JWeRfGdqH76ySyaQyNTgecjWEwV
	LMoXbl5FBP1DX72plTd82v5JQHk4knSHTWMEd0qguSqPlFZdweeZWDgq
X-Gm-Gg: AeBDieudK3WpuDa398FQdoF8cVdmH8q34fbNQ2590fQvgv4muVjFFXUX9+QT6Qw9v0e
	ZIGWSSrTNBgRunAw+uqQmPnpUoyxiCavnSHNo7zn9MpUAFstDOXbmdx69SHpWhZR7ScT5uUBCrL
	wiPPioeYov6g6diVl3A+vHdY3fwW6wZojQqIZDLQ+D9Snh977texLbGv8UMLKqv5eZT0wERhcpc
	j5IuBQWQprKeNCVSXp9119YTUEx95XGcGYVwOKmS5dU40ZH5yurZxyjOEVddpVxsOfOtM96hxws
	Qusz+d+f9KgOWglwrR5PBLYHXn3nwUC6STmh4E7rP1fV+dU4KD8MKLT0qTk5uAUp54J6F+VxC9i
	bxlD/Q3xwC7B97YLvjSpT4vSfqBVyZKW8y4UoH2h0wVXgrV/OdTklzol0EgETvaITNrqudRPkiN
	s/iX3SQuTYkiUGyBX4VzzBY2sHyZciuucgxC0IB0Z9Sz7Fe9gcs3+sGc5FswQd3MymCFbVx9lZW
	Yq1YXVuMD170Vyd
X-Received: by 2002:a05:6512:1110:b0:5a2:c66a:d6d1 with SMTP id 2adb3069b0e04-5a3f0848711mr90903e87.6.1775766704556;
        Thu, 09 Apr 2026 13:31:44 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeee12fesm136816e87.40.2026.04.09.13.31.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 13:31:44 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 22:31:43 +0200
Message-ID: <20260409203143.19012-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq7bqgujto.fsf@gitster.g>
References: <xmqq7bqgujto.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Two and a half things I noticed.
> 
>  * use "test_grep" to validate the result, like you did in other
>    patches to the tests.  t3903 is rather old and has uses of raw
>    "grep" but majority of the tests should already be using
>    test_grep.
> 
>  * Not validating the base line is a bit unexpected.  Even without
>    giving --base-label to the "stash apply" command, we could make
>    sure that the output says "|||||||" (and nothing else) for the
>    base label.
> 
>  * When these labels are set to an empty string, I think we should
>    refrain from adding a trailing " " after these marker characters.
>    Should we add a test case for that, e.g.
> 
>   test_must_fail git stash apply --ours-l= --theirs-l= &&
>   test_grep "^<<<<<<<$" file &&
>   test_grep "^>>>>>>>$" file

Fixed, thanks!


Harald

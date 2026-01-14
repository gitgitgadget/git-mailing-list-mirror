Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5026F2A0
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432086; cv=none; b=sQEOhoqNA85ctdou4uczUcKj+SaHMf0PddJzZeuuAJu2RBiQt/qdhsBTflfWEda+JUXc1YU/hetpWBI3tFQkM/CRH2ScZt1cZSAFj6esqoXsOKsihLoAjLEqdrTx+W/obGOW5vaJdWhfopjDXNNeTH8twWulCq/XWM2INmglyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432086; c=relaxed/simple;
	bh=i6msJwbskOyKSrVlqNkqGizNpXb4aOt9z8NXrA6oWQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPkAf00J8WvSV+X1+na5FYmEDyRgMEE+GCA0YVFJIsGB58iQYW/6GMkr2/99C5/KWWZ/WWHXxum3UxRPHFHkLJ9lilCcHARDBM3yuT9wVBtX5pvHxwCRkSCMSpsdmtnjsQg+9wEc0QA9ZrP6mSMAUqPrncsU8cUr092UUWAA5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTR3coHL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTR3coHL"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-382fb2bb83dso1935901fa.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768432082; x=1769036882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80uLH4ZAMmshbK+L8PBLeSpKp8cTuVK5acAdd1KicVQ=;
        b=XTR3coHLcw1Hh7hNWEoUL8N0OPVpQxjnr1NYWx/64W3EDtyel1KpT8xa335TDtDAjy
         zJc8V7gt5JxY6G228xlSPmXyJYxlIs+M5MOhp8wp/uz2q0XgK2ntcg7S3EkEH6QZK4UK
         5aT3FezsKCeo4PKaeOfIBe4eVZOpa10U2DSvhQw9SRQuO14XsF5T00ZgJgCq5WTpH5nF
         bAXTuhWMafpqrT1PKjls8d/AN3JsRuZ/46wvQewiIa1LpCEBoyQn7CbaYfLRgKO4ME7R
         EXlvJjJ845U4L6ocFYlzaZ/oeH3MtXlgIECSELsIt96f2Nrq9pXJGOPmaWR65hfPx/vQ
         xmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768432082; x=1769036882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80uLH4ZAMmshbK+L8PBLeSpKp8cTuVK5acAdd1KicVQ=;
        b=caOlq4caLZWMDGi1qo5rhj1zOVdGGjeHsYRJXZhYyNk1EI2R2i4CSdWYk96qbj1Gpz
         +r1U3S5DbSxsa4w+0Gq2Srby9qJf7RXFBYys3jF+VxqR6tSrB8AJ7KozrBhoEYrDtSe7
         k2ganp6dBEBmK0s+web01Wvg+RmnR2LiD64Y76+eA48J/HRM0AWQg9XO1IKkuvwk9XqT
         JEnBXNWujKtNthQL6MwWMhpSICVq9CIaCVmfWrNR3IJyXHMfiXOo2F+FffNTGQldNczL
         9p4ApmjxfA3LG8syhsPHpdsQR/Rabl3qbGLnqgS6W7uUGGVB4HjiI8zbMDkRKYlIVdwG
         WNzA==
X-Gm-Message-State: AOJu0YzYet0+d2fvmlQ08SFsExx0IeLFsSnFR4o1hlbVGwNcvwAZscKg
	FVeYzYFkkxMvrWb1wipWyPO/bwXGyuR51yRrXjxZeYsBxXVwyN+J+BU6
X-Gm-Gg: AY/fxX6pyTem+ZT2uqj6TzNI0hlP2Jre3k/tw1x+50XkhAnm5QDnFAB81H9SrUsX01b
	LER84MnT5Qmz5O4PchRy6GXYgneXiXMiQgKhpvhPBLjUGvqLfG8PBSxC8YpKJKFkdHEi8Nzxyvf
	yecdoGEW2tCw3JJroIUhXAkFJydOKAJJTAIcXmvU/k/UKBsZXCTp0E9R5FE4loyOQOaUH9T8tl7
	Tp7VKTVFfiyHgx0nqezL7m0bHSdCCj86Umh7FITmYLh0d1UwNGPiuiDjU4Ej5YcAmFx9y5Rbr3r
	l+YxslrVf6c0gOO0SA0/PsD5K1pdaWw21b6UDOvZ2bOzshGCyUxaJBzIKoiDgQ9+km90zv2PEiN
	N61ncD12uiW2nOujUXi2ocH8Eb7UkhwvtCL3t+r/SpqmDqyVV+zrZpCrwoWYi0NTeryvJkEhJoS
	Y3u3te7XqBGhxGQeDgPkvb5PNeC+loadLg0U3sQsIoBnCytXdir8Rr2TXu2KMvxCOV5nUueBs=
X-Received: by 2002:a05:651c:18c6:b0:383:1a86:ad0f with SMTP id 38308e7fff4ca-38360667b8amr12361101fa.10.1768432082115;
        Wed, 14 Jan 2026 15:08:02 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382f494946dsm47340161fa.45.2026.01.14.15.08.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 15:08:01 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Triangular workflow
Date: Thu, 15 Jan 2026 00:08:00 +0100
Message-ID: <20260114230800.56885-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <56D0BADB-43C8-4E93-A871-6E6B11B59DCF@gmail.com>
References: <56D0BADB-43C8-4E93-A871-6E6B11B59DCF@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Agreed generally, but the chicken-egg goes 2 layers deep here due to triangular workflows ;)
> 
> I favor something similar to what Junio described but also including @{push} by default (and ignoring it if non-existent), so that folks discovering > triangular workflows for the first time are easily able to see what is happening.
> 
> Us ”already triangular” squares are probably well-versed enough in Git to find and tweak the new feature if desired.
> 
> Idk though. I think more folks at work should try triangular flows, so I’m biased :p

Ben has an excellent point about triangular workflows, and Jeff of course,
your philosophical instincts seem correct to me, interesting to read!

I would think that most people don't have separate tracking and push
branches to begin with. So it's not a lot of people would be bothered by
having this be on by default. The people who know about triangular
workflows will also be able to find how to turn this off.


Harald

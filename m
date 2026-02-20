Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A422DB79F
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631713; cv=none; b=NeGOc41XxayCCFjWX8XEb1fMfmCZ7njaa52OmvqCgvc8WtEbzdk7GOX2ny1B8qA3t6mDEzmk2UCIDki3DPgYH83AB+TMabQcExmcDy6TPqFhSKXse2WImZHxTEA72P8tRwKTyl2bk7HJyiBGeqABUOG6Hv8c1EkzaHyXtOqdm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631713; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Mime-version:Date:Message-Id:Subject:From:To:In-Reply-To:
	 References:Content-Type; b=QElEcAHRuGIz6ID2t6bfJytodfgtXKPqGPn5ZfLFtmQ0qtpjfwaeWDtiCDwd7pNHyTye56aL2exU1x24qRybNMMuOC6UXL9r/QzKEsZwEAgBYTxSxkXEyWrJ1gqYuF7h/pOgNb3r07tEEQ1Vkc1kxVLSWNfne04DJUkWTry/zMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4/uY2ku; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4/uY2ku"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82311f4070cso1743790b3a.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 15:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771631711; x=1772236511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-location:references:in-reply-to
         :to:from:subject:message-id:date:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=D4/uY2kubhaPtPVnRY9fh5UHmgXxUQPKo0LvezmMbIhgVkT641Qdx22+bJzRDCalXl
         c85CYD6hwn2t7uuy5Mg/Gx0+RJeCm7K+EHyJwy/j308/wyFGs/e/X/peVnkuvlZg5O9A
         7ibaVHwjjwK2+fRV4xV7pE9R7bcywygne7wGyNH0aGmT9KE4x2tn6kLbghU4ZV8uN+RX
         qNtu1oC2lupcVoHlUH4sHflbWpoqs7Wp9I3cmyLWAes9PTFSqCQu7NEURAX37Esfkm9U
         TpFfgXro7hNIKMrTtP6/otVvVI8sGXDreLI+p+jqXG7q2jgRp9iOFr+Vqt775XbgD21P
         NE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771631711; x=1772236511;
        h=content-transfer-encoding:content-location:references:in-reply-to
         :to:from:subject:message-id:date:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=YcuU5iGAA9Q0c1LgHYE2yKMutzBUEI1Yg9kpQKPuTnaMs9gt7ke0rd8C8tvLemFc3L
         vGDrJRjd8gYnCtheiQ3YD4nZr+YGrzLQSieA1otrTaP58eMty7j75faJ6VrAcHcTAr6p
         utaJnQ0YUzaZM8dUBR3X9kJ7Um95TGjORPcRTQjOSEdwCUv2darukyPo7uPPNm8c3ypI
         NRw4R/A3ow+9F8q1JPxBukM5HQsFwevPIyLgiNBdxW7727WATC4dDWuotENjFbPykW56
         xYLDaOpn4NvjKFxhvv7XhJZzMEZaKBqHD0sty8UUI4qqdgQBEJ5T4FXnOyJDHiXUu4dU
         X49g==
X-Gm-Message-State: AOJu0Yy7xktwDoqQ5Gs6t+9MjB//Gr5fLVZ0D6BDfxJIpD1CixW4E3JS
	A8GWmdqRcoHqjx+q03p3bb/tcPJQJqt1QlfkzvhigTdWX57CEGD2LyM3U27/z0gYYNw=
X-Gm-Gg: AZuq6aK9khWF+v/0isTFV/u1KexoPjOrpaRojR0f+XyhGw8njfCrHtwwT9gkxwqRr2u
	mQ83TkMfdiNRQ/LRFqrodKQuJFMKE/Xk2O3axIkROO8uCYEKloVCCy4k9Vm3a2l59W3nrZQ/NFv
	+8n5E8jWFJBToz64q3fMnFT+XytsGqthdgbxu8NyNga9JpvuxKEXGj1aI65u1XAtCZokUO8pfsY
	EGuCBIdwAMd3Um5fBCh5V7rN9ZDYiMSOarhsB+3O+CSsk/OncdgoAKkwEnQWvVXhK09Rc3+HAqs
	qLkcg/+OopYMys2+qVoT4fq7w0seoZy6i8g2jzFii++7/JiMlWlSgXiiwp6bCZztFaFC+DD14vK
	RvyMhWQ8rQNIJgdq3JrAsZ0RQ1Y1Do3BoZ8btc8KhefSWmA9PnPClnK1Wtq7d+aMQxWLcWqjggC
	dVwAGUjh0tzaBFlPz44NoiPyHmHusgeiEaSh9FjWfHti0dSZ3IQW3t
X-Received: by 2002:a05:6a00:3d52:b0:824:b304:2d1e with SMTP id d2e1a72fcca58-826db7f0d35mr1106700b3a.8.1771631711551;
        Fri, 20 Feb 2026 15:55:11 -0800 (PST)
Received: from localhost ([2400:2411:d163:3000:f4f3:9c6b:2242:cc08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86c6f7sm400790b3a.31.2026.02.20.15.55.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2026 15:55:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-version: 1.0
Date: Sat, 21 Feb 2026 08:55:10 +0900
Message-Id: <NIorGovrXXRrDTqOqJNyPliERqAYQItB.1771631709989@gmail.com>
Subject: 
From: <mari0211juna0517.n@gmail.com>
To: <git@vger.kernel.org>
In-Reply-To: 
References: 
Content-Type: text/plain; charset="utf-8"
Content-Location: ja
Content-Transfer-Encoding: base64




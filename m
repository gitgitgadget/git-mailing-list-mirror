Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AE1FBC9A
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119895; cv=none; b=Yov2tLZKWtIS4S/znjTwVnkuMVfZn7VSOT9dyT8hXnTSPWBR61sxyUlhMINs6YIpqzErx1WHiINsHf/4s5iVcLIwR0zPu0Hrw2rAdef2h7sHyoP3PuW7C+dw3MZm2nmrm+AI3N7q6GVwT+KKkll2w5J8hIXLQquI/rl8amjXbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119895; c=relaxed/simple;
	bh=Thz3zixaGtPAQXe9DePK7t5jxnHLDoorShMaarx2af8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuhwrmZGZo3CtdMLrZA4pTCp7b04siyN8jYt+zhy9LwjOVbKUItILc00Uod6cvQGjJ/9JcE7VXHOIyeDbnwhmcxscQ/sPBx1jCjQYgIZNys1mCCI55F7IEHqroZTfPHvgMdgctUkJdyTChK5rMCSbcjIGqXtagpQRAp2VpeZwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRavICLm; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRavICLm"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-220ec47991aso23345905ad.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 22:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119894; x=1740724694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnPYFq0aWULB4mrIGSwj0bbwFFoKZ9R00At6OvX7FDw=;
        b=DRavICLmT4PuGxdQ0C7rCM0v2cVXGiSzdXJUkvHozfTyW8Fvz8Xk11WVTckpJIRcFf
         8qeg7GExaJoRxGQiveUCA70bFcU/qZsq+Wp4RnsxktOx4M2dgQteK0tJwZqWhQxNEbM3
         gvM45RA8/2cOKK74lvcBAHs3Uj1ePjMhDmqhjubg+2tp4GcIJbW3phS2y/q92RsHweah
         F/fx5d7Xh2gpppUNJqSbHQflvNpBBzOzMr0HVJSloPEH8HQ5SaLVTWmxKAr2MwOzz+8k
         kG7gsaSLO89BftJscD8c8t6nwsEv+wRZFJ2gZPcSQDzQP9zjLzXhlKzzIjlqCTOozTJV
         /5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119894; x=1740724694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnPYFq0aWULB4mrIGSwj0bbwFFoKZ9R00At6OvX7FDw=;
        b=vg2/DKM63vUzd1s4kGFG9tnKaeehSoMS7gitBd2tdoi1yqQTQnWum+3xQpX1Rrhjn0
         fwxkBhnwTunWEbRE1pIioRJyUGiZZTvjkIc+eBJcvtEPWGVO0wz3c82Fi6Uv6/k/j1RA
         Ecp/eUd25vYNldhFcYsNnqmLfZndLRnUQXGKbJBh28+JdadjQ0aPgJnw3nPrWIYD0tRG
         m27VGv5OIrcPhOQIPCkmUwFycVzBnsNEbLEwmezTG50a5kAvXRFWOaqN3F+VX/ImUnyc
         XcJ7tm3SRlFBIqtre0rwCSjZWDCo9TiFoUE/EMFH5O2eWtLvpcILMVuqTRbc9B5TJnVL
         lRlQ==
X-Gm-Message-State: AOJu0YxtVxzwaWB0wsJON/LSZ0vbhwncjyKLK+BmZVj9Dg6Pk5egorqn
	zDVKE+jtGgQxjEZmmPMEKgXkF4kw2ovaXNNhC0pGM5yf1GOe60+W703xBmZe3qY=
X-Gm-Gg: ASbGncshfKSAYIAXxyQI+AxE/791lhSl3Tcft3J4cBIi126pgOHCW9y3lDXpVE5f5ZO
	GZ6D3ZvkCzfm4CJhTRBr/1i6kYDSgeLOxv1cr6qBZ0E0XQEON4sv1Qk5zDIcRgOFi2IexgMKW90
	FHWvXDoz/cvkujvzh+LRawJcmMk5KAi2MDLOjvN4WZl0Xt/pNGK2AoSUMYwrYRduGxPPo/8zsa+
	yLkiabP2j80bXjcm2VHI7WgalhJlAThbtDGGswIyV5/84EFENU37Ov88H+iUsYi3nps+n7DCpb2
	dy7FMn8jPUM+bu4d1BKiiapWN04z+YX8UvfvABkHGgHgKF/mhYneiXxaxw==
X-Google-Smtp-Source: AGHT+IF3LV464oVYxwDXO5tRWeL0IBdeh3Jvvn4eIBzkBYu8RoXTopKD46HW37cr2zt3UgxfVzymsg==
X-Received: by 2002:a05:6a21:9215:b0:1ee:7c7d:e66a with SMTP id adf61e73a8af0-1eef3ca2d1amr3677922637.23.1740119893656;
        Thu, 20 Feb 2025 22:38:13 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([2406:da1e:bcc:8000:7a73:581c:1722:8d2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7340751558dsm4107528b3a.162.2025.02.20.22.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:38:13 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jelly.zhao.42@gmail.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Date: Fri, 21 Feb 2025 06:37:05 +0000
Message-ID: <20250221063705.15539-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqpljfxhvp.fsf@gitster.g>
References: <xmqqpljfxhvp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Feb 18 2025 09:49:46 -0800, Junio C Hamano wrote,
> Doesn't it mean that a change that makes these line-number
> variables to size_t is wrong?  Of course the change is not made to
> break the code but may be to please some code paths in other parts
> of the system that wants these line-number variables that are
> currently "int" to compare or assign without range-checking with
> "size_t" quantity or variable,

Sorry but I don't think the change here is wrong. These line-number variables 
are used as unsigned integers (compared with unsigned, used to index arrays, 
...). And what's more important, we even do range-checking on `line` before we 
assign it to those line-number's, which means we want to ensure the 
line-number's always store an unsigned integer. So why not declare these 
line-number's as unsigned if we initialize them as unsigned and at the same 
time use them as unsigned?

Regards.

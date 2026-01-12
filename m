Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788E3659F8
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235813; cv=none; b=U9CEv/pVKy4OAJHCnik+nvAtF4T0c9meWkL0SjAaAzLugQ+z/Pyjb4JtbwYt+Wipseg3Tm4R9WpEjmFAnUkR4wP9zvTgfZPVoOvDFqPMUmEsF/u5NBtIcKj75244woFRa4obirQ3nGnnF7Tizb1CsfJm370P+904apwUM/1zRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235813; c=relaxed/simple;
	bh=BR2Iqnqlzgc9MJT58WjOPKN5Q5+s9tli4pJrWLYXeSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX4vju4BVeRQRuD9Lx/BZb8dPFMuEN3fi4RhzEq6W8ktr/8KF2QdAq2RwiPx82RiKpFCUZWmoNI5Zmtjc8xXw42kxjQH4ZgTeh32mPlehj4jr+r2dNaWO0dBaqicYAkQkaupvkJxPlqeDdi8z2Q5LyGAhlqk09QJPS1joYU50ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L34KRLjt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L34KRLjt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0a33d0585so41327925ad.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768235811; x=1768840611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Panbxnkl7cnB98Q/hI23cWnN45Q3dp8p1ICsM52lThA=;
        b=L34KRLjt9FWhdyOJhTwPcH9zERJomxLt4uUP0arMAM/h0qAc8AnhqeDvd8OQsJ8A4F
         eyxRGsx8Fj50PDkwxsuitrZx2+dlYSTApcQMWICiUmvZ8m+b8/eBwPxKgcB0Z9XcmJnc
         JQGvrkiofobgs+Ev3I027ex3Hmpb+RH0i7pGxZKbon5J07vuJjbuRLtiwnPQcnX6sSOU
         BYXZRWfJFIzWs0aMM7LWKWd2kf6KM/oOP3ekV75PDF/EWlXnrlieqUaw8FxIk/BYCNI0
         Isnp9lZeMjIp2ApaWrS6hbD+tYtSRropVqvhJWWhq+kJFyMdtct0SgJaAoXVPBGfuYyi
         CwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235811; x=1768840611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Panbxnkl7cnB98Q/hI23cWnN45Q3dp8p1ICsM52lThA=;
        b=K33Rpq8NuPTWBA4+PZqpZi5f9lhNF2ZYqul6IbBNy2fFKNqO/0c2K2B4ZQZlnvqU2M
         TmeWNJiNQNEt+IbuulpX1B4hTb7YOVk8L3MyLblvF4zU/yXH/7/SJlq/luhnQNJMOIAn
         Cjt8d/GJMMdE5dfMexgUNAoLHnF7vKl2dd462YM70rzSQUM6qCClmSA+rdZThaMjEM1A
         Tpx0lLCHP4stLUeO4Ds/VwiohoGytT8ZS/Su/wXDVyAmz+pQ7Rkrx4vlG/3hyNmbVhC2
         v+tv4B2dxH1g15UmSuhKveAmlyvvJ1+ptiSN6HfQspnpe6L7y1QHWlVKmVgyiCvjjAKB
         ux6Q==
X-Gm-Message-State: AOJu0YyzmFxuwwQEGytW8CSDUod9+SIuN5BaafEDc+ziDqzG6xLszgX5
	xpNkY9YjSzV0b0aHlUhznc+btsvaKXw9gUpYSuPGaAY2iVrZ9SMOrfrRqeHf1F4T
X-Gm-Gg: AY/fxX5353Abh4XDIHkarYMRCQERrK+Ag0DtZCXZzc57HW79OjeK/rMd28xrVBrhMYG
	UZwTTG/WpRF2GAWU1i6LpYiYIZ/rmKEicgWBJjdPzQp3LanJ1Ww/5Dp2niOG48OCl8/HPNA+NZW
	ozJLu/zhFZ3iG7i+EQCOttB1OSKGB5DHm2QRXJqgEL/zmBDVG2BXtpkQHNQj6LrZb1/jfa8pVUJ
	QZeE57xR9bxrmHzvsKIeRZoUmeXv8zrCIRxDc0/A6CrsaJl8fsv/XyY6NYLxejVicJlvh9c0UJd
	+QXt6yQRNu98QyxftcTMnzdzP9s7Jh0lkpu1sQ9felMAWUghmSTfVDwvyVK2PBlRkQL6qXUxGml
	m4ICDLO4e73Z/FNC/u43PDbP5z2pVzkBwmYdX87dr0qCyYBIVrZ407Bklb74iLF7om1E02kwkRo
	wL2kNnxAG++ZDwJ1aiR04YHQGDXbivxD2C
X-Google-Smtp-Source: AGHT+IGAjrwQl5RqAhmT7w6gZ9ChUIgJaZ94JdxjQYkBx45v2UHWYT+zl42F7TKbAktP5tmarC88dQ==
X-Received: by 2002:a17:903:32c9:b0:2a1:360e:53a7 with SMTP id d9443c01a7336-2a3ee434bedmr180537245ad.13.1768235810825;
        Mon, 12 Jan 2026 08:36:50 -0800 (PST)
Received: from d ([49.43.40.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2c04sm183006655ad.53.2026.01.12.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:36:50 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: deveshigurgaon@gmail.com,
	sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 0/2] t5403: improve post-checkout hook testing
Date: Mon, 12 Jan 2026 16:36:41 +0000
Message-ID: <20260112163643.231-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260111072950.9463-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up on the recently merged patch that replaced 'test -f' with
test_path_is_file, this series continues the cleanup of the
post-checkout hook tests.

Patch 1/2 introduces a check_post_checkout helper function to replace
the repeated pattern of reading and validating hook arguments. This
refactoring does not change test behavior, but makes the code easier
to maintain and prepares it for further improvement.

Patch 2/2 updates the helper and hook output format to use test_cmp
instead of individual test commands. This provides clearer error
messages on failure, making it easier to see which argument (old ref,
new ref, or flag) did not match the expectation

Changes since v2:
- Update commit message of patch 1/2 to note that the clone test now
validates post-checkout hook arguments, not just hook execution.


Deveshi Dwivedi (2):
  t5403:introduce check_post_checkout helper function
  t5403: use test_cmp for post-checkout argument checks

 t/t5403-post-checkout-hook.sh | 53 ++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 23 deletions(-)

-- 
2.52.0.230.gd8af7cadaa


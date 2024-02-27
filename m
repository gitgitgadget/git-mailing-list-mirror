Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32716535AE
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049784; cv=none; b=t8bG8zyq0qYNei2WiLwgfeQvQ4CMxuZew/BTJGVGf2xMH3NFudM6hUyrR6u6YqV8qUk1OKe17Zo4iUaVVtiIrmbH8yIJmB2V4M0YQPFRFMXHg8aDmOCy4cEBo4SFRaYRI9hL2Y8YGA3nxegIx+XLQQRWlwBFQO4JgfLrZMvEcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049784; c=relaxed/simple;
	bh=6AuHnUm/dv4+8YTS91uZAfUq2qc9K0obj3EBlGAb68w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nm/K4NT8RvWpe5KxbZs8DTc8r33fPE5ZGViXYfzHqn6M/Olvpy07y5pccHjX6m1jmvhpzHVxSB2+YSsEVUnL2enSpQdlRiL1QGwHirAC4v5tVn37cotOe0LZRMfpRRyVWO6GSX/7Uea0MuVYd3DF76gXu3ukhMVmoBznMAZgL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf6tKU9D; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf6tKU9D"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso2348028f8f.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709049781; x=1709654581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahNG/IlB4E/zO5RlBFxKooHarteZiQX/i9aJesmMc2I=;
        b=hf6tKU9DBrJPoetU77B7qqJr8YVUIF8+vBn7vzVTjCdKZDttN9Vbsi/bJj0qy7Pf68
         eoKWTzmGkXqiuYLhotli3IVtNCf6CGxBy34FNyAGx/COcjrkp27KKncAJxrsXprHUQC0
         2hOY1nDoWyKLD+reITFOR2UKSLJaGGmxm2/8RaIy9KEZcZO+WMrs2Qw5+ByywmxTe8T1
         hpEw8bG4l2jsgzFtTd0za2LjzQsLSASyhYd5iDF+xPQNdJ8BbeAM4flZxKxiGorY+fjY
         LJVZCDbRpLVpLvWFSsWWtJbMHR6FTkI50UKYjw+N+XVI3qMK/rSKYW+Ytrz4CuV4cvVB
         4NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049781; x=1709654581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahNG/IlB4E/zO5RlBFxKooHarteZiQX/i9aJesmMc2I=;
        b=jUh0mYu/1SbhVtf42OMHeFog+y2glXaOLkrzRy519zhb3r5XW08bNXMRxJLEE1RHlh
         XQsvDduzz063RSmWqwdMfwdpPDOshj3yCcpwqtUi94EIJuF0Ga1L//66+FJoKEaWKTJv
         hh1ibMRGEFer3TqxunVWZPOw7SEJHv2SLdDrfNAfv+Y4WHYxdPP8oHpriFjsT4YLAPHR
         pQmxxbjfVT0yPKFOZ+wbcI5P0zpPcuib8WgJbJdSoljuwj2+qHjRYaJU+qMogo+TVBOV
         VyI22SF0j0nFNl0HmWfNxGBenI5YANAxQhr/W17FPXRVFduhgGyLIlo6a9dqS7KsuShZ
         ObcQ==
X-Gm-Message-State: AOJu0Yz11GylkjV/DuiOJv4QoWi38QRGSyStxdDUZQF6LyxOmRh1glSi
	ZCXgRDa5HkZLPghSpX1eT7i3rvbKpk6Y/Wb7ni0RnfzGutb0hvISzZxfvyDpVgQ=
X-Google-Smtp-Source: AGHT+IG0RnYzKJ/FLUeeyTuN/WIu4USQH2QZ7e0NOcoOSanttbwMiubzf7B1Dn8Kcv4+SIdZZ1ZWWw==
X-Received: by 2002:a5d:5312:0:b0:33d:b03a:5e2f with SMTP id e18-20020a5d5312000000b0033db03a5e2fmr7182712wrv.10.1709049781448;
        Tue, 27 Feb 2024 08:03:01 -0800 (PST)
Received: from host-sergy.. ([154.72.153.219])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d5702000000b0033ce5b3390esm11714323wrv.38.2024.02.27.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:03:01 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH 0/2] Add builtin patterns for userdiff in JavaScript, as Microproject.
Date: Tue, 27 Feb 2024 17:02:51 +0100
Message-ID: <20240227160253.104011-1-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would like to apologize for the numerous irrelevant emails that have been sent to this mailing list recently. 
They were the result of a configuration issue with my setup, which caused my patches to be sent from a `noreply` GitHub address. 
This led to a series of failed delivery attempts and unnecessary emails.

Firstly, I'm so sorry for the delay between selecting the Microproject and sending the patch series.
Learning about regular expressions took me a bit longer than I expected, but it was all worth it.
I'm very grateful for the opportunity to work on this project and I'm looking forward to contributing more to Git.

This patch series adds builtin patterns for JavaScript function detection in userdiff, as 
my Microproject for GSOC. The first patch adds a regular expression for detecting JavaScript
functions in Git diffs while the second adds a test for JavaScript function detection in Git diffs.
This new pattern looks for lines that start with optional whitespace, followed by 'function' and any 
characters (for function declarations), or valid JavaScript identifiers, equals sign '=', 'function'
keyword and any characters (for function expressions). It also considers functions defined inside blocks with '{...}'.


 t/t4018-diff-funcname.sh | 25 +++++++++++++++++++++++--
 userdiff.c               | 17 +++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)
 

base-commit: c5b454771e6b086f60c7f1f139025f174bcedac9
-- 
2.43.2

I would greatly appreciate any feedback on the patch series.
Best, 
Sergius.


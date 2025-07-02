Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CC2DE6F5
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489983; cv=none; b=qxTJEuAGm1/Von2RurjMCzJZMnLg1yIWHgPZxL0UktmXTDVn0KSVJ3WjsBJMMNZlhiZH3zCGkUWJHJSqWwXgT+ceIXFwDO6qYPqkum/3bUyLb2G/LTHnYOZBrEtBHve2Or+OrhXo7XOdrVxiXl2f55ExjORtnAJbfsmbu+i1ZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489983; c=relaxed/simple;
	bh=5BC7VSpQKvBXFA7tnJABR0lJDYpep5aKLyhMxoyxcmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7g1BMkY9KWUfiecUhvdN8IAsEZCeLgp58N31gpctyi7G/Ncsc7AsoGL1OKVkhsBTRGKePGDQIQwRWvRkGGmYkTEftxzjDH4nISHxU/GtkwOeJE188OcjTshW8mBH3FojesqG1LfmNSPyS84oaWuo7Y1q/ORzAYwNN7FxmaskOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MimgSwnT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MimgSwnT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e1d710d8so87507135ad.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751489981; x=1752094781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y/hr1mjBIIseu2o2DV35uOh4eMt28SYgNWgoc3D7UVI=;
        b=MimgSwnTayaouySDU1J6fbLdL1WbnhbJXbXJUmtK5VLvr2OtQvgyNaOT1XYYk9fE5I
         sOkTnjzt//zC6mojxJHwyxEwnXQNXIyZg+KqtpyFh2OdUDGBYlkGS66AMsxmby/9pdIy
         fVbb7eYqnz0Hg8Z6uKSqZwCek6Yjq855mISUuBTea/amZ22EicgORKAXvlXGlsPMj9k/
         Uf7hrSuTofeqRjlYXiybaNfG9kTbUrE+Lxir3RJdqNr4IC6JSIYt+9GVngT4sACQW5zZ
         q7AOjDz/L0PvuLZ3J9bFnInPBIcaIR7OBZ0V93+jdY3BvC+FiKJOVxl8SOrfor1hAy5H
         82tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751489981; x=1752094781;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/hr1mjBIIseu2o2DV35uOh4eMt28SYgNWgoc3D7UVI=;
        b=kESgz9vgSMIcPCf1r6Cxgmm5UVdvtJrNJUKsVtf22UzGLbSC82NffBFy1ndhRAnyTJ
         z4vTfKaDyyu8wZCxmcsaQgsXKZiO2YVoGNfeS/Qk0BUJF7wlyV9sTb/NV3bQH8JUNmL4
         z5l11hErp/pZXmtwAJgTfA1lbXGNkt3Fn3vpGXRKgO4JJXwIyldq5CYq8ULNAf6JzA9w
         dRkNGCdSjF+uSRXOU8h4X75stdDChqG0kFS28YJiHBDsarXr1OHgA31ng98IlBmsm/eH
         Aa0wtoAPO27i0ZQWkAphzss2vKhTkOsq8Jdvlguvg1k2tSq6bZ89uknD9Lgtgzx0+6nY
         /YnA==
X-Gm-Message-State: AOJu0YzqMeQ9hjdTZmkTfucwUVvYODEk/QNAO5WtWoCnNJvEitYb9VoV
	6DzFvYbDX9hqNV6fKtITfnyKANfnsON+6MWCVvuKS7b5aDORNT5yonAS
X-Gm-Gg: ASbGncsj+bv4lJCKnpJJb7YZ7JAQLUwC/I0YR7RJxSPF5567/x62A9eGpSNlPkliPjg
	ZDIhScfxrpZI5OIYd77UllDx8NDDaG40rdFDoQgzXlus4m1o6zZ38uP9b0x4eL2CnwvkLezMKnG
	AZbJlOIPeJdCl9XGHIMkkhlLYn9jotoItaIC2axKS1qBy6xIR0ga08kW7WESrYgqVR6YeyrkC7c
	WQyDAOo2nszleuL1Xzg7P6MMFDJL4AA8iLiVMfyZmK3F3h+9V7LTrIuKB/uOAuj0yZ0/NF+oSho
	rE1LaD43ANzaD5Vw0XWmd1/bY8xIs+rJis+UBMcfECCD0CVRzNDJtpUFek+X/ZLw5fD9uNeuIfF
	SisDukT0SpNMWuFoPDfjC+XsNbIw=
X-Google-Smtp-Source: AGHT+IElTH484aUzVmLg8YlAdBu+rB3X5gmjqktsCYQEeO2Z0A5ipSfA12KmDtA7Dg2hYJImaXf84w==
X-Received: by 2002:a17:902:ea0d:b0:23c:6cc2:feb9 with SMTP id d9443c01a7336-23c6e5d52ffmr64726205ad.45.1751489980544;
        Wed, 02 Jul 2025 13:59:40 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e39f7sm138544315ad.49.2025.07.02.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:59:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  pclouds@gmail.com,  brad@comstyle.com,
  collin.funk1@gmail.com
Subject: Re: [PATCH v2] builtin/gc: protect against sysctl() failure in
 total_ram
In-Reply-To: <4vz7mwsyckx4ie74qdlitcmhg4vyuoiuwzufd4nktgzu5ppzfx@cqmznirthjcp>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 2 Jul
 2025 13:22:29
	-0700")
References: <20250702144244.43858-1-carenas@gmail.com>
	<20250702154649.44210-1-carenas@gmail.com>
	<xmqqikkacu30.fsf@gitster.g>
	<4vz7mwsyckx4ie74qdlitcmhg4vyuoiuwzufd4nktgzu5ppzfx@cqmznirthjcp>
Date: Wed, 02 Jul 2025 13:59:39 -0700
Message-ID: <xmqqa55mcnr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> yes it does, but the "implicit" sign conversion will trigger a warning

Ahh, OK.  That makes sense.  Compilers tend to go quiet when we tell
them we do mean what we are doing.  Thanks.

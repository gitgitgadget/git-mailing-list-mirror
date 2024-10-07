Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9018C000
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290751; cv=none; b=lTeBeByxyefBASTz3zSKYAmysquCAJxA1LFzv5913iteSjrhlIoDV/4YplQJ1hHPpuLxnwMzdVI1XO4tQH6iqLQWFw2g+v35gAjgLwVCofetlYJ5MT0cgqNYF4r2wal9kFnWaXMBnrOZLZKYqH56VcnCJuCSMTvibMzOH+wN0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290751; c=relaxed/simple;
	bh=IkDb3fVQAcQtHLCnbLsznoAwuOD11AaTMAIGLjcBUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqHYyLO0g+iZliQ5Hy9m6pH5xpFFnapEmD4izQ7EHOt10pwP1b9Izl6cYAMMa1UBPQPCqlxonJ1UWuTok4bPX8E+B7+xByx3twh08Uq56jsR9AwEAXjPEDyJR7un3nyLfx55A8iHpiJjRVJ/ZBf/WXI5OdEItFPQE9EWefRoTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkcOTSve; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkcOTSve"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso830799b3a.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290750; x=1728895550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyvAfF/4Oxlw845+PwktLvOQPH3wGBMupqNCNNotp6A=;
        b=AkcOTSveTD2R1QAAOxB+qEpLyBn+pmS77n2vUzfBwipQsAunR5JNzoQObOkK8Hhx0H
         sWcNEyTJQgH4VxbsAzKNxL23xQYcm5UL4A+AjAvBIFqXqWeOBp7nWt7fur0ZGh2y/cER
         QCsaT6rfBZpBn/l0Wp3E2i6yzesB8CaRtnmBY6CvJVgshTCmY0vco3mB4vVXkC5UAA7/
         dxU4EN9CifKfWO0MaohQEYHTFO4za9VGO+qlkVgaUJYh47jDmD6vkUHKHjrMajc13JvQ
         NL154lxOJXnDXSP8JYl9+Z0uxwOtxDqYjsN0nmWwstBApQ+07zYCxwl8uXiKeDttRDL1
         vFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290750; x=1728895550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyvAfF/4Oxlw845+PwktLvOQPH3wGBMupqNCNNotp6A=;
        b=dR22BRYsQy4OyB0jycqFVDrq1om3QUz2R5slQfguzaVQ5F4A1nlKpKaycyqQVvzdni
         13GyiPKFSj726KCKw3kRzU6+e38oUR8dNGi9kLK3OD52BSOWLAYFi8EecOOCBs1G/RnX
         7WNDMzHBsnz3h4rTjyC9SVobs8hI3ghJvnsbnmyWMumKJd8UGHlGZ3Mbatyh8akz0RXr
         lwupdoXqcrv+D+VnZFrx2+aUjEuWTzuYdyXxXpoIbKisojHZRelc7q2OipW1asaLEDOQ
         ehH80y9kMN28R8RwEcJpPZtFFDiMvDptWOaKN/V4nN+rTo8Mz/KWD0MOpA2jAYW6qdYi
         9Psg==
X-Gm-Message-State: AOJu0Ywx4t6AG1/AyrXl+BzrC1d8I/N4aMy8avttuGOB5AylaSm3ZnX3
	ZH3exWmrmUn1K7aztCk2rWcExU1akJzW4fSwhWsRUzvNcDrWsyCC
X-Google-Smtp-Source: AGHT+IFeUaZdzFJmNjXXO2k5kG5OLEl1qCwkjwHu14lLklVZzwRrfSoxBJgySkEibA+ceMoPtZsGAQ==
X-Received: by 2002:a05:6a00:1485:b0:717:9340:a9d0 with SMTP id d2e1a72fcca58-71dd5af2697mr26222675b3a.6.1728290749831;
        Mon, 07 Oct 2024 01:45:49 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d66319sm3907219b3a.156.2024.10.07.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:45:49 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:45:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 9/9] ref: add symlink ref content check for files
 backend
Message-ID: <ZwOfxGjuKmzm00ry@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj_EELQdMsN7j2w@ArchLinux>
 <ZwOGqpeYiKITgsoV@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOGqpeYiKITgsoV@pks.im>

On Mon, Oct 07, 2024 at 08:58:50AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 29, 2024 at 03:17:36PM +0800, shejialuo wrote:
> > We have already introduced "files_fsck_symref_target". We should reuse
> > this function to handle the symrefs which use legacy symbolic links. We
> > should not check the trailing garbage for symbolic refs. Add a new
> > parameter "symbolic_link" to disable some checks which should only be
> > executed for textual symrefs.
> 
> You're getting into implementation details before noting what the actual
> problem is. So I'd recommend first describing the problem at a higher
> level, and then note that we can reuse parts of preexisting infra to
> address the issue.
> 

Thanks, I will improve this in the next version.

> Patrick

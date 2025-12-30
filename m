Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3C224891
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110892; cv=none; b=ohpqNq+KxuuqbtoF9jhxhaHWQogXlLLQP/0sSy5JKWR45pRooJKK9KUw6I/mJQnc5/LgZnXwQk8x9RiZ/9fMedcOzjNFVqnVGSvdzXxbQ/WqI+Jt9eRoEjPoEmGQGLJcq1M3LH8647dB9lJ6N21VeIRdlNtWKLM9NeIFmJ5MRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110892; c=relaxed/simple;
	bh=oLojZLZ703l+GHvMcda8/d/QRtkX50SRIIX4hncjWUE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Jeuu7QaWinbl/jrblusqUN/9cW8gAOp7hxxMRV36Z9vmzu0djhTTk3rQUprlrBp/CF4v1mupvpg2z8Z447qyzCaKA41Gplt3kMFwofx23dk8sVZyWiBPvdEd+FwB+ty+1RtVKDo9jJ3hF35r1R7wNUNdMMCyYXlmgLJMDaQ5Kb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUOwoys/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUOwoys/"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso9692925a12.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767110890; x=1767715690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck1ljUQiEe3k6ZMKRmlbnKcbEOs6j89To9l0j6ccaSE=;
        b=hUOwoys/wKlRwQwh25H47x7/LA42MdcMG8OhFIy6AaZLg5uFhnbMEHnxhEndIOdzH3
         GOvscMI1ZP7AWXOo2l9/sbOVhKMZvp1TinnIA3RMdjeZP7UQvtBVdD7dwgmoo7H7N3Us
         fVoIek0Hopf/QAtxgLA7sdNTcVWMJf9no1ZcrFg1SWhYhMIoOvW/hkDnf2dprKG5KpII
         51xuslQpjPfSzrCuuczEGx0ua5MBrv0XbdgA52W9hOUmyY+d957mmgddj4N2QTWAl4lK
         B7zDJqpmhynRNbNTjXZQwH5z/lfeLahbv7Q9FJL8JNFFBKDZOSbskpreJl3Xodl5LJCw
         geVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767110890; x=1767715690;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ck1ljUQiEe3k6ZMKRmlbnKcbEOs6j89To9l0j6ccaSE=;
        b=FVBprPXLj3Nu81dd/f6f49WSZOEsGyJdc9NgfVtXIAZCMysi100XBt39ZoBi8rlWI3
         HfxewC/nZk6WGtwaZ+o9b6KreA7+M90yjyV5H2LkauIPhsxUoAuWY3EmI5J1Dl/N9IfY
         kMkALnoUEhLHviK7zdxg+yqLvCCdyEcPBzli0KvU1Rl1ZmVYaZmUyRZHpKdDidkORv0b
         +hfd3dvb9fZCFSn3sYbHsykw2IYXRcXjfZqZlY2bNCX/GU0NFwBH2uoRzx3hq7w8m0Ra
         IxX8ALF/4HugYsTmaXshPROdpYKOn9duc1WlD0k34kz9dapW7z92ptNtUz55dZJXbR4s
         hhxA==
X-Gm-Message-State: AOJu0Yxx7Orhzh1yTb500K+nVNax4+iDA4jJVv+s1MLWLjtDNZzGeFa8
	jeMi8034OI6I+dVKYC1IaoI+mtFfgZrlQ91AWnHT2j9TismcMwaCn0nH5NRJEQ==
X-Gm-Gg: AY/fxX74eYAEpY7wd8DIjPC/8ViGvOQAKGbqltXOefDuCR2u2+bkJ2GxIT+Mm9wQAAR
	Po9QGzfbEXR7OTNJK7X+hAn/KIclzKQeP5Pxr1IiP+c7XTixng70lRvwZutbZ11bTkX2lg2HTQe
	OKaUjTo7X6QeHvPLyy6KaRSSN4Ogz/INA+WkHvlW2B4SjVBzD5ZLyGQLAH7ERnljZJ2sQYn/Uzl
	a+GIqZypanfe9IECxZg80JJ+Pl9+YmVn9irE2GGh5q2tgthYpheYBaPumst3L0Vf76Vh7V9jHeK
	jwdo3/sizFXxT2jlhxX11RjkL1eTfHqWA7VFrztjT6Wfd0E4oXb3aQgU8W/uypzCDCl8wwrySwl
	XStZNaS3De8KXEzrhzLr70MnvNu9IZxIt3DT0mQTuM10+L47I5F3ooOZzW+LWRIv5Fsz6tBb2Wp
	F5iYjWMS/15M7FUjI=
X-Google-Smtp-Source: AGHT+IGukpRE71B6fhgLdWY9HWR6vrf6YZS2vUJdBnp6Ey+GwkDKVUmM6MUtDkSSV0WSIUvrKNl5Sw==
X-Received: by 2002:a05:7022:7e87:b0:11b:9386:8261 with SMTP id a92af1059eb24-1217231479emr29631970c88.46.1767110889588;
        Tue, 30 Dec 2025 08:08:09 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm129718561c88.16.2025.12.30.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:08:09 -0800 (PST)
Message-Id: <pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
References: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 16:08:05 +0000
Subject: [PATCH v10 0/3] status: show additional comparison with push branch when different from
 tracking branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com

Harald Nordgren (3):
  status: show comparison with configured goal branch
  improve tests
  use pushRemote and tracking branch

 remote.c                 |  89 +++++++++++++++++++++
 t/t6040-tracking-info.sh | 167 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 256 insertions(+)


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v10
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v9:

 1:  ecfe122585 = 1:  43a75944fb status: show comparison with configured goal branch
 2:  53bab23737 = 2:  e6d24b8b6a improve tests
 -:  ---------- > 3:  13c2a03b0a use pushRemote and tracking branch

-- 
gitgitgadget

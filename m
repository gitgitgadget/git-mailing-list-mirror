Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696701BA063
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929624; cv=none; b=SLDsAEWcKVxjNUO4q/BtA4Gq8GOKJnvIPDCiRg7rTlvor+JEY5w6Jid03EfPuRNhdupk77nc7gUGTruUwS/RxztlEI2l94bmreLpiSPijDUOCN0lA1EO741i9goSu2udwBOeywANCMOgvHSu/aYFf76tTBmXXZCTXrPHShWC8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929624; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=F4Jk85Ds/nyrYyoKAb2HHN2piMYgFvtjmBh7g6Wa4ZJSzk6BvtBC2HY9laL7hUw+0PrCCmTAzFEA9T5mPSf3xTxgqAnz1HD9+AUH5FTW8tWLcVuq4ALuQ2vYmwmIYkSD0I8FvOsCv1ErqPVzfOvX6QiGBtC2IrLJq9dTMuOaO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu1zOrL3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu1zOrL3"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64a6bf15db9so36450247b3.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929622; x=1720534422; darn=vger.kernel.org;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=Iu1zOrL3KnfjWQ2fFOLrJJTdzWBXcSQHQi/G0KEgJUKy/FzfeLrynOkndBQdTjaL75
         taGAdTOr0kp8XRuf0HktsV4TMGcSL6+sILYm1yhQHcczcJeKOlQ0wd8wBN8KfhYqed5b
         GSOSuKeZD1dJ5mvk4LCnwe8OEmvwri70KrF9gtUclTPqowQz2P7ZuA9RNGn5acOYGmlt
         LFubsDpe7vZ/d+eouRj2TiyNiLMj1UJEpVpFBTT1RqEpfS8ypB7cyE7mEeZLSqmXXrpP
         zSDXgM/aDgkgxLS+oEE1nYf/OdFp2xM0i2xBliQgOCiUaCHrV5pHt5MLisIi42oZZZBE
         NDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929622; x=1720534422;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=pPG6FIGUHLtkOyxosTudifECL58M1HMTHsX32IHSjKd8mRH8DgeoA8nR/YbQIrxL7Q
         olf62JD5MTz8ItC1wR7d3NcsNgc6ATz1vF80Hi1oYEcz+P/0q88Cg86nwhugEmOzi2sd
         yDpbGC02MZGCQb5BblMOKuOx2CkytQZF3FjnfqFSrWx+UYrapTfQADm7TblE0sgz0EaK
         W/5kn4Sd4b7EqeIbZNCTYuf3Sd2NjBD3gCyauTWEjv4A+xIv4bmv1uDMTCoW4Xy8BC05
         T6DyM61FRrgF+cTXcO1AL6CbNXlY6OGEW39O02Dci6890Bc6mC3td8bmUVWLmTVWzigC
         zFLA==
X-Gm-Message-State: AOJu0Yzjo0xr4T1S2dBXgsaIg8fsq+e3Wq2DqgyrqER3p+mJblJDYR6a
	Mx4kAw/ky4GBzvW9ZJMuNstZzsC/cWLNEyKHEcgELVgzjFvH+vxXzpTzjw==
X-Google-Smtp-Source: AGHT+IFXZHwf5vzd2nTJsxiUuvnWfEMXkbbLaK1wTn43nNUU9B2fA3Ufl42U6pNjVFogPdjkEqNG8w==
X-Received: by 2002:a81:8385:0:b0:62d:1eb6:87bf with SMTP id 00721157ae682-64c71144f5emr68400467b3.5.1719929622051;
        Tue, 02 Jul 2024 07:13:42 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:8f50:4030:2c7f:753d:4dae:4029])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a2394f6sm17644247b3.33.2024.07.02.07.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 07:13:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Kenneth Porter <klowflynno36@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 2 Jul 2024 10:13:30 -0400
Subject: Re: A few usability question about git diff --cached
Message-Id: <DB7B2FDB-535D-4845-B3A7-7F19CF5F4303@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, paolo.ciarrocchi@gmail.com,
 vmiklos@frugalware.org
To: m.mahmeed911@icloud.com
X-Mailer: iPhone Mail (21F90)


Sent from my iPhone

Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D61B4223
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832795; cv=none; b=gPJ/KEHUnwj/9lqnms3UXJo79lvMqcWqdxqOjipXRaRvomF4I4vJyYZeTDZClyQVvRPpP66xAp2snB186cTAd02iVwfXIP4KZu8GkSsEVzolhMzHgr8MS+eT4Ba4wSY7u9ehPtwZuy03593aZGKgayCced9UtuF7x6hjLqoK6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832795; c=relaxed/simple;
	bh=FBuLCog97T7F2yKA8JNNhDAtlCXXvFbA3MUDm0qeFXc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=eAgxJdILQSS3Ruj3awcthgWFfnWilWOiz3CGAi3BgOoYIBq4Xb7Pl9lvYTPicMVyALB1XlT5GDQXQXDa2gkdmhJVnd6puqNwtz8PhWXorwOgsLvKBFrFtAzlQLhtAPpS+1vq53UajoXmBXY9J7joZQO3eL0fAkfNl28mBKceM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWShpjkN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWShpjkN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359a16a400so3666106f8f.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 23:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771832792; x=1772437592; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5gZ4Hb4B1N/uipGrUT6+GsnZfhRoCf0TxBy0HOvnP4=;
        b=eWShpjkN4SZDydaK2a6P7V62TLhMYeXYG5BTlMZOr8BCKfpI99vxiSbtlWAmP7qG9P
         vPMY3hyhX8s/VwbmKxdOAg9IFVHBfwpOnJ4Q85eBblHEfaAT5K9NZ524IpacHwyGwimW
         nf88CkV7uCadBhrtsWVFV+i9a4uyvz6VaSkQ0BcNPXKmq12aPlWwH8yGe1Ce6MtT+7Ms
         zx7UBtPVy7mQjw/pp7PwQo3NWMwzJbyBB7Y2QeUhgb7lf72O73ppETaRmZEPmwSpBig2
         PGx7OMJJO0xxjC8ZRbClaYGBvxtCXEEMf5Jymwq5edatFWsVoCr78rgSNvWJ4n881rXd
         OlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771832792; x=1772437592;
        h=content-transfer-encoding:subject:from:content-language:to
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5gZ4Hb4B1N/uipGrUT6+GsnZfhRoCf0TxBy0HOvnP4=;
        b=EbWOd0u8f3wHJ3VKir+/PoVgCyT6lAtlWr+dKJu/gSWh3Du32fEtIXa9omS7gRKuvZ
         2rnbR+OQCT/nB6oDIX1iH3g3KlNWs+GkaRt4Z96rFesI4hFV8tCIVq7CCOk9RwJn7cnR
         K1xm7Z9cTLxmfBMA6XYbz2oJdkgvlx/ZZCCSK/1vp9PZVOsFjLGHppO2xqJTEdG4yH9+
         C8yWgUQmQc53TN41otqck3YTDUWnHCgyqj41KxKkMAI4IFB7d0E54BM6r6AT8dKzO94Q
         CwZZp1V49G4zneaM7RhX7bpnctKo9ypfSJXkCv3jsgh61LRrc1Bt8LTdWY/zwlXYhM4U
         wayQ==
X-Gm-Message-State: AOJu0Yxv16rJqFJtTNB1Qo2Fbq1pB/YNlw0z+15lsYTDady1nGOzz36b
	PYFgj23p+fYYXnX4jdAxDB5L3fCnbdV9fZ/vkZh1My9SGID7m+364qSYzU5N1FpKflDV3A==
X-Gm-Gg: AZuq6aKut82UYu6mFvDNEXv3NHTZdMlgg+wiqrINe9k+pNsnRd6/+TQeyIFy8eDEolB
	Pw1HXIbr9ujJ5sDK+cAsu74BqYccVtIz/YVXaIu7zA59mJtvjetlaknhNEWMKXlAxCXIgRvH9ul
	GTgWi42RyvPYgUKuHguMP88OE+qrv2hi9UcMbBvf3XR3BFD5ecdtNnnSjbWPlpWWpSnF6WaaOQx
	NsLhOVDu5aT6iURp/xaItm3dorEF+F7rUkggEmn9bsBNq2UMc4+p98bmeUscmql6c4EmfP+ZMAn
	wFR36wkah1KMoOLwxEp5fg2G7v9y03Z/xzcT6zAZcW/8996r0vPDbBJ2lcfiI0mof0dgO7rrcLo
	m4D2nXhIOxYvUlblQtB7T7Vlb8EMnHREEhejPODOKuguNmmTbW12dXj1paSuqqTQDlkVnk84aFH
	jVQ3YseRwNwZGFU/f/s3PQHE56opkd2szKmHE=
X-Received: by 2002:a05:6000:24c9:b0:435:a600:2601 with SMTP id ffacd0b85a97d-4396f15b0abmr14873752f8f.16.1771832792399;
        Sun, 22 Feb 2026 23:46:32 -0800 (PST)
Received: from [192.168.1.12] ([176.240.71.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00768sm17496270f8f.10.2026.02.22.23.46.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 23:46:31 -0800 (PST)
Message-ID: <5e3d4344-1c06-4984-afd8-3f2743e2b7f8@gmail.com>
Date: Mon, 23 Feb 2026 10:46:32 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: tr, en-US
From: =?UTF-8?Q?Tuna_Din=C3=A7er?= <hweord@gmail.com>
Subject: Pro Git 2nd Edition Turkish Translation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Pro Git 2nd Edition Book's Turkish translation is done. You can pull 
to main. Website shows uncompleted.


https://github.com/Hweord/progit2-tr


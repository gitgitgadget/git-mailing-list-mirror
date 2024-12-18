Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0915853C
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530980; cv=none; b=eI1KeMrU9vUc5kdBiTVjdI8rP5ROfPXX7Y4djHMvoidJqbfg8lNNq+Z5xnShLZRQ1VbTbmFztTY1bC6HFOrVo7Fd+9y+3xrHNZwxu5VqWL/vXfaCd6hN8D+0STjQ3JcnHvuodMvQMWMSVaRlpnypPmc0IGi5QGMJk6ZaVpffHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530980; c=relaxed/simple;
	bh=+OZqjgAvK+6bbVFoPqWFMuF6XAhXFf9qjtspRtw1KG0=;
	h=MIME-Version:From:To:Cc:In-Reply-To:Subject:Message-ID:Date:
	 Content-Type; b=OXXe2I6VFpgUFwbgrzUPFMMWMZ5ECxiHV5fGBbSq1dvJujCkN0KeqSY8RQmWD453TVqqAtTWzbK/OzHcLDvIoJlafYO8lObVEqyhjMBpDgJwf6dvE3MM5OqNXjwz/2VK3wrH9Bu/gWO0CFIlM55CRmvVN0FPFGVHL9cqFfYvSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxONGt4Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxONGt4Y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216634dd574so38524085ad.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 06:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734530978; x=1735135778; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OZqjgAvK+6bbVFoPqWFMuF6XAhXFf9qjtspRtw1KG0=;
        b=VxONGt4YvsPNFtL/H5c1raIVgyfnlhOaWLkK8KiE6ZhXGltpbzTelPmzwoPdi2LnEk
         f4q7mDSFF5VTt7lt86dCHoU0+1ltWtO3WZrcuA/qJWRB3kPFmc3TIi+/zyaZaAn10QHP
         ra16YmuMdJbXOKJnwzEpuqV3ueEEzZqZMUiGzlfbs9UsOCcJlx9/9KXh2WjuiMO34qng
         2Vrp3o8YLYSxkqYhDtWRr71poYfEHlg3Jvv6loU0m7nkK/msoj5iljcmj33bZhT7orHq
         sjw/N2coZ6zLXFmfvxos7wCme5LO8NC/AgEry+XWIBKSXkWK3d8f2lluP0t/qCRV8BQS
         jkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734530978; x=1735135778;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OZqjgAvK+6bbVFoPqWFMuF6XAhXFf9qjtspRtw1KG0=;
        b=OliZIkJ9h4DCq0skUq8cvHStVvkAb5MtZmPpkq4mxsZ8RJRMaZcQuky7k3Qgyfuth3
         cvrE4FDntTwpJQcGmEsFlV3iaSg2GyUYRveyTk6YGsUP9DN8Y12FsCRtp/ThdQx+CgP6
         lt/+2Ys8wbzpO5FIXDcGN8ddYj7hRy+MdX9cCc2gaT7g6wwz/W19BNOaSPB+NfGqrO+6
         Gq+vFvb0xncloRjb8F+yT+F+BNOFmXQyjS+LxZTVbSTdNpMWBG+CYswbgGjWxPtAbOzF
         Z8qRNYnI5y91uH1ecAD/vsWEmhkSQqHcEubCOzrN5b6BRN6MJyRZCXxSSdv18MQHQp7e
         yegA==
X-Gm-Message-State: AOJu0YwV8WISQUcbhJKJ9CskfGw/bdLqxTvS+q70guqCGXvOCCrFDpIP
	+NBiMrEen3a92P0fS7PRn4ydgM9P0FX9Fzpi90xM4imHP+5XOQkj
X-Gm-Gg: ASbGncvXbQFVtVG+SgHYX2Af7ctMEVBrrn0Wivuv4+xKxtcN0y4QNWGCbc7duSbGUq2
	1xTkRRlC0NnZuisKVw+Oq/mkAhyabroaaCZBSQhuhiqM/qEGdd6K8Tq3YqEkPRiU3L66Fhd6hfH
	bDdetENAjD6ndjtTtrLQNJk5pS2IDcGx2fW8BZrROESuDRBLb2owG9RFxULk7WRx8hJesj45Hbt
	KDJrxEz6j3iuqMIypgzRi8SyiqlvXhpSUuCy3duuvqt4EzAFrrdyOk1EbSweK91AWhTQu9STOsD
	ZasAiw==
X-Google-Smtp-Source: AGHT+IEIKsSEDFHI3WBpXXYG4c+z10Fi3nx8xT842giHA7xoSPoDBMA3KK9BAv96JQGDPkDTvoK9JA==
X-Received: by 2002:a17:902:d503:b0:215:b087:5d62 with SMTP id d9443c01a7336-218d724458amr44961105ad.36.1734530978468;
        Wed, 18 Dec 2024 06:09:38 -0800 (PST)
Received: from host (36-230-86-110.dynamic-ip.hinet.net. [36.230.86.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db63c3sm77204315ad.48.2024.12.18.06.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Wang Bing-hua" <louiswpf@gmail.com>
To: "shejialuo" <shejialuo@gmail.com>, 
	"Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
In-Reply-To: <Z2LTp60u03Y9iiUd@ArchLinux>
Subject: Re: [PATCH] remote: align --verbose output with spaces
Message-ID: <18124abbd9d6169f.305d7269b347c5c2.ae083dd7649e4539@host>
Date: Wed, 18 Dec 2024 14:09:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On 18/12/2024 21:52, shejialuo wrote:
> Yes, I agree. Although we may provide convenience for the end user, but
> we may break other tools parsing the output. I think I bring confusion
> to the Wang. Actually, I have seen that Wang contributes to Git in the
> first time, so I just want to courage.

No worries. Thank you for encouraging words :)


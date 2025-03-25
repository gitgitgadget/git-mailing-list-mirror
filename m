Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9D19AA56
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927671; cv=none; b=VOqSRTQ78dnRCImkzQosuJ6gM/pB8AlBXUgjE7AvzT07q29WJYtNy1Nm55NjdQ4Ne5hoPSETnsMlL695H5rR/Oc7xIodC25r17yXOS3Cb6oFuf7PviDWSAhUI6SLjhvV5aNLQzTpY5JclQ/EG3LfwcTSymgRXGtgb12T4swjHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927671; c=relaxed/simple;
	bh=/ZbJNAKT8zqlMkb7IeIhvAHLRanV44umhxZbepnxAP8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nNxEnlb9aE7Jv78k99EXdu0kMNxbMN8NW7tYbzuP2la2FHsrwRvwSXO/v8oq0Je6M+T+CMpFab1jrQuPP3T9NsdJEwJglJzIdvrdD7podnogT2H/mVMITrapkc3b9q5tC73sqjm+MPuEIwBpIMal0om+PPNkb96BHHttHR79joQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HPGNKrXV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HPGNKrXV"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4766631a6a4so59743081cf.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742927668; x=1743532468; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lY/8QKRgHlT+4ti3ifAQXPYfHMm87SIVfRJ7G12Tm4Q=;
        b=HPGNKrXVBNRz/wK1Zgy8FhQpPy8sum7ihY/0mXfHBVzeLC9tNNyxaf4y8HJ/YnGjVk
         dRUHRIIKxzb2BTnOig94ceJg3jTJ11Mxehd9T21gY19ZP9PSY8WZKqz9IV1CLWua0MXY
         pNboXG/oL+dUVqzFizgskEq0luxpjBKDjlZyWDcVw/kdesJkxS2IzeuZKwHefI10jIJU
         UaC50ong93XjBbJMX4dVV+a5EBZe+9/RpX7KURqBmZa0o5MxJOhyu/jWEHGpD5wbA/jo
         rmriiLAXno0eJAviyCqOaB+Fh8jmpREUbWHnTv+lygP7uDvoTiEC5K6rF5ObrXwUMfZk
         rPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927668; x=1743532468;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lY/8QKRgHlT+4ti3ifAQXPYfHMm87SIVfRJ7G12Tm4Q=;
        b=o5WkgZDTl3J69hTeFDAT2tbwbqcojtWGOD3PCy2oHpX42ABNJb2c2DnV2Er1FKFHrN
         E82tMYeqrmSt0AhSqCcfIUr/PRH9T2yG7nYQGfLbeSQ5cRrKz/DNxNqRT/wY+9bHtIvn
         AA1aogxOO61b6kiSwtUsNsfHh3tI13kqwiXLnUdIRvRXeifp/UecDed2iSvTQ+t/gb5S
         ZAGYjGqltd8ie+8WnOi4/g6q0Lxr71+C7BEzHyMMZ9TRwlTqU5ztLGKAsGKTtfWYhDdu
         mjM5tpopxgIbEjWtiZcIajroivaCVAaA4eACjo1lY3+Kai8HQTsd5urqQBwIYE9j3SxC
         JnyQ==
X-Gm-Message-State: AOJu0YybSJFqRiCPWLqUyYPbiGaxfMWtKtp5mJrfOALKyY0iEsIbRYqP
	CNLcWl028bmUdJwBoZ8jXzCoHDbV2DB8wVw7kiLmUa/7HfuTIhZ//P+UsxcRi3PTgA4+Z2G1HVk
	xFQw=
X-Gm-Gg: ASbGncvBrvLZETJ8w1fi3KycdETZPwqqdWKLhAkPEY0GRzSCRCkrI4sBuAvEntvNFti
	O1bDE/Uk4xslnLnagfanZCSL1MC/97EcEXnWXelyloq3YzH3+ynurrzc75R4EFEN9WAsi2Azz80
	We5NikEGPGcTCxb+z4f462VmV9NR/rk7de4cTR3GTn/oq+Kqez7qrXSae+O069RS28sjTx1tdJD
	LWSBhrG3bYnA5vv44fNd9+7rNSbCu2tpfYww+r3i0yc7AI9cBSYEDUnJ9wtxKgLknB44OJ6MoiH
	Ov6g97Uu3doNkfQ+YMSFbipzLfTq7biDosIQIUKTepF8GydGygpYEMtoTk7rQSBioVBOtcZ6XHr
	+aur4SLjsaYs/mTQ5
X-Google-Smtp-Source: AGHT+IFWsfN0Jclov5+2J7bw3c574KB8M47LKaliod+1+tcUC5CqnETq9pMZ79x2+k4YJvDiAQRZBA==
X-Received: by 2002:a05:622a:5e17:b0:477:cb9:13b0 with SMTP id d75a77b69052e-4771dd5c6cemr244985571cf.7.1742927668465;
        Tue, 25 Mar 2025 11:34:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d18f7d4sm62246551cf.37.2025.03.25.11.34.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:34:28 -0700 (PDT)
Date: Tue, 25 Mar 2025 14:34:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge 2025, September 29-30, San Francisco, CA
Message-ID: <Z+L3Mt58n18KUNzs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Git Merge 2025 is happening on September 29-30th in San Francisco, CA!
The Contributor's Summit will be on the 30th. Here are the details for
the main conference:

   When: September 29th and 30th
  Where: GitHub HQ, 88 Colin P Kelly Jr. St., San Francisco, CA 94107
   What: Main conference on the 29th, breakouts and Contributor's Summit
         on the 30th.

The conference will be structured similarly to Git Merge 2024 from
Berlin. The main conference will be on the first day, and breakout
sessions as well as the Contributor's Summit will take place on the
second day. We'll have a cocktail hour at the conclusion of the first
day.

For the Contributor's Summit, anybody who works on Git or related
projects in the Git ecosystem are invited. If you aren't sure if that
includes you or not, please ask!

Registration and the Call for Proposals (CFP) are both open, and the
main webpage below has all of the details:

  https://git-merge.com

There are links to the CFP submission page as well as ticket
registration on the main website above, but direct links for each are
below:

  Tickets: https://git-merge-2025.eventbrite.com/
      CFP: https://sessionize.com/git-merge-2025/

For GSoC / Outreachy students that would like to come but may need
financial assistance with travel costs, please reach out to the Git PLC
at <git@sfconservancy.org>. We'll collect requests and try to make
decisions and notify people by mid-July, which would hopefully still
leave time for making travel arrangements.

Other than that, please be thinking about (and feel free to discuss in
this thread) topics you'd like to discuss, or any general thoughts on
the format, venue setup, etc.

See you there!

Thanks,
Taylor

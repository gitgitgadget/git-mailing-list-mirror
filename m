Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9A1758B
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387571; cv=none; b=co9NTlEG+GsAmxbBuWK4MRS/KNgEN5r3T+e35Yb5AtNmDdYHKqURDTksVI1N8xK4bGrxl7xOuQLnobN+enOrgpatwdQdNIHXUsJXByMLMdyz9ZAqUndKNz6dOud+vqsJS2dBQQv7DuxTn7g8S/Dr03PHsZjKPT6SSLwzD0jPX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387571; c=relaxed/simple;
	bh=KGWwWDAYsJaw4DEnjGP1cqUNyUGw0tG9CvElaL2CP4I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Vf4vQMUUSEn1MA5WN6lNtD1tP+VXxOy2QRgM6ILTihhSR4nh9+TDkAFf1AcMUI85g3wbSSs0ocB4K4FoXZ/f5Rf5liYH86DqupuFekh/F4mo5/WwD1EI5uaLt8M+OABNKZFEAHr23JpWisKVMeIYDU/EivT6GpHpHam+M+KSp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFauRmVG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFauRmVG"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-295548467c7so4180085ad.2
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 16:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762387569; x=1762992369; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGWwWDAYsJaw4DEnjGP1cqUNyUGw0tG9CvElaL2CP4I=;
        b=iFauRmVGQbMioUT1LsUe3qNunA6wRwDKP75erHVXsXWF+7SMDMh8SliXLS1LBaroRM
         wlt5Bjkf7g2+q/Yq9/6NcPqD2PHdnkxmJrbZnGt2/db7cXOFhBHUpHfRyb2y/72EFlBK
         AckL+vHErEMO2qY5pz1OFuhf4DVwLPS+qMKrQ10yKs5sRIxTlJGujVrqWoJqB2848clz
         j2K3rBWwMtXjQndcR1Hh78k/woXUyz+kNQpXWsOloP9rd7GJJ4XBWipIpJNDN/Tr/Wh+
         4WnybO62VCRQ+1F1OQVvFt3dv5r/4I+tj4L9piJtp+szfet30XMwKuY4C/Vgam7ZteBZ
         1g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762387569; x=1762992369;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGWwWDAYsJaw4DEnjGP1cqUNyUGw0tG9CvElaL2CP4I=;
        b=Ipra6ePxrqAmV0w6uxlB4FGjPYWJ8HnT10Pb2tyBQRkHUpswg31U+mRt5CQB8SRrzn
         +YTxGDEMyIU+zl+dEqLjKH8ezKZp9Huh3cTlE5+h3UX7OiaCbNBKRHx94tYAlvC0BzPn
         yPrw2O6tHibobSnk5K7O/5rATM02glpP0Mcw/nSfwqkV477YjY9poMfmHwap5/Ukv3ii
         g6RT2r/uEvnnRbsxpl/ys1omUVoI9J83IK+CIWA9xifpeGuUtv/lvUQSNYTwwEAs9MGG
         oTkPPexdwQVIoEBQRhir3+0a60C4gsoPSBluIAgyga/OAUEW2VhppHEw2Ry6b7cF76wH
         lhqA==
X-Forwarded-Encrypted: i=1; AJvYcCUHlVTluJfe2Ql4bUN/Sr/cKHxb05PNgFoYkz6ItxpZymB73sD76RdMjUjTOSblvpqTOpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxft/9MmIe9lskg5K0fPyEFvIQMD7/frmJHpUWwStAwLXCy+Jgv
	UqyDvkgQrJ3YAYlApDCSwynnfCgxjvQx2FbNoEf6jdpqnoPxIwJH6bus
X-Gm-Gg: ASbGncvZ7Lv/fNc6twe4+4+yeJGVZ8Imm0lirOufRGvZB+/Wbg2vWyJkPvDOBAoxZil
	nFl7liCWL0fbnFPWYu9g9+6TEyQUBobDqaXPCt4q2TRw/TX4qg37NaxB+2RpgR5XBVQH7EfXNZE
	n71eM6sh2FU8sA+6WSkYc3C2lVWBfMm/IhjwUas9uMxE+x4vsko+dr4xCrhjLBcVKb6cuMlEsrj
	O+kuPNtXagtp6Wt6S3ISHBIsZsU9LHkfPIY+dbqoye1n78+zcguNhSgr9DKFvzPzo/ViyHQXr3s
	xNyHNPVA1KAMs8On5qHez7TeVze2oc9/1FXqiwfQ/QDZgzIPf6+6dN0O14eddFNcXYJSalDm+fc
	FeuHLip02Gudomnq2Ww2Nynn/Z6hJlYWW4ZGFkETkeHZWJ7l6ztmNza0vL6DMlKZirT3qpZHHER
	dy2w8SzvYW+2zCXLfBjI+aohAeFED35w==
X-Google-Smtp-Source: AGHT+IEQ0EMhIH6TaFAp8vBMbmFcTaZS+d59aHHQI0KfjErKil2yxUvjoCHoNQTo5vrYkFAT3qwA4g==
X-Received: by 2002:a17:903:2f82:b0:295:7b89:cb8f with SMTP id d9443c01a7336-2962abf4e54mr64217845ad.0.1762387568720;
        Wed, 05 Nov 2025 16:06:08 -0800 (PST)
Received: from smtpclient.apple ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207232sm437937a12.32.2025.11.05.16.06.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Nov 2025 16:06:08 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: 
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <9f8acce4-1a4c-4f4f-b8f1-827d778fe6e3@app.fastmail.com>
Date: Wed, 5 Nov 2025 21:05:54 -0300
Cc: Michael Roach <mroach@mroach.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE487800-06D5-46ED-9C78-3C42EC62EB4E@gmail.com>
References: <0be81c5272a5e42c8471239a1369ee6c32401bb1@mroach.com>
 <ed8a6d59-9b85-4ca6-a23a-1e43efaa7efa@app.fastmail.com>
 <F8EAD922-315A-42F8-8E77-5C562B5041ED@gmail.com>
 <9f8acce4-1a4c-4f4f-b8f1-827d778fe6e3@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> Sorry, I didn=E2=80=99t see that he only replied to me previously:

Thanks for forwarding that!=

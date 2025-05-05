Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878B1AC458
	for <git@vger.kernel.org>; Mon,  5 May 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467296; cv=none; b=IE3O4nMSgiydABIISZakNNsUxfV+DpFviyI/v++BP9/x+G7bF/MHxCYGAoHEzsF7BdY4q7BTqtcwuzpW74OY+OjEc7jbYrlqt8eRwElz7MKkmYh5sIN15myOMCETSumayUqEBZwchZORtG+4AHSMb27WwfLCQDNGL2gVJ+QaFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467296; c=relaxed/simple;
	bh=J1TviDuj1C4EKbsMEcxJPOb6IYSWyZewZaz2WodbkcA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject; b=U2u8XTxF+0AaHa45MLdrNHmhWVfTIj9BMUNCacCx0795lVed+ykWhTZkKhdAf4cC5CgPT3HmghV6IAnPbwW0CP+0NDLRIbQZOtWXDWeY07Fpec8pVAw4rG6ra3ABxnHentjxvv25s/Q4bz3xakAn2IJu4vhxRSrsxff4OWPUWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Er5T9NLg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Er5T9NLg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2241053582dso71149915ad.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1746467293; x=1747072093; darn=vger.kernel.org;
        h=subject:cc:to:from:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J1TviDuj1C4EKbsMEcxJPOb6IYSWyZewZaz2WodbkcA=;
        b=Er5T9NLgHW+n2LdLK/cxUPGYdEx1iqqV4Us33hn73uUvpYyNj7hN94FDYmFGr8rYLC
         92iBY5BK2gg5OrHQZqjvKC3+oG6QmO0zDImzmLHqliDUJw0o+CboNNe3s3dV8Xc6BDVY
         +6ZCfa14oilqINF3FqU3x9x6IE8ZyjrDpQU+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746467293; x=1747072093;
        h=subject:cc:to:from:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1TviDuj1C4EKbsMEcxJPOb6IYSWyZewZaz2WodbkcA=;
        b=an5nnbKsx47iPLkqGKQ50bXfRp8ElqJ5SAABKdQLcv0HIKETddILYU3r9adcuM5TyP
         sTMFNyjvOZyJ0kKgyZmLYLBHE7ZMw4eML29J4c7muDnFcNmZB5ddLQJpAEQW5Q18ijS3
         PpOJUSlj/nHx8Y+VR/drLaHcGjuL/RbPsIwor02JLKkVIj3sdf476PjiZsE1xCrAU3gM
         ciKJ1E7rQtD08Wr6JaREQrDgLZyMyu8RFzDL5B95gMMZbNQOLd5SW0s/HAkbZxMswiXi
         W9jzXHvaxtKbu0a77QRchXUltPZgovV7kbYL1YUlAWciM9qEDsgprqGm6MRA/9eQpWNS
         AzAg==
X-Gm-Message-State: AOJu0YxzfXcZ3/wrX+UP3fPANbzTYTfZ5bn+cN9hLalL+Y1CkE4OrPy+
	3deIPtETz9Okn925VkYpBBYogm0Rp/omBCsS3m/BKyQTNtjcgcicEBKFZsdLrmz426KXStILjAn
	cSSSo58oSte+JjVu4mZWGKgFithQPcM7o9bxVlRhLWj2QrhCrljsNcaBAy86GkggzKtwu8XoQYz
	GLvHQWBp05Nd7v3WzzY4pxoecTHo+jrMnF
X-Gm-Gg: ASbGncuvi8Q3m0CqiZpYu0xj0qNRzqMxjSCQhUJBHjuEyZ0yT7FEXqLLzEZUOx7wfSY
	yWbALLB+ypGN+sAsMgvnMjqc0R7p78qtZPvlx0On9PJNy1+DEgYSwHQ4ULhUMSoRMkByDhsopfz
	2IAXOL0ZS3EqW7qbh02sh+JFf8s3+RIvddK0zaFkKTZ+0RbsfsOIOcCC7OqKt/tUXD0s1Mv42ll
	Io0H2bUgW4bCP329kQdpN0x4txggsC0nB5dlqXRyVF+VD3f8QKl3CXIQFbVZG1jNkg5P/O5Sdhk
	NJK901m5Y+BmrzXwShqF+dItWDVVrHXmKKvnXBJRcDVYVtvOzAeTacMKO0Zke/hPWw==
X-Google-Smtp-Source: AGHT+IEM1sOuQwGpQPjPmvxNvv28+EgxUhRrj6AHaHPtvTSuzm+WS2cJuoGwUnIFq9O/IwjFObhJ/A==
X-Received: by 2002:a17:903:2408:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22e32ba8292mr5116005ad.28.1746467292852;
        Mon, 05 May 2025 10:48:12 -0700 (PDT)
Received: from [172.20.10.2] ([2401:4900:91e3:a99d:fcd1:c9ad:8551:9158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229469sm57681785ad.207.2025.05.05.10.48.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:48:12 -0700 (PDT)
Message-ID: <6818f9dc.170a0220.3b22af.84a0@mx.google.com>
Date: Mon, 05 May 2025 10:48:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0252110459312059723=="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: numarahamath@ieee.org
To: git@vger.kernel.org
Cc: 
Subject: =?utf-8?q?Collaboration_Opportunity=3A_IEEE_Summer_of_Code_2025_?=
 =?utf-8?q?=F0=9F=9A=80?=

--===============0252110459312059723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

CkRlYXIgR2l0LAoKSSBob3BlIHRoaXMgbWVzc2FnZSBmaW5kcyB5b3Ugd2VsbC4KCldl4oCZcmUg
ZXhjaXRlZCB0byBhbm5vdW5jZSAqKklFRUUgU3VtbWVyIG9mIENvZGUgMjAyNSoqLCBhIGZsYWdz
aGlwIG9wZW4tc291cmNlIGluaXRpYXRpdmUgb3JnYW5pemVkIGJ5IHRoZSBJRUVFIFN0dWRlbnQg
QnJhbmNoIGF0ICoqQk1TIEluc3RpdHV0ZSBvZiBUZWNobm9sb2d5ICYgTWFuYWdlbWVudCAoQk1T
SVQpKiosIEJlbmdhbHVydS4gVGhpcyBwcm9ncmFtIGJyaW5ncyB0b2dldGhlciBzdHVkZW50cyBh
bmQgbWVudG9ycyB0byBjb250cmlidXRlIHRvIGltcGFjdGZ1bCBvcGVuLXNvdXJjZSBwcm9qZWN0
cy4KCvCfk4wgKipFdmVudCBEZXRhaWxzOioqCuKAoiBEdXJhdGlvbjogTWF5IOKAkyBKdW5lIDIw
MjUgIArigKIgRm9ybWF0OiBIeWJyaWQgKE9ubGluZSArIEluLVBlcnNvbikgIArigKIgVmVudWU6
IEJNU0lULCBCZW5nYWx1cnUgIArigKIgT2JqZWN0aXZlOiBFbmNvdXJhZ2UgcmVhbC13b3JsZCBv
cGVuLXNvdXJjZSBjb250cmlidXRpb25zIHVuZGVyIG1lbnRvcnNoaXAKCldl4oCZZCBsb3ZlIHRv
IGluY2x1ZGUgeW91ciByZXBvc2l0b3J5IGluIG91ciBjb250cmlidXRvciBwcm9qZWN0IHBvb2wu
IFNlbGVjdGVkIHN0dWRlbnRzIHdpbGwgc3VibWl0IHB1bGwgcmVxdWVzdHMgdW5kZXIgdGhlIHRh
ZyAqKiNJRUVFU09DMjUqKiwgYW5kIHdlIGtpbmRseSByZXF1ZXN0IHRoYXQgZWFjaCBQUiBiZSBy
ZXZpZXdlZCBhbmQgYWNrbm93bGVkZ2VkICh2aWEgbWVyZ2UsIGZlZWRiYWNrLCBvciByZWplY3Rp
b24pIHdpdGhpbiAqKjM2IGhvdXJzKiosIHRvIGVuc3VyZSBhIHNtb290aCBsZWFybmluZyBleHBl
cmllbmNlLgoKQWRkaXRpb25hbGx5LCBpZiB5b3UncmUgb3BlbiB0byBpdCwgd2Ugd2VsY29tZSBv
cHRpb25hbCBzdXBwb3J0IHRocm91Z2g6CuKAoiBTcG9uc29yc2hpcCAgCuKAoiBTb2NpYWwgbWVk
aWEgcHJvbW90aW9uICAK4oCiIEludGVybnNoaXAgb2ZmZXJzICAK4oCiIEJyYW5kIGdvb2RpZXMg
Zm9yIGNvbnRyaWJ1dG9ycwoKTGVhcm4gbW9yZSBhdDogKip3d3cuaWVlZXNvYy54eXoqKgoKV2Xi
gJlkIGJlIGRlbGlnaHRlZCB0byBjb2xsYWJvcmF0ZSBhbmQgYXJlIGhhcHB5IHRvIHNoYXJlIG1v
cmUgZGV0YWlscyBpZiBuZWVkZWQuCgpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXNwb25zZSEK
Cldhcm0gcmVnYXJkcywgIAoqKk51bWEgUmFoYW1hdGgqKiAgClRlY2huaWNhbCBDby1IZWFkICAK
SUVFRSBDb21wdXRlciBTb2NpZXR5IFN0dWRlbnQgQnJhbmNoIENoYXB0ZXIgIApCTVMgSW5zdGl0
dXRlIG9mIFRlY2hub2xvZ3kgJiBNYW5hZ2VtZW50IChCTVNJVCkgIApJRUVFIFN1bW1lciBvZiBD
b2RlIDIwMjUgVGVhbQo=

--===============0252110459312059723==--

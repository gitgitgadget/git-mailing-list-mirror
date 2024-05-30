Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C7176AB8
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057957; cv=none; b=reG+HKWO1eqzk8TZHNwZejEE4oPeWGXa3T0d+9rPs9cFZE5rZRTYa8PtCnm+FaGTBJ/VTRnEkBfwRPIsEZGjBVnBddHpQ49TcR9heMgliQnytdBCdTUVB8YgWEBqNdx4UmiblHafIzxCszbXMrBsGOee7OKREa5Tn6/8KvDcBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057957; c=relaxed/simple;
	bh=O+6Vbvad4xex0TZ7KfqzCqcYnJFnRQcK7RtJvQha3lU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dOSeSbqUwOzGBsRi9Ea60ig8k3chWdZ+l7wMBEB/Z54MXJexZX8vmUk3HELVoj3BPrlYsQRVBqB+uch+fhWT6+RzenD9seFNEb9lmuyChi+pQvtg1DoJH/WpV4w2t4uOtNftiILXaVpW0T4w8Hz3IXoXM6E5lyNPnU8sDAvGIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=NhtaTlEg reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="NhtaTlEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=q4Ypnbl7rm/N6ZR8Syo7tEr7SzpMnPowzny72E+ndKU=; b=N
	htaTlEgrOZaQ33/Q+nMTl9T4Xudt0pmKoKks7/ji7tk77+niWWxIVJ/aOzmyFskb
	cY62jwk8YLuBdoHvAgpCGmIe1solwGlFbCyofx0Yc6WO8NYnAnppVCPaDtm80XT9
	rEdB5RGhePt0lBQzXsAMuf5cV/a2xE2El59xfP6fzc=
Received: from bupt_xingxin$163.com ( [124.160.72.194] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Thu, 30 May 2024 16:32:12 +0800
 (CST)
Date: Thu, 30 May 2024 16:32:12 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v3 1/4] bundle-uri: verify oid before writing refs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZlXGI4lkaXcD7_8C@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <8f488a5eeaaa0cdb525c34c2c165e6ee74ee7691.1716824518.git.gitgitgadget@gmail.com>
 <ZlXGI4lkaXcD7_8C@tanuki>
X-NTES-SC: AL_Qu2aBfyeuEEo5COdYukXn0oVhe85UMW2ufsg3YReP500mCTM4QcEQltABUHxzMyBNyqhlDytThRXwdhIdIxYfI7Nlnkv0xRuQk4hYiI4vPll
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c990a2f.8915.18fc8a0cc48.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3nw6MOVhmaMVSAA--.25510W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiLxTubWVOD9OcPgACsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNS0yOCAxOTo1NToxNSwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6CltzbmlwXQo+PiAgICB3aGljaCBtZWFucyB0aGF0IHRoZSBgcmF3X29iamVjdF9zdG9y
ZS0+cGFja2VkX2dpdGAgZGF0YSBnZXRzIGZpbGxlZAo+PiAgICBpbiBhbmQgYGBwYWNrZWRfZ2l0
X2luaXRpYWxpemVkYCBpcyBzZXQuIFRoaXMgYWxzbyBtZWFucyBjb25zZWN1dGl2ZQo+Cj5zL2Bg
L2AvCgpDb3B5IHRoYXQuCgpbc25pcF0KPgo+PiBBbmQgYSBzZXQgb2YgbmVnb3RpYXRpb24gcmVs
YXRlZCB0ZXN0cyBmb3IgYnVuZGxlLXVyaSBhcmUgYWRkZWQuCj4KPnMvQW5kL0FkZC8KClRoZSAi
QW5kIiBpcyBjb3JyZWN0IGhlcmUsIHRob3VnaCBJIGNoYW5nZWQgdGhlIGNvbW1pdCBtZXNzYWdl
IGluIHRoZSBuZXcKdmVyc2lvbi4gOikKCgpbc25pcF0KPkFzIGZhciBhcyBJIGNhbiBzZWUgdGhl
cmUgaXMgbm8gdGVzdCB0aGF0IHZlcmlmaWVzIHRoZSBjYXNlIHdoZXJlIHRoZQo+YnVuZGxlIGNv
bnRhaW5zIHJlZnMsIGJ1dCBtaXNzZXMgdGhlIG9iamVjdHMgdG8gc2F0aXNmeSB0aGUgcmVmcy4g
Q2FuIHdlCj5jcmFmdCBzdWNoIGEgYnVuZGxlIGFuZCBleGVyY2lzZSB0aGlzIG5ldyBmYWlsdXJl
IG1vZGU/CgpBIG5ldyB0ZXN0IGlzIGFkZGVkIGluIFtQQVRDSCB2NCAxLzRdLCB3aGljaCBzaG93
cyBpdCBjb3JyZWN0bHkgcmVmdXNlcyB0bwp0YXJnZXQgYSBidW5kbGUgcmVmZXJlbmNlIHRvIGEg
bm9uLWV4aXN0ZW50IG9iamVjdC4KClhpbmcgWGlu

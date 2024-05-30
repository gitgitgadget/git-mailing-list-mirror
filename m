Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B71761BF
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058964; cv=none; b=W8AcCySAhp6H96/Zn525SGcDMDlsQpiyPqWNfl0qpfvWzpPGpaP4usz7Pod/GTSDiMsc4Nfq8GOdpHRZr7vvEMLB0TM6eHM+qhYZ9sXxJyMQuPtsT1C24P7tE5yiiXF0LjVxMb4VjJg79Qx5MjLm03tcXJgB8Lm/dIqlCyG9PbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058964; c=relaxed/simple;
	bh=g8Sa2WrCLNuBdypAt0fDE4loPl8SSkLHCbiTUTJHsuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KA/wpXkoTBIPVibTaJ8wzNsw+F33Fl1N7Q8cEpjM9Cg6oj7M6vklXq8DvQeXwf58x//YFY9rtttEglXESK9YXA4v3M5Wz1/DBhymeT64kfUmy+E3u45yz6MB1GyHILueJKTLEulCPV4xTa2DVt05qd109n8xa27PIARKwHzDRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=R8+ahdyg reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="R8+ahdyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qPLN0SnRMOevWxxpfCB5Jq+tAxU6leYTnJziZCCSqNo=; b=R
	8+ahdygZRaD3WsySqAD7qpP/k1hLxQeb/QBtYQCGdHPQbjIDUU+W2mMfDgKY6BdM
	VxLvGb+3q5XZKCwZajomUSx51kmFndmzt/g7wwKeMqC5zQQSTbey1E70zsrB6dwG
	lHi85qf8n2zT8ST+zOp1pU7X5lGL+Ehzd/jaj/WHYY=
Received: from bupt_xingxin$163.com ( [124.160.72.194] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Thu, 30 May 2024 16:48:54 +0800
 (CST)
Date: Thu, 30 May 2024 16:48:54 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, 
	"Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, "Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v3 3/4] fetch-pack: expose fsckObjects configuration
 logic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <xmqqbk4p6e98.fsf@gitster.g>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>
 <ZlXIBrs5Q91r_-qU@tanuki> <xmqqikyx6ew9.fsf@gitster.g>
 <xmqqbk4p6e98.fsf@gitster.g>
X-NTES-SC: AL_Qu2aBfyet0Eo4iWRY+kXn0oVhe85UMW2ufsg3YReP500mCTM4QcEQltABUHxzMyBNyqhlDytThRXwdhIdIxYfI6t6wU+1iauQFWuihbdJcDC
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5cb91961.8ebd.18fc8b01748.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3Pzl2PVhma7lSAA--.17527W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiRQnubWXAmilFVAABsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNS0yOSAwMToyNDozNSwgIkp1bmlvIEMgSGFtYW5vIiA8Z2l0c3RlckBwb2JveC5j
b20+IHdyb3RlOgpbc25pcF0KPlRoZSBvcmlnaW5hbCBiZWZvcmUgaXQgd2FzIG1hZGUgaW50byBh
IGhlbHBlciBmdW5jdGlvbiB3YXMgd3JpdHRlbgo+YXMgYSBjYXNjYWRlIG9mID86IG9wZXJhdG9y
cywgYmVjYXVzZSBpdCBoYWQgdG8gYmUgYSBzaW5nbGUKPmV4cHJlc3Npb24uICBBcyB0aGUgYm9k
eSBvZiBhIGhlbHBlciBmdW5jdGlvbiwgd2Ugbm93IGNhbiBzcHJpbmtsZQo+bXVsdGlwbGUgcmV0
dXJuIHN0YXRlbWVudHMgaW4gaXQuICBJIHRoaW5rIHRoZSB3YXkgdGhhdCBpcyBlYXNpZXN0Cj50
byB1bmRlcnN0YW5kIGlzCj4KPgkvKiB0aGUgbW9zdCBzcGVjaWZpYywgaWYgc3BlY2lmaWVkICov
Cj4JaWYgKGZldGNoX2ZzY2tfb2JqZWN0cyA+PSAwKQo+CQlyZXR1cm4gZmV0Y2hfZnNja19vYmpl
Y3RzOwo+CS8qIHRoZSBsZXNzIHNwZWNpZmljLCBjYXRjaC1hbGwgZm9yIGJvdGggZGlyZWN0aW9u
cyAqLwo+CWlmICh0cmFuc2Zlcl9mc2NrX29iamVjdHMgPj0gMCkKPiAgICAgICAgCXJldHVybiB0
cmFuc2Zlcl9mc2NrX29iamVjdHM7Cj4JLyogdGhlIGZhbGxiYWNrIGhhcmRjb2RlZCBkZWZhdWx0
ICovCj4JcmV0dXJuIDA7Cj4KPndpdGhvdXQgdGhlIC8qIGNvbW1lbnRzICovLgoKQXBwbGllZCwg
dGhhbmtzIQoKWGluZyBYaW4K

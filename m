Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB18C11
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023314; cv=none; b=tMnq6b5SqmuTauiiHhgSoI1L8D83bwPVpd/LbXYrdCrm2HMkeqleFovVjXlWV8qOwSmqcSZw2M7mLlQNBcg+RH/P2Rqqwv2tggHpbXXsV/84KpX75rM658HpSOXgP33gqzYCMxAwzapYA+4X6GVJxvUiA4/L1fuevt9pbqJ1gt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023314; c=relaxed/simple;
	bh=MGupEqg/5mFNNEtvIpqYdtZDwbFpyT+8IKD7NId579k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hAMAPyIHIrXlx62UsI2NYDZKoP7ziTpw16POZeTNwPBj4Bg+4hc0Rl20DjlcA867Tc/69EQt7yytg8uzVNqXHv6go7/lzlPnfsHsY24OAq6jke8WkSP1KfjD1UGE1DXdsQ6G9JqqYsdrxwCocL9RfvsoBGi3jAI7OFtkCFBKVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz9t1749023259t7055e207
X-QQ-Originating-IP: E1RY2HNLEY48ojfMja3awNMyF0jDT7GSjkJ8+jCt7rw=
Received: from smtpclient.apple ( [58.213.8.105])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Jun 2025 15:47:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6465757338677845911
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] commit-graph: fix start_delayed_progress() leak
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aD_46Qxh9oVj-P3U@pks.im>
Date: Wed, 4 Jun 2025 15:47:28 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB88AA24-6D26-4BED-B430-62A453E6B9D6@smail.nju.edu.cn>
References: <pull.1986.git.git.1749006675784.gitgitgadget@gmail.com>
 <aD_46Qxh9oVj-P3U@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MF9wS9BzufCcp04xufz0Bn3C2LGKD2ujFiyEcbyjG8o/PJp4xeXkN0ZR
	uHagznvKqLV27o5pLqUP74KywUiVAe9hMvpA1fs7FELj1QLMVrM3bTvuham5BeKFZirCF9x
	7v2ftLw8w/XNV0hKmiMmC+viF6CbAROCY0C1KFm6Xpei3MzZUqSwa+8DJBqllm/K7wAiFqs
	VHwwOrTUvupW55DYGtpjW/+KK8iYdDzCDHVFfPv7reUDgkOfl/nj3D2q7sEDl+rnRFnbx84
	SRCtulicp9ii5FdCm0Ja9+j20nhliCrlv/syVy3fxQM5M0JJfnCG9r5obrXQd0gA/4t64Kn
	zomfAcC5Fxwr1NvwGQ1M5C/SlXwPu5K5GnIl8+Z5s1wU2f/Y7tbUJj1X5KYFkkJPz001gvI
	/wdQjLRB4S3k6m6Zh6ciOF48bOC41hVM1tAJv87l28UtEv+4peDUmSYLynGNlgRD/vBy99l
	TTLQOgrLxp/xLDh8KTyU3ml9IfCLiENMcawR6GrifonfeXVPxuOZKEChXEOJ6gSahTmsWGx
	bnA5zzH0hkD7jwUHXEgihYlRy+L86I5KKz42A+dEoeg6N80Kxvgip7TZJE77D7eReEfFX9Q
	d17xyxXIyoA/fP8gTLkp01/sqbyaAE9/6GkuCESqJFtegvgZnHFkP7mpz9ISwyk+QmTx72e
	SdslIghiXGG8F2FFfA4E/pTwdm3MTf3YxA7w/EsIJo2Xq88FKg3ytKkhLimvvLSXkbB5rpG
	k/qhdtEbqqQwAPMeVbOakNlA5mvyWcFWPtrNqI6MAOEBUqmG2JX7R0BMCOqbBT306yAgkjJ
	HE19tIRZhv28/6mkGGBUjaoNCCdtMf2O/LnRFRZsXLV0rQXuJTh1PnpTn3I+5Par4o3qj7s
	m0W8sNq3LEwFPlzQ8QArWfVjQuuUYRxp4Wbc+c2fDLOSupW9epQpq10LWD/5sAu1uGnWK5x
	IG/jtSScrI1WL441ACArMno4jBry6U+mEhDcjM3Osn22lUUUw+Q+5HU4hgOJe9a6Y8Ng=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=884=E6=97=A5 15:42=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 04, 2025 at 03:11:15AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> In commit-graph.c:graph_write(), if read_one_commit() failed,
>> progress allocated in start_delayed_progress() will leak. Add
>> stop_progress() before goto cleanup.
>>=20
>> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
>=20
> Nit: it might make sense to send multiple patches that are related, =
like
> your memory leak fixes, in the same patch series. That makes it a bit
> easier for reviewers to group together related reviews.

Got it, though I think this is the last time I send leak-fix patches.

>=20
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index a783a86e797..ee48980248f 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -311,6 +311,7 @@ static int graph_write(int argc, const char =
**argv, const char *prefix,
>> while (strbuf_getline(&buf, stdin) !=3D EOF) {
>> if (read_one_commit(&commits, progress, buf.buf)) {
>> result =3D 1;
>> + stop_progress(&progress);
>=20
> This function calls `stop_progress_msg()`, which knows to exit in case
> `*progress` is a NULL pointer. We thus don't have to guard this line
> with `if (progress)`. So the patch looks good to me, thanks!
>=20
> Patrick
>=20

Thanks,
Lidong


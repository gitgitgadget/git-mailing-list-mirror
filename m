Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA531C3E
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717984985; cv=none; b=Z6LXilsitQrb/qtBSmIOHCj7vnsOHd1bBTX1MFkHgDuRYPvixg4tobMyn0QzKQoEk8spOep93TUkkFZi/jvaP/EuYHvbuerGBx6+WUQa+GJPaY/cmzf8JlO4mctGdpFsJ7qSrIYHE6s6+MAy8FPlpaWnMZVtowJ9uaagLfW7F5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717984985; c=relaxed/simple;
	bh=mb/OA48GtnDhDE5W843CCeJZYUgJQD6rY1K79cLxRG8=;
	h=Date:From:Message-ID:To:Subject:MIME-Version:Content-Type; b=HhDotOf8+StqkIMpMLaDl2WaA6R5E/QfuFkTF7EZTiP0xvfICGEfWtKuRRICBnphLHtGpkrXkRL7GJwoCcM+a2ULKt39ts2k2C/8RhPS573mJOY4gwNkiZwHRJfs14m9idA5D9aMJW6UJCFHdUI/EIa8upI2ItB5XwAnbmTaYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=jXOiPFit; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=VNolhjgt; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="jXOiPFit";
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="VNolhjgt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=mpfAOj6PafB6R82IUUiYwSh/MlW1aCRsp7ptj+jAmgI=;
	t=1717984980;x=1718074980; 
	b=jXOiPFithiyb+dPheVN/F6WhHHDlCbBBRgL/hMO/yT865QFM0WFNegiTaD47SdFKEgo0vKXyrZL7xgXa2ST4jC86pX9nkuexz0DQ1dZ1n/f211JcLH3YbLJwRO3LsT1ksQXSjNRcfkEzvc/YfbMVdBLwOcCKPnqQ+6vMXLlKTj6oiLsN+7JDDc2QZ9smhLnRsyJdlGQfdtdIpSp8EIBOSKZ1iXTOFvuDmnpAksuwdi28nvO7Grk1UEod2mnBCx4zdmobspSNT0cBPG1GIl6bHmUwvvV1M5d0SUwuJrU3y9HuJsOyaaL43f/rzGVCRV1v7rMfsvBY1EMrT8mKZM7yzA==;
Received: from [10.12.4.33] (port=47062 helo=smtp58.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <andry@inbox.ru>)
	id 1sGTfi-000Lar-Jv
	for git@vger.kernel.org; Mon, 10 Jun 2024 04:18:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:
	Message-ID:Reply-To:From:Date:From:Sender:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=mpfAOj6PafB6R82IUUiYwSh/MlW1aCRsp7ptj+jAmgI=; t=1717982286; x=1718072286; 
	b=VNolhjgtMr3htvVf0eDltBZC+mY7594RHUGO2MRM4klARDhDocIcC1HdVp21l2zV5Bgmn3ZAwk9
	96HeiSccMgpgeqy9ASO6vc2MPOneM/JQiYpdGc6CUfV5X54HB8B5EukDuOrxbBv+sNiVJnPFo3htd
	KFCVErZD56JCUKVabuAyGsMZKoyaEbpXK6oGLmr0vEXb28usBLCXfCbtC8xjhGzr5hWbeMMOspgeC
	9H+qZBuZmC8tKUAHkaMga8tfErw+/lNTYugRUX4qPRFuGEDlYQL0LiNXiBuUPmpNsbU4mDV2DC2Fb
	XImo+RZJGIE4xn5sh/6EO+AVNB1saz6vIj1w==;
Received: by smtp58.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
	id 1sGTfZ-00000006D7y-3BSH
	for git@vger.kernel.org; Mon, 10 Jun 2024 04:17:58 +0300
Date: Mon, 10 Jun 2024 04:19:10 +0300
From: Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <153002248.20240610041910@inbox.ru>
To: Git <git@vger.kernel.org>
Subject: [ISSUE] `git submodule update --init --recursive` does ignore 
  `fetchRecurseSubmodules` flag in `.gitmodules` and in `.git/config`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD948651DF6EBC8E8B2CDFCA9C125A01F11FCEC3D28553B772A182A05F538085040A27BED5AF8E403362EB5D77EF37489D1618A0CAF02AE85934FAD6E3F11AC2FC5E32BF596A4C5394D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F157A19638F32F60EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371005780D56A98C20EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F364C145E86BDEB8D56F39F90630756D2A11075E49F7D1757A51DF9E95F17B0083B26EA987F6312C9EC33AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A96583C09775C1D3CA48CFE97D2AE7161E217F117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7850F8B975A76562C9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE7DEF864A245BF348FD32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C056235C9C6E4B608FCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B66F1C5D350F9AE87C089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5946C8C4B0315C3A25002B1117B3ED696B3FFD65B6C0B2640C638DF663A625AFA823CB91A9FED034534781492E4B8EEAD1DEE520572A35377C79554A2A72441328621D336A7BC284946AD531847A6065A4964A708C60C975ABDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D343FB425EC7F4D4A4B8C5556DBFE0D2AD5186B2B1F05876740AD429F97079E731B46F3106D89AD00831D7E09C32AA3244CAFAA41F62BF5790DA0CBE312C330D7D5AE4992F23AAB0C4BEA455F16B58544A2C99F59F2F009F096E57A8CE2CFE77B911F8C4C3A05AFEE91ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXjcTJaZPmfQjMIUM2ptUCSP
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E14E2A65CDEFB9ADB2EB5D77EF37489D1618A0CAF02AE8593F544F87C5664B7A3FCA528E711DA173B928A2593B14EC4C304421B0C186AAF3EC77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B653A1001F6F75E40A3D74342114FC17B77EC27CC701D973B647ED114AB003ACA992DFFF99F4BF93416B42642348F74D4AB9004EE6B3C70C53039D7BA51DA99F
X-7FA49CB5: 0D63561A33F958A5EBDC1D52AC839144BC72A0BC2E1AF4BDCAFE3B5A66B8E27ACACD7DF95DA8FC8BD5E8D9A59859A8B6F9DC411BAB40BC2FCC7F00164DA146DAFE8445B8C89999728AA50765F790063780B3000F7A6F2D7A389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC87893FB2F108C49E4F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE77E5954487664363B731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj6D5zjHqYKv2Ra2OZuN/Shg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Hello Git,

First discovered here: https://github.com/gitextensions/gitextensions/issues/11783
Another discussion: https://stackoverflow.com/questions/58403616/does-git-submodule-update-recursive-override-fetchrecursesubmodules
Manual: https://git-scm.com/docs/gitmodules#Documentation/gitmodules.txt-submoduleltnamegtfetchRecurseSubmodules
---

If use a recursive submodule, for example:

A->B->A->...

And call submodules Update on A, then the Update does ignore the flag and keeps fetch recursively with the error at the end:

>  fatal: Failed to recurse into submodule path ...

Is that supposed to work this way or is an bug?


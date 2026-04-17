Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45809301471
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453021; cv=none; b=DtOgZCvVuv7wsAt/29VNzbeMXwjnSaapXihFxnrp57abdoxfhGwmhaDinN+DKncAwjTcrwtzXNX+xi7E/YPC4OGtUNz2NyfHNYvUjKBTafTA78zQ3x65YMDrrLIS3wzZ7ujO3UW4+JGkt1crO3VsOzXw+TxrxQ6fKtNJRMgmOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453021; c=relaxed/simple;
	bh=quAScRUmql+0Kxb8cndaceijgPyrJqaZEuD3Np7GX0k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HkRAV2ZKfCNCYOsToJmjuWD13csnkVr+TpV3DCRjZDsQ4tFuanUeOtj/uaVjE+xiIJPpzE6W4S81WS9f1GDJoyMSfN3/TihxnQlTsNiU4j/phEBf06l0w5BJjbg4cmWij9Q1oyXo0PpzYQG00lH83jAhisrG8KSrVgowxdH8izA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d22d2.dip0.t-ipconnect.de [91.61.34.210])
	by mail.holtmann.org (Postfix) with ESMTPSA id D5FCBCECCA;
	Fri, 17 Apr 2026 21:10:17 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH tig] Fix compiler warning with latest gcc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <87pl3xsfrw.fsf@gmail.com>
Date: Fri, 17 Apr 2026 21:10:07 +0200
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD3BAB82-DEED-486A-8A17-1B556D993588@holtmann.org>
References: <20260417161228.1578-1-marcel@holtmann.org>
 <87pl3xsfrw.fsf@gmail.com>
To: Collin Funk <collin.funk1@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)

Hi Collin,

>>        CC  src/diff.o
>> src/diff.c: In function =E2=80=98diff_common_add_diff_stat=E2=80=99:
>> src/diff.c:191:22: warning: initialization discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
>>  191 |         char *pipe =3D strchr(data, '|');
>>      |                      ^~~~~~
>> ---
>> src/diff.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/src/diff.c b/src/diff.c
>> index 6c670e4b4fb4..182ea349eb9c 100644
>> --- a/src/diff.c
>> +++ b/src/diff.c
>> @@ -188,7 +188,7 @@ diff_common_add_diff_stat(struct view *view, =
const char *text, size_t offset)
>> const char *start =3D text + offset;
>> const char *data =3D start + strspn(start, " ");
>> size_t len =3D strlen(data);
>> - char *pipe =3D strchr(data, '|');
>> + const char *pipe =3D strchr(data, '|');
>>=20
>> /* Ensure that '|' is present and the file name part contains
>>  * non-space characters. */
>=20
> Minor nit about the commit message, but this is due to a glibc-2.43
> change. It isn't related to GCC versions.

do you want me to fix it and send a v2 or do you just amend it after =
applying the patch?

Regards

Marcel


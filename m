Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D725A62A
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928912; cv=none; b=G51j1EiysamZK3yhKu3d31Ov9OIHkm15tjyAyeSCuDGNgSRp8yeeQZ9jbvdv/jYRf9q3rQLgaKaQR5OUNt1OplR0OPCXfNVWW7gcxysswt9QXJfKLVP6DsHrEmmoEzyX1nFLNyaiy8P4QsI3TZ4ARb5wSiECKgvA+H4ATGNSfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928912; c=relaxed/simple;
	bh=Lye4KW8KkdNVMRhfW2khRSTncKEqoorz7uPfryy5y+0=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=l1ZMS8qRpXvyvgCo3tuSdA/oGztpWgED3Zaq9E0K2+0yIjGZKdVYPFT05I2XiHLLMPDuaEFYOBQPP637Pza6bOkAVmjnnTnJkKfvpqKHQotJ8LoNsOohkrpl7DlHuwW5VfkXyzsiDk6b6j6LGmc6ww7JvvpWazipmZlRv48IpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=l6yTDgh8; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="l6yTDgh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ZOYtG4gnyrCH/U+PVGmtOLCHrq+un5bBX2++61pEaGA=;
 b=l6yTDgh8fdi+Axbm2xFcPaVbiE5OgIWdi51yBczEsUsV7l3Sqin7AsD1R3RW9NjLXL6/T5ZYRXQ7
   yk6eKdSRSfajPDBR8NgxI/cw+AiYyqg8LICYn51UYgWpXIhnJy7jpTlSnxbhv5geQBjAIJQrxinf
   8m6CsPhSVV/lYycaRB6T/z5c7f59UbQldM4vk9WKV/HksZMZ0YOZHYBkzZg8pu2fOVrsyhgYIJI6
   /wcX+Kt845Kx18X0ZhLHkRdpevNIYV5lznI6hoB2x2jzpJScoCgebdCWcy0rSvER9ZQEknFZnUgq
   csA/gfujk4t7mr6CFsqZRJS9rjIydYoS/J8YHQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQP00MCNUIS6YE0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 26 Jan 2025 22:01:40 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 26 Jan 2025 23:01:09 +0100
Message-id: <D7CCD8S1TP43.3HNQHI22K9WF9@ferdinandy.com>
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare repositories
Cc: <git@vger.kernel.org>, "Christian Hesse" <mail@eworm.de>,
 "Christian Hesse" <list@eworm.de>
To: "Patrick Steinhardt" <ps@pks.im>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20250111202628.0e5894e4@leda.eworm.net>
 <20250112165125.130400-1-bence@ferdinandy.com> <Z5Mrk02wMdABtrVZ@pks.im>
In-reply-to: <Z5Mrk02wMdABtrVZ@pks.im>
Reporting-Meta:
 AAGxQJE2mvPvJYyGsn82nZBi6C+00/KI80E9EqRXX2QbGz3gT1lVU9+HX+sJCJZI
 0MPjyFvpW1LwzYkg+DQVpeaSWGuN9XSExqXjcvIKkiuqBiy91EzwXA2N5OjbWvkS
 hukyRbKyazv0N0o7ECcKEVODJxjoWw8lp/Hx30aBv3pT9kClds8xCrUMbFCloWcx
 xKeVSnZb3nPNhio3EOYa1UrTQAwRa54jxzHLfdx/U022+Weu6FP7vCdHd6bXeIYQ
 T3GqSDpjf8WEvvwfF64cTrCYPP2oVyO0Ua963UEFk0scCzAjmirJm5kf/IPSPjKY
 QJCpXh3vvHQ7bUHPPDtS/QZPozBozVGvdTmRUVb1sJpcawbTT0io+XaSo/IghAU8
 8KMCYcU4BcHEYgpH94CmcVRblV4zzDn0uQt4gxgaR204eSCtPCnVzYGWENMa5g0U
 mpyUcJLYpUH4MzEzyxooXLFfNAD7T51/Lr9XarrPJHwZr/WlH/0uPwKs


On Fri Jan 24, 2025 at 06:56, Patrick Steinhardt <ps@pks.im> wrote:
> On Sun, Jan 12, 2025 at 05:51:22PM +0100, Bence Ferdinandy wrote:
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index fe2b26c74a..625d45be8b 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1925,7 +1925,8 @@ static int do_fetch(struct transport *transport,
>>  		}
>>  	}
>>  	if (set_head(remote_refs, transport->remote->follow_remote_head,
>> -		transport->remote->no_warn_branch))
>> +		transport->remote->no_warn_branch,
>> +		transport->remote->mirror))
>>  		;
>>  		/*
>>  		 * Way too many cases where this can go wrong
>
> Nit: At this point it might be sensible to simply pass in the remote
> itself, which would allow for an easier callsite and less risk of
> getting the order of parameters wrong.

Thanks, that's a really good point, not to mention inside set_head gtranspo=
rt
is used to also access remote, which seems a bit of an oversight.

>
>> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>> index 519f7973e3..c75cfe968f 100755
>> --- a/t/t5505-remote.sh
>> +++ b/t/t5505-remote.sh
>> @@ -589,6 +589,16 @@ test_expect_success 'add --mirror setting HEAD' '
>>  	)
>>  '
>> =20
>> +test_expect_success 'non-mirror fetch does not interfere with mirror' '
>> +	mkdir headnotmain &&
>
> Nit: this can be simplified into `git init --bare -b notmain
> headnotmain` so that you don't have to create an empty directory first.
> Also, do we want to `test_when_finished rm -rf headnotmain` to clean up
> after ourselves?
>
>> +	(
>> +		cd headnotmain &&
>> +		git init --bare -b notmain &&
>> +		git remote add -f other ../two &&
>> +		test "$(git symbolic-ref HEAD)" =3D "refs/heads/notmain"
>> +	)
>> +'
>> +
>>  test_expect_success 'add --mirror=3Dfetch' '
>>  	mkdir mirror-fetch &&
>>  	git init -b main mirror-fetch/parent &&
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 2d9587059f..cfa63ae086 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -84,6 +84,19 @@ test_expect_success "fetch test remote HEAD" '
>>  	branch=3D$(git rev-parse refs/remotes/origin/main) &&
>>  	test "z$head" =3D "z$branch"'
>> =20
>> +test_expect_success "fetch test remote HEAD in bare repository" '
>> +	cd "$D" &&
>> +	git init --bare barerepo &&
>> +	cd barerepo &&
>
> The `cd` needs to happen in a subshell. ALso, the same comment here
> regarding whether we want to have `test_when_finished` to clean up
> state.
>
>> +	git remote add upstream ../two &&
>> +	git fetch upstream &&
>> +	git rev-parse --verify refs/remotes/upstream/HEAD &&
>> +	git rev-parse --verify refs/remotes/upstream/main &&
>> +	head=3D$(git rev-parse refs/remotes/upstream/HEAD) &&
>> +	branch=3D$(git rev-parse refs/remotes/upstream/main) &&
>> +	test "z$head" =3D "z$branch"'
>
> The closing single-quote should be on its own line.
>
> I see though that you simply follow existing code style, both for the
> call to cd(1) and for the single-quote, so these are fine. This test
> file could use a makeover, but that is obviously outside of the scope of
> this patch series.
>
> Patrick




--=20
bence.ferdinandy.com


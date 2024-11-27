Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE249202F8F
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735254; cv=none; b=ZRnihc3O93zP5D9ERJGk7rHmIT5FgqNVRXXKOXGxzHATH2Glq+Qs+mfWoN3uQ9n/9A1dBVIRMOa6vlykpK11FhsWHvWayC1vTtxDJGMYoV7KpQQ5gwEXK1DSBp8CmCdB8BWcaAkvTkCWk/Gw18zFzYlhoXRvxJxseVaMmKoPJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735254; c=relaxed/simple;
	bh=LXnjzd77KFE4Rr/Wy0hANKfCF685YRU8KbmqVELqn2c=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=W5iW/vddMGCukDO9kLfrfl03Gs91fQmDId2+YOGwOr9PV2sNZj3Zon5S5SX0exilYvKAsLjpBULDj31ctdhchpZouP+wNfcV/RfFBmDFgXBQ3kndPIU7zlS69vG0Egf2DYfDcS6F12Ec138QQtBiIODuwq6QzeaXDM29vPxdjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=EYstKz9f; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="EYstKz9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=EdY+zvQds+DXMSpseqJgbt4ebEPFxrpGelL/r1ZKets=;
 b=EYstKz9fHruEq9gxzgfP81XKWe7XrD4l/Wbn7SSZW3YvsCbTRAPme4A7ZqIzcLFrh/Mt2NzFgpT+
   /wtiEx0iBus/2mOv0s+j9BS/MquV3BMsb2TEMCyktYC1u0P3eBvyF+cZ8IG3voqApk2q+S+fPqfU
   Lwl0WTxxdE1dE4nRs/HZbEzYCpgqpY9Amupm5OfY1GtwYhvp7yFhNsDRlkemJYFb13jrZeoxdwZn
   ucxryry9HbwE5UWADvVzLlCDthyoe4dQkyWxRXLWWeWzYgGg/mtV1XZVzu27M3n4iYAoygLkH7T4
   nsMPQFVKpCWsm/AW/BGvYzr5peZsgaezbW5RWg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNM00NBEJ2NM640@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 27 Nov 2024 19:20:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 27 Nov 2024 20:20:25 +0100
Message-id: <D5X7DHD1BRYO.22CU1OL6KLN49@ferdinandy.com>
Subject: Re: [PATCH v1] fetch: add configuration for set_head behaviour
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241122123138.66960-1-bence@ferdinandy.com>
 <20241127091718.345541-1-bence@ferdinandy.com> <xmqqa5dku6w6.fsf@gitster.g>
In-reply-to: <xmqqa5dku6w6.fsf@gitster.g>
Reporting-Meta:
 AAEp2BwE9lAIs+hMLi5ROhmcSucg3U2DsAz8xB81gEYOCGnHqe2ACdGPXtWo8eD+
 P3scUIFjODM9w5BKgmXyoiYJIVGrF5GRB3xpfc+9IYFhEBn1uFUM9+61Z8MtiJYR
 BI7a6BnQuqC912VjwXZEW44GG4LpuaOg6IR38CIq1mTe+aIgUfefBfg6ueYkXFKj
 gn48mToY/IdQRBKYq4AcSciu/Dz9DpUR6O8wkJ7YOoAE1tmKj6GpKLy+jIBXz3Fk
 Ek37jl3KjSK4mXQwuhz+j+lTW2AgCyFr1DRiwxd7YkNYO03306/2iH/cDrKj3bNz
 tBlYRz8ewSYBKTk6Azz4ietRmdnBQ8RNJWZY6BFi3BG1Rsx3SUlTqC2q7+Vb9GIg
 rYWaUHaS6Gkk4nIqk8PNHLnwqA1dg3z70aLOHJTEqz2Spi3bc61TfHdRNeFsvJIR
 AH5xqtLw8njrIy72uEo7Cc/0C3OqrFSGip0/h+ROMHKjvKqNvTCF43Y=


On Wed Nov 27, 2024 at 14:46, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> Introduce a new setting, remote.$remote.followRemoteHEAD with four
>> options:
>>
>>     - "never": do not ever do anything, not even create
>>     - "create": the current behaviour, now the default behaviour
>>     - "warn": print a message if remote and local HEAD is different
>>     - "always": silently update HEAD on every change
>
> That seems to be plenty of choices to please many classes of users.
>
> Except for the one that I would want to use myself, which is "I
> understand their HEAD points at branch X right now; please warn when
> they flip their HEAD to a different branch, but until then please do
> nothing".  That's somewhere between "never" and "warn".

Just to clarify, an example: the remote's HEAD is set to "master", and you =
have
- git remote set-head origin next
- git config set remote.origin.followRemoteHead "manual"
- git config set remote.origin.followRemoteHeadManual "master"

you manually set these explicitly. As long as the remote's HEAD is still
"master" you do not get a warning when running fetch, but if it changes to
something else (even "next"), you _do_ get a warning, that is not silenced
until you set followRemoteHeadManual to "next".=20

Would you expect `git remote set-head origin next` to set followRemoteHead =
to
"manual" and to set the correct value for the followRemoteHeadManual to
"master" if it actually changed the current refs/remote/origin/HEAD from ma=
ster
to next? Or is having this completely manual fine?

I toyed with the thought of rolling the two settings together (an unrecogni=
zed
string would mean the reference for which we must be silent), but then you
couldn't have a remote/HEAD called "create" for example, so I think we need=
 to
store that separately. I'm also not quite happy with "followRemoteHeadManua=
l"
...


>
>> @@ -1603,6 +1628,8 @@ static int set_head(const struct ref *remote_refs)
>>  		string_list_append(&heads, strip_refshead(ref->name));
>>  	}
>> =20
>> +	if (follow_remote_head < 0)
>> +		goto cleanup;
>
> There is some "magical" value(s) that is/are negative; we will find
> out what they are later.
>
>> @@ -1614,6 +1641,7 @@ static int set_head(const struct ref *remote_refs)
>>  	if (!head_name)
>>  		goto cleanup;
>>  	is_bare =3D is_bare_repository();
>> +	create_only =3D follow_remote_head =3D=3D 2 ? 0 : !is_bare;
>
> There is one more "magical" value that follow_remote_head can take.
>
>> @@ -1626,9 +1654,14 @@ static int set_head(const struct ref *remote_refs=
)
>>  		result =3D 1;
>>  		goto cleanup;
>>  	}
>> -	if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
>> -					"fetch", NULL, !is_bare))
>> +	was_detached =3D refs_update_symref_extended(refs, b_head.buf, b_remot=
e_head.buf,
>> +					"fetch", &b_local_head, create_only);
>> +	if (was_detached =3D=3D -1) {
>>  		result =3D 1;
>> +		goto cleanup;
>> +	}
>> +	if (follow_remote_head =3D=3D 1 && verbosity >=3D 0)
>
> And there is one more.
>
>> diff --git a/remote.c b/remote.c
>> index 10104d11e3..5a768ddac2 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -514,6 +514,15 @@ static int handle_config(const char *key, const cha=
r *value,
>>  	} else if (!strcmp(subkey, "serveroption")) {
>>  		return parse_transport_option(key, value,
>>  					      &remote->server_options);
>> +	} else if (!strcmp(subkey, "followremotehead")) {
>> +		if (!strcmp(value, "never"))
>> +			remote->follow_remote_head =3D -1;
>> +		else if (!strcmp(value, "create"))
>> +			remote->follow_remote_head =3D 0;
>> +		else if (!strcmp(value, "warn"))
>> +			remote->follow_remote_head =3D 1;
>> +		else if (!strcmp(value, "always"))
>> +			remote->follow_remote_head =3D 2;
>
> Use something like
>
> 	/* The setting for whether to update HEAD for the remote. */
> 	enum follow_remote_head {
> 		FOLLOW_REMOTE_NEVER =3D -1,
> 		FOLLOW_REMOTE_CREATE =3D 0,
> 		FOLLOW_REMOTE_WARN =3D 1,
> 		FOLLOW_REMOTE_ALWAYS =3D 2,
> 	};
>
> or something?  I have no strong preference between "enum" and
> "#define" myself, but moderately strong preference for anything
> symbolic over magic numbers.

Ah, my mistake sorry. Magic number bad.

Best,
Bence

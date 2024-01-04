Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDA2C682
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XLQY06E3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25A271D69F1;
	Thu,  4 Jan 2024 15:09:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FD8vOzZNgG9e
	qonZn8tRRF3pqbJeCDjDLWPKg8qRTd0=; b=XLQY06E3bYfctWZRc0fS8RPRDqpH
	Qcm31BVqVpMc+dzvktjysLYPTKHNBv7x0Vlr08F7G2TmBKY/XKs8OUD4CEJwOF34
	OoxVwKQCA6TvAxXH94emVyj28YGNvjBL7Xph+vxEY6Im0XFS3OfVEk77n/YDw2bW
	zex+qVYI71uTqWg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18D321D69F0;
	Thu,  4 Jan 2024 15:09:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 714031D69EE;
	Thu,  4 Jan 2024 15:09:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH v5 1/1] Adds domain/username to error message
In-Reply-To: <20240104192202.2124-2-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Thu, 4 Jan 2024 20:22:02 +0100")
References: <DB9P250MB0692C8B4D93ED92FEE680AA9A560A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	<20240104192202.2124-1-soekkle@freenet.de>
	<20240104192202.2124-2-soekkle@freenet.de>
Date: Thu, 04 Jan 2024 12:09:21 -0800
Message-ID: <xmqqbka07te6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 26A5876A-AB3D-11EE-94AA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

S=C3=B6ren Krecker <soekkle@freenet.de> writes:

> Subject: Re: [PATCH v5 1/1] Adds domain/username to error message

Looking at past commits that worked on the area this patch touches,
namely, 7c83470e (mingw: be more informative when ownership check
fails on FAT32, 2022-08-08) and e883e04b (mingw: provide details
about unsafe directories' ownership, 2022-08-08), I would retitle
the commit perhaps like so:

    Subject: [PATCH v5] mingw: give more details about unsafe directory's=
 ownership

if I were doing this patch.

> Adds domain/username in error message, if owner sid of repository and

"Adds" -> "Add".

> user sid are not equal on windows systems.
>
> Old Prompted error message:
> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/sourc=
e/repos/git'
> 'C:/Users/test/source/repos/git' is owned by:
> 	'S-1-5-21-571067702-4104414259-3379520149-500'
> but the current user is:
> 	'S-1-5-21-571067702-4104414259-3379520149-1001'
> To add an exception for this directory, call:
>
> 	git config --global --add safe.directory C:/Users/test/source/repos/gi=
t
> '''
>
> New prompted error massage:

"massage" -> "message".

I probably would drop two "prompted" from the above, too, if I were
doing this patch.

Thanks for working on making this error message more readable.  I'll
queue it when I see an Ack from Dscho.





> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/sourc=
e/repos/git'
> 'C:/Users/test/source/repos/git' is owned by:
>         'DESKTOP-L78JVA6/Administrator' (S-1-5-21-571067702-4104414259-=
3379520149-500)
> but the current user is:
>         'DESKTOP-L78JVA6/test' (S-1-5-21-571067702-4104414259-337952014=
9-1001)
> To add an exception for this directory, call:
>
>         git config --global --add safe.directory C:/Users/test/source/r=
epos/git
> '''
>
> Signed-off-by: S=C3=B6ren Krecker <soekkle@freenet.de>
> ---
>  compat/mingw.c | 64 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 13 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 42053c1f65..6240387205 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2684,6 +2684,26 @@ static PSID get_current_user_sid(void)
>  	return result;
>  }
> =20
> +static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
> +{
> +	SID_NAME_USE pe_use;
> +	DWORD len_user =3D 0, len_domain =3D 0;
> +	BOOL translate_sid_to_user;
> +
> +	/* returns only FALSE, because the string pointers are NULL*/
> +	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
> +			  &pe_use);=20
> +	/*Alloc needed space of the strings*/
> +	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user);=20
> +	translate_sid_to_user =3D LookupAccountSidA(NULL, sid, (*str) + len_d=
omain, &len_user,
> +				   *str, &len_domain, &pe_use);
> +	if (translate_sid_to_user =3D=3D FALSE)
> +		FREE_AND_NULL(*str);
> +	else
> +		(*str)[len_domain] =3D '/';
> +	return translate_sid_to_user;
> +}
> +
>  static int acls_supported(const char *path)
>  {
>  	size_t offset =3D offset_1st_component(path);
> @@ -2765,27 +2785,45 @@ int is_path_owned_by_current_sid(const char *pa=
th, struct strbuf *report)
>  			strbuf_addf(report, "'%s' is on a file system that does "
>  				    "not record ownership\n", path);
>  		} else if (report) {
> -			LPSTR str1, str2, to_free1 =3D NULL, to_free2 =3D NULL;
> +			LPSTR str1, str2, str3, str4, to_free1 =3D NULL, to_free3 =3D NULL,=
 to_local_free2=3DNULL, to_local_free4=3DNULL;
> =20
> -			if (ConvertSidToStringSidA(sid, &str1))
> +			if (user_sid_to_user_name(sid, &str1))
>  				to_free1 =3D str1;
>  			else
>  				str1 =3D "(inconvertible)";
> -
> -			if (!current_user_sid)
> -				str2 =3D "(none)";
> -			else if (!IsValidSid(current_user_sid))
> -				str2 =3D "(invalid)";
> -			else if (ConvertSidToStringSidA(current_user_sid, &str2))
> -				to_free2 =3D str2;
> +			if (ConvertSidToStringSidA(sid, &str2))
> +				to_local_free2 =3D str2;
>  			else
>  				str2 =3D "(inconvertible)";
> +
> +			if (!current_user_sid) {
> +				str3 =3D "(none)";
> +				str4 =3D "(none)";
> +			}
> +			else if (!IsValidSid(current_user_sid)) {
> +				str3 =3D "(invalid)";
> +				str4 =3D "(invalid)";
> +			} else {
> +				if (user_sid_to_user_name(current_user_sid,
> +							  &str3))
> +					to_free3 =3D str3;
> +				else
> +					str3 =3D "(inconvertible)";
> +				if (ConvertSidToStringSidA(current_user_sid,
> +							   &str4))
> +					to_local_free4 =3D str4;
> +				else
> +					str4 =3D "(inconvertible)";
> +			}
>  			strbuf_addf(report,
>  				    "'%s' is owned by:\n"
> -				    "\t'%s'\nbut the current user is:\n"
> -				    "\t'%s'\n", path, str1, str2);
> -			LocalFree(to_free1);
> -			LocalFree(to_free2);
> +				    "\t'%s' (%s)\nbut the current user is:\n"
> +				    "\t'%s' (%s)\n",
> +				    path, str1, str2, str3, str4);
> +			free(to_free1);
> +			LocalFree(to_local_free2);
> +			free(to_free3);
> +			LocalFree(to_local_free4);
>  		}
>  	}

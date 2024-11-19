Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4F13E8AE
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011470; cv=none; b=EipdULC15JIWBSYo/s0i2BwKmifi9WLDaI66zdyyZP67ef+TYAK4AzT/4IhFTTO9m1iZaPWmCNR3oPB7NJSEBx77WxlQD3uAe8mIGJ/TmBx44HJKroGLBV74OMdDHRQzP++PNR+wSxz3TYdJ9Oonlj5pHsfUhiryxRP/u3ZdELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011470; c=relaxed/simple;
	bh=hRBKell6KOB65kF/fY2afAwbfhr07+hI9ASqZUJZeuU=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=UeWbluYWLiVX0Fi/YFCt70q4p4wIc0FALhqxQvDCnWa9XADrYKy1dI8NfhrX24CLC/bGDcxmCwgrB5Zjws9DfYEAOCiq+kgq7NyXCVOB7Moli3NBmpd6cQumZ3tO8c4DNsqS5s4o2WoEUaFtcUywfR0a79YULU+W8XqjWlcf+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=n605FWU2; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="n605FWU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=r5KxUhmj4sPEo4jx7CMjpF2OWBXaqKAsafRomINg3xs=;
 b=n605FWU2QDwf+qVkhAmWFNwglFLu02ml1u5Vj4uRYeE3xLaKX+xfJaErEdfCOAVgO9KA1IF53p/l
   xIXMTLnbMCFMrnCAL3OCuK5KXYfaSZRPyExylAnWD4KcbQTeXs9KRdX71qPLi16IiEKubOn4KrCA
   jDjUrWFFxS39CT+3gfZA9yVaeKAjei+72JiXQvjNjXfj8BoTtQfF2lXuaOI7xCUP2vg0Lk75mwuB
   RlQqhiveGphMfaW4go9mDn/1VPlE7ynVxNQ+ApLkA/xkWCrunLenAqvtmuwKEzBCpvEj7k0XAPQx
   mIEU3LLqvCvuuCD93fGllfHs5Svdg5WwelZ1SA==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN7003KU0LK24A0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 19 Nov 2024 10:17:44 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 11:17:27 +0100
Message-id: <D5Q2TEEZQYFC.2CH8JBLF3PHZT@ferdinandy.com>
Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
To: "Patrick Steinhardt" <ps@pks.im>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-3-bence@ferdinandy.com> <Zzw0ooX0HFwSit7v@pks.im>
In-reply-to: <Zzw0ooX0HFwSit7v@pks.im>
Reporting-Meta:
 AAFxfWV/iJ+JjdyZ1bd7q+7AaNrqXyCOts7+CeKRtDckYqY8pIS2Zs+vSyERepBn
 7erBk8MphuFG/O4bHSarq7bUhULVE2IoO5ELpC8yTeM+7Tme1Gn0VwWnN1LksTLY
 0kUiDWGRe8mKXXr4kO+apsBY0L/fiRpQEM9k1X79UJmCFNAzmnkmCbw4fXOMFhPc
 l/u83NrkSjrWwIZiWuGaaEH+w3iL/xY8hQcsrjX95JsRYHrD6vFb2J+PKq+yanNi
 tgruHkaKnPGFva4uAIqpKNpjNX1D8h2dO0ImdQMPgxXWW/Q5g7x2IBtUp5aEpUKx
 asWPrRAdoMw1jn67ceZTBjCKOhiEdjK4mJvBc9A2CLsoVPAVkkl6Ojd/35aP6bki
 YnQ1YiqIfwLYyTSnKMVlRJNTqMgMDIxt0r8COdw1rGW3DeaRDxviYWHYqAhVX15o
 3gdet2ydTD1Vo1H5vphDwYMCL2BSKAklJtt55KNDS7Hl+CKeLmMTh5I=


On Tue Nov 19, 2024 at 07:48, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Nov 18, 2024 at 04:09:21PM +0100, Bence Ferdinandy wrote:
>> diff --git a/refs.h b/refs.h
>> index 108dfc93b3..f8b714ca1d 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -83,6 +83,12 @@ int refs_read_ref_full(struct ref_store *refs, const =
char *refname,
>> =20
>>  int refs_read_ref(struct ref_store *refs, const char *refname, struct o=
bject_id *oid);
>> =20
>> +/*
>> + * Return 0 if the symbolic reference could be read without error.
>> + * Return -1 for generic errors.
>> + * Return -2 if the reference was actually non-symbolic.
>> + */
>> +
>
> Extraneous empty newline.
>
> Also, how about the following:
>
>     /*
>      * Read the symbolic ref named "refname" and write its immediate
>      * referent into the provided buffer. This does not resolve the
>      * symbolic ref recursively in case the target is a symbolic ref, as
>      * well.
>      *
>      * Returns 0 on success, -2 if the "refname" is not a symbolic ref,
>      * -1 otherwise.
>      */
>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 2313c830d8..f0ef354bce 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -673,6 +673,12 @@ struct ref_storage_be {
>> =20
>>  	ref_iterator_begin_fn *iterator_begin;
>>  	read_raw_ref_fn *read_raw_ref;
>> +
>> +	/*
>> +	 * Return 0 if the symbolic reference could be read without error.
>> +	 * Return -1 for generic errors.
>> +	 * Return -2 if the reference was actually non-symbolic.
>> +	 */
>>  	read_symbolic_ref_fn *read_symbolic_ref;
>
> As proposed in the other thread, this could instead be:
>
>     /*
>      * Please refer to `refs_read_symbolic_ref()` for the expected
>      * behaviour.
>      /

Thanks, that makes sense. So  as a summary, I'll update the comments and al=
so
the implementation detail Junio pointed out.

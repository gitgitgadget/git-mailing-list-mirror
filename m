Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FB130FC19
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780278; cv=none; b=b9N66+stgEJ0VqakbcMmEsYU1huj3LIkwQXOKGwDpVP9ChEoQQcCHGiynquqZaGDLqzr/dZoH03RUh87oUmxNdOx+U3Z6aUHfo4TOrbrCDdZF9C167HI3LSO6r2GARfFTu3UVAwztL3AU3j+y/LDKHTsvjwk6zMg6fdEdfq4r7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780278; c=relaxed/simple;
	bh=ultWnEg9YZmSuEC1oNajkaMMeh5jx3XhmWvdbPksOYY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMsoTIB+y2BgeOHnKamyAQHRyy2PNsAtoz58cSGzv6y6w1njvPpsCZ7yFwOg5lwKfDayKupBm0x5fRT1AxonFpTUB49vKL3i2BBqVLBuS70BRp5yp98cFWxT9I8G4u4buDQtv9a27RZdrITJ5hgUWS5vVDsn5pa+4hiOrnEPm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvPCGASi; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvPCGASi"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso2891291137.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762780275; x=1763385075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U6zN8wu8Mjqxz09mHC3lTkGNSByynDQJw1XqHYQQtoo=;
        b=cvPCGASifFFHeTv3kS3wghoGJyKvgFkM7TycBZD+nyUNBvcTXksRDpmtb4N4Ym0r1x
         jeWvfNNlR3mfnPVyCdI8BsxBtcPFy6gBJtjSfHytbgkEMYp1dKYNGYCO6Z3l7EVvVbYA
         SNPZh7iqC0uEJheQ2USLqmtfiwse7E9t7A+NrJPNSXEJlCpXUs0cvTBAUN0IiyRZHX1M
         BJ17dscN8uTpTZVtUFwtyYzzipbiUQ1o84tJl4T8kaSDejy8U49hJaYWRzxDIWXkkn9S
         RCAK2K8R9+zYfZ7y6A02zR+XAM+BTyo6I2EQxBnJzynSL/0Fj7yLXKHCT+qSTednVx3b
         0bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780275; x=1763385075;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6zN8wu8Mjqxz09mHC3lTkGNSByynDQJw1XqHYQQtoo=;
        b=FdDJjEbdzdRBjT+zA2It5m2g2WR4rUiQLUC+/aAE8sddqL78SJPzmwoSWIFN2fT4rf
         +qmgipMd8G+w8madPCcN0WtTpgZfHPFxEE0aoH3Z6y5quk2LbXkbQ0WQzs5JuDptcW2j
         760QNsviq/Tmnj5QSHKY0gkUe3+6qkSIb+QxQ3qB/WJxH4U1baIj7i06iVXIkq5c89GV
         0DZy25+98BDoMa5UW4FPJtwaALsyGGxE2LQE3rTVTkVOolHuyla7+Pah9LOX69/HeMVM
         P9XN3tWYYvVs+FR4uJ9tuXaUkQ22gnrPFeBvMVbNZmCGSwZPXaPK2r1S928p40GxdxMi
         5hfw==
X-Gm-Message-State: AOJu0Yzm+ZrpPe3NWOWwSB0YIJNWrhhymPscxAAk5SsxiVldAfd2tBrd
	GuVEpHNnbtHldRvJhCZyRmf0HTDbu4j+jFSrtpXZjVup/WM53zPnMHc0deAWgUxPke4xvWV4dDV
	xbQKiX+ilyqCe5Q4YMx0ViXEzrxGJs95d7Whw
X-Gm-Gg: ASbGncsVZsdDEBuR4nv6Z0GJehPdS7IiA1U/zknTJAZIZGNMiC7JJzfBfcnBvBsMMHk
	iQMKybqayMwtWEp5wV7jHMOXgtqyh8lCqgktgzVD/tvyj7ywMYWr4ajClxTWTvwILoTjTm8cUlD
	d1XPXChB4/grC3TeA5x0MRYueeQHwRYDHgzY3ornMy4Qqyw3SwtKvZ6dw1jYkmm45DITduxk1L3
	R5pbmZMIuS5ukPi41uKtn9jpLMbV9ZmkG7XSf4Zumnjh7Qnc6YuQt5VCjlk33EdIq/cNw==
X-Google-Smtp-Source: AGHT+IE6Ob47CvPdvK1y4ch6ie/R3zXIk5Cd0BfW1X7mzAcQMbzJpbOZX1HOvPR/2V9duesxo65JnQeB7KqSB249xJc=
X-Received: by 2002:a05:6102:1454:20b0:5dd:c53b:75cc with SMTP id
 ada2fe7eead31-5ddc53b8489mr2087742137.13.1762780275349; Mon, 10 Nov 2025
 05:11:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Nov 2025 05:11:14 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Nov 2025 05:11:14 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aRGVhA4eXnAFxvqE@pks.im>
References: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
 <20251108-fix-tags-not-fetching-v3-1-a12ab6c4daef@gmail.com> <aRGVhA4eXnAFxvqE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Nov 2025 05:11:14 -0800
X-Gm-Features: AWmQ_bmeEO3r_ZXFORbxYwQ9Tmj1LBNEBIq6F7MSDeN-3f8nV20Svsihi7xkpX0
Message-ID: <CAOLa=ZQLWF_GBtYXN9F=+=BwqugYOH=Z9OuNV1n3VmnH=rbqpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fetch: extract out reference committing logic
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000213f7e06433d4428"

--000000000000213f7e06433d4428
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Nov 08, 2025 at 10:34:43PM +0100, Karthik Nayak wrote:
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index c7ff3480fb..49e195199e 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
>>  	*data->retcode = 1;
>>  }
>>
>> +/*
>> + * Commit the reference transaction. If it isn't an atomic transaction, handle
>> + * rejected updates as part of using batched updates.
>> + */
>> +static int commit_ref_transaction(struct ref_transaction **transaction,
>> +				  bool is_atomic, const char *remote_name,
>> +				  struct strbuf *err)
>> +{
>> +	int retcode = ref_transaction_commit(*transaction, err);
>> +	if (retcode) {
>> +		/*
>> +		 * Explicitly handle transaction cleanup to avoid
>> +		 * aborting an already closed transaction.
>> +		 */
>> +		ref_transaction_free(*transaction);
>> +		*transaction = NULL;
>> +	}
>> +
>> +	if (*transaction && !is_atomic) {
>
> This condition is somewhat weird, as we know that it won't ever execute
> if `retcode` is non-zero. So wouldn't the function be way easier to
> follow if you turned the above conditional into a `goto out`?
>

I don't have any arguments here, I basically simply moved the code as is
and didn't want to make changes to reduce the review load.

> 	static int commit_ref_transaction(struct ref_transaction **transaction,
> 					  bool is_atomic, const char *remote_name,
> 					  struct strbuf *err)
> 	{
> 		int retcode;
>
> 		retcode = ref_transaction_commit(*transaction, err);
> 		if (retcode)
> 			goto out;
>
> 		if (!is_atomic) {
> 			struct ref_rejection_data data = {
> 				.conflict_msg_shown = 0,
> 				.remote_name = remote_name,
> 				.retcode = &retcode,
> 			};
>
> 			ref_transaction_for_each_rejected_update(*transaction,
> 								 ref_transaction_rejection_handler,
> 								 &data);
> 		}
>
> out:
> 		ref_transaction_free(*transaction);
> 		*transaction = NULL;
> 		return retcode;
> 	}
>
> This feels significantly easier to read to me.
>
> Patrick

I do agree here, and since the code is small, I think it is worthwhile
making this change. Will add in. Thanks

--000000000000213f7e06433d4428
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f3159b3131685b7f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rUjVIQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFY1Qy85L3FCYWhOelA4UmR2bWN2QSs5bVZBODJwcQpOayt1UEVOK0RR
aXBld2cwZmdkNlBBL1QyN2NyVDJmQis1d0piamNOa0hmWFp2aW83bkVmeWdsNGd3YW5FNXViCmlF
MWF0eFY5RndlYUdRTDJMYU05SnBoQlY3VkNHRVNzUkJwQ1pVeVJnUnN3SVpUeGI5YzY4UW8xY0lZ
dlEwbVMKQ3lWcVNadnk2aVdWSy9uR3h0Mkh3QzlGUTBvelF5cXR0ZUhhOTQrbmVCOENZakdzSzVo
TEI5MFVtdXJWZ1RJZwpRZlpxeWdqRzVIUFVJRnFVZzM2YnhMaFk4cDlIaGVXWFVOZ1pzYzNyR29Q
WGpvUlQ1RFNGOEZmelRIQUYwUjA3CmlFTGxxT09vN1VrUFNTMWM3VCtscEJmTzEvVkQyUWp1aUc0
U2kvM1gzZ2tIZnliQVlJU0lQY3Y1NmlmWGwyMzEKWHZhWkhWS2VoM3BCT1FDaHpwdFE0bE1PYzlM
R2Y2Y0hXeGMyZVJoRWNNT25jUm1BczJ2S2lKUE0zTDVicTQwTgpXNE03OVBicEpiV3lqd2ZxRTYw
bWdvS3J2WTdieXRqcExxUXltei9FbU85aFBmdzhZNy84UU01UFJRbkQzclpRCkgveWRCM016SGp5
bGpJOEdiNFNRclZJTVhKSGladVRXQzhwVzMzRT0KPVBtK1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000213f7e06433d4428--

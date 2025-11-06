Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CC2820AC
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434447; cv=none; b=Q1iM10WQGSNF2HzM5J42R94S/m9nDsyNNrd+W14ZVC0DeSdGtbJR76z1JJLiNmYNevXYc6kZPq28xq6XlzysPuUyvFT3T4NRJ70sbvFRMnLVtjjTcg7uDOIy5COr0O8I7SnI3YclV/E7hjoSVZDMdd0sVNtaWJ5DHEYI0qjOb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434447; c=relaxed/simple;
	bh=fFSpZQR/U7AFXDPAXzLeoj0RxeaWgS6NFmm0Cxa7jL4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyQUXjdBfBLFbXsg7wg0wOrYkFA6ScWA57Cr7+9nfTHgbMPt4/nPZ2nZeEtitMWyi52WjJjHrjZaoUZd1ltsqc7NRna/ogpMDGGJq/AmBA7+cp6GneFk+sQw39QOgLac066yPPG0HSYa4NDjAXZSfw2VZZslp3ikiTq+kXQDqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkxfCM8o; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkxfCM8o"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ddaff87c82so844137.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 05:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762434445; x=1763039245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxVI+l+OhwR3AammJowhzLeS3V/+bpMvtO3DhdqW9RA=;
        b=mkxfCM8oRtRCsj+IdICj6fG/QQiR62NWkPCjVD0OJxL8ANdRFfW54ZcJEZAkTSUTe8
         GOYw7ORsQcewHlqI1H97uKWBr2YJeP+6r4REI2m1nP0sf+0qfDiUb2uV+BQtOTGukHzx
         gu0QiKTd9v5iYR49WLTBx8gdZMUsqmtT3Yd+xm5oD8uRZjL4MKVBpiVD0MMZz+uUlX7I
         kMNU/7zw7NaNgyz9L2jDpE56aIdDFdubQvkzo7QPCRnPh/FezQP8gZgSbBWZK/7AJq8g
         glnKQZwHcP9wKifIKgvD6tIUzrB38YwoouCfyI6jzm2vi5st37osq4qR4B1YG+2d2MnQ
         sp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434445; x=1763039245;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxVI+l+OhwR3AammJowhzLeS3V/+bpMvtO3DhdqW9RA=;
        b=VURK0pciE2BJXSvhe0kLx+/wfq72ZH3BekG6pB8oc0fHjUeR+XBarQdkVoptcGlrOb
         fqwYx5XIK1DfpNGA3NKxrdJzl0ITYIZS02zp4gAa0ZhwEgQ/U8qXvuEUMtA0Z32YJS7Y
         OQ50vooVmTyNJskIPFyjPBQIDKQfaFz/V/7mN37BEKhtJG2GDbfIH5OoyL0WFj+NU7I3
         wI5UBoBS8Z2e/Fxyd+HChMjqpND15RfwrLbe7qaOUQg/WgB6kF6O+X757kG3BA3oJ/GR
         BZl+7U3dQQpzM2HPQPf87YR0kHaoY8Q+NsiCCVbXqZHL33nc84KEAGzIw8mYQGvjGVq1
         oYjQ==
X-Gm-Message-State: AOJu0Yw1FkE6P6acFzuMxDDsNbHViKhuD98er5ErIFe7mQ4EBoVjm8QR
	vz97lyc4HB8KYR6CyMpL8OuuEigYVN9LKExxDNRJ12/IgLfW30F3ndGCng2nE1h7fCaaVX++fBN
	laJ/1I2PH3QGMZM4jBj/r5TJtc7N0aYI=
X-Gm-Gg: ASbGncvDORPes8QPu9nbyJtzQgDn4yk85CLMd4UzatrJfKyOSEdyv60JWC+GTsLLse+
	Fg6d/zLWBmv99HMD0+VJ2pGVtgDdFZNwUujksuBQqydzTRZ9K3dTlA1f96OKDcOs6ETqtOFnwoX
	/C4mPdM7VSEgArpJEjGs4e8AgVn1PR8Ls9mDJAO3/5qS33+S/13oLDNEg67ZPw+ErGBghgKpbft
	m2j4x3Fh7s3qWHhmSvhOoGClIRRpY5s3sihGZvI+DqXSgxVidx/RNWwS4LKDxMHEapN5g==
X-Google-Smtp-Source: AGHT+IE4hv8y26nfUHmFIZ2eWwS1Ognc2AQtjYlZhQpSI1QBHgC8SzrvfTst9dcLiRpV9AflHH34nRvwMB4vY1p7Gkc=
X-Received: by 2002:a05:6102:32c3:b0:5d7:bd64:cc72 with SMTP id
 ada2fe7eead31-5dd88ec771dmr2481694137.15.1762434445079; Thu, 06 Nov 2025
 05:07:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Nov 2025 13:07:23 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Nov 2025 13:07:23 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQyOZ0e6HO0_77Au@pks.im>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
 <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-5-d611a2a95cf5@gmail.com>
 <aQyOZ0e6HO0_77Au@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Nov 2025 13:07:23 +0000
X-Gm-Features: AWmQ_blD5Gne216oVXFqWCJP2iwQn2XKuzzaCEjcyTI3X5l-IA4VGrMkbjdGsGc
Message-ID: <CAOLa=ZS9J9SfMFp7+dmue=isJrpFSbTU7z8TCShOb36XdB8Y_Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] maintenance: add 'is-needed' subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000000a12020642ecbfee"

--0000000000000a12020642ecbfee
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Nov 06, 2025 at 09:22:34AM +0100, Karthik Nayak wrote:
>> diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
>> index 540b5cf68b..37939510d4 100644
>> --- a/Documentation/git-maintenance.adoc
>> +++ b/Documentation/git-maintenance.adoc
>> @@ -84,6 +85,16 @@ The `unregister` subcommand will report an error if the current repository
>>  is not already registered. Use the `--force` option to return success even
>>  when the current repository is not registered.
>>
>> +is-needed::
>> +    Check whether maintenance needs to be run without actually running it.
>> +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
>> +    Ideally used with the '--auto' flag.
>> ++
>> +If one or more `--task` options	are specified, then those tasks are checked
>
> I spoke too soon, forgot that there's one more patch :) s/\t/ /

Weird, not sure how that happened, good catch.

>
>> +in that order. Otherwise, the tasks are determined by which
>> +`maintenance.<task>.enabled` config options are true. By default, only
>> +`maintenance.gc.enabled` is true.
>
> This could use a pointer to "maintenance.strategy", but I see that you
> took this explanation from the "run" subcommand. I think this is good
> enough for now.

Yeah, that's what I went with, so I'll leave it as is :)

[snip]

>> +	if (opts.auto_flag) {
>> +		for (size_t i = 0; i < opts.tasks_nr; i++) {
>> +			if (tasks[opts.tasks[i]].auto_condition &&
>> +			    tasks[opts.tasks[i]].auto_condition(&cfg)) {
>> +				is_needed = true;
>> +				break;
>> +			}
>> +		}
>> +	} else {
>> +		/* When not using --auto, we should always require maintenance. */
>
> Nit: we might add a TODO comment here.
>
>     /*
>      * When not using --auto we always require maintenance right now.
>      *
>      * TODO: this certainly is too eager, as some maintenance tasks may
>      * decide to not do anything because the data structures are already
>      * fully optimized. We may eventually want to extend the auto
>      * condition to also cover non-auto runs so that we can detect such
>      * cases.
>      /
>
> Patrick

Sure this makes sense, will add it in.

Thanks
Karthik

--0000000000000a12020642ecbfee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 57830b0ce880d8dd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rTW5Zb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXU5REFDUXg4WUYwbzYvMkliVDk1c0FabnVKcXF6RgpKNS9mSmFyZDhI
cHhVbzBFdXdyUXczT3RIaVZOL1p2NHlvS1RjT0lIU1RNbVlTK1hyZHhFZ2J1K0JXK2wxODhqCnBO
Y21aSVE5Q3QyeVY1L2s0TXFIem0vZHN1WStxb0dMV0NEbnZ4bUhpY1JIbmN3Ums4aTZwaTBHd1Zh
c2xuUHEKZUllTWlEOWt5NkVCZFJTbmxub0VydFdGRXRHa1NKVGxPTngrbFBOeEJJYUFMTVMycmw3
dUZlVldMa2ZQMHN2egpZUmhEK3lvVG9zT3d6QTVTZHIwVTZKYnl4U2YzUkh1WTRjeWUrVlBMOXN2
VUpqOFNTbEtrSEF0bDNXcWRld0toCkdBSTJUK0k3RHlENTV4djlhQk9NV1ZTZDBIak82NHFrZFl4
VXVKYXNMaTIwZVdZcXVMUXNhOTY5UHYyRXVvZzQKamsySlJ0cGFrblRNdE0rZ0ZkRlprQWdLUVlt
TDF2NWF4T3B3NUlsR3ozaHZlTlIzMnpsaHhidHVTV2U5UXJsNApNY0tjeWcrNGloYWZwQVVISjN0
NkptSTZPNnp3UlVDMkhXdUFMMUNIaERHOTNCdElDNk9sM0ltd2hRYjhqdVpGCmpjRHJlMmZmOHlx
eW9DZExzdDhoN1o0TzVpTmhjeUVrcE9Sc2UzZz0KPStOa3IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000a12020642ecbfee--

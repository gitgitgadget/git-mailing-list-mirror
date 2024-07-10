Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B7190075
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620389; cv=none; b=tdTqq5gmOqfHSfgRe0E5IqC8qQhbiQuCxlsQVbJSRcI3A/xrb+hDDdufGyCjbbKzwK/0Govpo79/MA1MvRjRf4LC0ohV6+4LX9L3CsoYEUqVTfCuJJv9SPRXNTQeuAjfNHvKpfU7PDSksbXWfxX/1/Qc+tn57z2okn4bZaHXFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620389; c=relaxed/simple;
	bh=DmfAAo2orS4o2evN9X0SR6OB2o0WloRAaQRc85/ONEc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yj8OJMsnXtBIrsJ3+EyiSqCe6ElYjUwZ8tTd9wP+WBnyyeOzK1rYGWaN7Iz8w2gYt3LpAMmcCm116iXKNMEWpJQETpe4saXuYEp9GKi8PCmtGxMHY6vOCC+5WEdK7y216KRmyMaEkHOw8HcU3M+ZjUk5lE6FQSfyMWjsUTcLYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa4Anvkd; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa4Anvkd"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25e0d750b73so3150562fac.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720620387; x=1721225187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F56IeB13ibjce4lumAnR9U9t+dQr3FIvTKXwIeBLjVE=;
        b=Oa4Anvkd+RYnKUU7Lq6d0j79ZC41H1ikp0/ifRNXtqu6fnC7LxBslN5usQsy1cu6O/
         yC8Kh9pmYNQOn09ZC7/gVaFE6hhvQ2ubOcv5bIYRGCxMXur1F5COiliqjhBWT2QKnFWL
         GgOlFVdfy7QUqBSM6EKuC3Net+At4Oqw7o/E22w5OTQ82jsywaKSJil5I1rnKuxbeNv5
         rrY6QOX1+zs7SuflnwX1NkTrsP/NbBVPFfxyPW/04HIzRqQGd1y0a7sk/0UZ7YuS1lON
         Tp1D68d6MJEbw1OJAXgR65omb5jtiEwgFfcdjsczS1HT02Pb3D26N/+O1c+BYvYKQ2o+
         phwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720620387; x=1721225187;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F56IeB13ibjce4lumAnR9U9t+dQr3FIvTKXwIeBLjVE=;
        b=MmbW3+eu15grNHj6lnDU3NzR6bhs+FgNw4c24TqJ1K93h1rddaM4Hd1dxCpo0Qir0p
         rEmWE5wUdjefBNEXeSu+OGibwMUKictSg4vBJOs9yjlmSw/oNB0Mcvn1RgpEgVdwtga8
         QJ26BjXiMQxlEaCWKa/QZcJJMcYLU6ojhhBeFUxoE4ElMsc38AjTq/cqBw0DL0+BSejy
         j9gbb78m2r3L/eOm7YdJZO6u9LrwM85IsmXprPiOzIZv6hVm1Fil7LnITeLaK51KvYjr
         LraXgwtzBqNgrMuOfk8nn0il3PgRYcIjLxpgpXT2BvMdhEAcB6TkqZUD91PEQ1KsbMO7
         /8cA==
X-Gm-Message-State: AOJu0YycqX39km7eqPmlZrnQV2W081ckEHt8JeUUxEzoZJYstzruNxXt
	AEJFF2TsXFv2OY6FHwMQl8LN/2uqrvGkWY+kiTEDTvb9Zd+etkGgfoPKNID+iFcQu8Ahp1v7uCn
	NQX0jns69s8n5Qt41syyzC4wrS2JNtSgr
X-Google-Smtp-Source: AGHT+IHvKfxlrj96Od1y/00RQIMuf+5Ut+Lm1/WsTzAwj9YM7WU4x4PgIFrcwRPsWPpPpld/4d6/6BXdqzL2aFm2v9I=
X-Received: by 2002:a05:6870:7185:b0:254:c7f6:3294 with SMTP id
 586e51a60fabf-25eaebdb1f1mr4474159fac.47.1720620386666; Wed, 10 Jul 2024
 07:06:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 07:06:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbk37hjma.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-9-karthik.188@gmail.com> <xmqqbk37hjma.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 07:06:25 -0700
Message-ID: <CAOLa=ZQdPTnLp63eFiq1oOkgukBGsug==Cam0hGW_9koCefhGA@mail.gmail.com>
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000f0e445061ce526e6"

--000000000000f0e445061ce526e6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'check-whitespace' CI script exists gracefully if no base commit is
>
> "exists" -> "exits"
>

Will fix.

>> provided or if an invalid revision is provided...
>> ...
>> Let's fix the variable used in the GitLab CI. Let's also add a check for
>> incorrect base_commit in the 'check-whitespace.sh' script. While here,
>> fix a small typo too.
>>
>> [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  .gitlab-ci.yml         |  2 +-
>>  ci/check-whitespace.sh | 13 ++++++++++---
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 65fd261e5e..36199893d8 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -119,7 +119,7 @@ check-whitespace:
>>    before_script:
>>      - ./ci/install-dependencies.sh
>>    script:
>> -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
>> +    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
>>    rules:
>>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>>
>> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
>> index db399097a5..ab023f9519 100755
>> --- a/ci/check-whitespace.sh
>> +++ b/ci/check-whitespace.sh
>> @@ -9,12 +9,19 @@ baseCommit=$1
>>  outputFile=$2
>>  url=$3
>>
>> -if test "$#" -ne 1 && test "$#" -ne 3
>> +if { test "$#" -ne 1 && test "$#" -ne 3; } || test -z "$1"
>
> You can just add || test -z "$1" after the existing one, making the
> thing A && B || C which evaulates left to right with the same
> precedence for && and ||.
>

Well, I prefer making it explicit so one does not have to remember the
precedence ordering, but it could just be my lack of shell knowledge.
I'm okay with this change, I'll add it in the next version.

>>  then
>>  	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
>>  	exit 1
>>  fi
>>
>> +gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)
>
> That is a large string to hold in a variable for a potentially large
> series with lots of breakages.  I didn't quite read the reasoning
> behind this change in the proposed log message.  Under what
> condition do you expect the command to exit with non-zero status?
> $basecommit being a non-empty string but does not name a valid
> commit object or something, in which case shouldn't "git log
> --oneline $baseCommit.."  or something simpler should suffice?
>

Yeah, makes sense. I think I'll simply add in

    if ! git rev-parse --quiet --verify "${baseCommit}"
    then
        echo "Invalid <BASE_COMMIT> '${baseCommit}'"
        exit 1
    fi

instead

>> +if test $? -ne 0
>> +then
>> +	echo -n $gitLogOutput
>
> What is "-n" doing here?  Why are you squashing run of spaces in the
> $gitLogOutput variable into a space by not "quoting" inside a dq-pair?
>

I actually didn't know about this. Thanks for informing.

>> +	exit 1
>> +fi
>
> Looking for "--check" in
>
> 	$ git log --help
>
> tells me that the command exits with non-zero status if problems are
> found, so wouldn't that mean the cases with problems always exit
> early, bypassing the while loop with full of bash-ism that comes
> after this block?
>

It should exist with a non-zero code, but since we're capturing it in
the while loop, it doesn't stop the slow. A consequence of which is that
it'll print the stderr from the `git log` failing, but the script itself
will still exit with a zero exit code. This marks a success on the CI.

>>  problems=()
>>  commit=
>>  commitText=
>> @@ -58,7 +65,7 @@ do
>>  		echo "${dash} ${sha} ${etc}"
>>  		;;
>>  	esac
>> -done <<< "$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)"
>> +done <<< "$gitLogOutput"
>>
>>  if test ${#problems[*]} -gt 0
>>  then
>> @@ -67,7 +74,7 @@ then
>>  		goodParent=${baseCommit: 0:7}
>>  	fi
>>
>> -	echo "A whitespace issue was found in onen of more of the commits."
>> +	echo "A whitespace issue was found in one of more of the commits."
>>  	echo "Run the following command to resolve whitespace issues:"
>>  	echo "git rebase --whitespace=fix ${goodParent}"

--000000000000f0e445061ce526e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d424d89c5c4e616a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT2xXQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFBxQy80dWZRSGxsNGdzVXJPTXpVM0JUS1FjQXdqNgplanZIN1hSRVFP
MTkxOWtLZi9jd1lQQjRHTGtqUWJ6VTB3MFZuejVFQmF1clJLRHRMSHZvZkVEdGc1SXFFOHhjClBh
UVgydVlMNGpOWHEzMlBhYWtVNGNzc08rb0VZd252RHMxZ0VFdkI0NVRuS0dxSHNyampDK21oS2R2
TmlGL0cKSGdMZWdZMTVtNTcxbzhmVC80Z1BVWmoxUHU3MjcvLzhTN25vd3FyOXI2MHhLbG04Wisw
UEF6OE1iTEVOVzc2Nwp3MllST25yMjFzVHdBSFNpWEtQRFRLenlSSDc0dmRHTnZlUXprU052YmQv
UC9ocmVMNXhJdTdXa080c2NVZDVPCmNsMXFFUjhGcTJJOUt4UldjYzJhTEFiQnlHRTY0NHF6VDR2
bENNbTlHOTdJNXErQlM0aDJmTG8zSEtmZjBLS24KNHNIaWFiSngvTlQ3aTlaNDBXNEdIK0lKSUhM
QkNLblBxMUR4Wk01WDVzcWJIbVJOY05ydGtLT1JiSlRlQ1dweApubDVBTi8yZVgyYmYwb01YR1Vu
UTg1aVlVQmVYbmJKUzVsdnFtandMdmk1QzBCeGhFWVpLZlNQMVl3WXRET3pNCkt0eGY2V08zclBO
YWhYdFUxd1JDaUFmTEdDVXNVNVdmbXBxYmRWdz0KPVRpQWcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f0e445061ce526e6--

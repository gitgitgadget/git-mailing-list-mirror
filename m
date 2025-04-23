Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31971280CFF
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429982; cv=none; b=Mx0oGnAtWHMU5/jaXy7++F7bzM81lIG2Nmk6wu4L2cF4CD3AvpC5sqWF391Pv0oMrNZ2AR8EXuFecqkYtwYwzSl9d14TsSbDKFGJPgUn9V8+qf6smNf+OHosNhnb2vUoORrmssbHN5J/yF//PC96e1nvYWsvsvKBBKu//ZlZ1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429982; c=relaxed/simple;
	bh=wiy/+vFcaH6vZfsVZI15noDNOuybch2IC3jFEe5iAfU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoL6VZnB//iJ1i4KottEoo22NASBCNOtjkbtcuGYkXKMarOkQKKyt4ttuzqt7urjwzqIoN2hKU4LfnRCPCB4Qhd9WAtG5JkW63gKZ6m8Csf/fyqyX0aulu5hu5qAYdvgpEqJCY7oZUDdCUWLyyn3w9XagbDv0PFVHC0uWrBFMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ9UdbrI; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ9UdbrI"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-52934f4fb23so87439e0c.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745429980; x=1746034780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdZmLOkrPw/DH1tQm8H1/ijICuNwga62KtXl4Rq1rgs=;
        b=WQ9UdbrIUniedqqM+ZQIbnGO6LsqZ9CscWeQ1pcvuba+5OUf2keFd7yeZ/ZgeglTyp
         XoJhtXCLmEOi2g9OmpwNXihUc0ljEI2BP+682Bjo7yjfDFSM6oSgIMlU5AthCYPzCrB+
         fW6jvpvyPp5cx2pQBUedQrWRlUCwQYsYykQtnpIrSpD24GXcEpUh07SAU3JUDsJU7a3J
         078Qa/yc32rzCcSyPqOQviyZLyHqQiKF9YFnNahE6A+nILzZa5Bo5Fp/fWh00+VQ+3pm
         QPfyX/1TD3AFudXfmUoCZ7EdMrYxA0HV9xibah2eCIsw6+jvvi3h2HcK5BQEyx0LPY67
         vaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429980; x=1746034780;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdZmLOkrPw/DH1tQm8H1/ijICuNwga62KtXl4Rq1rgs=;
        b=q3IIv44iPwCKiCEZHtZAuCSSOP4RB0sRxf3EuHxkX6ACMC+xAXV68MwY9ZLvugyaKj
         FStENhbpNQ4Ms+/diguNR8P51SE2CPfYq4OzpYDb/H1BTz6ikgcpXGAFXzscBU49SMWV
         hSwg2B8L8nV+rG+/d+TPetNxjh+CYtAer/KNMZXu87ckkkdPrQxeY+/3vsS/usQiFULL
         9qmG4lAzE5p/QmEUQIXJwI641D+TZrCUGu03jZk4qqmGVmdJ9gZxq1SfoIE9KzfSEZA4
         uznclVdBnnoUE2KXpohLVMZor21fgAxjI/ZHsfcG9dX5q+NkepGtWTuMjTGzK0ofXdWH
         hmxA==
X-Forwarded-Encrypted: i=1; AJvYcCXSDbAE+68HbcMRrKp9xu3oZSGvV+1PXpB330iEriOUHGLu0+jw7tQBlbN2AT53bKtLPW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVZGPLPU6Yd+OahI0gWc/o3PtoPi1fvT23nosVVVQTW+J7MO/
	i1mQNvQtCWpUdYTj3K8RzxVwb16PYTw/YOCQG+oAK0SA9yNVtGPguuvpuQuJZ8CkWJI4S5VWloT
	Djaz7QoCGTQdQwNt/zB+c+q8Ux5w=
X-Gm-Gg: ASbGncuP0/LlhdzqbRBZ4Jpz5yqJXBx6JwpnX0B+xCACbKdSR9rbA2rdQKz3w8g9/Ng
	penBhXLAkD7yl55fGh04xvIGnfy7IxzWwa27o9bgretrOP9pxSXlx3NgNtwAqtk6kH+NNqXG6dW
	iIGB2a/K2tIoPWtvqZRArTzNOqjIZ9ctmTwJMaSFYk3XWGtREuH2MKaVLBKUFaILPTUBE=
X-Google-Smtp-Source: AGHT+IFgMxQtVuwVuuBdz7L+vi6AGIuGo7Ib2zTvvcxE7EpmsjS9wGPjMLkbDW83VkMY/lwALiKq7YO4+8cOZ9m36VE=
X-Received: by 2002:a05:6122:2527:b0:520:62ce:98ed with SMTP id
 71dfb90a1353d-52a76b421bfmr262398e0c.6.1745429979856; Wed, 23 Apr 2025
 10:39:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:39:39 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:39:39 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <3607a937-9795-4348-981e-dce92203c6d7@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-1-d1e2be4b2078@gmail.com> <3607a937-9795-4348-981e-dce92203c6d7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 10:39:39 -0700
X-Gm-Features: ATxdqUH1MBPOQCjDLURFjTpHdlOhwU2esJgvi8VEvJhSsdnAFR7gSxi-qRGTyQA
Message-ID: <CAOLa=ZQJZ0L2wONYJo_JNKSDHHRWQ-sOTuA34FLLgzzZPnHdqg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] ci/github: install git before checking out the repository
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000ee1bb1063375955c"

--000000000000ee1bb1063375955c
Content-Type: text/plain; charset="UTF-8"

phillip.wood123@gmail.com writes:

> Hi Karthik
>
> This looks good, I've left a few comments about the wording of the
> commit message but I wouldn't worry too much unless you end up
> re-rolling for some other reason.
>
> On 23/04/2025 09:15, Karthik Nayak wrote:
>> The GitHub's CI workflow uses 'actions/checkout@v4' to checkout the
>
> We don't need "The" here
>

Yeah, I think we can remove it.

>> repository. This action defaults to using the GitHub REST API to obtain
>
> I'd maybe say "falls back" rather than "defaults"
>

Right!

>> the repository if the `git` executable isn't available.
>>
>> The step to build Git in the GitHub workflow can be summarized as:
>>
>>    ...
>>    - uses: actions/checkout@v4 #1
>>    - run: ci/install-dependencies.sh #2
>>    ...
>>    - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh #3
>>    ...
>>
>> Step #1, clones the repository, since the `git` executable isn't present
>
> It would be more accurate to say that it tries to clone the repository -
> if we fall back to extracting a tarball then we're not cloning.
>

Yes indeed.

>> at this step, it uses GitHub's REST API to obtain a tar of the
>> repository.
>>
>> Step #2, installs all dependencies, which includes the `git` executable.
>>
>> Step #3, sets up the build, which includes setting up meson in the meson
>> job. At this point the `git` executable is present.
>>
>> This means while the `git` executable is present, the repository doesn't
>> contain the '.git' folder.
>
> I'd maybe say "source tree" instead of "repository" as it isn't a
> repository without a ".git" directory.
>

Good point.

>> To keep both the CI's (GitLab and GitHub)
>> behavior consistent and to ensure that the build is performed on a
>> real-world scenario, install `git` before the repository is checked out.
>> This ensures that 'actions/checkout@v4' will clone the repository
>> instead of using a tarball. We also update the package cache while
>> installing `git`, this is because some distros will fail to locate the
>> package without updating the cache.
>
> Nice explanation, the code changes look good
>

Thanks for the review. I'll add it locally to my tree. That way if I end
up with a new version, It'll incorporate these changes.

> Thanks
>
> Phillip
>
>> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   .github/workflows/main.yml | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index 37541f3d10..e9112b3a64 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -414,6 +414,20 @@ jobs:
>>       - name: prepare libc6 for actions
>>         if: matrix.vector.jobname == 'linux32'
>>         run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
>> +    - name: install git in container
>> +      run: |
>> +        if command -v git
>> +        then
>> +          : # nothing to do
>> +        elif command -v apk
>> +        then
>> +          apk add --update git
>> +        elif command -v dnf
>> +        then
>> +          dnf -yq update && dnf -yq install git
>> +        else
>> +          apt-get -q update && apt-get -q -y install git
>> +        fi
>>       - uses: actions/checkout@v4
>>       - run: ci/install-dependencies.sh
>>       - run: useradd builder --create-home
>>

--000000000000ee1bb1063375955c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 59dd5aebbeae0132_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSkpka1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMW5WQy8wV0p2QTEvQWx5SmZUeFFKdkhDT3ZGcEFSSAp1V1NMUXlKdDdJ
eCs0NjRoZC9EOXZqU0JFSDZVRmZkb1I4SEpsZVBUVThKT3lla2szZEljM2JaTEoyUTBvamg5CldG
SDd0a1FPZFl6SkFBbjcwRW5oeTF0Q29jelFoRE15T3VCTHVIK25RQlZZK0FyVmIvdEZSR2xnS2xw
ajdnK3AKU3lMZ253UVpnYVozSjhvMVZuN05lRnpkWVIrY0l4R3UvVVVkZnc4cGZWTEFwK0xxMVZN
QjhrWFdtdDRSNFlJWgplWkxpZ0V4TkwwT29TVHRaM1hhKzhDWDZwd0Uvb0tuY2d2Ny9sSi9paHV5
bHF0UW1rdzFwRGY0Nnh6N1o2bmdoCnp6bTNVakFWMnNYOWRJM3lMQ0J6ZFd1dkpaTm1IZXpvR2VI
M29JNGVOYTlPK0g4MmlLUktVeTNjOHZpeXYrM0wKUld1RWFiK2JoN0I1ekxyVk0wcE4xVThtblJk
bUZEbTJTcTRJZXZSb0IrSGpIeXZwa1gxMXB4bkZLcVJXdGJudwpya3RKMWRiVjZ1cTNkTno3a2J0
czhMekpPMWp2a2xrUEk5VzdYMnFPT2kzRTB4azhETlp5VlFFOXdPWGFENlM1ClBGOVJEREhTdUtL
SGR1OWUycDFOalJNL0UzaTU5MHNIeHVzaHBObz0KPWE3MXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ee1bb1063375955c--

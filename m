Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164C267B6A
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106161; cv=none; b=IsB7R9cwOGVHYdmkuW2nRSX2sSeGp0z+KzpMWmPMfyIhOfWc7orwQp8VofA08Gp5U2Wa//sh8Ab/+mi4w8gOuzWGzoTL7CA7ccZO+tigtecIpbzMGVcFOqZEy2J1MVg0ZCJ9zgcNdXvhsa0llVkjPQm3Ahxhlwf7UqwvNlpU9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106161; c=relaxed/simple;
	bh=VdnJuKp1vrOBdv12+0D9k9JKAm9betDcnBdRoMBzth8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B09aPW9S10MoUpBlF+36yvjF3ULdnkpjYubnSZi/CwSpDgRCzCkk8ktXY4f9RZplUCDfbob6aBeegdAVgrLCns+gZc/5Oxdt7s8aJgCX+WZXXelU39CnCd2tjb/i/7I/Wu1YFaMvuhGr1u6LgJzufTHCfjH+4vFVzKScy6H2Nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLpcY3iQ; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLpcY3iQ"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523eb86b31aso2495764e0c.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744106158; x=1744710958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9h0Bm5tO96ziwi87L1G4ZoDklkkvf4l9OOlBnhknJw=;
        b=ZLpcY3iQ4I24/IhUMsfOJhV6EDxFpGwMl/R3EJZwwoidMlIotbns8jRNP3uoR613Up
         IfQnZWuVbM5Ho79Wg8LUOL0U3vdcTKNcWzGefsgak/YTcdE3jzbX+QqUtRrmjSpdlwF9
         d3SICNVLM4/FAoKK0FLamg3UMKInn0br6CmNWr5P377Y2nWw6hIxmrWt3yTQBgSIm9UK
         tzU/L8HmphFR4yWaJHN0BSriqoAIeg98nifJQ1sNr7KKBJrie6Vi5TZx1e/xPNjeU6pR
         DHTnO6v2uhfQzkA6O+k3V1accHOj04GNOloaLIG73M+bjLZ2Vc0c5vjjt9EiykFI8FpN
         YJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744106158; x=1744710958;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9h0Bm5tO96ziwi87L1G4ZoDklkkvf4l9OOlBnhknJw=;
        b=dgsnWs3tu5i9Mi4sh7LqdI27E+aWVAKWRd2DTaEm2fYUNCEvtNbD9D/xMo9uE2Nn75
         ieP88Tuh8ovll5NhLuFCo5PVsCD4/165z0fdfYpSkZBSEV5xXhNd87ZAGwDBUB/uCq20
         EVIrTMuS4HTGiGsUpOHuO3Blhv5sbTHVYHikeIjecwaAbefRX2JS80rkKUK+SYi3GpQw
         2ScJ5uNXJaDGVHY7Nu7KxgKnPyNpQrSYi5fCMRyWvVOV5FA+FE/RJy3td3TpxUBQxlfq
         WvXnccE15PWIHctOJM6Fofzci+L5/o9dcl/wed/7G1/021Jl9x+TVJ7kBJ3wcffrgdun
         6shA==
X-Forwarded-Encrypted: i=1; AJvYcCUUnRTB10kKQJGwLtJqHWkXmLdAsV2s+JXkoisZ/CuwLsCIXWP93c6wYCW0TiZXa5X5WvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwny8kezh04yA7fUqBG+ec/lZ6LdEu+qOZzmTPPHJXagQdU1qe
	XCllDcTaXISUHkK6UgfhwEGGKGuRltsxql+dRecE5+IyW2Vx8HcoZXKXNwO1Ge97g6MNAX5Jq8V
	dz0tGfustjJYbLyEWFOjaKpVVw5g=
X-Gm-Gg: ASbGncuJfYlReTI8CqHIG5guJAQyEXPWnDZVRlar+Vd2ZTV64V9TY1WbuyMyESj/daC
	33Nf0GGfl8sbmvHsj/f+Thbv+B0JmjGC0LIU5VXyFKb0JzxUJDFmxyuw99SBxyvpWysbymHVsiA
	zU24nFIY1tkRzuFuFnjkLiSZDR
X-Google-Smtp-Source: AGHT+IHt0TgGQ9scoVUktdVTvkXlxOloBKQPih+BIsLD1xBtBeDBPyh1jgUZCy3suS8evQpfPEbcd0Jd7i1pS2vHSt8=
X-Received: by 2002:a05:6122:168c:b0:51f:405e:866e with SMTP id
 71dfb90a1353d-5276444bd32mr10452972e0c.1.1744106158575; Tue, 08 Apr 2025
 02:55:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 11:55:57 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 11:55:57 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250408080802.56341-2-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250408080802.56341-1-anthonywang03@icloud.com> <20250408080802.56341-2-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Apr 2025 11:55:57 +0200
X-Gm-Features: ATxdqUFEVqYFEG7tfgVGNZOb5VIEvMcHXwxOf2C81ypANZDQCa0mXoglkiFuWws
Message-ID: <CAOLa=ZQPgSNOAnhc8AHwzkgphz3RCF1YkPdC9LKPi8Hnhz4ijg@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v4 1/1] Remove the pipe following the `git tag`,
 ensuring the exit code is not hidden. Add explicit verification to check for
 expected and unexpected tags, increasing specificity and future-proofing a
 portion of the test.
To: Anthony Wang <anthonywang513@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, shejialuo@gmail.com, christian.couder@gmail.com, 
	shyamthakkar001@gmail.com, sunshine@sunshineco.com, gitster@pobox.com, 
	Anthony Wang <anthonywang03@icloud.com>
Content-Type: multipart/mixed; boundary="0000000000000872380632415c64"

--0000000000000872380632415c64
Content-Type: text/plain; charset="UTF-8"

Anthony Wang <anthonywang513@gmail.com> writes:

Seems like the subject and message is combined together?

> Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
> ---
>  t/t9811-git-p4-label-import.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>

A quick check shows that there is a whitespace issue in this patch when
applied on top of master 9d22ac5122 (The third batch, 2025-04-07):

9d22ac51228304102deb62f30c3ecba6377e1237

--- 92f98eb326 Remove the pipe following the `git tag`, ensuring the
exit code is not hidden. Add explicit verification to check for
expected and unexpected tags, increasing specificity and
future-proofing a portion of the test.
t/t9811-git-p4-label-import.sh:100: indent with spaces.
+ git show-ref --verify refs/tags/TAG_F1_2 &&
t/t9811-git-p4-label-import.sh:101: indent with spaces.
+ test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
A whitespace issue was found in one or more of the commits.
Run the following command to resolve whitespace issues:
git rebase --whitespace=fix @~1

> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 5ac5383fb7..cd06f39519 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
>  		cd "$git" &&
>  		git p4 sync --import-labels &&
>
> -		git tag | grep TAG_F1 &&
> -		git tag | grep -q TAG_F1_1 &&
> -		git tag | grep -q TAG_F1_2 &&
> +		git tag &&
> +		git show-ref --verify refs/tags/TAG_F1_1 &&
> +        git show-ref --verify refs/tags/TAG_F1_2 &&
> +        test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
>

Looks like this is the whitespace issue.

>  		cd main &&
>
> @@ -208,7 +209,7 @@ test_expect_success 'use git config to enable import/export of tags' '
>  		git p4 rebase --verbose &&
>  		git p4 submit --verbose &&
>  		git tag &&
> -		git tag | grep TAG_F1_1
> +		git show-ref --verify refs/tags/TAG_F1_1 &&
>  	) &&
>  	(
>  		cd "$cli" &&
> --
> 2.39.5 (Apple Git-154)

--0000000000000872380632415c64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 73b211f743011a16_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mMDhxd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWFmQy80aVNLTnI0UnJWa3N1SDh1QWUxVk5LV25WMAo1V2JJdUd5SUU1
NkovMmdpOHBaa0U1clozdWRCdFdWRlg1Vnl5VzFWMDlFaXhkdU5ZaTB5TkhKeTM2UnBucG9KCk1z
L1VRVmlGSzVqNFVaY0s1enlFcnBQeEFKS0V2MlBSZmtodmJhYWRBTFRBQXFhTm1uMDZtMUxtWlpT
Y1VubHAKWWJiOVc1V01iOVM3SU01dGk1b2kwWlpqQ1BlakFxY0ZONWNvMDhJeDNHcllsSk4wN2xh
bE1uOTdUMDhSTFRtdAp5KzVoWmRTcFRWODNkYXRUY24vNEQvVmR5THVmcTYveGFtSFNZRlBYc1U2
cERRLzlySnd5OWZqcldFekxtOWFyCng2aVM0Mi9mQnBaSXZTRGVHOFU3NVd0bC9DSU15cWhuN243
V0ZUd1B5a0ZmT3VvdVh4aEc4SmRVOU1GV1E1U2kKY1hiTUZpcmpNRTFMcFoxQjZleXJGcHdLeVkr
Y3Q3b3U2L082cW01M3pJUDZhVEEvOGxlMFZUTE5BbVdkLzdNNwp4ZHhwQmtrSnlkSk9EbGtZNXhW
S0I3eE1URnUyYXRwNG9Cbzc3OGNEelRYREk3MlVqUjdMLzBFUGkxRXZxRVYwCnZNbjk3akwvT1Fx
ZGUvdGNBM0VPdTFDVWgxNUZ2WWM5bXZZNVR5OD0KPVAvQVUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000872380632415c64--

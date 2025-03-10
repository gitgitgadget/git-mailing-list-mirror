Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC21C3F34
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644862; cv=none; b=Zwdx5dQAJG0HpXi7bIPS6zm4iMWhjKyMBDMVorZb9NcsEQ6YPZ3SuYk6kBH4x0fKHcoNQGm1JJJWgvoFH7vVrLH14jlGRzfOkDZrF+tzlyhwbpP07c1V+OC2uYd5DzNoURJOVN0xLKVVunG3BpX2xtr7vbHa319iMJKLJBgmQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644862; c=relaxed/simple;
	bh=MBPs/Lg21pmaVhoL1YxIhanhGhUmUZCVUG5Kr3QymP4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=TFTaUckfhjs7bRRcoJ3mytrhCrP8w86pHyIcUFKov8MpPVpn9hItXwFO9LxwVYn/myYK074jp5CnGdzyMj3lasyCnI4NdC1GqgeMrOAphEYT5ifSQ2DPyI8RJ0vMNE02sw5tyrP9hm/lMVCfKeNpHIWMO/d5DrdshM3wtMMEzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwUh0bEz; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwUh0bEz"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d30787263so2131186241.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741644860; x=1742249660; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcDG6EXLofcMs7V5Wp6nFvA1ahl5QJs2aVTugIAJHXo=;
        b=dwUh0bEzTt3DHGOM8QPzse6V3mu245H6kza6jy2eL4uuQExddD76x6wU/AhuFARCD4
         yrX2f3FhyxbCU2D4wKBZX4PBxhUgtBboh6ycsBHP10DCY+LSAQMmbGRyAUf0N3jRuk4x
         /MEv3PWJJwSakAlh8Mri17ssxs2gWt6jsVA6gwGcKYoYrU33IPTnV712uvl2xm9xOHVb
         2UL22j6eAFc0ArQiUxbsfij1TaPLpIWyfUq7b9sLiyvsixtBAKkIPJCKF3iWrPo5azOE
         dE8KtbuhkycJWmZBUEJN5kcxjRsUz4BfIRPyMctpmGvpCUFbw+xBiw2dPnOi0Xr/LI9q
         7BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644860; x=1742249660;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcDG6EXLofcMs7V5Wp6nFvA1ahl5QJs2aVTugIAJHXo=;
        b=m6asXJ0ac510wuEE8C2d2viqgUtG4wrwb6sN9HgRhimZHkUBWmua6XYltI8D/ps3Eb
         Rr3sRVunhIkS+6nSmFZpPWjqB5Y4jjwp+qOXZCUdrnLlEIBh+YRLOk86rKbI36H3hvBf
         11i+vKsxbcrxJJlRQVsfIBKO3UdUfrJzyeddg0+2Cz5OQSGf3XT6aLVVGIBvY9xp6uhC
         jgWgNV8DWK4pnVQ9vtFHy27dq2HW8renRaZ9mcte9UyDt9hR4Kgl1IX7QLRK4qoRxvSi
         PdfyxX6sOmoV+QbWAi3ZL1O1OGvONQqWhDy1AE88/BTJ2hLlldU52IWPYJQ4i4PLAwEQ
         8k5w==
X-Forwarded-Encrypted: i=1; AJvYcCVnhZ8hgw+0bUuMIn/PYvn5lMk7MsndT9cFaVYeenU/EKlNdSt8t1Pq2/ikXOtiA4m+AQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzTMaKG5l0WjFbANAyMZoby6lzHWXhtTgHsA+SwwwMBtKsOPc
	/9Jly9BRz0K+KDnjW4fFjVh/iZst4mc2/X4l1P2DG+F7A/OgvpcbY/MeL3Ei2TjIRbqDSHcHWkR
	66MytdlijlrXGwUpiRJFWWttdULpVS9M4
X-Gm-Gg: ASbGncuKLDeQ9PFF1XL8+XbXrVPMnzXFHgaBkqdKlWtOUNBj0IcTSfHL3DLJ8bDR71B
	2BNsDOBkg3AxXbv3fTyIiguzSvIxs0WswUR3vezU5sw/etiNYBNkIBT4CBKYhLR8zo2qab6RaF5
	yvkMsv3+LWlx3F1xj6mDkInRf22Gy0+FbQpDml6P03LTHw2A1jVThvaCTLqvve
X-Google-Smtp-Source: AGHT+IHTIlby+KMemDXYhm2uWLrxE05TGgUoLeKLTtJ8YhxTQ0EDpauRPsa96TiBYABp2DNQSLJOXjT2/FcUU1PGh4M=
X-Received: by 2002:a05:6102:54a3:b0:4c1:875e:2215 with SMTP id
 ada2fe7eead31-4c30a534d15mr9491397137.1.1741644859696; Mon, 10 Mar 2025
 15:14:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 15:14:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250307123934.2064275-2-05ZYT30@gmail.com>
References: <20250307123934.2064275-1-05ZYT30@gmail.com> <20250307123934.2064275-2-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 15:14:18 -0700
X-Gm-Features: AQ5f1JrK6xiVwx3yp6Xh6k8D9aF5jgXgZgmneltfHt3B8nqQNHWlYzgiPq0hiAs
Message-ID: <CAOLa=ZThgmKkYErnxUAGOhHyFcFrYDrcQ8KvqqkMBJ3wEckVPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Improve SMTP authentication error handling logic
To: Zheng Yuting <05zyt30@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000300be50630044b99"

--000000000000300be50630044b99
Content-Type: text/plain; charset="UTF-8"

Zheng Yuting <05zyt30@gmail.com> writes:

I see that you've added a cover message detailing the patch, but
individual patches should include the relevant commit description and
message. This is also outlined in 'Documentation/SubmittingPatches'.

That said my perl knowledge is limited, but I'll ask some questions
anyways.

> ---
>  git-send-email.perl | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 798d59b84f..a012d61abb 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1419,19 +1419,19 @@ sub/ smtp_auth_maybe {
>  		die "invalid smtp auth: '${smtp_auth}'";
>  	}
>
> -	# TODO: Authentication may fail not because credentials were
> +	# Authentication may fail not because credentials were
>  	# invalid but due to other reasons, in which we should not
>  	# reject credentials.
>  	$auth = Git::credential({
>  		'protocol' => 'smtp',
>  		'host' => smtp_host_string(),
>  		'username' => $smtp_authuser,
> -		# if there's no password, "git credential fill" will
> -		# give us one, otherwise it'll just pass this one.

I didn't understand why these comments were removed.

>  		'password' => $smtp_authpass
> +

Nit: unnecessary newline.

>  	}, sub {
>  		my $cred = shift;
> -
> +		my $result;
> +		my $error;

Nit: It is easier to read with a newline separating the variable
declaration with the rest of the code.

>  		if ($smtp_auth) {
>  			my $sasl = Authen::SASL->new(
>  				mechanism => $smtp_auth,
> @@ -1441,13 +1441,27 @@ sub smtp_auth_maybe {
>  					authname => $cred->{'username'},
>  				}
>  			);
> -

Nit: unnecessary newline removal

>  			return !!$smtp->auth($sasl);

Shouldn't we do the same kind of changes for this `smpt->auth()` as the
other below?

> +		} else {
> +			# Handle plain authentication errors
> +			eval {
> +				$result = $smtp->auth($cred->{'username'}, $cred->{'password'});
> +				1; # Ensure true value is returned
> +			} or do {
> +				$error = $@ || 'Unknown error';
> +			};

Okay, so here we try to do the authentication and if there aren't any
exceptions we return 1.

>  		}
> -
> -		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
> +		# Unified error handling logic
> +		if ($error) {
> +			# Match temporary errors
> +			if ($error =~ /timeout|temporary|greylist|throttled|quota\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\s+error/i) {

Where do we get this list from? Regex matching errors for the type
doesn't seem like the best way to go about this.

> +				warn "SMTP temporary error: $error";
> +				return 1;
> +			}
> +			return 0;
> +		}
> +		return !!$result;
>  	});
> -

Nit: unnecessary newline removal

>  	return $auth;
>  }
>
> --
> 2.49.0.rc0.57.gdb91954e18

--000000000000300be50630044b99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ccb41dee62917e80_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUFpEa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnpvQy80bC84TDJyYTZxYU5XUHVBZW9uRWc3cUpDWgpxam52VjV0NTBG
NDFDeEJteEJISHVQZXVjYTRaVXB6c2MxWW5WV0NrOUdqWU9zYS9NekJQNnFuS0VKd01iVUZTClhq
K3FtNkVia2V6aGRnV1RYUVFoT2p6SEpmSFpadVBZeURsazk1TVlZTXZmVDVnS3VscWpzYlNNTXMz
Z1JmS3oKc3F4enlVL3c3TWhzOEJuUTAxbklQUmZyY0lZSE93MzdLd1RBYy9vZVNPbk1uTnN4V1NQ
RnhsdFdEUEFoVzR0SQo4QzZROEVMYXJrek92TWF5WlNKZXlXTkhTN2ZjTENueHNiQUdaaEoyS2Zo
MDE0bmZrYU5ZKzduVEJ6YTcwdVdPCmZ6MkU4WEhtT3pQM05mamVra3czZExDclQ2UWZ3YkY0cVcr
VnlTL3VrcVJ6QS8xaVBobWdDdlIrSTY3NjZibjcKTG5PN0NEdGZqTm1CMHNrdkpYQVY0eUY5KzAz
NGd0LzhuTFdqRWJ3bFZCU2VUdTZFc2tHYW5MRld1MTFuSWl3WApPWldqUWpycWtPMS9KY1N3WVFP
OEh1SEF2Q1oyNVFZQTJpR2hBOEhtNFQ4ZDNXTDlUWXcyN0pFd3ZNWk9EdXV4Ckw4TjEvOXQzMHZo
Rm5EVzQ5dmpPRkNPTmR6R2RUMHgzT2dpTFpwOD0KPWgzTFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000300be50630044b99--

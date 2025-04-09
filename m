Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB825E45D
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201213; cv=none; b=STPzoRYonoSY2SXUXZwU1rIhUDEHIhGprIhdh9EjJeWglLmedEO2EJDC1dR/XMyhFY/zXb1k8j2RGoLwGp1fItk4g1Nyu7kwPzRQgYI3LnDPa6JlzlFhkie6I8PUWNLBQm/GkVzng1wHB2EQo686ct72sXRlPn3x3D0O9zTpMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201213; c=relaxed/simple;
	bh=mMZisPBNH4/WLwehCh82Xd/PPNwO65YBX9bQ+9i+3W4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=u0gdL6mv6TdUJw0IO29+2zyzgHoPqYHmbrPreI113vYK1QhYXZfMXqUwckCaxe8oTJkgvBrtn3HsZixWefYiH6/VX1KPrKRj3bgcTij8P/R59hOrpe7F4nKZOtpiAey2ewB55a0aSc+zSqbhGZBp3ai/zY5IuqNKVIy7DkhPJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5RDiunO; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5RDiunO"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so37549246d6.2
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744201211; x=1744806011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxjdLa8yepVkpxMwC7Vd94uWYSbh2Ocv1tCYdzncMek=;
        b=h5RDiunOc/UuEJjjGHTQDPRuyDTqdkQrscjO+6pFnLeF7hVjbvs1tQ9glM/9HIYN4l
         b7yGPX71SN8jz09BtcqHu9UfR9uOge2k+RAKohT/9DqhmjWBIuTiHsJGOzZMW8IGYW+z
         h/NPF0wyRjVQJlDSErsyMjkaaVOKcvAyhW6qeIf9UVCplBzL/Nq4b4aWDyZSAuY1Ifjy
         YBUg2V3SYwa/6nPIoDmrvOkvanXh5NRZF+xukhc8AqfsocT6r5GuZGvDJmbSrha7F+b/
         iWLBdcnhb1AO/yrb4unyZt14lJBsP4H/Jhb5bSRKh15w9XnKsWtZA6LrEN1JGm5AE0Ht
         L23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744201211; x=1744806011;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxjdLa8yepVkpxMwC7Vd94uWYSbh2Ocv1tCYdzncMek=;
        b=WhcxXakz/Qbed4bk2OvaQ14KdbOk1+EUaLsduaIlKqwY40nfcKJw9jljnpVK1k63r7
         WQIHEYfbc69Lf2QSGubZT28uRA4ze5hD/VUqd7jZAxj1GQ+JdV2rUfX5zgPyQLcrU90T
         yZ5tonPDzBF3fExmZq1pSPD3ZEt7bahbd5EICzHWMVlgB6LGF0M/iZ9/jnJRp5AsGohp
         IRAeIXKV6fj7yeSKuEGPbVD/IDObaoVvSnByh7iX2FMWNl/8fOwFqoL+tH0AubBVjhfl
         dlDMXs/zwU3WGsybiwpQ+wueMPO6qYj9jOUt5UIAoS8PDgfI7eA9UTSodr8VYwi8R7Sb
         66Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXxRlOX5Di7EALEMC5Euzbh5RnvOBB1gLkGtrr5EBzAymidQNVLisIjmUug8vQVGhGgyFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMb962VSajVttZ4vWQAA8xYMoTujY8te0D0VNxg6iou5+EU06O
	PPahZQZbu9xgifWvIWT9HnMSDEwKsTIdh6IBxUOd+RyeIW3tMxju
X-Gm-Gg: ASbGnctVeqK8FtOdS4LQyteK+KpGnkPOeXFKDOKdMhW+CdejNpN4Y06qJOgdR2QlQfM
	VGo2p5a2+ZetFrlmJlFbjhVAGlZ/iMFIKi/S7P3A8S5814YbHTiZSdzOVyZGVCi2fM7DX2njlZ6
	Xtn6QAjjV+Tryov+hCkT/pGIsbumBpGWVlDMA5z2oRFzfgODBbrUJQgWlFZU9Qaiwku5HFL8Ivu
	WHhw5JYrM1fX6CP3e94kJ+aeNfITFbDRdx04GTCvfE5U+f7uprbzOCWZ+lVjlAmxtbjb1O9LSq0
	dwXUjWJfTkU3cJ4VMSiZcGGFKVF2qfWy9jdPYxb1UuC6E9usJXLSLA95494uHi7GXl5LsVxx5uT
	JmKMZdmzKzEIEiOnkXg==
X-Google-Smtp-Source: AGHT+IEKJE9+8leL6E+p+3BxoJrLaQsSV/QTUW9GXtDKDUrSfBq3zzjFkPWXn8w7Go3528g4l7WyWA==
X-Received: by 2002:a05:6214:1250:b0:6e6:5efa:4e01 with SMTP id 6a1803df08f44-6f0dbbbd667mr45968896d6.20.1744201210587;
        Wed, 09 Apr 2025 05:20:10 -0700 (PDT)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea10676sm6500686d6.106.2025.04.09.05.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 05:20:10 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <75b9457a-3da4-455d-9612-b83f25d3c854@gmail.com>
Date: Wed, 9 Apr 2025 08:20:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: [PATCH] git p4 fix for failure to decode p4 errors
To: Fahad Al-Rashed <fahad@keylock.net>, git@vger.kernel.org
References: <pull.1926.git.git.1742440852765.gitgitgadget@gmail.com>
 <32b401c3-de0e-427b-83b7-eb5a5b315db1@gmail.com>
 <fdbb3f88-7321-4dc0-9ead-7ed9ef0fc995@gmail.com>
 <339b8557-d41a-4a40-912b-eb2cff63159f@gmail.com>
 <7e5d0613-d116-4e60-8ccf-efb092776398@gmail.com>
 <652def28-2e97-4177-9197-bd93caa57886@gmail.com>
 <A1896FA9-F09C-4099-8A7E-4AFFD2DBCF7F@keylock.net>
 <1948dfea-88c9-4e4e-937a-e162ad42d8aa@gmail.com>
 <501e308d-61b3-429a-bc4a-6f0c81455279@gmail.com>
 <e91c0859-da89-47a2-b0c7-ce1943318529@gmail.com>
 <CAFd+s4USsHPaepvfNtjm5VGieuH89zbW5Yj+OSXD8THxkj6tTw@mail.gmail.com>
Content-Language: en-US
Cc: phillip.wood@dunelm.org.uk, ps@pks.im, bekenn@gmai.com
In-Reply-To: <CAFd+s4USsHPaepvfNtjm5VGieuH89zbW5Yj+OSXD8THxkj6tTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Awesome, thanks!
Could you please advise, what are my next steps to get this change accepted?

On 4/9/25 08:06, Fahad Al-Rashed wrote:
> Hi Nikolay,
>
> Yes, the test passed.
>
> > ./t9837-git-p4-error-encoding.sh -v
>
> valid commands: submit, commit, sync, rebase, clone, branches, unshelve
>
> expecting success of 9837.1 'start p4d':
>
>         start_p4d
>
> waiting for p4d to start
>
> Perforce db files in '.' will be created if missing...
>
> Perforce server warning:
>
>         Pid 277404
>
>         Operation: topologyRegistration
>
>         No entries made in db.topology for server address: '9837', 
> dest address: '' and serverID: ''.
>
>         ServerID for the server should be set.
>
> User author saved.
>
> Client client saved.
>
> ok 1 - start p4d
>
> expecting success of 9837.2 'see if Perforce error with characters not 
> convertable to utf-8 will be processed correctly':
>
>         test_when_finished cleanup_git &&
>
> $python_target_binary "$TEST_DIRECTORY"/t9837/git-p4-error-python3.py 
> "$TEST_DIRECTORY"
>
> Could not decode value as utf-8; using configured fallback encoding 
> cp1252: b"Path '/xxx/git-git-p4-error-decoding/t/trash 
> directory.t9837-git-p4-error-encoding/\xfefile' is not under client's 
> root '/xxx/git-git-p4-error-decoding/t/trash 
> directory.t9837-git-p4-error-encoding/cli'.\n"
>
> (this warning is only displayed once during an import)
>
> ok 2 - see if Perforce error with characters not convertable to utf-8 
> will be processed correctly
>
> ./test-lib.sh: line 1007: 277399 Killed                  while true; do
>
>     if test $nr_tries_left -eq 0; then
>
>         kill -9 $p4d_pid; exit 1;
>
>     fi; sleep 1; nr_tries_left=$(($nr_tries_left - 1));
>
> done 2> /dev/null 4>&2
>
> # passed all 2 test(s)
>
> 1..2
>
>
> On Tue, Apr 8, 2025 at 3:13 PM Nikolay Shustov 
> <nikolay.shustov@gmail.com> wrote:
>
>     Hi Fahad,
>     I hope you are doing well.
>     If there are troubles with trying this on your Perforce system,
>     maybe we
>     could think of other way verifying the patch?
>
>     Thank you,
>     - Nikolay
>

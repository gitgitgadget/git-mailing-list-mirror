Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AEE1F4E57
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131368; cv=none; b=rlW+FDRxCAfKkN4nYltMyK+v9p0Fm/h/us+tKBXMEhd+3D49woKOtGO8qlr4fI1OKL/TTtvdayI5v/x38JSE6osIl5O6UxzUO8p8cD+3DdG/76JAm3FFJ9c81Y3ua4PVLReWrr3/iL9GQJWRrkctd6r7ZezIN0C0zcrdA+QKd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131368; c=relaxed/simple;
	bh=1B7ktXJ9d0TqfvnObhA2+1bm3JNDcP3Qimu/eleBLMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A3K0H+ds0FEehPSXj7QlOT1BfOfbq6uGMN39N9x0ue/Ox7RUUKYlFz1IIotQ6V/+C/40vrD481Vuc9UmIt5XQcAvfTVqfa/Z1rXB6vNN0SDdYyejF4WVOcLt03xFPT1op9dX0xxY6R2s1rtbpIx+/+tkSFdpLHlQWbAxm28Jf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq5czSij; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq5czSij"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70dbe6b8142so14618696d6.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756131366; x=1756736166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71D4ntGQJTrj8RGbwELD6UO5E18GXxhqt7qWUrcAhBc=;
        b=kq5czSij2O8NINgv+YVdCsOA8/pIBy1Y41t6PSXhudF9NQ+8uwUeYmeRK8TGRmbbBv
         MBSMZscQMLxB5vl/huwtNfVv8xPBAmcwos8Iw+g3MrG7s4SfD6M6z3nDfnrp3NyQXcm+
         4Io44Qcno0KV+j3ISXghRera3en+ppXhIPBb/0zB1MarJIefuGxFB+gf1lwmm+N7eQKp
         ooLY7OA8+nCs/9JEhLjpm3J+x0c7QSVIE/YETUMF6jgQONspuNE52EH7CuCxsSO5Tq8O
         eN+VCN0hQabCT102qDVFwywPVwGzVx5pcpEli6fv8kQXjz+r/37AKlWW3TS9txy5ADIC
         lf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131366; x=1756736166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71D4ntGQJTrj8RGbwELD6UO5E18GXxhqt7qWUrcAhBc=;
        b=ha4pz8sUWeJQbmPI9jRlYyjveNHzStsqMI/yTuypRUyc3OzW51P31VT4aNB+wRiw08
         RVLHgY6leIGQSLjDHpIYI+4cFufugMXy+0mNO98Gltf3VW1WDCfsEj0QJBDvxJk89KdF
         DEpSJbYu/R2MG9ZMtHJbUzapRbV4uU3JaV4/ONNtRrIKHAJkMNicpyduDeeDdxV79pvl
         rVlC3VHKGXnvd2fipUI/EPMs4kCome4delUAxtgPvFp8bcNe9dHgSYGEZfNkdVdyTXhY
         IJVfzWRlaRHrrHCHhjFWNn3sojhdtJqp3da8/aT/P4tDGSQexNKzsvLme3j8Q+j6JbuT
         rSvw==
X-Forwarded-Encrypted: i=1; AJvYcCUgbGogO5k8bIF+7r9oyRvJBHPIm+CUMkADlO2P3q2vOTSYgWg5G2ZgNqRbN8qwDeyXKuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEU2LaEuIsUpoCTeKQJFHEeVRMtZuyi9AfyO1sJsvZ35NCpldI
	cYFGTZZWswv2ePQMQN2RhM73XUTHwNkJ7HDHJf16j1TgNfIeeWGjxGe1OOO2Qw==
X-Gm-Gg: ASbGncukfV3AzevEzVkF+6/Q1hfa2z+452k+WiUxSNMwFR61v43MraGK51lQGntv8JC
	ye54xsWcetpivOmAbd9p9Kb4lR//VqYjj4RICl/2ZM2uT0peKNo6nx9FA+5TjBMdAaOrN5h+Bwx
	rO8hh6yCHaSYUU/NjnRFiPDdw6YSVU4FBgmOciqh699TCUhzkx1vYf6Fs8IhPUqqUooBHgk+w5F
	f/CvPt+H9rW5goTAZ6wp7bAEKiX+Lp46wf48DOOCx4Y15tt6kRH72H0CIK+t3d9FWWMKx4C5998
	2YlWqwVXoEzCMF46Fwf1j/kUpowSu9rMTrXpIUFenTzo5anKzdpksE/HZ7APoNaD1acEZ8hD1qu
	4ebOW3j1bYgLAvOcYJ5M0TAS6rT/LGWrbraY=
X-Google-Smtp-Source: AGHT+IHt9tD86S3ACmZhFHYZvCZ7FFbX3cmLLYCN6RbdWXwB1x6zBeYUKHbhkqD0mdWBgBbrcxVCgA==
X-Received: by 2002:a05:6214:2421:b0:704:95c6:f5f1 with SMTP id 6a1803df08f44-70d97200c8emr162577056d6.34.1756131365926;
        Mon, 25 Aug 2025 07:16:05 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da7147253sm46699716d6.5.2025.08.25.07.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 07:16:05 -0700 (PDT)
Message-ID: <8adecfbf-8593-4084-81f8-d7c23950e4e4@gmail.com>
Date: Mon, 25 Aug 2025 10:16:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] line-log: optimize merge commit processing
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250824190644.2573279-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/24/2025 3:06 PM, SZEDER Gábor wrote:
> The first patch is an optimization of the line-level log machinery.
> The rest are cleanups in the area that I subjectively consider slight
> improvements.
> 
> SZEDER Gábor (4):
>   line-log: avoid unnecessary tree diffs when processing merge commits

I gave a detailed double-check of your perf numbers in a direct reply
to that patch.

>   line-log: get rid of the parents array in
>     process_ranges_merge_commit()
>   line-log: initialize diff queue in process_ranges_ordinary_commit()
>   line-log: simplify condition checking for merge commits

These cleanups are very welcome. The whole series is excellent.

Thanks,
-Stolee


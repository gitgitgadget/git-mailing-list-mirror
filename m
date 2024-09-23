Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41E184
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727056212; cv=none; b=YDsc2lwBStUHxbgzkoTKTmn8LOMSxUsZvN2ZH8Q24oJbQTgClDIlUe9ER+bykfXJLvc95ep/kzNbNYewJVrIOmMs1l7RNoDwKkLThyzQlCrwJDXzhl6dY0ULxiYUFQQ1B0b7mp95S41AqzarrRtqXI0iTgn5whU6tjvmMCetFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727056212; c=relaxed/simple;
	bh=nN7r/psPMsmDLDJfa+oa0wSM8MU3MwNqhZgcxfKa7eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5/xq1gAADieXXhNVRa6va/l0FoLvasdj6Bd0T76BDtaFbNns5F09PtNNGF4ix0SrBEEEHhallXKKZ6mfn+GACvGOAzwjZudVCv0X8YCzd/NxbWiHMIrWri6lp7K13zuqsShKfmzOkYlOTnKqKES73YJHfSqMIMu4XPrhwHRjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNXPLwRz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNXPLwRz"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-711009878e2so1649688a34.2
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727056210; x=1727661010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0mX/ZAUFUbT0uwjri9bTAbMjf1//fWYCstLpq7bgSw=;
        b=WNXPLwRzKx/+EdsR3iwsrGavRmoiogzLQMyceVT1HdNzYJM+La8WZaERkIqqfkpcag
         IBmuDsu3BtVGLUXF1Jhw1Ie3+B0qPmgU2u4pUD6MgeofSEzWlU+NWwLlcGTbbfRSQeI6
         jFSSVeDahT+Pfnhzut2cGeavM4O9O/IBEy2TuqV1N5n2qd7aeXjld3BWKPVolGbIem5Y
         KmF7/bQmSLFQM5+gd/0zrBs0UIQ3LjA6ewQv+ZtQ6tda10jnCF3vg8sra2cbEIr4d4ZK
         X0hN0K3ESVgHwL5iawvkPl8n2BXl+Ol7qYXSrEZ12nUzRaQqU9gVZaA78k9P1QVFHeNM
         y+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727056210; x=1727661010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0mX/ZAUFUbT0uwjri9bTAbMjf1//fWYCstLpq7bgSw=;
        b=hDJ57wfazcuLat6SjqVpYaYJ/nVhMStBi0cO2Pit1Ck7tzOlweIMSEHeIYajZrOdoq
         1sFMfkDcMbQJ8Ci9YSp4YcZF5EuXfcqsU0BC9OGqGwrzVAeR9gJzVnNGo6wRXlLm3Zgf
         AyGmTFNRXbMYm7LGeA49Qbpps0hi1cCvK/GAifkQBVPy8oC3aIYZyVNqNwtut6tQUagF
         Nxkvai1Tjv+eUYGR005Oimg81rnG6UbkXnR6v02CQOKFI7Zer4FQvKwDkcb6Zu2NGFi0
         ir8otoxinZ4fRh5kznqb4QB/QRp49d0L+iO0ZjwEaiDdvvxsEQIOFZWEyCisauu0CbjZ
         yaUQ==
X-Gm-Message-State: AOJu0YwJu+ESGW4sIeTdE586/48dAM4iPRX8bZWYkIaN95AFkrNOBFrV
	y61wTXk7g9QKvd8JimA3ZVIXTnGVhDNoyQcsWTZF1YK5+foy/wju2sscHg==
X-Google-Smtp-Source: AGHT+IGUBgkLk51JaVE73gV+7G1HFVPjDCEiHjZNRltX9IBTAK85yP3jKNbIGWN3HCxPrDVwEaF0eg==
X-Received: by 2002:a05:6830:6d0b:b0:710:dcc2:dd13 with SMTP id 46e09a7af769-7139349f828mr6838213a34.13.1727056210347;
        Sun, 22 Sep 2024 18:50:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1803:188e:65b0:6321? ([2600:1700:60ba:9810:1803:188e:65b0:6321])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71389b48bf9sm1972217a34.5.2024.09.22.18.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 18:50:09 -0700 (PDT)
Message-ID: <24d266e4-4279-42fa-871e-c843ba6d4f5e@gmail.com>
Date: Sun, 22 Sep 2024 21:50:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] p5313: add size comparison test
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
 ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
 <999b1d094241b0ba8d6924ac6976eafc64c7d4a6.1726692382.git.gitgitgadget@gmail.com>
 <xmqqcykz5mrg.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqcykz5mrg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 5:58 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>>   t/perf/p5313-pack-objects.sh | 71 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>   create mode 100755 t/perf/p5313-pack-objects.sh
> 
> "wc -c" -> "test_file_size" or "test-tool path-utils file-size"?

Thanks. I was unfamiliar with those options.

I will squash this change into the next version. The use of a
variable for the packfile name was important at some point while
I was testing this with various repos on different platforms.

--- >8 ---

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index 5dcf52acb0..bf6f0d69e4 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -25,7 +25,7 @@ test_perf 'thin pack' '
  '

  test_size 'thin pack size' '
-	wc -c <out
+	test_file_size out
  '

  test_perf 'thin pack with --full-name-hash' '
@@ -33,7 +33,7 @@ test_perf 'thin pack with --full-name-hash' '
  '

  test_size 'thin pack size with --full-name-hash' '
-	wc -c <out
+	test_file_size out
  '

  test_perf 'big pack' '
@@ -41,7 +41,7 @@ test_perf 'big pack' '
  '

  test_size 'big pack size' '
-	wc -c <out
+	test_file_size out
  '

  test_perf 'big pack with --full-name-hash' '
@@ -49,7 +49,7 @@ test_perf 'big pack with --full-name-hash' '
  '

  test_size 'big pack size with --full-name-hash' '
-	wc -c <out
+	test_file_size out
  '

  test_perf 'repack' '
@@ -57,7 +57,8 @@ test_perf 'repack' '
  '

  test_size 'repack size' '
-	wc -c <.git/objects/pack/pack-*.pack
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
  '

  test_perf 'repack with --full-name-hash' '
@@ -65,7 +66,8 @@ test_perf 'repack with --full-name-hash' '
  '

  test_size 'repack size with --full-name-hash' '
-	wc -c <.git/objects/pack/pack-*.pack
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
  '

  test_done


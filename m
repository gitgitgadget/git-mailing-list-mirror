Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1211BD4EE
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933520; cv=none; b=hUj/FqYutuppFYMWMhg/k28PUlyZUzoAaVneylWO5med6XR1vcL2uiHuTELZjiZy9x7C+CGYV+B+FuT2lab733Tk5/bkBbaAoQjE/RRJEJ3404cNqJ/nxgv5OA5GkHG24DkwwJs7VipfkTD5ZythSrlRJeeomZiQo/VZWnXp/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933520; c=relaxed/simple;
	bh=v64rAACmOhxobXFLbUoNopGGh8kOWJM0nWAuGNfVZ0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI2AT5FV+r6KvyPDuPmTeMlw2MJGwTUNNmVZbZsVKbrJsuDdM6xtKRSBogJxTCsNUAQxS/PrgDxgwuCULEtSC4Wxg8/AqZQalbr3szAHme2qv/uEzMfITjeNQm+fm8pXimFc1J4gWhMSmDpHOUzQzoEP+3k5Y3Q/j+65hWbbe2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9GH5vSs; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9GH5vSs"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a20b8fa6dcso27563485a.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722933517; x=1723538317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUzjvLNCSCgcrwFKM3TG9RSSu2iprcNSsvt1agSEVRw=;
        b=P9GH5vSsuNzB/8wDm9Nmy2w1CMorFWZuY3crLUBMGUeGPlUq/rizF7Fkes76issEDH
         lv2VxRMrXI8O9BtVRok1h/0FlCIvmvQ0h9L0aI9b+F7lEJy4zv34ILgVanwQRXeJpyZq
         M2OnIhhngq35xWuxYTNQMwOUOGeLDk5XG5hIizoLXmzP5yAnOCobhnXrgwuMUIPNeYIC
         7/MdY4l22moOjOgc/Fe4lbYkqRDI2CwatMSvlZc5/jrM0sZ7yaX76yrTbOd/KRkENjhu
         bLZQbWGCTWzS2GzeU9wggegKarXCogcQToAqBq/QfmaAHfVPXIFbsMY6juRFMwr2n4xV
         O37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933517; x=1723538317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUzjvLNCSCgcrwFKM3TG9RSSu2iprcNSsvt1agSEVRw=;
        b=MEOcNM4SHqXfphMa/aa/fRrkmPSmjTWuTr5SitxThHnOTeybBFSaLxaIzAa0IBfuBh
         UbV1xQEI+kS5K1Fgy3dZBXnjp0D4R468MWAnnF0b5uffXHz6POO6cjNu+zVCKI+xxtW9
         B9wy0PR/hxxWyqYvsbrFrRfgpuTaRDndKaUtQeox3OdyMzYE0D1XM9yT9/Z47FQZEuHm
         UbjjgNIYl6ytY0GUOr3x3Bq86Wjp/c4sroBe7hsr8ZCbL7yXTtbaF18N/2FSs7ikxBfc
         6bazU3WFGTm1nT20VdY3itDodjyAKDMmYNJ947oKxc2OgCf9X5Asr1+zwYDdTozauy5W
         Sj0w==
X-Gm-Message-State: AOJu0YxmMCj7ejr8K8ohS0QMLhnBZPYUzKijyzjwXYc/pP7vVysjRjF3
	Ie0xGJj4Xz5Knx/HkKjClaAWe9afRrJeztTYM7SgXbfb1zwEKNmI2VEjo0Vd
X-Google-Smtp-Source: AGHT+IELYJvS41jxGwt/jfdAPMj1rFk2xCagJEEsRZu/9f0PTTiGpNm9b7L0GBDbYdBJsFAJeB89JQ==
X-Received: by 2002:a05:620a:408f:b0:7a1:e214:34df with SMTP id af79cd13be357-7a34efdda59mr1669341685a.65.1722933517263;
        Tue, 06 Aug 2024 01:38:37 -0700 (PDT)
Received: from [192.168.1.6] ([197.40.163.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6d7ed8sm428638585a.17.2024.08.06.01.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 01:38:36 -0700 (PDT)
Message-ID: <3cba795c-631b-4e86-a1f2-ddefe76ef0f4@gmail.com>
Date: Tue, 6 Aug 2024 11:38:33 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] [Newcomer] t7004: Do not lose exit status to pipe
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
References: <20240805235917.190699-1-abdobngad@gmail.com>
 <20240805235917.190699-3-abdobngad@gmail.com>
 <CAPig+cS6-gqZbJSz3wBcummyycJVudKybVZW=D33WHk-Fa9ytQ@mail.gmail.com>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <CAPig+cS6-gqZbJSz3wBcummyycJVudKybVZW=D33WHk-Fa9ytQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/6/24 06:13, Eric Sunshine wrote:
> On Mon, Aug 5, 2024 at 8:00 PM AbdAlRahman Gad <abdobngad@gmail.com> wrote:
>> Split "test-tool ... | sed" pipeline into two commands to avoid losing
>> exit status from test-tool.
>>
>> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
>> ---
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> @@ -97,7 +97,8 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
>> -       test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 | sed -e "s/^.* //" >actual &&
>> +       test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 >actual.body &&
>> +       sed -e "s/^.*   //" actual.body >actual &&
> 
> It's not just `test_tool` we care about; we also (importantly) don't
> want to see `git` itself upstream of a pipe, and there are many such
> instances remaining in this script. Here are some common examples:
> 
>      test $(git tag -l | wc -l) -eq 0 &&
>      git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
>      git tag -l | grep "^tag-one-line" >actual &&
>      forged=$(git cat-file tag ... | sed -e ... | git mktag) &&
>      git tag -l --no-sort "foo*" | sort >actual &&
> 
> By the way, these days, rather than:
> 
>      test $(git tag -l | wc -l) -eq 0 &&
> 
> we would say:
> 
>      test_stdout_line_count = 0 git tag -l &&
> 
> which nicely avoids placing `git` upstream of a pipe.

Thanks for the review. Could this be done in a separate patch series? As 
modifying a patch in the beginning of a patch series requires lots of 
time to adapt the rest of the series to the change.

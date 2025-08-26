Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CE2BEFF6
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226456; cv=none; b=rmfsRWkw/uiui2hSIguzciwPkEb1wNcg75NsNP63SLhHJroBejQK6hTXZ5kTxakCer0tXQa59k+4yeGmrwdrDilAvN+oHBprRav2vBHiHP2WQxJ36cgXFrXUSFLtLQSyL9XF/rkA0NEchQp3pjyIdHT8wuJscp7LYgkTuCaK55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226456; c=relaxed/simple;
	bh=4D4Kc1mMMVC3uXVrrUdi/kxcnYigvacsWd/uOtxHOHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuYhDUSytQs0NKcBI3ZyICtZqnlK6IHe+ZfFdM49j4Cnwi6LBaiAZN7NESeaL/Pa63plhpO3yFMq8TGLPS4nC7/b3De5kWrS2bx/G2dfVA//vlEW3VRzj0V9M1dkAoa4FSCto/D4e474ndCFk+VSBoOr8Lsg6NvykGp9vN4v360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhIITPi0; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhIITPi0"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ddadde292so3448246d6.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226453; x=1756831253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbF628aM0BdHks2iLAKGOVnbLSS62UC+YgTXiM7ktoE=;
        b=VhIITPi0rIKCHRzV8KyS4jYrsaXmAxAMrsyWOxqgIFVh0J5RfJ+bWD1i8if+OGzj6M
         KPtJPqH0i8xYIFlWB6EOvs2cDsh0X4ehsetJR4p+FOHCql9IW04PbfsruFnMrpABmehu
         vh678afE+vmBcSg6lSutbqYcga3tq7F6fB1X+Qd4WMcuOfoBz7Qz/HJGTvVqkRoxvLvs
         etL70DxumX+pN7tGc00TynVUbIIRc6YJm/elIoTPNj1ZQj9LlOcibtO3U5e8lhEe7rE9
         MELA2YzkPHPzQXLWferRTeLntBnLFyg/VI7vUTO+qKTFa3D7EmJnM6Wbp0QfKceFdl7s
         cxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226453; x=1756831253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbF628aM0BdHks2iLAKGOVnbLSS62UC+YgTXiM7ktoE=;
        b=VEfJIf52lXT4cHKJfrOiw5zI/sQo3icZC9oTBnhqJUnHazWzfBd1tM/26pdWpusezV
         lCrZ6+tn2D/TjTBY3auOmlNP5pvScdrYOPJltzcjsAktl+J7h21kOCDPveO+4nt1M0Zy
         i3QTedM3nvrCEuTHqdaayQio/WiQjAtwj1IrPDRSvxTrjWuQBA2XGLLpnAfd0AxhFVYs
         /DUYB06MJGJfurRSRZIofE/Lf9ItsUC/+MzCErHQT/e12q8th85A9CdvKOitposestns
         6KDyE1H10rg3ucb/d18lhKqzjBaMfBZBU4shjZjXMhFo4C6YOMDwwdrerzdG7aIQSHi2
         VHeA==
X-Forwarded-Encrypted: i=1; AJvYcCUd2USgGC3jlsQ46FjaQroUIWOhi6SyZJea0+INIsx5cHFvJ+fBe1/HBG8C4kGIQSYZmd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYjk4DfT2YhmU6S2RIinoqa1NxE9YFRPjjjKIb9l1nijvMRd2
	tV96X1g1lBSPTFYyyTxaL4ETknmX1SNed61/6Tg9GhN/jE5Tp2dO6TejfrCMlw==
X-Gm-Gg: ASbGncukqtcmsk47wIywlQKb9y4hVIMUW8AGWUqm1YlmrwhcVmNtEw4L8uLcDLpPTw7
	E6gsXIMYWCW+w0xMdIBGze5aWsplms2DVKlHMbY+gGMwrnAm8HyKllOvzUA15rgbzhgaUt6VBoj
	dIBL5O5T6Xpg/B4VbOBcDNnHks61py2pipIaxOD33GabJESi7oSLxiB6PhJkcBfSbHwqMEUEkge
	HNTreTXbO7JiPQCkqP2M1OClMgDTplP68MdSpVnNMs/+2mmfkvDh8HmGZTnpKssoSAa70eHEvn3
	2oBi2J5XPfj+lI7EcvJc1ZESHzTwYX6ZAvbXDAmZ5ImxKYmkAaSjubv0q2xnJHeCje1Ni7vRUKE
	lIkLYOSj3jmc+1BIZ8iNo73tYrgpxQ/bHdTjXQIkSNg+hyw==
X-Google-Smtp-Source: AGHT+IG9B0Vj6zu6J7Y/65V5oWrLdoJZgVZQCl86nWJsXgsEfw9N9dQncSTPXheazkt3yvgcavjJcA==
X-Received: by 2002:a05:6214:3018:b0:70b:af81:690a with SMTP id 6a1803df08f44-70d970a5717mr180188886d6.5.1756226453388;
        Tue, 26 Aug 2025 09:40:53 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dbffc1f71sm42159906d6.10.2025.08.26.09.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:40:52 -0700 (PDT)
Message-ID: <c1f2e7b1-7583-4e1e-8f20-584a7a768286@gmail.com>
Date: Tue, 26 Aug 2025 12:40:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ls-files: conditionally leave index sparse
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
References: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/2025 12:12 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
...
> Replace this global check to expand the index with a check inside the
> loop for a matched sparse directory. If we see one, then expand the
> index and continue from the current location. This is safe since the
> previous entries in the index did not have any sparse directories and
> thus would remain stable in this expansion.
...>     Here's a small sparse index performance update based on a user report.

I know this is small and somewhat niche, but it hasn't had any review
or been picked up in What's Cooking. Could someone please take a look?

Thanks,
-Stolee

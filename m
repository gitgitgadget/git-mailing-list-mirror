Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7A1DDA39
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500139; cv=none; b=UbsaXOmSQrxHSalDWyg++XFXIF74CwJJwbDiX0AjadPyLofLvNywkKNftPey+7weILUpfvp2EWrImsViFA0WE2bDqMGautUwuKdQq1V1xqSb6JMyM10RfnhLfhs6qoG/ER4+9xVMNZrHBlT79N+YARI8gJoE4PyFKmjTeUhI8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500139; c=relaxed/simple;
	bh=/utpsqwR8oPalpPmasJ9e/duxmF0QKLjveEBD4HmcYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmRwQUg4x8bi/tjJY4pytsPPFt6kYNkfuF53cCSVTHTic+JzeN3f/jktw9dsn3RkNAk2KVKSLvu/6kdsjWlwoTesbBSZNtWI1N/pISRShe1XPu8pnDntkNoYtD7J3WzbCE4IIXGlyxkYeNaIStRVILwtwDKUELMx98Dd8dLLL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REkJ4nOE; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REkJ4nOE"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e63504bedd0so899232276.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742500136; x=1743104936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3V9iawZX/ZzFAzw1IOawHIBW9m25Y9Ag1I5ncUXMRM=;
        b=REkJ4nOEOec7a0c4D5giX8Cdhw776sYhhRKIFjgfDUws1whK4tnws9JTJwK4Z7xbNW
         TmcTNvJ+I7EJoiwFtS9w/80R9DmX+KC0vuSiifJG4skCcmcxRVzqG/usR94pXR1/rMtL
         +Ni5T/jTxbaosM0DVMTwzq0XEi3feNRvbybzfk9uBf7o8aNmqmVHDYWbnfKrbsN/O+Tr
         9/gpf+rqx3ZBfwsXcqCYUtRasDpOv0Pa4uKFccDKgO0NuoI1HCBEpGlSMeRI593qFwO7
         gPst0eSqyvk7hTzHxk3uMI4igyHzTWXKVfBqJrit+VjLGxoV8VKX9DWywQR23y3c2smZ
         ZvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500136; x=1743104936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3V9iawZX/ZzFAzw1IOawHIBW9m25Y9Ag1I5ncUXMRM=;
        b=P+EN9OP2jZO8wAynuNlcZqBW0Pgdd2R3kLM8X+XpyvaRqFY4iu3cmOokjq5WsOrUe6
         y8vyUCGE29chxtZSIpqdkt/fdgWKQ2Ft85TmS+RX/AYWhxSc15ejoxHFl01ZI0ZNoJlT
         14aKFLRK13AF6jtam03JMRo6WEFn6ZDuJq884aJRoHl62kl0mOBliADD8dAae5TJ/Ifl
         qrWN9+tBp5ei4YkxZeb8bvsxwGt7u0rI4RZrXdv9Wfkt2fB/e/R+e7j6HIvXJE9XcpVF
         wFBvcoRL8BFXtxHsZxig9sxaO3tfgcYuSIeQV/5N7rjjW6NPqU5HKffO67ChJUIhbeQL
         bFGA==
X-Gm-Message-State: AOJu0YwzXifqX3GNtl+VdD4v+Krkzlitij+RJaFSfx4QtO1t4xHRAaPY
	tnqqX+sj6HgQuKwQpOQkTdnDawgIm2DrX7PqYYwRGXPjj97UPcdk
X-Gm-Gg: ASbGncvqjvGUbN4aYLZ06Lb5RJRBrBWRMV4fqnVbC91xRvrbjS3SCcBcp+cZoWZ2K3S
	2Ix5D/lbkcOmWSSiZq8QZG1HLpFxRwcPCbKxtsJQmiqz4g5vHbd9k1JpTOjQ+9uWUP/URizdmOM
	HYUtSZSRXUs+OWq380g2g5XtHggU6zKWfHmZbUzTP9g9Dh6wCTRSU71jax0AOjtjp+h1uHx66j2
	YpBPsFqXg+aePy7YLENepZAVscvscFXptBEiJEv+vjJ9VehkhoQ9U+j6xrZLKFNUVSfGp5x9kyQ
	Hc7hVChx9VF/TYt0jzLBw24SM+aBdkpGwV9frhba7NbwdeP0xPq2z2SVkmI3kGzCRfOt5V95w81
	LI5oJxw7l9lw1+DR3Yk8X
X-Google-Smtp-Source: AGHT+IFnS1ZT7PRdN+GSjt3WHe+Fu9PdH3fEPGHh3K0aKTSxWwcWvEVd0YjG28QSa4QTiaufWcdqrw==
X-Received: by 2002:a05:6902:260c:b0:e60:9d5b:b882 with SMTP id 3f1490d57ef6-e66a4dac942mr601269276.27.1742500136518;
        Thu, 20 Mar 2025 12:48:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f12b:82ea:4a0b:3183? ([2600:1700:60ba:9810:f12b:82ea:4a0b:3183])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e66a4264fc7sm52811276.24.2025.03.20.12.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:48:55 -0700 (PDT)
Message-ID: <afa6b6a2-c301-45e5-a931-66d146392ad1@gmail.com>
Date: Thu, 20 Mar 2025 15:48:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] pack-objects: extract should_attempt_deltas()
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <a2ed1f2d4e3946c563f934fcaf149050d50f255f.1741571455.git.gitgitgadget@gmail.com>
 <Z9H2E9hEWgaS9NnP@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z9H2E9hEWgaS9NnP@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/12/2025 5:01 PM, Taylor Blau wrote:
> On Mon, Mar 10, 2025 at 01:50:43AM +0000, Derrick Stolee via GitGitGadget wrote:

>> +static int should_attempt_deltas(struct object_entry *entry)
>> +{
>> +	if (DELTA(entry))
>> +		return 0;
>> +
...>> -		if (DELTA(entry))
>> -			/* This happens if we decided to reuse existing
>> -			 * delta from a pack.  "reuse_delta &&" is implied.
>> -			 */
> 
> It looks like this comment went away when this part of prepare_pack()
> was extracted into should_attempt_deltas().
> 
>> -			continue;

Good catch. 

Thanks,
-Stolee

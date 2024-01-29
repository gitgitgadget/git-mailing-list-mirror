Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE36F091
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552193; cv=none; b=ecWkXd1jc7ClPKf6I9L5vIZIKrRu2zUn4HzB0XL/K/xcmWZUC7kjIPExjZBXoAh5SxSsUjI7U3Oxu4hJ+TIz5MC0Fw2vY50cHofR1BikXcy8jWq3lxUkI36fBlaanYvHq6IRrSgErU6sBamqd0kaP0vD9na1EvsDcU61MN/Rpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552193; c=relaxed/simple;
	bh=TeQPNjjVs1aUhw+yYN+r52vgoCRoOYb2/fCsmTpTi+A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iIrzzvQKe6YehL++MMpLBnHLmFbVjkJKA1GA5ftfP4AbzZCQmz0kAXsaIX1es5Bb+YMu6olYiUeITdT5NqO9s/+cPkesWT1C6OqU2IHD+RtSsG31g6C+G9JsBKop0iUZgsVy1ldayPqo0fMeHH0axNqBp3ZQ5M/L8JQXLHj8v3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbZlzCLA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbZlzCLA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1325396a12.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706552190; x=1707156990; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP1GYmHbAK4Y1Q4E5PV1HlPfqJqKpFkNntG8r+WfOAM=;
        b=YbZlzCLAdjzs4QDhpsFuMUph6qWiAK0x+ctDY5U1hgnZGNK0OgyyDecQjO5J1cnsSK
         +R6OAS4vilsnEjvLcxJXAtJchBMLR9+oVOfdKhmILgAGYFjln0bRF3HvlW66tZndQYB6
         8bC/et19/HRbv0YwNh7IqA7r9Jc9nVXj886JfwJH2ImS+kVsSz422NL9kyWfFgOQbPai
         X8WGeKIJeZwG+97FQQkHb4lM4len9eEsD252TxFToG0eqBAFz3h3wU+uOzvj+Gpd9CT3
         EeO89cB7qRJ+vbVZIkJLOV9qYCXwyUUBL3I4sTTU7y74diccyK12uAbizKCZnPIRs3v/
         0Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552190; x=1707156990;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JP1GYmHbAK4Y1Q4E5PV1HlPfqJqKpFkNntG8r+WfOAM=;
        b=Yehh6P6kIMU1e0kWcJ81ZvdTTXsOrI2MGcEzuC6OrSeKB5kaMREGBaldryETkeeW3t
         gqmE6XvbJW4/pWwplbZX65HetCszEBTd3S22eOyB+tpZ5YI86BRBdksHgVJo5xX8pHZb
         QmTB3ejY+UR70Cf4E2cs/a/DNnZklDEGcLt86cTPNdoA85vaBX3tYBe3SM90KUcSMNyw
         Fnr+sQhd2UtKs5D9dMOw4y0hH5z5yAMbVWUl8HdKQ8PSi0BgD8GhxjAcj/aE4zWoxEIR
         a9idvyt/jgNpgBYr9eaCUW7NUmIK2O/TA1TjVEhimGz+/yWNclUzEL+mS69q/aeH2avq
         9qcQ==
X-Gm-Message-State: AOJu0YwPvuEIr0fNgVyddta1zUdGFjwt6Pwk4JP+XKxP6plxMKOPQ046
	4wdoAFCrlg88b3OJiMXtaPwdJnTROWq2hv0W8EjPewSpoI3yBNAFatux+QT6
X-Google-Smtp-Source: AGHT+IEKhUMNtdFaThSzhdIEEYkdTPgavl9YnkZX+Kr4mpq6Mnn/1t/czZ+IK/FoLemPjWhNHENioA==
X-Received: by 2002:a05:6a20:958f:b0:19c:a883:4709 with SMTP id iu15-20020a056a20958f00b0019ca8834709mr2549363pzb.15.1706552190240;
        Mon, 29 Jan 2024 10:16:30 -0800 (PST)
Received: from [192.168.208.87] ([106.51.151.68])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e35200b001d8e41b3f95sm2080674plc.51.2024.01.29.10.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 10:16:29 -0800 (PST)
Message-ID: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
Date: Mon, 29 Jan 2024 23:46:26 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
Cc: Christian Couder <christian.couder@gmail.com>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Victoria Dye <vdye@github.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Git in GSoC 2024
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

GSoC Org Applications for 2024 are open now [1] and are due before 
Tuesday, February 6 at 1800 UTC. It's good to see that contributors have 
already started working on microprojects this year :-)

I could help as an Org Admin like previous years. I could volunteer as a 
mentor depending on the set of available projects that we're able to 
gather for this year.

There are one noticeable change to the program that should be highlighted:

"For 2024 we have the concept of Small ~90 hour projects that are a
  standard 8 weeks long (they can extended but it is suggest not
  extending beyond 12 weeks for the small projects). We aren't
  required to have small projects available but might be worth
  considering if we have any small projects that contributors could
  work on."

The GSoC contributor application deadline is April 2 - 18:00 UTC, so
(co-)mentors and org admins are already welcome to volunteer. As usual, 
we also need project ideas to refresh our idea page from last year
(https://git.github.io/SoC-2023-Ideas/). Feel free to share your 
thoughts and discuss.

Do feel free to ask if there's anything that needs to be clarified.

Just like previous year, there will be a GSoC Meetup in Brussels during
FOSDEM weekend on Saturday, February 3rd in the evening. If you are
around, interested and haven't received the link to register directly
from Google, let me know so I can send it to you.

There's also seems to be a GSoC stand at FOSDEM on Saturday or Sunday. 
It's said to be located in building H, level 1.

[1]: 
https://opensource.googleblog.com/2024/01/google-summer-of-code-2024-mentor-organization-applications-now-open.html

-- 
Sivaraam

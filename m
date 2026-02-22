Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83B18787A
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771783160; cv=none; b=d/KC56dHFF8b5qS5XvEM6oa6Z+vA4n5/QOW6xQ+vu7S/Dj7y9I30fNf0OQIAODuLCNHv4CcbD7c7PJvRxUraGCZojZJM9HnhtCPon97TWMLysaWtwWRq4bjxUZm3MwOgTEx4QO/NF3X3u1xZBS4tek8wWXgHzZFCTiOPVkYAMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771783160; c=relaxed/simple;
	bh=uETTRSQRY0k+mux+XO2A5z/tkc45bLRkDDqyVXbP0CA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=n6zn2NgLjGqV0qwxVNkMIVWt4v6adQm1X7u0pd7J7rNDsayHJ5WKmwQ19SE5LqIuaoS1JfZ3oHViyb3WZ4fM/nU+XqBMqULxBRiCpe0qohqI8M8jH1b7R4cGeiMG3nJqPTMfFIlVJCCh735GVOOgir9BbuQLERW+1WjEe0p43yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfVcGbPQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfVcGbPQ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70c38515d3so101445a12.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 09:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771783158; x=1772387958; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tct6RWHNCxgita9xnrGfQUQQhD9Wi9wQ43Og4L+o90A=;
        b=nfVcGbPQNSCTRNyu4A6Cz8G0JMBDrqbycDKHnMPU6BE7VS3RZPSeX7Zt1YiqRkc1OW
         L9x+HKWKwEE9CA7p4aW9QXWWPhIjMVYqHF9kTr/ac4UHs3dWWBnmsSy6YwS4GErhjzNr
         h4JruqTi+LYZ37ADAD1eNFxtdYaA05WDRy6jPyUD72XL050Efmy2GsU42DwsZVGSp3l5
         MoB077kEqVFkV0xiFhrRJ0skaMGvYSjAN2QB/3Zjp5SaUSSCIleUQUxbhX74/is1rT51
         Wt/SvTwNAZAZEtHXRfV27uyceRCCVC8HYsn4uWcGrS3gUu/jh5qdYM7mdyEQRllZpkMu
         MK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771783158; x=1772387958;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tct6RWHNCxgita9xnrGfQUQQhD9Wi9wQ43Og4L+o90A=;
        b=mdjJNwScyLu5AtU7P/2a64FUXcSXj915Xli5/Y333r55IGpvWi3LA8qxkYW/0lGUqw
         YiwuqJSG/1lnb+wZjjI61VmGbU45thJs72IL0OshrJN0ufIyEIPmh90HMSOyMIlWxl1h
         8a1T7RAbDKaUH1Osk7fZK1eolssxlITLo+Ks5wKikmWlN9GTciioBtc8Tj4ivxsK4RTr
         yskR44LwCRdfC3Blszs/RSGB8c3ZE1UIeEu+9uBEu4Q0AN/Ax5GooGP+hUFWkPyQTibL
         hhBOXV+EEZgf4EpG+krQzQZOyRWm+cxOUnjhjNjVg90qy/bD9FwP9AO+2n2wbT7WZT3W
         ZdnA==
X-Gm-Message-State: AOJu0YyXNIlym2j5YPtmD5yVamEf3YhXvqcB72bvHkrDZlXa8yktDqgN
	2QfX+Co9H2QPbkPzc0XzoYaSQtKr3zG09qxNP86RXPWm7LrxThzHg9OntxWBpw==
X-Gm-Gg: AZuq6aK35Mm1cD1GQorGmxKAsjKmHmI9f4VlK1V4r6LfHk7QH9Qvs276Uzhqn7+3vCX
	TpnDQL3aot8KpF91Z6qBhL4BOAWJ6rTWZzqWixGVAjNuFbzQYtPxXqYXquPqqQ0DKMUSS8cS1HI
	Rr/jP/4YmxaI5qXQddMKq4r2IbDLeZQEzuDR1tMp8ouYMinChaUcc4qOdQqpZgF0NwCzfAqpvhq
	N+DDnUkCvBShxa5NkU74+lsU9ce1bxz+jBvr6XoEXH9G7sWNoILXV3mgv79LTBVCh54lQ1nAssT
	HvSea+/HuvLFDWj48kYgPqiQ9xhDcTudCHBgtciK2pws86xVZJgyNdmr+IQruZsrNdk912VNQNA
	OgeGj8F3bpNGREvhW5zeMTMqPm5Cvq1yS27h7l5wJFQrYB18FXb0eISIL7uSSfmS0sPmbVCPbW1
	LGNmI9jk4ntzMmFfYj4DPdQfNHzIA=
X-Received: by 2002:a17:90b:5246:b0:340:29cd:dce with SMTP id 98e67ed59e1d1-358ae8eeb67mr3924815a91.8.1771783158418;
        Sun, 22 Feb 2026 09:59:18 -0800 (PST)
Received: from [192.168.0.101] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af95863dsm4961511a91.17.2026.02.22.09.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 09:59:17 -0800 (PST)
Message-ID: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
Date: Mon, 23 Feb 2026 01:59:15 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
Subject: [GSoC][Draft Proposal] Refactoring in order to reduce Git's global
 state
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

I'm Tian Yuchen and I'm planning to apply for GSoC this year!

Instead of pasting a giant wall of text into this email, I have
drafted my proposal in Google Doc. I thought it might be easier for
everyone to leave inline comments and suggestions there. (Of course, if 
you're more accustomed to email replies, you can also quote the content 
from the doc in your response. Thank you.)

Here is the link:

https://docs.google.com/document/d/1t2sznOvnPz-9tOzVMH--pLxzRqYSJCFzqVWBVfL_NP8/edit?tab=t.0#heading=h.c3c40ftj1ilv

Feel free to provide feedback!

Regards,

Yuchen

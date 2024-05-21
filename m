Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68D18036
	for <git@vger.kernel.org>; Tue, 21 May 2024 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258732; cv=none; b=tLHk0GCaC6C3vN7IE8923n37v5WH8YoBUDuL+nY9JexbO8OQr1XXkRIaHyV0VUO/whV+60Kp8wj/S+UtA8l98mwoxOJy8UOrgf5Fw0S7uTlxUklcLA9LzFXmSTpsya1mx2V9ree5c1VC8tYgIsjuTbxZJ/avoYhrtoDZoMPT3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258732; c=relaxed/simple;
	bh=dWFu92O3OTzIJkoF0JyhBSJo9oph16yHeNkZz4UyfqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNXd9/ghTdhI51ToivpHedBUnPoCs2WHraS1WrWYvvN+07b5y5p4p9jOgzVdXqQ1v+CVSijn259uM7KvgqF3c9DFNqATMV0GU128FaMRoTovPaHN8REIvzhIhbfYQpnU1Ilr04h9F1xua7cBeU+8NwjWmn5DBYGBZX44oGe0OyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=oYhxQRJE; arc=none smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="oYhxQRJE"
Received: from pps.filterd (m0355792.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KMfZfK021617
	for <git@vger.kernel.org>; Mon, 20 May 2024 22:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=20180315;
	 bh=GvHWGiUuo1X8ch24JJq2fgXYamofjsPjSfcJJrufGPA=; b=oYhxQRJEMnEh
	velodiAB7I0gfUPhT+DXZezphenhyWBv9UxvNnjGNrLHnKH2Y7jdDpbj2S8ucYht
	3r1v2xJLX7OJFtJ+ZVMTQwkWgoWeJxXu1wOlnNOWOwXRyUj4ykvAI/frVCBLs98+
	NgOyvGjgmAbnjIBfMWXATTuBdqjtdUcRcJPKypWbUzjrKsTuEXP1QyaN97zCgrAB
	aoNVMeFPLewRVP02PI0IlY0IzT4kqhSWwpwcqSoYpENYOofOfB/pQtgZj0F0DAVV
	dLfJmG0XH/be0iNGpYR8eTfdKy2Sqd28vP/wVMHprewMxjlCb9iK+je9P7yBPfOH
	L0r5FeHdyg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3y7utwe4kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 20 May 2024 22:17:41 -0400 (EDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f4574f6bffso9560838b3a.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 19:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716257860; x=1716862660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvHWGiUuo1X8ch24JJq2fgXYamofjsPjSfcJJrufGPA=;
        b=eXINHzgf9mhNsTKuDo6tKo1+9Qn3NAkvS1x5yB6WgE3FmO+Yc1rWt1bI/tmRYJgdS/
         kC21TyANeivmkvvyCnTERHlQNMbPSK8vU+lw5BQLasOaMDKF1Oxp2iBwiL3SmIfSguKk
         fr/7ft48LHEzeh/caLvqGTsqckKM3pSt33y4V2VTlWP+LzPzuPoM779WPmRYhr/bz38A
         Du+qdDZw7V5lz0veJFGdBmNDzd8SI0tTkDAdAajSJGMkUUQ+415StMvhINmi9EN3HLOs
         MYk025qQIZWELhGPJE1zGlONOnVq0plOBlvvdq2m40vi7Nqw4NjwmksANkGASlwNtgSm
         Kozw==
X-Forwarded-Encrypted: i=1; AJvYcCXEJTkaFQypQWJMfB8nVoJnhbxnN6rs9Whbo+a0t5xGA3aMTBAiLQCHibZ+Xhw+wAXhPRlSqN1esxpixWpzteGIXIld
X-Gm-Message-State: AOJu0YzajRjSSCei/qgKkYFDbdk0eFJ2WqLMZ/FC4YL7s2Lgrs3Xe/aU
	RQ8Mx6cXB0unP0jRP+tr6+SDrWbcBNU+sWAE4PC447uCjyy92+l7Bkm++1A/e6Mi47H6qHGXfML
	CCI3agFSuQ74myo01CA0YgzhUflKZKoKnbv3+IwaZVWBqKHU=
X-Received: by 2002:a05:6a21:3a85:b0:1b1:dff2:ed03 with SMTP id adf61e73a8af0-1b1dff358b2mr3307876637.16.1716257859903;
        Mon, 20 May 2024 19:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsOWgL2pLmCEBJSdZNnLfJ1VFhrJ6sdrsNjnkCV5nB/M7juzu9ggYpk9X4B5/a3PFk6eGJeQ==
X-Received: by 2002:a05:6a21:3a85:b0:1b1:dff2:ed03 with SMTP id adf61e73a8af0-1b1dff358b2mr3307858637.16.1716257859412;
        Mon, 20 May 2024 19:17:39 -0700 (PDT)
Received: from [192.168.0.106] ([49.37.251.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30dec58d7sm2840885ad.22.2024.05.20.19.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 19:17:38 -0700 (PDT)
Message-ID: <835eb66a-737b-40e5-99be-af299e231408@nyu.edu>
Date: Tue, 21 May 2024 07:47:35 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Git Merge 2024, September 19-20, 2024, Berlin
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
References: <Zj0JyL1b+g1G3zWx@nand.local>
Content-Language: en-US
From: Aditya Sirish A Yelgundhalli <aditya.sirish@nyu.edu>
In-Reply-To: <Zj0JyL1b+g1G3zWx@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T0Q_mArXWQBRPb6WrSe1ZBB1zkzN0r8M
X-Proofpoint-ORIG-GUID: T0Q_mArXWQBRPb6WrSe1ZBB1zkzN0r8M
X-Orig-IP: 209.85.210.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 impostorscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210017

On 5/9/24 11:07 PM, Taylor Blau wrote:
> Git Merge 2024 is happening in-person on September 19th and 20th in
> Berlin!
> 
> GitButler and GitHub are co-hosting the event, which will take place
> over two days in Berlin and allow developers and community members to
> get together and talk about the future of Git.
> 
> Here are the details for the main conference:
> 
>    When: September 19th and 20th
>    Where: Location TBD (in Berlin, Germany)
>    What: Talks on the 19th, birds of a feather discussions on the 20th.
> 
> This email is just to announce the date so people can start planning for
> the main conference and BOF discussions.
> 
> Registration for the event is still being set up, but it should
> hopefully be live in the next short while. I'll reply to this email when
> I have some more details.
> 
> In the meantime, the CFP site is up and running. If you have any
> interest in giving a talk, please consider submitting a proposal here:
> 
>    https://bit.ly/git-merge-2024-cfp
> 
> If you'd like to come but need financial assistance with travel costs,
> please reach out to the Git PLC at <git@sfconservancy.org>. We'll
> collect requests and try to make decisions and notify people by
> mid-August, which would hopefully still leave time for making travel
> arrangements.
> 
> Other than that, please be thinking about (and feel free to discuss in
> this thread) topics you'd like to discuss, or any general thoughts on
> the format, venue setup, etc.
> 
> Thanks,
> Scott Chacon (GitButler)
> Taylor Blau (GitHub)
> 
Hello!

This is very exciting! Could you share when the CFP is likely to close? 
Also, is there at all the possibility of having a co-speaker?

Thanks!
Aditya

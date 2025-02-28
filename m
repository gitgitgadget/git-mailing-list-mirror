Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05941B6CE8
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719200; cv=none; b=bHNbAokOAxoHzXgEdI298FtUbp6sW2F/ToZKoL9lTVQXUkHsdBG3+zoTXJqALAvY9+dP9oFhm7+IPN2lmysNQK/mVNemCeva93Gu0AVvZR9tkumaV5vlKFMyxtaazC8bkCyzDygHiO/iNyX2578b8skf/t+Ia6mwJn7jAL32wNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719200; c=relaxed/simple;
	bh=L7tzuIQ8njkovFBxfkHO+S+vA0Hb6Fj3bjPRcpeGu4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiD+TogVogNcEF+43wSgv8rpMXE9qGXJpcA+G+2MujzNGK1GfAfgRIrfSzO+Y5lTiCLnYOytxy7zuOLEJKTih3FD5WRgWWFT0pvttSZ2H90Jupkeng60oQ7qf60C4d1DoBF1A0fl8if8shWbdeAef1weSyeAo/4RFtWoqB1dTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsoFvEMQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsoFvEMQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-222e8d07dc6so31892185ad.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 21:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740719198; x=1741323998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ3ABJVXygz+PWjj6Wn0iaDwJYCX/uemG8c0ntRD/PM=;
        b=CsoFvEMQG+1WFu9Wxn7vvnOK79j/vXPxw0FeE0ly/O8abM9G7effYSugFt7ySaTXnT
         H44hp2xocsjXF846AeqPsjcKcVRx7+4pM7wILlCWa1nI3QXfWvl9YaOxUASF4Bvbm+vv
         zzodFcHCz1B88IZfnT6mffHCwGObNTU7mNNtaxdCputALGKTRd2y4nCewo2LCgdTOKoY
         qwtnjOjs7179wo7CUwjehiLj/cXrN7Hj71eRY1KWf/BybF/FWw2ZkNsUuMkiokpCAhMh
         7Ao7DbHYtxHImest2/LpralKyNYmWTuDEkSYO7jSUzum+ET/0wmpa3R4Sejo7e6gJ4DG
         Sj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740719198; x=1741323998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ3ABJVXygz+PWjj6Wn0iaDwJYCX/uemG8c0ntRD/PM=;
        b=S/KfOC/dNMpDCzhK/BEzDT5qy/Fnh+hVIw301Hn2XUUbyBc3H04U6MOxE0zSrclnPn
         CfPFwtpAe6G63I1YKr8s5SoXNUlo3g2uYeRG7mozOEGDlJavNNwn5XuewiRhTgFByake
         IzR4t1vuOg/6zaFDRrdoICT+M6slb0l63vh8x/AKK3UVRXmmdE/Cc68RMuXfHmbsiq6B
         WFjvp7PjhFvlauH6YgzcIudP7bzmkbQXfWcdXNMRWfa8od1f5YDe1Dkww7SmDxl5Ant1
         VROU3YlmIjpi8YF9opyA1VqcbBfipg9M+HqA5FJu2pQiw5Z5UqthIN95EFasuWQmcK4h
         18LA==
X-Forwarded-Encrypted: i=1; AJvYcCWm66trqwm5eGX8T/zmJNcGMtHAdvFo/tG6NvDSvs2VKc5xTeAbNCO2fjZVmLffFSeVXHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/CmDnwP8xxlvRrt2UtIXly4V19bB0bhg04QNo4ZYxgwMZJ35
	+G1FQqPtX+lyVhAWmUUXu5V75Py7XX4CTSy7VVUfGggGuNP4cBc2
X-Gm-Gg: ASbGnctoXm9bU4+Z19oUS7j3k1BPiAen37MmzmO/r+y8lLAbQLlLF8e19vQCf75B7nd
	7PpPzprQmRHblzZ4SIhk1N0jqyxWQQr8WP8qNN392aWGnjURNZyMmCp9S5hl5CvulhGyUP+HtKX
	ruXCTbG7bI3H4drh4LsiRjjjJP54BKsSl0kDbA6rfieTjjQmEtpxxof0p8eUDzF0kisGvlyaqhC
	tUh74C8OA7bCn5EUI4jCp1Ppp5Ivt7Apsr2MqQxpMhMsdP2i3sSa28yQecFoGewMTS2u4HKlM2/
	2IMhP5m6scHbn920m/EAXQ==
X-Google-Smtp-Source: AGHT+IFOJQFcF4E9huD0BEy/Bb2ik0Zw9I/+7nhXv7IuUPVWsD+N7bf3RFnz7mZTljSKxdOV+eO1YA==
X-Received: by 2002:a17:902:f687:b0:215:758c:52e8 with SMTP id d9443c01a7336-22367455c9cmr39509885ad.12.1740719198173;
        Thu, 27 Feb 2025 21:06:38 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2235052c806sm24512285ad.235.2025.02.27.21.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:06:37 -0800 (PST)
Date: Fri, 28 Feb 2025 13:06:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
Message-ID: <Z8FEaIzK60EDMEFn@ArchLinux>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>

On Fri, Feb 28, 2025 at 08:33:38AM +0530, Kaartic Sivaraam wrote:
> Hi Christian, Patrick, Ghanshyam, Karthik, Jialuo and all,
> 
> 
> On 19 January 2025 3:43:29 pm IST, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> >Hello everyone,
> >
> >It is that time of year. GSoC Org Applications for 2025 are open now[1].
> >They are due before Tuesday, February 11 at 1800 UTC. It's good to see that few contributors have already started working on microprojects this year :-)
> >
> 
> I'm glad to announce that we've successfully been selected as a mentoring organization for GSoC this year[1]!
> 

Thanks for working on this.

> Christian, Patrick and Karthik,
> 
> As you're already members of the organization kindly log in to the GSoC portal to read and accept this year's Program Rules and Org Member agreement. Let me know once that's done. I could then add you to this year's program.
> 
> Ghanshyam and Jialuo,
> 
> As you're new to the program, I've sent you an invite. You should've got an e-mail about it. Kindly sign up via the same to read an accept the Program Rules and Org Member agreement. Let me know once that's done. I could then add you to this year's program.
> 

I have already signed up and accepted the agreement.

> Let's look forward towards for a great summer this year! :-)
> 

Yes, that would be a great journey.

Thanks,
Jialuo

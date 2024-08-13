Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7E19AD8E
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556599; cv=none; b=Y7xcCSkA//7F2Y/ORgz9Eox8P9wMAsbpOHeP1pXbkeeAyO7Zb8ARZwBKAUyg/fdyEGSi0XB8XNH9NGs5wFp+zK+htE2HYFwaJadU/QPZ1NgUga7Empf2113C9fVb9ijSubY/C/oczQDf8k10zZPRHM+6P9MuUbkVbX3iYIk/dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556599; c=relaxed/simple;
	bh=jk6jBD0mQkX5VW0qMLsKh3G4kMsIbLz+BxHRXpPOZTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn8xFi905xcbaotUnyqnEkQGxHx75sROhtMf3ezN8rqOctKbNHSPf9LmWDxU1HynyQpbnVqPeIOGsatSvBcyRsFlrvvAKr+mXDjDOsGWXZRMlBk7q2lpec2FMtzI2n+RJdUWRbAi5cjS9q+PJZU64vh6dCaKEdi4H+i15DeO44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATnkNGEO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATnkNGEO"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7104f93a20eso4576640b3a.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723556596; x=1724161396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0z9Z0ZyL4mf9imfAdh1+Maz947yOXKGI4rBpB+zcA/Y=;
        b=ATnkNGEObFWmnPTlg4JiHWWzfZGSuB0oP/9S8UlPHkoI5J0sP73Ws+xg2ynxZNBQ5Q
         EmMoZ7APkDdzPyKG39hVD4BWcGJyP6/guctQmNUwV3MJ7coa4KJAC28Ew9SqLF/dbyau
         6EaukjiUM/c4Jvt/Eped7JEaKnPQacP8LCvzrD5iGdUJ8aYXKxRSfJEGVKxH61efCQsQ
         sCw/8pXUm+rEegWB1x3k5l2DiZ+5vXVfgz6CGp8yblFamW/eT4FfgLOApkyhs8zXbhgC
         goNdXfH9Y7WZQsQl1n6aYWKBWZaHrj23rGxyw14VHrOj6HWeMHqWZLQDHl8Ntd2IObeK
         ZRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556596; x=1724161396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z9Z0ZyL4mf9imfAdh1+Maz947yOXKGI4rBpB+zcA/Y=;
        b=laJnC9WpooWJ7cXn+jyvBqWcjApchPhguF37EC+phEB71uO5hnbeZszE4IU8cHGxU/
         dJfPt7BfIynBj7DDZB8V2doQXGcd++frGx7I9sLznP/VacBodl8F2xl5kepWFEJ/m6sU
         z7XTuzxanAtbm8TSPUTpBKHAMhlHPl8zXvyM2Z50Be3jBY2okS9XV19PFfJNHXToGBDM
         SonM5icQR7tIb5kQ21H3t8u+D+gRDVfaNkmphKINWF5HDP5jPL30o/NfIGAMZL/nRPGA
         qg2e+t9TeZGbSE9IVMYs4L2q8CDQHkmd957Qk27TOoduTw5sz5xId8gVIWWe6adjt+bP
         SQ2g==
X-Gm-Message-State: AOJu0YwJQFYiyIaAEGYInfLQXZ0wFJ4D5bNyL0DvwwNMMyVAGwpiRlM0
	yzHRI3b5pdliHGhKJcPfnm0xXhyGlESTNuKoQXTXcmpX8KR4D6MqCytpcoUB
X-Google-Smtp-Source: AGHT+IEksLw49xstpMcQA7Had0lkVBI++VzkVPUE0nBorf8C9393TmzbE5wuz+HsRBLPE9AtY2I4/w==
X-Received: by 2002:a05:6a20:c91c:b0:1c8:bcc4:def7 with SMTP id adf61e73a8af0-1c8d74386a3mr4331532637.4.1723556596285;
        Tue, 13 Aug 2024 06:43:16 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8c361sm5870149b3a.143.2024.08.13.06.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:43:15 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:43:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZrtjF7vO8rxsLVLB@ArchLinux>
References: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ7j9HYVOpP2Xga@ArchLinux>

Hi All:

This is my week 10-11 blog:

  https://luolibrary.com/2024/08/13/GSoC-Week-10-11/

Thanks,
Jialuo

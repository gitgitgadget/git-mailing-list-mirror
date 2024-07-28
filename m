Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1C8C06
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722149842; cv=none; b=KxdRPe9cTNcwweggqutmaU+jSzZRbqT9GhMTNquKeZ9g4t9uB++WNujAh4lbeXAlRbTQ7RM6xEw3moCVIKbPoupzjHtoI8rZhYnORHJMH8S/8C92C3mgLN0xxcpNANFpF8861pf79Rp+jOeIZSQCOHckAxLyBPoJkliCQsNi/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722149842; c=relaxed/simple;
	bh=2m8ZKylArCoScyBztxFfy/L0QsxEtdgNWCtPH5b+XA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJYpnh8IpiKiC/UNkzks7wI01Tgzg+G6r6lgXsdU9SUcAZWtApZBDW+XcbayxMhXh8lm2r3R0mZETfwFmoMXjdply5PRNF6JLwFKzZh56xyVcvdE3TcHrFJ51mJhZZ958SAIaJN6W5jbPXXYS1DVJ0y05b7ShKOqMXRQ52UizDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcKceFQI; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcKceFQI"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4928d2f45e2so312959137.0
        for <git@vger.kernel.org>; Sat, 27 Jul 2024 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722149840; x=1722754640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U+SiHKNLewQ7MPyYL6kDUbMSzAnd2jeo+YA7kJcnNY=;
        b=bcKceFQIINgMS5qVFHywQN7J6qSb5vEhkA4miqw7N/4DEyzTFZtFXGVfFDEB3tiihC
         Dpbraoaor38cva0PoK5A2w4pwxniBX/T1I2l8OZLnslvayb82PHSVvqnfQIiGbpqrIph
         sMgpuF4hGH6qKc2IGf0t6A9afePkVg5aYrXc6ABF7Q5QRlgBGQBgEctM9K7jXkxQkxrC
         HN11E3sNkaVSmDvKfTeJttB8g0HfXVbTorkrmas4LmJJuoGWzhiBrJFoN0zA3gjQGJKj
         90jEiPzIsFa/W2CBomvEwt4j+9LtQcov2hkoOOcWLXS21YcHqElpj0ZCR8vlYya/rlcY
         Gseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722149840; x=1722754640;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0U+SiHKNLewQ7MPyYL6kDUbMSzAnd2jeo+YA7kJcnNY=;
        b=j3Tiqo/93A25VHTrkcxYhfClUmQatabeMxokI63oVAjR7uMw74HIn7oEzJt4F6C7Bj
         cUbtFyijkVZ/KoehM3cgvOCpMJe+GoR5Fi4M7XsC1OWYQjez8bftli3O/sOxBH5ng8vM
         5ywIT4LNXteYNGmersZ8p1vVpIFexjaaVVtf3JdI4c82jWqyDmswUFDcKGCRO3qZCcXr
         jkrbN3MKzWHJEC/PCE2r1+9G0kR0n7TF8xW3QLh6MLWJ/j31So+/tOciqLkJ2pZw4OTd
         l3LaESC0NH+JKyBCs1wcVxonHFeKvYyWCmAc17SdpFwy8S03erbxqDexXG3WTiHF0EjP
         CT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWevj9X2jNscfEjoyvtScK2nTwNTm/P/K0azR9PgnKR9dWGVArC/AlP0KcujXJdDWXbWxjinYf8JBli4doRzGTdwYPW
X-Gm-Message-State: AOJu0YxOlGNca+uceRvE8WayEwyMGmcR/1YwqQnXh+1j+yKW0WIfndbV
	/wC+Pial3U0m5TMeX7o8ThZ5NBRLQ+Zpuwx0A2oMP4xWUllsoZ2kFjmSC/nW
X-Google-Smtp-Source: AGHT+IFQG92tcYnzeTSFhCRJuyw+F/ABCdmR3RBrOqFkZ6TfeuEETsM2OJm3ZH49r15AwmvIHZYFAA==
X-Received: by 2002:a67:e70b:0:b0:48f:eb37:fd86 with SMTP id ada2fe7eead31-493fa46f41dmr5790029137.30.1722149839779;
        Sat, 27 Jul 2024 23:57:19 -0700 (PDT)
Received: from [192.168.6.104] (mail.3111skyline.com. [66.76.46.195])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db135264fcsm1503326b6e.41.2024.07.27.23.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 23:57:19 -0700 (PDT)
Message-ID: <0ae914c6-70be-44b8-a6b8-53f0b15d5674@gmail.com>
Date: Sun, 28 Jul 2024 01:57:18 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
To: Jamie Landeg-Jones <jamie@catflap.org>, Johannes.Schindelin@gmx.de,
 gitster@pobox.com
Cc: msuchanek@suse.de, git@vger.kernel.org
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
 <202407260038.46Q0ctEV083266@donotpassgo.dyslexicfish.net>
 <5747ba0d-7268-4538-9705-11650a7d6e35@gmail.com>
 <202407280346.46S3khd9005129@donotpassgo.dyslexicfish.net>
Content-Language: en-US
From: "David C. Rankin" <drankinatty@gmail.com>
In-Reply-To: <202407280346.46S3khd9005129@donotpassgo.dyslexicfish.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/24 10:46 PM, Jamie Landeg-Jones wrote:
>  From what I gather, the idea was to stop a client user from unintentionally
> running potential hook scripts that could be evil. A similar protection was
> already present, I note, for other methods (I couldn't run git log and other
> commands directly on a repo i had unix-level read access to, but were owned
> by another user until I added the safe directory thing in .gitconfig)
> 
> Closing this hole to make security more consistent is fair enough... however,
> in the case of git-http-backend the "safe directory" method doesn't work at
> all!
> 
> Is this an accurate summary of the situation?

Yes it is.

   Prior to the change, the repositories on my git server were owned by the 
user with push privileges and all repositories would still be cloned over 
https. Now unless the files are owned by http (what the web server runs as on 
Archlinux), https users cannot update their repositories anymore. Changes 
pushed to the server by the user with ssh access (and owner of the files) 
cannot be pulled over https.

   On the other side of the issue, if I make the webserver the owner of the 
repos, the ssh user cannot push or pull.

   Gitweb remains happy no matter the ownership.

   I'm all for more security and welcome it, but you have to provide a way to 
configure it so that prior functionality is simply not broken. I'll have to 
search and find the little truth-table style of repo user:group ownership and 
the resulting succeed:fail with push/pull from the server.

   I'd be happy if the docs were just updated with a concise explanation of 
how to support both ssh and https to the same repo running under Apache -- if 
that is doable. It must be, github does it. I haven't had the time I'd like to 
to further investigate. Next month looks better.

-- 
David C. Rankin, J.D.,P.E.


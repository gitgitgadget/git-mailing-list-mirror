Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE961F7580
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043192; cv=none; b=nJ17/F+hrqdrQDXadwfQJ1TOXviVXYFCIzaF78WIy5dYXwinM1/hCIDeVhm0IbZhOn6rQLqeoNTcTtOmWn/vrGYxZ1hkU/2qiKxvEq0Q4bCNNv6+H2Tm0dP6Gdel+wqVPaDdB+y+CzQ9zpPn8uScTQdKA85/UH2z6PIUQExQl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043192; c=relaxed/simple;
	bh=qIP6NFRJRErVcq4sS+rT8CG4tEpBz6GEMzaGDna8V68=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=i1maxlbkWSyFkOcJlWdwZACBJDa5cIhTOaoTvkBqCOavl42GqkU4ZJLp9SDUjWiOvjBPXIdsYbr/EUt4Wo9rE2Tu9N+DBqwmRzbFcNYmNqaBgwMvr7vzqVkcC/uJCz6RL2n9fKTwOrZO/U9VcdyowME6vrltks1hWGuGScEt8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDrMnFVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDrMnFVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760043190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPwn44hQZl+cREJTphJHPZxVkauBCQkZ7h631nLSqo4=;
	b=fDrMnFVIU05aORbUPMkFQXEsBQvzJYuDsOJs6f1tFplO7UJUhi/hcsACmT5/BgmBS+1NjL
	MKNUZrj/UTalcm2sCjgQHNJCmpqzm8E0rXWtrcr8Ix7pX2XHHeMZ8rBeLQVN0Q0rzgnrnO
	e4xhRLL/yaJGWLk7vC4A9HG7mQ58qQo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Lv9mnpNFN5y0Q4DcbHc7HQ-1; Thu, 09 Oct 2025 16:53:08 -0400
X-MC-Unique: Lv9mnpNFN5y0Q4DcbHc7HQ-1
X-Mimecast-MFC-AGG-ID: Lv9mnpNFN5y0Q4DcbHc7HQ_1760043188
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e002f413e4so25910511cf.2
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 13:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760043188; x=1760647988;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPwn44hQZl+cREJTphJHPZxVkauBCQkZ7h631nLSqo4=;
        b=VzvDq+qLz4n6XQFisD/Uv2EJEcmel34HWXG84odl/OGFNCdf7UORiVmZdVLJzg9Keo
         l+H9aUZvLE3G9cnu5qiBH4sOwetRl8cP//U6SxtntCcps4ngTQ+N0QIZy/sfxGA2OX33
         L2/4UBoOsSnZiAJJ/YO+E+WM8EMs2CgQ1muiZIoF4pWAiq6Cub62DxOKe4wUet7ihdBi
         6F1bAIsnWgluh8e+Ig06zN0Jej1Jy5LYnTRw2Dz4HtzjlNvakMDY6uGl9M1p1i089eRo
         RUMY1FEwptyh8OldDMsFHBp7J2qqlNYwtBBGXI1Z3u6lb7CFiTArFMdndlU/grdBavGB
         fR0g==
X-Gm-Message-State: AOJu0YydMzkfJEDEKwaa4cYhPC/0zVLng3vjiZHrQijZQs9i00/UvEkj
	YqP5ssJWsiutY/dKNUJEP9JTxzxkRxE3njLZGYWOPnhuAa47oGbVTuSWEnO6KvAtmaOjEUo+dBB
	Tvetduqo+q7cCCEObacK3+Xk0VZEF1I/Wde3NbdKnoMKtRWUJP+P5SDDjyDvpuJD5Njy7pKvkK8
	uaDWX+f3ArJI0YxHcNZJvk3fWl2aR+2xsxXYtodg==
X-Gm-Gg: ASbGncsA33aPCWJokQ1YFzvHHf8EsN3BrZV3xXV4qjIwWB0nY4rGgKQQS+zjXqSwA4E
	pvfqFTurEc6csX7EUBuYQbLq9UGz7dvMMsO/oPWVUbcK7p+N8nC+Dsc4ZSc2Ul6N73Z5ohkbZjL
	Jx1Bumxoks9+JZrF8mIRPyvrH0uczc0yujQrItqgOdw36gF9kXFvzykrZfhN7ZvcTpKkk5VfwY1
	179ScGnyF3vXnbcxLn1yID1Tux5/IJ+izdY6WXKd5f6JOCgGSoKahwkx4n+SB62MZ82gGbKm3Zy
	itS/J4obBMBZ3LMhTUGHuxXUIibX603NBWDpHE3Mnxp/U+1uttntzc1n0hv/46lYLzm2XxxjTll
	5GifM7Q20yplUFfWhMg==
X-Received: by 2002:a05:622a:588b:b0:4da:16c:6ce9 with SMTP id d75a77b69052e-4e6eaccc71dmr117122391cf.5.1760043188026;
        Thu, 09 Oct 2025 13:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1hz+u3VKiylCkMYVVfb3eZweMavJ6KdK3Vh1twG6XJBiEDlLCA0et6wNOcFhuwOnCjYhQvQ==
X-Received: by 2002:a05:622a:588b:b0:4da:16c:6ce9 with SMTP id d75a77b69052e-4e6eaccc71dmr117122081cf.5.1760043187594;
        Thu, 09 Oct 2025 13:53:07 -0700 (PDT)
Received: from ?IPV6:2603:6080:b00:79e7:5442:2825:33b4:f35c? ([2603:6080:b00:79e7:5442:2825:33b4:f35c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc357560asm2987766d6.38.2025.10.09.13.53.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 13:53:06 -0700 (PDT)
Message-ID: <a6067200-a7cf-4632-85f0-8c6bcd00a5c1@redhat.com>
Date: Thu, 9 Oct 2025 16:53:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Justin Sherrill <jsherril@redhat.com>
Subject: 'git whatchanged' is nominated for removal.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

i recently got this message in my friendly git client:

$ git wcp data/aws/insights-prod/account.yml
'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <git@vger.kernel.org>.  Thanks.
fatal: refusing to run without --i-still-use-this

This is just me raising my hand as I still use this feature :)

-- 
Justin Sherrill
Content Sources Product Owner
Senior Principal Software Engineer


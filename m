Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40D1339B1
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772193848; cv=none; b=Zzd+pm6brI8fPSbUjJcOkb6CWDUTqhKMne4owJKgOyZlVsPs6WQUGO77wlEFrMW14oqIm8N7t8EEv8BPpfuig5oZHwli+PIMdhbQllAcgzig3zaTigLEVzbsvbhuOwFIZFAcJR5hQ5L6jfuDSDpycuG7wA3HOC85GiMnI760c5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772193848; c=relaxed/simple;
	bh=LS2+Bw80tmV4IdE1AMyCvT4OJm2gSWmIE293turQUko=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=g+xutf8EQyvS0Fk5u65Xnrz4Y5Q/AiGsmv+NGZ1uoWbfNe+Nsr+4TPxZbQUQEMu5Sc0M7NSgNVfBF8eD5flv86aJNBSTT05n74EdqXT7IWwjornx6V4iWqcLUZaspAWJBKNGNhAPTcCBp5MDskFZv+LqSjIvc8d9m6Sx6Tn45WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com; spf=pass smtp.mailfrom=odoo.com; dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b=W1+8vRWP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b="W1+8vRWP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43767807da6so1333253f8f.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 04:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google; t=1772193843; x=1772798643; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG1sGNwqU+K/hMpXqpY1q9m4crugnT1jnT/9zMXR2P4=;
        b=W1+8vRWPh98w37ZYUwBvnkL0V1DVeX78p16iJWvI//pXcDMZdxc/flZAkFyu4EdeXG
         XvEcdEiMYkaaVbZ8jBitvZN3B1/1iH+WFsUKxanxxyYJk3Szf2PrFWvqCflR2Pgf5501
         KUuqkYoZQcDJmjtKAA4W4pao+Cc3vFsvsD3Gh7rDGHkhyDB4JLMIIEj1E+c4WrBjSgGn
         CIVA9OlkdamQnZ/K3T+czS8ECAOUCZE4QhweqO+O+htKgX8BADDko4PQxIx7v5XkVUjR
         mBwjFwAuccdZ2v5Y5llnnWl/qVbcH9z600fYyL828FhwPc+pNiLDlnH9nAAso4TXt+yD
         CUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772193843; x=1772798643;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jG1sGNwqU+K/hMpXqpY1q9m4crugnT1jnT/9zMXR2P4=;
        b=EdqwlpQmznnjtjENKi8OXDaZH7CGdvyXS0gvi0ycv7DtksVQsoSJj96kaozF/xtdIN
         zRZtuCGNdtJU0iwkyrkjFRA3BG8aGa4XvXimVQ/X+aG3lByqKVrJ+/IXNxkxXJX0uK0t
         UBNQSkf64FTRR2H8mZ6tdbHm61RYnFC+Gb7qdbjKuhj/YgDjhFT0O5aRLstps0bOcq/Y
         blkg9QeS80g0BhkTYICmuPWni6nVpLVmqnq6fXcKVXYbi+Xuqh9uMYzaQdjAJi41jldH
         D2zVyiElc9W9SitfBIuluxFzlZV6ylPD7zC5xeXPjy0kdKp8WZnqufUv6SCXSzylT7O5
         nPMw==
X-Gm-Message-State: AOJu0Yzpf6eL3hROEnEMHaCPY2Xp1y7tY0dn1Kpm0iv9JpgBJJW0ESS7
	V9Keixjt/lTTZ+ob+/oBFUrGPe2XQ+GNr9h/9dVtsiWnZ+87hTfw/KxdANVDS0BeMibCwXwyJcf
	bPdV3
X-Gm-Gg: ATEYQzzCJh7yCt0XToyUbPNKaqoHWrnzV3uSCim668hOGhYJvRCGVmp7xz+roFaD9co
	AdWrwbsf0fKCku2z/6l6eantfWEYjacRPDNC+bglL8FUQTaNMY2HNO06u8yf/Zc9auEhLNOGUiw
	C/x9sCreNPn4MzaWGKgEM0lsbsmKXoKYBpHY6ZRFsvTXqnxqoCrvWapF4XB4xPDtQLDbYPA27Oc
	7/lsgoMs9ED3raZBxKROTQqkU1NM6FQNxUe27rdkLLYhFLN2GXru1I5ONz3WmhDdK7ZlIzITmB8
	cTyPggQj7ZLFA5dMvYCdg+XavL3WZNPKGCDz1iYYsdTW7sYF5A1ohHlz2XEh+Bp8LBBd9HJ4L64
	nncSy9SxnIDg5AM3zCHiaTUllEZjyXfca+MffQqHNY1qRmUG4WiG8jUGRVeapsX5f9yN6cOlHcM
	yRaGmyChqyUx1exa2ytLEnhOS9hD3Lqgh2NISvlOjw7up5GVRJy0c=
X-Received: by 2002:a05:600c:470a:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-483c9ba68eemr34133565e9.6.1772193842996;
        Fri, 27 Feb 2026 04:04:02 -0800 (PST)
Received: from [192.168.0.2] (ptr-178-51-154-189.dyn.orange.be. [178.51.154.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm232030495e9.13.2026.02.27.04.04.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 04:04:02 -0800 (PST)
Message-ID: <0a5a8da9-5565-41b0-9ac2-7d11ae116b3a@odoo.com>
Date: Fri, 27 Feb 2026 13:04:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Xavier Morel <xmo@odoo.com>
Subject: git clone --bundle-uri: follow redirects?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As I was playing with --bundle-uri again, I found a new oddity: git 
doesn't seem to follow redirects when resolving the URI, and the error 
feedback is less than ideal.

One of the few projects which seem to publicly use and advertise bundles 
(or at least one of the few that's easy to find) is the kernel, they 
have a pages recommending either using a custom script[0] or fetching 
the bundle locally then cloning it[1] -- the latter in order to resume 
the bundle download on poor connections. I figured I could just

     git clone 
--bundle-uri=https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

however that immediately prints

     warning: failed to download bundle from URI 
'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle'
     warning: failed to fetch objects from bundle URI 
'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle'

 From what I understand, this is because the bundle-uri above is a 
permanent redirect to 
https://mirrors.edge.kernel.org/pub/scm/.bundles/pub/scm/linux/kernel/git/torvalds/linux/clone.bundle, 
and while wget will follow redirects by default that is not the case of 
curl. Thus git finds itself with essentially no content, and definitely 
not bundle content.

[0]: https://www.kernel.org/best-way-to-do-linux-clones-for-your-ci.html
[1]: https://www.kernel.org/cloning-linux-from-a-bundle.html

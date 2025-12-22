Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6D2FD697
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414242; cv=none; b=RrTFOPrLvSdNjkent4FwaYUcOCwT6Rj2L6pcnjzau9wmkA3AMnien6fGzkjOVAUl6cakcIwSYKL32+1SOzasFWsWPTZg0HT7Guel1ev/aQoblEQXEeNjrkyiewcXx8MjC2qhmpXIy7nwV6TudAes/jPdebJ88LpISjn21FnCEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414242; c=relaxed/simple;
	bh=I9Y1YmfrzpduWXypx9eNFBpWy2HStlmuC/N1H/7LhZM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=F0AffyS1PqBEKyQ8iofsg0BZZgEIGGkyYGCBNXw18EDWrOL2f7VPvNbRxtqF1TubiE5iXmA1DFWiq6Yc+NTn4zEChlT6JSHFQzmLRT3iKvcC1jdkPAauf0cng2Db96qcdoJ5INQs3BT5ZVi/V4/p8r0jvmSWLd+a1JazDnmpEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caUStzlQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caUStzlQ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5959105629bso3900449e87.2
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766414238; x=1767019038; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:content-language
         :from:reply-to:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tjyp3TuI/iwzpZOLmfsTNBery6c76cRBtBDZnVzpaNw=;
        b=caUStzlQzMOQfQwTuqczDWtAGhhTix3wC1xivWoCqYdl0Y/CcsxUPXNYcIDcSOjHTd
         lU7EMUnDXKqHP2Kpf4oXrzTZRQ9fHULyttTsZwPdlxhVbEpgavXOZgi6qkLohB3avgv6
         m+9eosdPN83E615Rt7sgExQJMjfp1TuudAv8JzRFnrzWrOXZqV/c0uyGjxyMBOmEOma4
         UEdiIc9rKOoKYX60G9jmztOgLH7H+K79wxYQUU4sRLEI4sATnPIXg9zczLXhSGhOXKME
         IZ0oQssogsyYzOVm64zn++xG4rM9khxkJUJkdNDz43W+ilrnyJMbe5Xn5tdKIYamhWae
         5rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766414238; x=1767019038;
        h=content-transfer-encoding:organization:subject:content-language
         :from:reply-to:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjyp3TuI/iwzpZOLmfsTNBery6c76cRBtBDZnVzpaNw=;
        b=B1n+UHmgJw0LgZxyNv2sBwCd/LXQDxZMIIoDXd8hMjXMWf7p0MqaGM2C53SnY0KrYx
         kAwF59fTBxKv6KlwxfmkTLK7TWMYLpOy5GhPw/f5rpNfeKoASIvKy8Ousr+T/JBD9Sgx
         P+uY4MOVDNKt/JrjadgSceumM9yCrPeUfuKzhaARWimb4AXKCTUsFJz2PqHQm6i1c9Yo
         pDXKHjEmArLAoqQn0TqBzB3aZe4JTQ6i+CxR0O6/qSlDQWqtYegbYUNqEblKZ/aCJv5i
         QE6rKa7vo77njt/jm9/DgLiVmH+CdnvVc+4p2JJLBqFDi8hZTGpurFB6+2uAZz8zTjej
         IbSQ==
X-Gm-Message-State: AOJu0YywXbJNWBOO4nzSZ1aaud9pw2mQc+Gd2JULYZ03O2AH+S9Eggt3
	M9YO5RW6uxZ+NIOyHYVCgyJlhhc3DdgL06cu/yZXeKNNtlWg+TxkEyy4eoBWoQ==
X-Gm-Gg: AY/fxX7BPpI1015pQjEdLr789xRw1P9T0NhmdTnzKY1Gbcya47PT7X4IfDshYDVpcfe
	7s0a/rI+hdLiowhhCIJxEmYZnxhi3c433nzW3She7vhfM0XwexXQnWDgTlUUtszxie/mL/gNESc
	xsmvPYNAXVh1Jh8dfRZ1LECIWjW7Hr7QE05yHQaNB1nhA0fT3ABpOEJnxr1TzXMX4WQfy1o9CPD
	bG5xgii5LDnfF3nfojgdF6fzbhMQOsJkHzHuvPvqnTjueAmIBWGUIro/ecz3WQbcjx6SRcf0lNl
	q+OjEzjtbP7kayFZJ9rXVToMH1hfHKaVs3Dr+kvyBvLtx02+U2kbUpMXid/8Lw798oPXRonjqEj
	KstQg71gTp1dC9SwSRptYpYf3xsekx8gc+Qprk2nuWvwa1DiLsUCOVKF7Fg3wlrbrgN/G
X-Google-Smtp-Source: AGHT+IH9B4leeP3iAFyaMLs6+tHiYh4i0bAJW2RijwR9YCDkyxAM34pqEVN651PWq0VElMyNSupYBA==
X-Received: by 2002:a05:6512:31d1:b0:598:faeb:2e2c with SMTP id 2adb3069b0e04-59a17d4901amr4307527e87.34.1766414237925;
        Mon, 22 Dec 2025 06:37:17 -0800 (PST)
Received: from [192.168.88.199] ([188.112.145.126])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59a1861fcccsm3163027e87.85.2025.12.22.06.37.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 06:37:17 -0800 (PST)
Message-ID: <3a63d796-b975-471a-84b4-8f8e7046615c@gmail.com>
Date: Mon, 22 Dec 2025 16:37:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Reply-To: rodiev.gaf@gmail.com
From: Eugene R <rodiev.gaf@gmail.com>
Content-Language: en-GB, ru
Subject: [ORG] git config list
Organization: RosBalt Grupa Holding
X-Subswitch: Organizational mail; [ORG]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Sir (Madam)

On the page https://git-scm.com/docs/git-config (Russian version)  we 
can see: git config list, that is might be an mistype as we supposes to 
see: git config --list

Thank you in advance.

-------

Best regards,

Eugene


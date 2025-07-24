Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E7241CB6
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368215; cv=none; b=lJ+5yLjp/5+B0XKalKoV8/mqcLJa1tZ6BgWwZ8qEVIpgsLcDSotSfw+NNxTdXbSxIhrEHyl25VgtqskYCPNiM/XEcbEiXTh8f6N6abQD2RVBFBJRBHPumnK3Q8b2NKl/VSOD0Xs86uqxrlkXcqqtoKoAZ8whYmQr2glBzFJy5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368215; c=relaxed/simple;
	bh=XBBwOgzBPjO9XnQSpd9oTVx+A86Wm4ShmETaxZxerSg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Py+tb8ppkA/6Yb1DMqB8zID9uRm5QL/o7VDM78rTQRIO/XDxn1GWhl/ALKjar7retTXfIQnsxVKMqPC3lXCXnenilU0ekb7Np6tuJZNTAWgK3h+IwIvvyINGIzb7YKLkrtVQhMq0KStlPMS0E1KzWUEWIUmiZIU2wez3XdzhHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFMGx1+3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFMGx1+3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1327777f8f.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753368212; x=1753973012; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XBBwOgzBPjO9XnQSpd9oTVx+A86Wm4ShmETaxZxerSg=;
        b=DFMGx1+3qU9GQn07BGM5Coz4ZnO8s/ygykuUc4+uGx2SUZtCtPUG4a4g+d7+1RHn1z
         NpDuy2CK55i+2v+tnvG3GO/G9poTbW9pF40DtaxvxqrZ/wa8JGCehd+8a6oK/cYqeujP
         xvG653eGCrqcei46C/ozoGNQy0ukz+u6b9Dfw29oI3raKI6quCfnAodqeYOrAuhqBKPm
         CtuBL2odG/tvixgN7ebARTI35yrs3FMms6vxuP62l+twxT4jbxZTMd2JuU04u6uvw5Lf
         N5WSivjBFHovl6kUl+HXKF8MGw8KPD7aXHcl/aoQELaNygtDEPkUCes0fmxuqeX2B9Ha
         5OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368212; x=1753973012;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBBwOgzBPjO9XnQSpd9oTVx+A86Wm4ShmETaxZxerSg=;
        b=Az/i1vfgz6pHaEXVsm6ogga6EUqE+8+UtQMQkjfKNgLG+ALQXjWbbNKADTrNMUtdTI
         ks3cSVj6DbgJ9O6A47qYsDYdoGAenZ5nFN7l7R/ISu/a4uPPZ3rH81fXccCj5iSF3EO4
         y/RtF2Tw+3O95Ob1bVpEJYseZve1cNCFNg0EJ1i1JyvUTN9sthKlyJzTNsUBwygbO7x9
         AWF570Y0hN1VsiLrataX8kD3A5vlyLBq5w+jeiHo5dhgDyYMHh66FurmsNzkqNeyVBVd
         mD8JYLUYeFaYWcef3Tgf3VbaorzuFRx0zna6m/uoOBwt+GbHOuc807VcIzcYh9vvByU0
         rKsA==
X-Gm-Message-State: AOJu0YwmmEc6wiilqVJjh1dmScZeKp5TVqtTdkBZsZGwNs2gUwGKf26/
	PlcTbVJD/IghBX1B5t/BaxatVnC5A7nJ1l3n/aPBhSq2ju7oX46QIeRTeezkO5TRfqCufxd7dc2
	wIPO7LRWCLorIbsdidUrqs/1w0QQLljvUHw==
X-Gm-Gg: ASbGnct3jyCCIDlFRQ0AJuS5gFTcoEs+xYbe5mVVJEKnd/jAwSPK/2X+ed4oxFPrIZn
	Yx1KIcCh6T46QU6ZRzYfuEfA0YBefTRAhL4GbaNpajxvs7W+bvg+gHamw8vMTo/6UehnIPtCyHD
	YQa43zJc1E4q6D60rg0Ka3EmDCQaDuueL6enfYYM+blyYae8OcKa+COTzjLJ2xEc6NOnllArima
	uCUTJvn
X-Google-Smtp-Source: AGHT+IGKtls0IJVQuuH5tOMm0TAy2ducmKNniPQezufrC0bcwqB1Jql0uzaeDLfQDXLw/4dVAq9x57w7ROM9bcATpoQ=
X-Received: by 2002:a05:6000:2582:b0:3b5:f8ea:28ff with SMTP id
 ffacd0b85a97d-3b771143b48mr2079352f8f.6.1753368211762; Thu, 24 Jul 2025
 07:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cameron Steffen <cam.steffen94@gmail.com>
Date: Thu, 24 Jul 2025 09:43:20 -0500
X-Gm-Features: Ac12FXzsZ1atDp1rRoDzRraYrJ5JZA271EOacnpzQJvewVbOQhxtOlb3wnz8Nhs
Message-ID: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
Subject: Show skipped commit message after rebase conflict?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git Community!

Sometimes I run into a conflict in a rebase and I end up resolving the
conflict by removing all the changes. Then when I run `git rebase
--continue`, the current commit is skipped and the rebase continues
normally. Would it be possible to emit a message showing that the
commit was skipped in this case? It isn't very obvious to me in my
workflow that that is what occurred.

Thanks,
Cameron Steffen

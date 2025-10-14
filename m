Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9628DC4
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402672; cv=none; b=V4CWDk8O6aUZa2SrK2ZwXR3F+MtyCnvJ9p7/3p3kJH72nfVqhA8TwLZUVtNpEViXBGeTICyQ4IR3szmspxwd8s5FWG3n4b1khlkFOfUZTvO+F4qKujRdvrKVi26ESnvFLF20TR3FGElNUBl9jQCL7aZ866iqq1Guq26KS/RTsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402672; c=relaxed/simple;
	bh=jkW6FlN8c36vxf7cuFXxLqHZgWYKcqhmtyaCG6Ssufk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=d+nQIfx5uzk0v9OGOEImFtiZG1P4VV0i9GzwnpDcnkldjedX1HHoFuDe0kM2C3mByeUpt3UiaCiSN7XOXQFSZBxztnLEZCXywQ2UNDEmeTq1qbolq7h/Czif+5sNSDkddXKidUarxuPBtpQHZRdYnBVwvCSNOV9OlUlIz3+cBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmoJkAOL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmoJkAOL"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so3903952a12.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 17:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760402669; x=1761007469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jkW6FlN8c36vxf7cuFXxLqHZgWYKcqhmtyaCG6Ssufk=;
        b=VmoJkAOLpvj7dkYJfqdBWSYfUtVglQhKXW6dsKhgx8vTlLbq4Get6+Im7+BbPNZhBy
         CklOW5pVmKPqiDj2Ep5isiZRbKkmI2MHCFOU8uJmXliFMmDN5ie0ZA14p43/6LZM1qir
         G/yayYH1i5Ll4CxzXW70Nj33hyJCnMuz9xlO4x0/oEjFZ9rBDIkICbgfLv6kRYCun6uB
         4+SLx8DIAEjcZ90TRVOmDuBBVygH0xskb/HtI8QbHnBydFZ1SXqOUoVBnzQYBImcp3Vu
         0+CUQrlkRZDtHj5ksCEnPHnkGYlJ2xIfisLxPI1TRvUtrpTtq33wmDNh/jLunLYHF+YN
         S6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760402669; x=1761007469;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkW6FlN8c36vxf7cuFXxLqHZgWYKcqhmtyaCG6Ssufk=;
        b=enXxSDW2yKirjTO2YnGNF+zTsfDxU25QZ5BoZOM6+kE6ZAXBkYUQU6UBwGQdgRv5a1
         AY6BIoC1utP+/gZnGwZLvEbOlp5+yOHXOnw4HwfR6e795c5v7mrJoxgDp5cbDnO8U3uE
         sgOtTRVE1tmzYoXT7EenUqnMfqdf7n3evuSFIK/Y0N2SPvZ6eaAgUuOqCOrQBLQYH/Mc
         ObgXiZ6PQLxJ6Tz5qEZaZ5nqVNGaO5xhRWTnIIfmNgxT3bHO9Sw1zcwM4wvge60lenl0
         aFUotL9LeN4adP++A+5WwkS4HqexgjRHdhFbrW706z32qQeBygJS4hbMDYO0d7TN8/MK
         fYug==
X-Gm-Message-State: AOJu0YzlxGFlEzmlXHXX9RnqwR0R19KncJfyj88pYzmgSSJ+u0vQfHGX
	7UVICtanIOzIiKci0A9+eDxl3Ld6y3fupdu26S+8VgfEFbEc/flv6ngPvrR6CX+qhTZFg1Hw5in
	8tO4YmQRw3D4XK4eL+h3zq3K3sWn2OqyU+jGb
X-Gm-Gg: ASbGnctMIuFEk/x03V+AYbos9kNrsQtV1oC94u125HNBzd5r//fAC622IJaqm8y1J/W
	Da8jRZgBxVyyMt7ZrU5P1ty+el+pbbDG3ev6jdPrqL6W8ifoevGO/N3OW2zeKih4/XWJf2CwAeJ
	FSYpQC4B/yXhBJxK98+/1w9XZxp0toiuxrfat/9gVL12dWJJ4L+fUU6Cjc65OfeKor3EizBFiYs
	0xKa91uKjTXQT7jO9RVy+QhRiWKmW+jmxc7jQ==
X-Google-Smtp-Source: AGHT+IEvce2qIKfC5FsE26ZnpAPZdmGO2HPvpi2nV6XLR1lR7r18hiEbv8fsfxmdHge4cfewtmIpeDgXZ01KnLMrF70=
X-Received: by 2002:a17:903:4b47:b0:281:fd60:807d with SMTP id
 d9443c01a7336-29027e5df98mr309697325ad.2.1760402668598; Mon, 13 Oct 2025
 17:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 14 Oct 2025 01:44:28 +0100
X-Gm-Features: AS18NWC-Yy1sd7WWAmVwYmwLL4WyWUKht53D-Snd39sQWfZ4XAeya5ZoKvcXOTs
Message-ID: <CAD=f0L9Z2kPWv-=wPbtytbMS7BuUtmAKCv2X_2rq0hB_Wsh=UA@mail.gmail.com>
Subject: [RFC Outreachy] gpg-interface: Replace strbuf_split()* with string_list_split()
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Christain Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

In continuation of my search for an appropriate microproject after
temporarily moving on from my mail to the list which was about
the check-whitespace script check for \No newline, I stumbled on the
thread
https://public-inbox.org/git/20250731225433.4028872-1-gitster@pobox.com/.
After studying the thread and searching the codebase for other
instances where strbuf_split()* can be replaced with string_list_split(),
I saw some cases in gpg-interface.c where get_ssh_key_fingerprint and
get_default_ssh_signing_key functions use the strbuf_split_max to split the
input string and I think they can be good candidates for replacement with
string_list_split().

Please, will this be good for a microproject?
I will also appreciate any guides.

Thanks
Bello

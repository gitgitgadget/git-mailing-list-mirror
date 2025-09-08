Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63AF238C2A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358576; cv=none; b=GZfVSxA2mLLHo3vDTxF6jZc56ey6zlYszbpZxKT96lxdjvARC2tpiFj3cY+WJ+HGs9VkGCP3tGbAIeWHAgDG+tp8vGBmOlGSHEqNzQ697SjyJnW8YO8V3Ek95em2eMSjgHGBAlb+ucfARkHCZ+BaaQX9LDMokTKlEKao9t3lrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358576; c=relaxed/simple;
	bh=E1GLbW/D+7I1zVXiIi4N0TIqeB2fSN5B3zdkki/nn8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUkhCtTm7/3woujd0nj2d2UgpeadhOumpssopD3aA08K2uv9E85bs8NCiJtC/NmgdVqSB8qDGeNSCD5u1cJ8DvNoq8BGR9JiqrT1GqYEfjHfoA4rjDpbaRl2dVOkglVnhkz90cvQ+M1kMXxIWNuFwWTGhauO7qXJ1a4jsnYo5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfH65hCp; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfH65hCp"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6089a13961cso1214471d50.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757358573; x=1757963373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E1GLbW/D+7I1zVXiIi4N0TIqeB2fSN5B3zdkki/nn8s=;
        b=nfH65hCpMb/LiBYt8oMyh+69kZd9t+ciWtpnyAsHOGns1jjMSg1HOPo/UHWpgROb0G
         gvA01h88jwxEIwnIQEk0ryur4VSTRH4AFY+RB4Z39AMETd7WSU5e45zDecKk4mnqqBRN
         H31YoRnw9OWXSET7TEj0G1PikozWYKmJXhJx6JXDuNYR/5rf9ytMBkjL69XsTEjYvNDd
         bvVy4xDsxrr2HUG1UdTH6UW6/cv+fJu2q0lHGgMpVLe8doicQR1k4ZNZ5f4NJEZxKZJY
         PIaOKZT0EykVAOrY2ITj4+KGRHocN7UD0cgynQ5ikpUgrHNavJyuvrV1PsGTdMaz8e9K
         i4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757358573; x=1757963373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1GLbW/D+7I1zVXiIi4N0TIqeB2fSN5B3zdkki/nn8s=;
        b=eCCRjG6HEcjYVwQmkC1YPgrVdDoYh5Fc+9lqqXPJ1pKR4Cz8jZIqWYB/hhCNmBfXDO
         Ty3dqOZlM+mU0F/D4lBLCa3x4esEQiHzXcM58/uCBP2kcrsbMZfP/elRENMLSa/gVTeP
         4hp87pktbpjEBKWyxgiBDlydXL73XAI/kBypaFRq+gjg7ctkbLavOPDLSRgttV7gzynD
         KXRZQkBesjZ3MPgIapAAecIyN30p/PCf/7upQX0n15FNRIqpxO6E1OKDa/6vlx0y563D
         bmkgE6W8kZPDAj2T6yfFisDm+jxOdVJILJve2rUdKC59TyOgigMVMkdLK/tY5j8Q2tYl
         S/MQ==
X-Gm-Message-State: AOJu0Yw40HwYohq/MwEgK0maZUT58wJT0ZOPX/ZcgojkbXYD1ZTTfIjQ
	MQG9VJsvMFtCSLXHpnYTV6dkgfcl6V3d6VHfW0mg+xJ5+ODbYy3FQ8Rec+LMMCxOgrzsooQ263k
	CRPphAGpD0Mxgo8+JETO0yvDgjjX5LUI=
X-Gm-Gg: ASbGncu1uCS+sBgsZ/c4pVu+8JCk9DfQkDc7A17CWslWa4FBuoWAIFPGfK2Y7P8Y7bg
	6eUmZxcsVRVAxqs84sSe0vLJdjsilHnEAwC0/Z219FeW0M/XM9UgX8XxZWkqEl8OSikN2jk3YUc
	JbSUp7eJnvC17qh3rVfVOcMTBlCqtmXuHy+NRiyDc69h5/+dXsBmOF9wM/QTReACI88MV/TGz+O
	JmVIx4=
X-Google-Smtp-Source: AGHT+IGema93qY7w5jEHst4r64t1FhMfyiKHFMzYZoCLktFAY/bpQMnX/GrgjSUFmOTblffQz5tIEeIISHFBKT7MoXw=
X-Received: by 2002:a05:690e:4246:b0:5fb:e9dd:499d with SMTP id
 956f58d0204a3-6102301c626mr5626883d50.15.1757358573531; Mon, 08 Sep 2025
 12:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGiEHCv7kXSB5v8Pi6gDYaC2O3m5qEM8dYW3vKvNm6sXQ_Vuhw@mail.gmail.com>
 <xmqqikhswzl7.fsf@gitster.g>
In-Reply-To: <xmqqikhswzl7.fsf@gitster.g>
From: Milan Hauth <milahu@gmail.com>
Date: Mon, 8 Sep 2025 21:09:20 +0200
X-Gm-Features: Ac12FXxs0YPRf2KAiE4_-M9xqwTRmv-s2v7RYlePydnUyVFdKqD-_PLt8ErUb-0
Message-ID: <CAGiEHCuaqu0ia7H8FKAPLcL3Gi_b0gKYe6ugjYAbyVkbd266_w@mail.gmail.com>
Subject: Re: Git dumb HTTP protocol should use WebDAV PROPFIND method
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> assume that WebDAV exists on the server side

no

plan A:
q: GET $url/info/refs
r: HTTP 404

plan B:
q: GET $url/.git/info/refs
r: HTTP 404

plan C:
q: OPTIONS
r: Allow: GET,HEAD,PROPFIND,OPTIONS
q: PROPFIND $url
r: ...

plan D:
q: PROPFIND $url/.git/
r: ...

(q = query, r = response)

so instead of throwing

> fatal: repository '$url' not found

git should try plan A, B, C, D, ...
to fetch data from the repo

currently, git gives up after plan A



> the WHOLE point of supporting "dumb HTTP" transport
> is to allow a truly dumb HTTP serving infrastructure

there are at least 2 variants of "dumb HTTP servers":
HTTP servers without WebDAV
HTTP servers with WebDAV



> assume that WebDAV exists on the server side

for HTTP servers without WebDAV
see my other thread

Git dumb HTTP protocol should work without update-server-info
https://lore.kernel.org/git/CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com/

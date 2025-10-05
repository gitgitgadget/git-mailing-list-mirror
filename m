Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AC1E990E
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759664018; cv=none; b=UGufC45EneAfpb3LnL33Eoxcg258jFmYOlqu69DbA4C/huzgayIpOR+CiTXT834w5KTEFwNgjswaOtqrwPPYbaPSJS14RyHb+of0GAnsk/p7ciIxqCWjse1+331u3JXi6U+EO5syXUyLXFTPIYoWN11StLIsxKqF7dRcvhDnuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759664018; c=relaxed/simple;
	bh=ebZ61whLT62EteYw+jw9rdtV6aC2UynTe1LkzO1p2HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tyJ3QiTuo0ZQ/AH8DmCJaEqDURgt2pp8mH3uJ21aAFlnOkoSY/gkZhEQdAkls3+Y+DzL+eubfFAjfZBYclkFt7KmfBeakVmz1ABx6tdxYnECaD85nsxHv6HpdmZVQk8X3WHHLFwdsEUV31wpyRUI4A/UPLB1JM6c5lx+ef0YFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wik4BPR4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wik4BPR4"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3717780ea70so42477201fa.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759664015; x=1760268815; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebZ61whLT62EteYw+jw9rdtV6aC2UynTe1LkzO1p2HM=;
        b=Wik4BPR4LBTrVmCIGm41Ka57XNvcmZe0IeM7jGMK5oxnzarViUahzVsBPXevjrzv0r
         SCUGXK+jGIWrhTfntJ7Bvs6WccOu5oJpCMhT909nQjtEGlK3xhFTmQKBNZnNkh//Rrzx
         839uc9ATAAdxzDqp1LgP6WOA0mdYTp6bziriY1IlUVOVt/y/3fxQFtDDXeIbw1WhjbK/
         Q/OXPZr6OgslBDscEO0UjBR5zYeb8iNPEUQuvq9F62pqtCkoVaddFPearEvVROHqJdwE
         H+yb6GlM+frfCHcXaHC6UxMxsY/15baDmTbXcy4/t8gIm7djAm05UyaA+TTa6fF9W8Yy
         donw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759664015; x=1760268815;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebZ61whLT62EteYw+jw9rdtV6aC2UynTe1LkzO1p2HM=;
        b=F3RfBNdWdJzGMLykNAOqGCcPfcK8xvM0h8JgROqTldcDUB2+rfUI1mg2tkTjN0AjKv
         FAYSv/SyP7Zok7RfnJ3jEpD+LJ6wtpH5g8lr2jfsd6+9PfEq5YVVWupr7JBNjdNUG9nQ
         n4GMi19Cz2ABJL778rRtpkhizx0ae3qLuf+BkReidRgz4wFw0mkU5C9Vb/Di+WB695Ga
         9695Z4TTvtt+SUmSmLsu7e0gVR8cRU5eNEzW5fu+nQXIu23lX6U11gjzw8/LY09FjDLl
         PIdgXTgFCXw57o4xQ/mxDtpcHOgPVbQU3KiRf63gHq7hm9vgEezt+WOIWgSUoDmQ7MOZ
         LFww==
X-Gm-Message-State: AOJu0YxoJLEX1eOhUlVq9sA9EPJqSKX03OOgac7LU4KhAsJO/vP44cVc
	oZlwSG+oKVTvKB6w0ujWkV4zRKr+deRVuwjOdRwOmFjZJ3mnVa50xOTxgivswqJ0Lu0oAMmFfLV
	cCuArkI2Q0neXf1ZialTyqs4/wZYWW/OqFF5e
X-Gm-Gg: ASbGncuBAHVG6ZL0QG7yUeU8fdHQvmzWkbrp67ZpNFgGHI0ucIGGPqGMjK7lDATuDFG
	AIuz3FIA3PiNFyvp1ycRrioCsMDQ+McpQsjV+sfc+ekqbYnSfaUpicKaDL81d3TNN4RQlZlsXsm
	TkiyexMGq11JuhRj+AwssXd2kJgcBXnlZt3svCXV4VZkKInYgHSSYZy9e8cMpVCVpkzvGXzTOoo
	a0/97ALCRR242YAXUYokJrRwBW2
X-Google-Smtp-Source: AGHT+IF64e3un5vvX8kTEzCqHkleQqVOaZQLDyJj2HvhxtIFmuUCTYRrXgV3FRBta9YBtWaJ0lq2oFZRzajLfOvZirg=
X-Received: by 2002:a2e:a545:0:b0:36a:6540:3ba3 with SMTP id
 38308e7fff4ca-374c3823217mr23348441fa.39.1759664014565; Sun, 05 Oct 2025
 04:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV0R7OYJKeBAs5-WY2Wqp7VxhKv5=LQ4cuDd6MaQwNqGNw@mail.gmail.com>
In-Reply-To: <CANM0SV0R7OYJKeBAs5-WY2Wqp7VxhKv5=LQ4cuDd6MaQwNqGNw@mail.gmail.com>
From: Devste Devste <devstemail@gmail.com>
Date: Sun, 5 Oct 2025 13:33:23 +0200
X-Gm-Features: AS18NWCensWv5usmZcavIo8XXfbqZ-MZo7Iuw7ypIuYMAusS1w_6QCd4T07fNx0
Message-ID: <CANM0SV3iRF=jVAFj=+rrgOC_nXEJ=_v1bUG88n3T9+PQD=a2-A@mail.gmail.com>
Subject: Re: git clean deletes negated pathspec if directory causing data loss
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Just to clarify: it's not about the negation not working, but clean
ignores the pathspec for ignored directories completely. I only want
to delete .rej and .log files, but it will also delete gitignored
directories (that may or may not contain any .rej or .log files)

On Sun, 5 Oct 2025 at 13:27, Devste Devste <devstemail@gmail.com> wrote:
>
> I am using:
> git version 2.51.0.windows.1
>
> Run:
> echo .idea/dictionaries >> .gitignore
> mkdir -p .idea/dictionaries
> touch .idea/dictionaries/foo.xml
> git clean -f -f -d -X --dry-run -- ':!/.idea/dictionaries' ':*.rej' ':/*/*.log'
>
> Outputs:
> Would remove .idea/dictionaries/
>
> No matter how you specify the pathspec (':!.idea',...) it always wants
> to delete the .idea/dictionaries directory, even though it does not
> contain any .rej or .log files and is explicitly set to excluded

Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB83090C6
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113422; cv=none; b=VzTDmGDfk6EkqceVHn/GNYwAo1OqGMSIpamxqPy50bnvptEH1VGx0/NgiuDaQTerT55j9xNRPERmrtU7XwFCHdKYls3GSpxxB/ztIVY8RoNlDlBpNh9PTagV3q50LPiJAO3U/NrJsCPon0fb6SAC//1rV2TYAfASqd5pBV9Od8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113422; c=relaxed/simple;
	bh=oqmxxix9wJMZ1T6fW1nUdS2iobsu1nJ+xR3wpPPXtSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOOzoX8qkyDfKLqGVYgGgOy91c+9n5FmlTVz8OK1mLTOyTceLJQmPcxs+CXCWRZUon7MM944LHug34bV0NAE6WaCQndRSPXg5KqDjeC5Q8sUN9WQwiB9KMjW03qlAn9dCP+X87O+eJhijrkmahTW4DAW1E7C1S8swIX2EPwVsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJvMMjnW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJvMMjnW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c05dcdf49so32565041cf.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113419; x=1786718219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V4cDMckaTpbW8fkum60njm6XV9LvPReOgi1mq6mwVls=;
        b=OJvMMjnWc9UP1nl08YQG8pK7OzdRUrvVdzxrIdi6CQCyfcYnKTp1F3iuMzKslXPGUp
         1BNUu/DpPzMg8ve212k5ix3WxmFbOtA/cvgPeQmLiLJN+8ux5fnjGP2W/eQdNwgREK4i
         htXGOPKFRHDwSAE4NbMtaSI/LU5RfqR2LENWOajT3TCpec10JQmB6cTzCb84BZ0dVYru
         ePf+x4oEtUmdX/JQt1vmdeh4YKfmyqv0AFf9J5+bLKUb/+aWfXJBwGYb7qBKXXRn0U1f
         fxkVnseahAehO0v3Rud4h6Zf/npF0+Sa/39mXV0L3CM/6QvTcFdm4xOdlLasIUy+bQCy
         IVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113419; x=1786718219;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4cDMckaTpbW8fkum60njm6XV9LvPReOgi1mq6mwVls=;
        b=J6EPSwAAezQKoIWbQIb0Qw3DWYTUWKhZE+I6EsRAsh0T3an7bBZzBqYU/O/FsuDK+M
         Q2LBeKzRO8c7x7SfL7zIGXtFWDXvExRpNRnOkRXO8Y/yiVZx2aTPczt5f4VkoMzyJwtY
         eSbe2+LusNyW09vyuXAoBiuISspJA4+Sge4THcSxcp+6dMagKIQ7F1rGOh89UgK9F2Nb
         Kj34r8QgdxEJewknBuRtrxTleTSmG0AV1r4sqwkjgHcacLJ2TojiodDjhM4hzzl63gcI
         yEByJrkOgp0HZveUsxqoSMtpBccB71Ac1HEBSimRVkY800oSPeIwlgLPtF/9SpN6JD2K
         ftmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYin+X0Hwq3brN2if8n3WbiyfAP5YpKg0A1EvAWEsyYSBFez+3yjbu77wPdOEnX6d6keQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvN+mtyoxKiO4lLvZe4TxZK0phMtXpYqCQN6B0NTPfcBOWont1
	PKtJKyzl4ZKdYNeuom+LGDd7ChXDE1wBDIm8fFM2A6VCylYBTv+RhUfl
X-Gm-Gg: AR+sD13SFn6AyT3zI5CGqr4SAb38ZK1VHeecNkEDfc4ZkRC4grd5QxGAJf0vCZe6Kz9
	yBmkNECT7LoAfH/mvrY9PRNrb3bNwX4obhdnECLGdiucbMvMSnnXjU1Xecun/jOa6RsDWg+81A5
	E9umMZKuPvf3WH7wKibHepii803nvcg4xhLdByy665kXU7VTdagN8xj4bKMVcezbMRQ1SrJiHD+
	AiR/o7A49z651G45GJEEQC9NpOnzb+TSk7MBHzrswDhfUm72S0A0P0tytWR83DdxNOVAgARRgcq
	WQyr6sYZjFaFPL9JX8mM9klCBXjkGFeqhFTMAseKNSUmMIHxGzvxh/bjV4PhSE2GiOjwCytyHaZ
	xrJPxHoS6h58BCb0/r1tHsV8yQONA6uZRgn0sb5yoMHQSImDa4mKDBTDUUSkizzUce3X4xRmFIH
	6TABLmCk6UOhQ3FX6j7zpIFo9G9zPQW3FFtlypYXDXzjp/7kQ0rAf9necOw7cC2ydkNZo1po+vW
	8/QXEBCJsFC8KklkypLl48pO1VLrEMbMt2lWWfPG2B+JuY=
X-Received: by 2002:a05:622a:3d1:b0:51c:a2ea:64d3 with SMTP id d75a77b69052e-52ce61c772cmr239933851cf.35.1786113419417;
        Fri, 07 Aug 2026 07:36:59 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1659c1e4sm13075891cf.19.2026.08.07.07.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:36:58 -0700 (PDT)
Message-ID: <4a1dc534-e9bd-41e6-8ae5-fb08c06479a7@gmail.com>
Date: Fri, 7 Aug 2026 10:36:58 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] gitk: set intitial colors of swatches using the
 available helper
To: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <ab16ec6276e448db3c8150e58e2f08d137317198.1785998419.git.gitgitgadget@gmail.com>
From: mark <mlevedahl@gmail.com>
Content-Language: en-US
In-Reply-To: <ab16ec6276e448db3c8150e58e2f08d137317198.1785998419.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 2:40 AM, Johannes Sixt via GitGitGadget wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> After the user has selected a color in the Preferences dialog, the
> helper proc prefspage_set_colorswatches is used update the colors shown
> in the Preferences dialog. Use this proc also after the Preferences
> dialog is constructed to show the initial colors. This keeps the
> procedure that gives the UI elements their colors in a single place.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
This completes collecting the color settings to one place, Good!

Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35C2139A8
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535278; cv=none; b=W1oVOhzVCT0B+pd2H4dZJeoT3U7uJ+7nRHvaj+Ci1v1miJerxj5QgpH9lPMRMCRkP7kNXdO/OXveDQo/SmUK3zz0XsySFo7BFOLj7L/euCMl0cYl9qXlc/5sFBh4X309Tf+fs8KDP3D/y5e8mb09UlMW55fTNzxRx89DutGeR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535278; c=relaxed/simple;
	bh=D8yP6lpow2+A2JDoFlHy4WxZK6+ilSA1CHL2XKEjWl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANx9Gla2Lg7Faswxrof6ImAWWQpdr4ESzp8sF/oJkgjS9WQ0FsQzDKM8i4toelsdB+/2CCdmPum4aXuPmsoTj7H9XsAL3gl5olhO93U/j2ZApk7xN2fgr3wCvEm0TsbMh2cDHgAKWo1A10DbGNckP8ubO1tqpyGP7GqfkVQt9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0xh+glT; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0xh+glT"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef60e500d7so17656057b3.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739535275; x=1740140075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9rBxtMmZ2tbNk494NakRx7DkEIGSV28a94OJ71uDaQ=;
        b=f0xh+glT1wVdUSKSM/uoQzz07diNk+4bqTssXROmo0PAzMBppOJpHyJAEtRXFBtTma
         aziLm5e0H9I6t++UMMSTvZMJwfzf6YukN8R/ND8pcJfHCNviECjbV+oUVbXjVxDYtDun
         ytFZMIzP0JijnZVuXh5FmfeqezfYIM8rfBW0Gsu4VwHLnnDuE7gOIVzKXrp00Yzk600a
         4y578X8eIUmcjCd2NePTEzNYR0jh1+MX+3FqLf6HUoLolMNbVMzf6zXmQWcXbDIompmu
         IZaScg26eR8wkPrXp8BtTJorBE/dMIENMCGwBwGVrRnUBJMqh8tigueVbzqJkcf7mmq7
         3zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535275; x=1740140075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9rBxtMmZ2tbNk494NakRx7DkEIGSV28a94OJ71uDaQ=;
        b=vgoPWZ849Pm/uYroBVCL/rIGdwbmCXzVK03UnXsdu21f1vKsKkLSH0HhazuMzrTMXt
         2xZp8D8dssb0TBoPgob91kyt/eDV3KNHmjg1d7LUtj3ChnQTVAFedhiScu5FWK4dOD7s
         1AJg4pnzb3chVxYj2jLc7R1AHSv10y++ewPYGDV13FAAOQKwnfIwQZ+GUK2kvf191FTb
         hWydfUv/fFIsifaf0SbnwfTOpFs7N0B7dYjB7DFhszkcF6otNnsKWXfJNkqA4tmGx8k1
         SZOFejOh0m1MsACMZpM8IUQxVgMjtb/zuBvDAHBFMuB0og8hdAYmfImtB8WrlQkup055
         Ga6w==
X-Gm-Message-State: AOJu0Yy2QxjZ+MAfK6K+RrlkN63seURlYZVc+Z/3zu9k3HHFNRCwV29j
	bJoRPEMwgq8ceY+JM/TIGTznjcXuyt2c8O85kg3AQI6EF/9QmQA+
X-Gm-Gg: ASbGncv9seF0ouev7rZTpEYV+NC13+IHPjheBqwaBURbmk2WLi5mIONp+XPWlfh9mJv
	QISmOKVWkfkxmtEsy0Tn/mpeK0eIpcxpjm6jRWkxvhCPzynWVB5DaWLfM9EotT7ZLphH+Efr5Ge
	2t4xOE4kmdCYLTC4WWerEtvzqwUV/7AWYNApT1yqvoN67tXvUk/9EOvs5Am7dzHJnHmF2pZqg9n
	vtOooJlIab1G9n6hN5gOVWnGmvGNv/AoNOSeQ4I9aYEw72n4RoMBmlyAiVEh2f2CoNxaA==
X-Google-Smtp-Source: AGHT+IH0Okgy6TY8COiljKNDT/wDvVmxEwi/rE7JzxArs1+I9VgQBgV+y/D0M1199zjtaoV3JxkYIw==
X-Received: by 2002:a05:690c:6389:b0:6f9:a7d3:cec1 with SMTP id 00721157ae682-6fb1f5b885fmr109464057b3.9.1739535275499;
        Fri, 14 Feb 2025 04:14:35 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb360954c4sm7288867b3.52.2025.02.14.04.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:14:35 -0800 (PST)
Date: Fri, 14 Feb 2025 20:16:30 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 0/8] add more ref consistency checks
Message-ID: <Z680Hsu2ov_ETVzl@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z67LkxAFIAeaYr0U@ArchLinux>
 <CAOLa=ZQFLTFNc5AnvDyAaLvY8__R+J9RHZ29TM8COhPxnQs8Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQFLTFNc5AnvDyAaLvY8__R+J9RHZ29TM8COhPxnQs8Zg@mail.gmail.com>

On Fri, Feb 14, 2025 at 01:04:09AM -0800, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Hi All:
> >
> > This patch enhances the following things:
> >
> > 1. [PATCH v4 4/8]: update the tests to verify that we don't report any
> >    errors to the user in some cases. Also, suggested by Junio, make sure
> >    that we check whether there is a trailing space after "# packed-refs
> >    with:".
> > 2. [PATCH v4 6/8]: instead of greedily calculating the name of the line,
> >    lazily compute when there is any errors. And use the HERE docs to
> >    improve the test script.
> > 3. [PATCH v4 7/8]: instead of storing the states, we parse the file
> >    again to check whether the file is sorted to avoid allocating too
> >    much memory. And use the HERE docs to improve the test script.
> > 4. [PATCH v4 8/8]: update the documentation to emphasis the default. And
> >    add tests to exercise the code.
> >
> 
> Nit: For someone coming in to review the 4th version directly it would
> be really nice to see:
> 
> 1. Summary of what the patch series is about.
> 2. Changes built over the last versions.
> 
> I know all this information is already spread out over the previous
> versions, but would be nice to have it here (in every version rather).
> 

Thanks for your suggestion, I will do this in my later patch.


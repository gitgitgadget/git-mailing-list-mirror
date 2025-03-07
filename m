Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1D20CCFD
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341688; cv=none; b=ONHrcbCkp6BlJLUMlR+KOb8oFPWIuete7Y5UsoMFyesYXzBOVg/szQmAGUyZYAikxIKFcjOaTKIZMATv//9bY7qYK2QQuD60fZsBoHNkKjRYJVI5gG9kHvEos9T1njallIf97U86lQuR3Aut7VhvCx7XehXsxKG8VMtbQRqu9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341688; c=relaxed/simple;
	bh=t1xKBatOPlmMIRkC61JROV0jdoRk4SVf5SIaVXDYFfM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/WNw2nO/PbqGgL7KUKir2M/EiP0i4RlWBLWWAErMyHg8uydJt5U//H4sbYAYGTEed56E5E/DkbtwPUCAc2IACXtWPiC2sLRy9guIFxhpxVmoymdeSA3021BB01UBme93njGOPpWzQZOmBtlr2qojlft+qv6NABGZikCSAIDuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWibtI/O; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWibtI/O"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523bf140eccso1932490e0c.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 02:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741341686; x=1741946486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zet1Z4CwXcAUlnmCPCM8CA0swqb28eTKIrXpjjbzf1U=;
        b=AWibtI/O+gtPCshUADLjNv3/a3VZZnnpkNK8qJGwbFAFSbnL/AG+b+eL8AxwtL26hp
         Q0I9JAmWtV1o50pLMCGxPkpMcNFdN05eGeAyg0g6SCipjRNZVBIsl0PhkZGs0S4oMGDi
         evSVtLOLjds6nauzP9WuxqfOv5xlkOwXUJrmGMXSKo0iXbadYWq+TVSIGtSsDPu3ZMpi
         trPAPcAEBokSZHN1BkO68qsRSSSaiIcHQELTxFW8QsWaLWUa5U1XiWLz/LssvtbhdXnE
         Gaq5lhufVMvjRqdvGc7M59W3Q39SwsN0kApD2B+x1lKbD8m2JRRp+kqUmnnxWWRvLe6c
         t1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741341686; x=1741946486;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zet1Z4CwXcAUlnmCPCM8CA0swqb28eTKIrXpjjbzf1U=;
        b=FupGsD2LKDWijmdXdkx0VWV8caV4WZ2UzMk/AwhS1YNCsQsG6wcsr3UbVgxM4bjnD/
         pqhkLFFdM5l8iFNwXZIJnChuz8LnLn2d2bCRvuC/7S4Ddc58+L7FnVAxD2qfIBmWgbvr
         NO11ao+G5nN1Qyuz5uuA5kUvN9frndBEPv5dDhSwj65BmLQ9vYlsL1kf9WFw6lkl8nDO
         u63JwjcAVvbRbJNu/g8SWjoAkjVWvA5PkmoIqrKIKV+C+tCU1PDRFXRq6niCi3GIT/oK
         mIsGZMv2uqYWtYUFCH8hNzahHAwknynPdpvn8J3S/Josi2zIu3bjbh8ky6F8pBQ/VDFz
         XdDg==
X-Forwarded-Encrypted: i=1; AJvYcCVv4lNsUrSUsF+IraFxoWVZ2rzymP6vaPuSZjQk10Jx90D+iH07EJHBjDLxsdWLJjRAWp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9cAWfyVERJyg1o5B5aC3RLrOiBYSyn4T9nx29GUrHk8aVz61
	8Yim0CyjyIKCMqs734JtxlFgzykKIeyjDb6XoqfyQoM9iZlFCxhYLpelB8VEr9MfIu5FJzW34T6
	TMVqwOOSx2UuXb4TId8pgS8mvL78=
X-Gm-Gg: ASbGncs5cVkuFjwWgHKfdvNHKRk1MYF6Y/Pq7UIIOWzAp/GQrtnKhXbmd0HRU3M+Dl2
	a3csSZmAiKBnUl7cv/1T8GTQnDSprgTUHtY5ceHPdvkmEMs+DaMIwVP88ByUBc2dVPujQxc+zcp
	WcehQI1CnBiDf22FVOEzc0+vRQNeA=
X-Google-Smtp-Source: AGHT+IFz0+IKYYEC9+/mq01IrOyqeQ/ygodGnOJJPWpInNzLPfvILHwLzx7oJhEE6V2Gq2n4dMw+3LCgduCJUtnEJ/s=
X-Received: by 2002:a05:6122:50c:b0:520:56ee:78e2 with SMTP id
 71dfb90a1353d-523e414eb5dmr1659297e0c.5.1741341685909; Fri, 07 Mar 2025
 02:01:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 05:01:24 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <59004310-f270-468d-a248-c83c97de4a1f@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com> <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com> <Z6Xmrfut7jdsVAfg@pks.im>
 <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com> <D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
 <59004310-f270-468d-a248-c83c97de4a1f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 05:01:24 -0500
X-Gm-Features: AQ5f1JrA2qPAPmmCx2ZEA0wHOYYfBXDk5kHtf17THmHS8cAOD0PMgsfkHr5wV8M
Message-ID: <CAOLa=ZRM3bLcR3s6nE8nXFv32zX8-mL6fSh1vbsVetJcp9KFhw@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Jialuo She <shejialuo@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000009f8ccd062fbdb4ae"

--0000000000009f8ccd062fbdb4ae
Content-Type: text/plain; charset="UTF-8"

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Ghanshyam,
>
> On 16/02/25 18:26, Ghanshyam Thakkar wrote:
>>
>> I can co-mentor this summer. The 'Machine-Readable Repository Information
>> Query Tool' project seems interesting to me, although I'm up for co-mentoring
>> in other projects as well. Let me know if you need any help with
>> anything else.
>>
>
> That's great to hear! Thank you for volunteering. I've added you as
> a potential co-mentor for the project that you've mentioned. We
> could discuss about the allocation to other projects based on the
> applications that we receive. Feel free to let me know if there are
> specific projects you wish to co-mentor in.
>
> Also, feel free to share if you have any other ideas that we could have
> for this GSoC.
>

I wonder if with Ghanshyam also mentoring, if this statement still
holds true

  Note about limit of project selection

  Kindly note that considering the bandwidth of available mentors, the
  Git project would only mentor up to 3 contributors this year.

Maybe we can do 4 projects this year?

> --
> Sivaraam

--0000000000009f8ccd062fbdb4ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 18856f0a48dd7776_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mS3cvTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejdqQy9vRHVsQ0liOU9UWVBJM1ozNlE1OVFyeDlEegpBZDJyRVpyTysx
SkhFNXc4V3dIazhhdGt2T3VQdjRYRzkwcDJWMEx4K2psYldldHMxQS9Wd0tvV0FkdXlWVUU4CjdK
dTQxdCs5UkRUUklEYzFPM0FrclVYdVJFdHVhRUJoSkhic2ovQU9QSDdGZS9tbUx4TWQxREJqS2dL
Mk1VK2sKTFRQWEltaGxCQkdpK3h2aG9DdUFoSUY5TDB1UmF2Q01sQkJoN2VLN0JWTHRkVnU4bFRa
VnFhTVpZcDN0Z1NDVwozUThUaG5LdmVYY3VVRWdjYjB3TElWdlNVR2plYkNjZ1lxRGg2MzVPYXBy
dGNlSndCS0JINUhtNlZXaHlGRGY0CjBMM0NmOFI4d1p3N2VtSmVxUTFyOXpYbFdrYWUwTVpUSy85
MHhuc0c3anlpQnBidjBONi9qaVhJb2JSR0UvVmYKZWVicXdNelNRTEcvakdDQlNyRzNJclpxbjlv
aWNoWCthU2diUkJ4Rm9jNElvU0dUMFpzazJFbWlTcnVZdSsvOQovZDBPeWNsWXh1Y2o5MmZ2UmZw
dzhIVlJVQldhalF0bzdkemVPdzE3VGtGc2pjT0ozM2FjMzd6RXZNeUwvSjJnCnFWeWZNYlBJdS9W
dTc5Y2Z3MUkzNWxTeEFvN0srYytpSFh2NW4wTT0KPWE2QlAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009f8ccd062fbdb4ae--

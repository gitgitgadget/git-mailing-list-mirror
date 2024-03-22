Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF31138C
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070545; cv=none; b=aOT+DjlOkzGgalc8AQioMkfGt44B3g+cB0EwhBCsd1VVUwYdC07fvb+L4U/BsRNtrHNuUXdcCYfsanK55KM6A+IelhUzlHahQyhRyxFvLrKJotpp9YsJHVRDgwhBcpktzE8EkfSDWsIJFS4yWewAf60Pj6AYTDQdXFW+QYnrPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070545; c=relaxed/simple;
	bh=wX7lJQoU+qD7vOfWabBwOOOGuTd2HzKbz7D+xQT+i58=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=r26uAZWDrSVDocrqR0E7EZTbi8oi4uiFM9TImsHW8YHuWgCNR1LCXbyiw44sA1cApRwVUAZrNiz0cRQ6HMqfJsP+m+dXhMHIUq48o+mP5RRbTC6xYgsi+zt8arL1Q6cLKoMR2tx/imhvYtEkgrQ0t6TrvCKTsCxXyXMhInf5Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvrM2aNI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvrM2aNI"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789e4a4d3a5so110372885a.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 18:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711070543; x=1711675343; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wX7lJQoU+qD7vOfWabBwOOOGuTd2HzKbz7D+xQT+i58=;
        b=KvrM2aNIEe66rugXnMcQtoRUUbNTr7ZXo9yQ4p6dU0RT0JsUScFAB7kymFbUPzls3j
         CUTZRiDjg7w3Pc1YxZ34p9WzJnDl0MJvZK/H9zEdSePxUqz0/5USdoD3GESC5TmeD0RF
         9390HEXWQpFtFPhG/yF5VafJQZoDF+uGGjvlmkxVxQu8azvxVTek/r6H2ytJoIjqj5A4
         xueeUnrZNIfCDnRWz9A+WX8KfK2qylPdjiGTMoeNhZ6PJRFj3ZmvCA3x9o77oYtx4wkd
         lPLehsm+LtQDhdUxx7jcJaa2AD6OSrn4ODhJz6SHtHUIuJ15xFNxrTO0YRig0TW+ac+a
         U3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711070543; x=1711675343;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX7lJQoU+qD7vOfWabBwOOOGuTd2HzKbz7D+xQT+i58=;
        b=LMjPftoaLNdyFAlQI04nfwQXFFVqNCMY8LkNkVqMjd1bpUo17zW9jZe4I6ovLXq3Zq
         kYj1Lm6eXA93vB1wv/has3iWLiJ0ZroHAUk/6r0U2IL2/ApnZQSZLodl8j+V/YOeMatA
         +eoZNxg9qpj36DpJmN8OBio+crfRoSRcgt6hqYQdkLDlgIKoLNlZ8aR+Mtwi5up/LWI+
         k5DHo5gKnAkSur1FHrgZ5OHobo80KpaQAyIHxXuTDnVsPM01hsz9nJFgqxO/i/Br5GL+
         qnZUcBbVk0Nt2+xt495FT/7P7zWsQi3IKn2evZhufYvQD6rDY/inrdEWPLBT96/FLIO1
         UQzg==
X-Gm-Message-State: AOJu0YwEynWKwdAkxjhoLomvpPz8V6SNGSBZKPPl1cTjVYzJnpfkie7l
	XLWxPTF9DHuTc0x9Qu9uxAq8WsTrFajJX9efPK8eFU2tRDZXtkUt
X-Google-Smtp-Source: AGHT+IHbDTxhVzqC8ZxPkY8QSgfXa8sCJbk5sB4yPv/+XCOpZ+escZnm+y6hevs/OYjbBKvxIsxk3Q==
X-Received: by 2002:a05:620a:55ac:b0:78a:28de:c2f7 with SMTP id vr12-20020a05620a55ac00b0078a28dec2f7mr909630qkn.74.1711070542841;
        Thu, 21 Mar 2024 18:22:22 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a0b9500b0078a0ae1b281sm400079qkh.1.2024.03.21.18.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 18:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqq34sjd9h0.fsf@gitster.g>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>, 
	"=?utf-8?Q?Jean-No=C3=ABl_AVILA?=" <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
Message-ID: <17bef197ac874ae6.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 22 Mar 2024 01:22:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Thu, Mar 21, 2024 at 8:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> "Brian Lyles" <brianmlyles@gmail.com> writes:
>=20
>> A strategy that I have seen work well is for any commit making a notable
>> change (one that should appear in the release notes) to include an entry
>> in a CHANGELOG.NEXT.md file.
>=20
> While I very much like the idea of distributing the burden of coming
> up with an initial draft for an entry in the final release notes, I
> am not convinced that the approach to use a single in-tree file
> would work well in our distributed development style where the
> history is merge-heavy with many topics in flight in parallel.
>=20
> I can imagine how well the approach for each contributor to give
> such a draft entry in the cover letter of their topic would work;
> it would be with much less friction compared to a single in-tree
> file that will be the source of merge conflicts.

Yes, I suspect you are right. I think the cover letter would be a good
start at the very least. Would you welcome a patch to
'Documentation/SubmittingPatches' that adds a new expectation for this,
or do you think this would be best handled yourself? I am interested in
contributing but, as I'm sure you've noticed, I'm also quite new to the
project =3D)

--=20
Thank you,
Brian Lyles

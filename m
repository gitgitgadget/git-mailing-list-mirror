Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15886BFD6
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494269; cv=none; b=XDgeEez7Soz4jb3Sjdv21l66DETkV6sStehxXaGVmu00lpWBARXCHOXV5WNC3XJcPHjCEkklLJVOLXH+eaH5+h/2bMIvVsdwPfBvVc0Oh+zXzWmRgMf5jMcpAyS/3IoqOH3qNtkO3ewErvlIblvCCvPNcmfhRIggFOpVqpwfHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494269; c=relaxed/simple;
	bh=ahG4e4fYcxGy7OBbBv3AvDnDErcNTgNDdofEXTz03Dc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Hk4lIc2CiRL+2jKa4XwiEYDEk4ei+/kt1ia2ok/mGwJXUz98UMVPjbB5a8BS8XHRnzNLkXgs3JS4hfTr5k95mhnZEssscRm/MStFlfJItDgJWcgeLm9gFXwJmt/LsmWlZ3cT94dk77Cbp7CizAHtct/mmL/zq9/+bRoECI+8xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUeegJ1q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUeegJ1q"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d94b222a3aso9262925ad.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 07:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707494267; x=1708099067; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahG4e4fYcxGy7OBbBv3AvDnDErcNTgNDdofEXTz03Dc=;
        b=bUeegJ1qY/B10z3JqRmIE846zJh7hdRdXNp8MiP9w9AQosScfB8CpcYfrJ06VtlsuG
         dtlqBxpN5KIXLVoSfkr4wtyPsIESZnt42q+Q/Qk1K/jZ0qbmvoJYE/NqFyd+Cknql3AR
         nAmJBlLGxHEUcseKPVXAYSoxT2TVpqr87WIaFyu2YAfYT59iCNlOvqqA7NaaTyj/7r0S
         eqQUAjOt/MQ/iA7olzVb3utbW5iqpXGda3H49TgfpEZuGVHxABPbjI0Pe+DNJf+rxqt+
         7df76tbiyIvW+fRzvu6tqSO+J44c6XEy2Bo215JbDR8Pyt7JQN5ZOH/BgFlNF1nJVxp9
         5Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494267; x=1708099067;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ahG4e4fYcxGy7OBbBv3AvDnDErcNTgNDdofEXTz03Dc=;
        b=S93Z4Kah7akAOJsCH+9Ks++53VsN/uRRTBGmW/ozkFLVMYTN5pBUSgfbq4I5kKWQXK
         +K882vbGmns1EqZPPW+/DtrDyG0o5KmZlywsuNJ0pPP5pS5j5HLtJgVnXWvd4lty3v7v
         FAcuxj3WRkpy6osI722Lhl3AURkhF2cjn2hPPmGgA2oo7snRX8uudadO6eXv5PxTgkc4
         Onub0RSd9K/RJIcqXwIldjxb9umqIVAiiH74CKWs6FJJMbztVFHsI0qU4nH0w+lIfDwb
         7j4xIHSx2Bm2WDS1k8mB25sqOu5fQ4SYD9fERGUQVz9bTAa2FNY3x21povS35PyE1sj+
         o+ew==
X-Gm-Message-State: AOJu0YxkZaCyk2pQmwJjZ2Pv7o67p0vt64cbucicOzib6dzX/wbOzp0v
	0Ulr9yRFhwGEctyDQNJUKH/T/KNK+XDqY8ze4wdpBqJ/VEgZ1qkaWOd3im+W
X-Google-Smtp-Source: AGHT+IF+WrwljIZgcQ5m/iXq4RDnS3YZDaVK/fjoCrO9ooL5CiKeBivXAa3t6xMtfPqWpz4lUjUy0A==
X-Received: by 2002:a17:902:64d7:b0:1d9:5371:bc with SMTP id y23-20020a17090264d700b001d9537100bcmr1865891pli.37.1707494266665;
        Fri, 09 Feb 2024 07:57:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWG/lrqMOkZRs2ztkRcKDswCGOhVc5/7nRaWL3SNvdbwz8YEdXgg8GC24Zbqaydlcu/OFdbDqy3L9kLuU/mZMAC/QyBCS6Y2eWbeqImmw9i0BY40L8=
Received: from localhost ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902c79400b001d7915fc630sm1659644pla.307.2024.02.09.07.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 07:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Feb 2024 21:27:41 +0530
Message-Id: <CZ0O76ZJ2BPR.1PSK0WMUHWT8H@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>, <ps@pks.im>
Subject: Re: [PATCH v4 2/3] add-patch: classify '@' as a synonym for 'HEAD'
X-Mailer: aerc 0.15.2
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
 <20240206225122.1095766-6-shyamthakkar001@gmail.com>
 <xmqqil31dqx6.fsf@gitster.g>
In-Reply-To: <xmqqil31dqx6.fsf@gitster.g>

On Wed Feb 7, 2024 at 6:35 AM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> > There is also logic in builtin/checkout.c to
> > convert all command line input rev to the raw object name for underlyin=
g
> > machinery (e.g., diff-index) that does not recognize the <a>...<b>
> > notation, but we'd need to leave 'HEAD' intact. Now we need to teach
> > that '@' is a synonym to 'HEAD' to that code and leave '@' intact, too.
>
> Makes me wonder why we cannot use the same "normalize @ to HEAD
> upfront" approach here, though?
>
> It would involve translating "@" given to new_branch_info->name to
> "HEAD" early, possibly in setup_new_branch_info_and_source_tree(),
> and that probably will fix the other strcmp() with "HEAD" that
> appears in builtin/checkout.c:update_refs_for_switch() as well, no?

I was wondering about "git checkout -b @". If we were to make the change
in setup_new_branch_info_and_source_tree(), then '@' would not be
treated as 'HEAD' in the above mentioned case and there would also be
some disparity on error messages showing '@' when running the above
command, and after hitting setup_new_branch_info_and_source_tree() would
show 'HEAD'. However, making the change in builtin/checkout.c:checkout_main=
()
would disallow creating a '@' branch alltogether. Hence, I would like some
feedback on whether we should change the behavior of 'git checkout -b @'
or not.

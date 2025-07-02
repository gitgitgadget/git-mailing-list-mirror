Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF77433B3
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471301; cv=none; b=MNX1YlitIohJigxASlEVmj6HlUN6hgvLGUz0pxW5/RhSJHV11VlY/se2PWxSBr5x5nBzGDV7KJ564w4lvsD1CHxgjDnWKJGVX+D3pHsYlNuHdsmWTE5X2Kv4nxTCL4T0KPIG4b2EenPOIOHuP8+HlN3T7xeJdW48XYH2KYeU7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471301; c=relaxed/simple;
	bh=Sr66yaxtDWVNAcv1DpmiBTOAjqcyNAb1/wrMtjP/HMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lO4jmbTm0/1vqjtUllRYihnrgQVnjPDBJrH5Vs07fzuIJpb6NyejTrKgTHWqd5mwrNSzhfRwsHSCvWoeVbP08wg41ESjnDkHJFPdXPIazrEiDp44bgSA/u5w1kxKSzLgif0GTj9gJnfqixIjyst0qbGV9PSxogVGMPUCVYNAbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j96tGKpd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j96tGKpd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so7656288b3a.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751471299; x=1752076099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XEDs87jb42OLij8cvfXE6IPqZFBajbk7gAkiURx1bs=;
        b=j96tGKpd4yExNveh4D9wB9jQtgqQqp8Y7jTFOdewDOet1s0lx0hZftagTa4vfOx75w
         XA4i1egI4yBIjfx83U8cupxxurF+arElRBtUCwPfMFrOQe7Lcq8DED29UV2FEYeJXCwT
         jvLpykLGjvf/q1sQ/t2l9JHu4ZbiaePFe3r+wjZgU28qYRbFmmNDPWPqFnQCRdER5JbE
         wb0raKlK6FTN6LE8spAEHgkDTb3WtvMyVDMIva+HZzWJV2nWR+Tcv9qy3qfAXspFRJur
         MKlqLkbeHvUiHMX0WDG++Cgi/jXGVTsqSfUYEXsd+OGAo7q8RfevusfPfNsFTrHrfWNI
         EQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471299; x=1752076099;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XEDs87jb42OLij8cvfXE6IPqZFBajbk7gAkiURx1bs=;
        b=T86yzkwwEjuY5JFdAuhO7tKJqAuKMjoO6AZ6FcUjD8DyE7wTRr6XP0cW1bpU4tKmGO
         Imq0xAKGfmGmFstrN8D0xnsz6WFAeO7RBZMh4cAuo4ASRWkoqvsEioodZYbCkqybnQHQ
         BS29apY/+vUb8WQSenrEx56srvIenleDyMkzzAPZDDcSr964vh7D8Zg7WCEk0OKF5V3a
         oXGgnFTDYB/IFRLln2zvSbkyGvSSule5sgCTIhd8jHrmV8/MDs/F+rZcXqlmyJt8faFw
         IegYrM8QswI/NXf5Y+kfvrjY5/0ZFfb7EvsGm5ba60H1rdkayTGN6gx5vyLbNc85K2Nl
         ngyA==
X-Gm-Message-State: AOJu0Yy5kDjw8zdh05erqy+EPhyvmsg0YBgxrXtdcOWp3fwqIN2KWmAQ
	2/pcvqZq9IXgOiuUjJw3/P/CiKbVkBRMPkvtc8/CKWyRF42Pc9ppvCAG
X-Gm-Gg: ASbGncuUE0xPKAA7KpDVhfOqYTH2bzFSMXRFgHSHYCzWTmnlu+TRmerk5NjVAk3V5we
	9uLLEhWpOtcu8xsiyHdcn2gAoCwOifOdGRWNYSl7359cS2XoaGJpoxQ9/22ric3/5KBonevR24v
	WlV4R80yy1dqQyVpPI8OFAcCMZtTayVzQFtnxGcdl28a644xkOS0rOL3iiNGllWAnEyJRbMwJ6J
	8yZAwVE4irU7nzDLEt0+RvxsMBjdMkAUHMisQ0PPXJ/jECs9/9aUcgPtZwHsnAsztY1ndMc1z69
	gr30tfrciOY8wRiMyRsOcv8wAuHl4veNuZMZNnDKebOK0KMSrMpBYV8zXBZMc28QsEv6XzBRVTI
	oXFMlgjgI1GqphlgtxmopKwFg/74=
X-Google-Smtp-Source: AGHT+IFqXKHHXF3xW2o26Hf/5E7XmCTEaE1naPZeH7B1SEKNyk+b3p4b56br2lGUVxR9y/AUqN3ENw==
X-Received: by 2002:a05:6300:7114:b0:224:a21:6b6f with SMTP id adf61e73a8af0-2240a216becmr163022637.28.1751471298592;
        Wed, 02 Jul 2025 08:48:18 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34ede0678esm11356191a12.56.2025.07.02.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:48:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
In-Reply-To: <D5CB9B7A-C7B2-4F5A-B358-8F46A4E18CDB@gmail.com> (Lidong Yan's
	message of "Wed, 2 Jul 2025 15:14:26 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
	<xmqqy0td8fa9.fsf@gitster.g>
	<C8E0D62E-11B1-4921-AD4C-2905F10E07B6@gmail.com>
	<xmqqo6u4kkg0.fsf@gitster.g>
	<D5CB9B7A-C7B2-4F5A-B358-8F46A4E18CDB@gmail.com>
Date: Wed, 02 Jul 2025 08:48:17 -0700
Message-ID: <xmqq1pqyfvb2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> I do not know about icase; though.  Asking about "Dir/Path" and
>> getting "Dir/ or Dir/Path cannot possibly be in the set of paths
>> that were modified" from the changed-path Bloom filter would not
>> help us optimize the tree comparison out, when we do not want to
>> miss modifications for "dir/path".
>
> Make sense, both PATHSPEC_EXCLUDE and PATHSPEC_ICASE shouldn’t be
> optimized by bloom filter.

Before concluding so, we may want to double check how Bloom filters
are built on case insensitive systems, though.  If we normalize the
string by downcasing before murmuring the string, the resulting
Bloom filter may have more false positives for those who want to
(ab)use it to optimize case sensitive queries (without affecting
correctness), but case insensitive queries would be helped.  I do
not think we support (or want to support) a repository that spans
across two filesystems with different case sensitivity, so those who
worked on our changed-path Bloom filter subsystem may have already
placed such an optimization, based on the case sensitivity recorded
in the repository (core.ignorecase).

> I found that my [PATCH v3 2/2] contains two unaligned parameters. Should I reroll
> this patch and introduce the nowildcard_len change in a separate commit?

Updating a patch with a fix to obvious known problems is good.

Extending the scope of the series should be left out for a new
separate commit.  It may even be a better idea to hold it while
the current set of patches are still being polished, and then sent
out as a new series after the dust settles (even if you internally
developed that part as a direct extension to the current effort).

Thanks.

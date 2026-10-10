Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA419356A37
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657611; cv=none; b=Llr+m0qM7jvico5+2pXnaeQurqhvwBPVi9P7vcdMnIi2L/rvgyHoZyu5HWKsmkznFdtTOZIp0m/wCf0pNCEyq0uNJuiVc7/Isy3/lKfukilQt6aQaJy6PtYuYSW4vGxG6XK157duW5AvRB1mWtTt4qj+cCo6iFooCmM4OiwYMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657611; c=relaxed/simple;
	bh=wZ4eFeFv7rx5zA9gWaYtxYxONRXDqsXbrvpNggErLj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fhRou6qCxCHaA3XSkaGQAXNz9ZjiKCaAqKhCT+nPPDI01ORQAiaoNKVvO762fUZ3Nz8YK86UgF+43eDjoQNE7wFDvTNd5L3yIwDAul/RwTcbjrgUfWBsnAw2rm8rD5vbeECnE1Qod8KfBFhjN+HD2il1MX74a7g9EdJSWxXkz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lrZRQyOI; arc=none smtp.client-ip=209.85.221.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrZRQyOI"
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bbd01d56ecso133566e0c.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791657608; x=1792262408; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wR9miSps75EpUre/HZgl2MWr7vdQ8falKVy9GNkpazE=;
        b=lrZRQyOI/FkY3KJFLgL27xIaCXXspes2kBgeXEkDKNdHjl3xJFVaKnJINSAze50Niu
         +AgldKvyTrI0uRVdCF0drp23XvnABVF62GUapVt2ZI4+D8TWFZqIH4rY2VkGuqTAvDTH
         9VP0Q74A5UVFtXYlgGOn7r64wFs54IP0p7u9OS7LUbgirOMBf6p7e63aIFtaPA1nKzRJ
         p7gM0rAjjc7ewIkOxglveTa+9jW0F1B8eWbyd/ZF/Y/6l755zE9wqyXcd5u6Pa1qsNM/
         eT7/gUUkk72FUxAVmlOGFxZ1bnVkPPkhmySsUu0TBtIcahXIUmxn1anKdF9H7Iu43ois
         HLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791657608; x=1792262408;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wR9miSps75EpUre/HZgl2MWr7vdQ8falKVy9GNkpazE=;
        b=kPvQF5DLRqEtkINRWh584i3Z2uEInVhtDG++p8L3FBdPJ0cTJuIy9HoTF61t2fqlne
         jox5fyMRs4qAIdsmG12lYHbdDOjVBXF2VOfwLYwndsmIHb9t9FKvYiX+cRNBwACbtDbW
         oM2uUaDldBz2XS2y41uwvX2p6oOP4dRW0XUWzzVyQavmMAFtDgJ7iwatwbRxPqaqB9b7
         O1VmjKhrxNUPc83xMQ78i/F/CJB92+p4E0EOzpyuo+D8SMNdVWUT78L+Ta6lbeyv+Jpf
         wqQaMgChsfpx51mrhVF9hKnqFm/EUfbivauKmhaxwkKEK/+CAbcsaqyD/3qhMhBL8KXc
         18jA==
X-Gm-Message-State: AFq9FYLElgTaLpzPYkWu19EUDIQLIMdSNG9EzZSdPOS2L4MQ8SQORKbT
	rITYpqPjrUSynAMGxnU7uajiqNwvW9/DtSMOHzLDQQmOlkYAnsTpEr7lKHTioxYWRgAqHrMEs/z
	RNKoK5FgwAg==
X-Received: from vssy14.prod.google.com ([2002:a05:6102:c4e:b0:7b2:a6f2:99de])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:4415:b0:7ba:3572:2789
 with SMTP id ada2fe7eead31-7cb3981be0cmr1419284137.3.1791657607941; Sat, 10
 Oct 2026 11:40:07 -0700 (PDT)
Date: Sat, 10 Oct 2026 18:40:07 +0000
In-Reply-To: <xmqqbj92ochm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com> <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
 <xmqqbj92ochm.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.2.g35e303d65b
Message-ID: <20261010184007.112258-1-rmistry@google.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, abhijeet040403@gmail.com, 
	code@khaugsbakk.name, phillip.wood@dunelm.org.uk, sunshine@sunshineco.com, 
	rmistry@google.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> These Helped-by: drew my attention as none of these folks commented
> on v1 of this series.  I do see they have helped the original series
> <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>, but it is not
> clear how much their inputs have survivied to this version.

From that earlier thread, Phillip suggested explaining why commit
ae3f36dea1 originally avoided a default file, Kristoffer suggested the
config override model and documenting --no-ignore-revs-file, and as
Eric noted, his comments were minor structural suggestions such as
updating the docs and placing the tests in t8013.

> > +	while (!strbuf_getline(&sb, fp))
> > +		parse_oidset_line(set, &sb, algop, fn, cbdata);
> >  	if (ferror(fp))
> >  		die_errno("Could not read '%s'", path);
> >  	fclose(fp);
> >  	strbuf_release(&sb);
> >  }
>
> Shouldn't the above refactoring have been part of the previous step
> instead?

I extracted parse_oidset_line() in patch 2/2 because that is where the
second caller (oidset_parse_buffer_carefully()) was added, though
extracting it in patch 1/2 would avoid touching that loop in both
patches. Happy to move this into patch 1/2 if preferred.

Thanks!

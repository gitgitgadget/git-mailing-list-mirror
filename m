Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2E3EDADB
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766362; cv=none; b=Mi2Rb5nj3kugcGeNu9LTeHtf8IvT2vb5vO2diWZI2a+GiS2fS1SV57e4zHdJ5twu/naQQfJO5qJCPFmo2kI02zkryusQ6ZJmaNKRliCZz7ANUzucYOAMYbOOYEE+FJoeNJAHIdoWCyk5pF9h9HsHXkrnFhmUZ6wb6XKRJGsW+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766362; c=relaxed/simple;
	bh=mD1wXS6ThHE3/0GNHtug7aKR0hm9DM2o11r4SoJMkM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKvWfUhKTHgmLMkfPcSHPUWhY0pUVJlapBbxEN25zeC9FBmradcUqQtstAIZbCQRx/c+LCUU0OLdexADmK/n4/XfUR/P8auqWpZDOoz18RbswCV2EQHgsOhmInk/ASPdsnz46xIlO7atOdLK3tSEOSAX+cz6k/QUX8Fl2Al1lMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/5SeO8h; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/5SeO8h"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so5895442b3a.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773766361; x=1774371161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD1wXS6ThHE3/0GNHtug7aKR0hm9DM2o11r4SoJMkM8=;
        b=J/5SeO8hEI3LjaVeqCLh8MNT9IjCJXEqynyK++TeB02KtwWAOa55dtgG04M14qiv7u
         rKzQbEFOqIibVqcaZ2d80n7YfsCeDavlsC5JEDkBcNtupPJgdkbG2oylgRFxcO8iLbEi
         llDmIn7bDjuWYGv9rxtY/ecrmEzLrXCDo1/JqYrBwECehTaUxzEBBQcZXCKSKYJq80St
         Nkjyjgwd4pitn4jI6Y5kZaz5folXJ8QMFPaWU0T9oJOGGPfb8yEoJJlC/lklPmRvOkFR
         61iiDecGZED/Y1/8LwASj6FlwVqnuqiWif3pB5uCDpgciizd/+PG2yCFkNnwyfz68MJs
         sI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773766361; x=1774371161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mD1wXS6ThHE3/0GNHtug7aKR0hm9DM2o11r4SoJMkM8=;
        b=djp21u6K+Ny9etc+0NCmU3vUYnu2EUPJXJana71XW3fnjgHL0I+kB61iSdBPngQI0/
         oG54Cc0DNs55VBypGYx1yBuDX3m45M+zVo9jM87exLkpwmqNEuPvGb/GrOrbuKdnqlHh
         lhud4/4VPxn+C6ToukpeLoaQuWcOFvkWDEfkHW7fKLkpP3s0PLmqB1dz0nB715Hc5gEp
         4JeapL3S+6Yu3dvowAxtzBkiq2C4/YhLfiTHhPu6jlZ/sFwiyLoXIsTOza1VNOb5FccE
         iWpUfbJdyFQ2FeRlakGFSggVJjpyGUpWnpRxrrhpBiJ6iXzOy9OcSTzdlApR1S6ekTEO
         9o5A==
X-Gm-Message-State: AOJu0Yxk6PdDFzFNXIEa5mZd3/BKwdNIb8RJR3AVKM2A9LETk77eBRoa
	WK5oxIfxKEPV+f8+EkUZ6x5m5sV4z5bkXew0+Sxs1VlQOXvfnKmh3lpfnGDs3A==
X-Gm-Gg: ATEYQzxenW3m4OkFeHxsTCSfQv7UxOz230sGwfUfEMoRBJ1MPkhenCKgfk5qBzPq5B/
	S82HrygSxfuiH4TyyRL3coX8IawnPbXpxX1uiwbEO6RvTfSSNHJOi32ICLgpYQ1yKUQAa19QlFM
	mXXLmzeDAdjuu2paB8wT51oMTU/JYv+NZN+Z4P+JS1mheM0+1+Rs6UMKUTg8JFQePBUPcstbEfl
	6dgIFYd0jobzy187TkgM+DFY4Sf7VZY+cO5mRFtFrPaInlDCbdGL/yk/j73UlTTo6XgTAXjdRSX
	IpqU6s7C4d23qNSmOLeT9NICah0iVNgTOMkcI8an9NXfIsqrVeQD92rc2IMdDhtsE7hdnVt1ACo
	Ijin2MIj6f6aYhTAaPYPrZBiG6DmGVnGxkUpr8aITaX6oEbtX32wvEwGo/Bx8hTTMCwDJmvoW7a
	V0gaVqldzD1bUZSXo8PhXHakxsFVDvq0/o27jkvP19/BE=
X-Received: by 2002:a05:6a00:2e97:b0:829:bd4d:3817 with SMTP id d2e1a72fcca58-82a6ae4ffe6mr47970b3a.28.1773766361028;
        Tue, 17 Mar 2026 09:52:41 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:4c9f:12cd:260b:8809:a4e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07384b27sm17203070b3a.53.2026.03.17.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:52:40 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: [PATCH] add-patch: use repository instance from add_i_state instead of the_repository
Date: Tue, 17 Mar 2026 22:21:38 +0530
Message-ID: <20260317165230.628705-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqzf46l7x1.fsf@gitster.g>
References: <xmqqzf46l7x1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Functions parse_diff(), edit_hunk_manually() and patch_update_file() use
> > the_repository even though a repository instance is already available via
> > struct add_i_state s which is defined in struct add_p_state *s.
> >
> > Use 's->s.r' instead of the_repository to avoid relying on global state. All
> > callers pass a valid add_p_state and this does not change any behavior.
> >
> > This aligns with the ongoing effort to reduce usage of the_repository global
> > state.
>
> So we can call this "reduce" but cannot say "eliminate" yet, as the
> files uses comment_line_str?
>
> The <environment.h> header lists some global variables inside
> "#ifndef USE_THE_REPOSITORY_VARIABLE/#endif" block, and the
> comment-line stuff is among them.
>

Yes that's right, there is an instance of comment_line_str, should I add this
in the commit message and send a reroll ?

Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E57191F78
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690325; cv=none; b=hQycqLSUlJtjP8WK0RuTPn5w31GVCrNcttoFiDyRkNf0hpJUqARKCPA3TpBUiSACGcxHpE0t0ZTuJZdEjrS7aAcoo9B1nNTqNmbXRReEaZhzZm4t6xgN7YczknjrNGWvxeIEgoQW5ZJ8NJCsdR4tgxxWcu8KP0YXbt96790YQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690325; c=relaxed/simple;
	bh=G9Lsp6TbgI8tOONFON1TfP1b1kO2xpqaLEbm0MEbFVA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=laPFSGWVxgFBh9asuvZLKOdalwUdSCF++jMOuUHnMYRIGwfK8xpIK3flWOt/axPwGTediBYZvhI1inbWxk1mpON7MekymG222uH/gANhqgPtmq2kmiegXMZg9UVKtaL5+76TIXw0+zGjoQ6CvYfH9xZ+Jc7baaMuuWSecs+VmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz; spf=pass smtp.mailfrom=klerks.biz; dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b=PLvkeo55; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klerks.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b="PLvkeo55"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso7590084e87.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1724690321; x=1725295121; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G9Lsp6TbgI8tOONFON1TfP1b1kO2xpqaLEbm0MEbFVA=;
        b=PLvkeo55UPhaFVNjv2lAKu6XUg6DCkDOrm1MpOaIPxrogLQWdTkm9hqQckgeq9MLnH
         M66DEdsoMzNHKYZDMit0f32cMAa7adsAwuk5068lcwFFZcRQTUthikIuvNddGyFTqlD9
         fT8EFIlaXUqeImXujkd3l0MhtnqN//6VSY2FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690321; x=1725295121;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9Lsp6TbgI8tOONFON1TfP1b1kO2xpqaLEbm0MEbFVA=;
        b=qprOd93kYgS3d3h3ErmXA0lUJYICHCF7YTVcbMn93eonlH9u6OdjQITkoBOORLf/2b
         N8x0U+2fZW1BqDTGXR8tfjf66o1AX6whRFqCnPqc0Z/r2CLtB+mqRohfoe0uCA7H8BYm
         qFB+qlGykHAOjicx5EYp3klKO23KholF5+8xR80R8g8cKZdF3VcwV10RrapmJNGs1Eqq
         5tiq7fbnP4SCfej4dkBacAJAwu0lbZ3KXjkj/6HWVAtEXCXI+FNCqwuwVAmkMHxLnh/C
         12r78BBrd4SFZp1Nn/yE8KC3NtU9GIoQPFzsdtw3H2VFu5wS01hw4dC3VgxVs20GBUgP
         9xvQ==
X-Gm-Message-State: AOJu0YxoW1UGmlwhbNJpDph4VkBSRsUvBHWGiCE2lQCIsmLUdFi0Sd8Z
	NNDAZHfRV6Hfeph2k/iBDyhV+wB8JzeQHeJwK+mgBb2EXx/+w40LBxSWidleg8QcfGhIUrMxWlK
	DPH26GUufcutBbYue5AHPwBtG+lTNefWePSlXeLQXkMItIkawgZJnlUaogQ==
X-Google-Smtp-Source: AGHT+IFBoxP5g3U3iPH16HzcTigzOEIAVwV0oZmW4CbR8ZRzbT4tuUbt0KRCLnRAdT76Ukw9LvXu/xvQlDWdceY/rJA=
X-Received: by 2002:a05:6512:3f11:b0:533:efaf:ab26 with SMTP id
 2adb3069b0e04-53438791a8dmr6858644e87.36.1724690321172; Mon, 26 Aug 2024
 09:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tao Klerks <tao@klerks.biz>
Date: Mon, 26 Aug 2024 18:38:29 +0200
Message-ID: <CAPMMpog7=ZnhJhrgZFwzRZibLtK1-LyOhsrp5c4O85ocRFDZxw@mail.gmail.com>
Subject: Sensible way to see what objects are being fetched just-in-time in a
 partial clone?
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

In working with Partial / Filtered Clone repos, there are situations
where objects get fetched just-in-time - eg during a "git blame", if
you did a "blob:none" filtered clone, you can easily end up with
hundreds of fetches as git iterates backwards through the file
history.

I was trying to write a "git blame optimizer" to pre-fetch all the
suitable blobs, and it wasn't working right, so the "git blame" was
still fetching stuff - but I couldn't see what it was fetching (which
made it hard to investigate the bug in my script).

I did end up getting a list of some just-in-time fetched blobs, by
dumping a list of *all* the object IDs I had locally, before and after
a still-fetching-stuff "git blame" run, and doing a before/after
comparison of the resulting list of objects. To get the list of
objects found locally I did:

git cat-file --batch-check='%(objectname)' --batch-all-objects --unordered

(ref: a conversation with Peff last year:
https://lore.kernel.org/git/20230621064459.GA607974@coredump.intra.peff.net/
)

This was a sucky process though - and I was very surprised that I
couldn't see what was being fetched (what the stdin content to the
just-in-time fetch calls were) with any of the trace env vars that I
was able to find documented: GIT_TRACE, GIT_CURL_VERBOSE,
GIT_TRACE_PERFORMANCE, GIT_TRACE_PACK_ACCESS, GIT_TRACE_PACKET,
GIT_TRACE_PACKFILE, GIT_TRACE_SETUP, GIT_TRACE_SHALLOW

The only thing I could easily see were the *args* passed to nested git
processes.

Is there any way to see what a just-in-time fetch is fetching? Or any
way to see the content passed around on stdin in nested git processes?

Thanks,
Tao

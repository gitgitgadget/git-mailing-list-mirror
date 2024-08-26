Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C426AED
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670596; cv=none; b=rlJqzcEMPGs2dFCcCgP9xz4qdyjbjGM1b7EP+Y23qCEtD6Bld9gJQdM9hVWDBlv05/pKLCjsNbJTZWeF9ZYScB37QEP/iUAYCnj4+mxJZRTMwNmfXc6mtWqcLLdA4ikmneBYmmHkzV3DgIaixrNtaH5aQbW8mF5p+XU1h2AjZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670596; c=relaxed/simple;
	bh=3dJZcCgWEBX08UkBEu72praBywPCxdPvLAnS8yuQsX4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=deaCzOzfq7AsA5qy2IODS3q7tF+X0MeHcHUmg6boE8Z3I6s//MXZPt0WWlxYgvYihVMAlCt0YhUULt7wY9CU3Xmhp8cl11pl0Zw56otXe0y4tp+2itbsXLLb3oURrXW+7nW0fP0EkzUylmC2yckFHlyueBbZ9iel46k704oVJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5hE9u+K; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5hE9u+K"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso3951537276.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724670594; x=1725275394; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jvuDpB5fb7uL7N6uy5jUegc7cl+gXlDbB7FAxnBz+zA=;
        b=k5hE9u+Ke50IrAJk1sIBrjwy2JHh4R7Q7k0LLY1d4D78z/0ctwGiwqZFC+F+l3AhSB
         xE8DIgcHJKaVOx1eKE2Qdo5qFz8cssE9HLdFU213rePpvHZeARIva6cjH2037g9IVBmj
         QV6g1v6OpSnX2MwZVoQrIOto9vcPS5iIp2xFQkRNlxIdd3Abkm6V68pBXvXxOXPbvucJ
         va4PfNXTTd5WThsfzKxrsdL2xduf0Gs+/Ct7Jo1DKclWuxrP4caMiJwelPPIF0jOZ0P5
         WYoSeZqRDsimOMN7cSnL55peaTGKUnB7w3RhM8BKdzuvtmjr6HpAaIbfbjQ/mhyBITku
         qHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724670594; x=1725275394;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvuDpB5fb7uL7N6uy5jUegc7cl+gXlDbB7FAxnBz+zA=;
        b=ij/MzkpWSP6g8WMJRORRqV+0rBcWR3R+x80IjfnnO5m+13VsWKjdQxltGsyw3n8Qxo
         EfudKQbsXEpVxY/uwNqFU4RMuVHqRobsqO6y0e2XwPtlhxMJNr4EE3yfCyGxh6QebrsV
         9fMPYtqYw2QWGW75Khr//c3qU894hlJfYyxFWwtfrh8Y7DFSFHuuDgjzm20KFpSsayd0
         GGh7v+V8r+gZsFFQpmn9FdkCe/zegWdJkb/BJQBh26yXG24s7gnpApdOzn+0DLtxMgnn
         SYXq8eekU77Cg5HcV7C8zLZSUNFT5A7Ooz5QuJpZiInxz5QlDoYipRpRU/RLgikvOP0Z
         lN3Q==
X-Gm-Message-State: AOJu0Ywk77l44BwV3CSdUztjLMh0K50YjAh8GH3ADZqBasi45836SacN
	9VpJjV9n4wjNQoytwhCBxkNJTHUBynkkKNTWYFaZV0wjQgyAkSk0GuC074jxGeJph69d8rtAEQZ
	YSwei4bUuETmV/vp/rzmleoYNGtn5R2c5
X-Google-Smtp-Source: AGHT+IE1OUWjMvpMKz3L8HeqFWqht9apT8h85Ya38JHhKEKtt3trwjrnqOtY96AQVYEwQ6PhpBVZnzDW0PpewJUfIzk=
X-Received: by 2002:a05:690c:4612:b0:664:badf:5a80 with SMTP id
 00721157ae682-6c62924fa0amr86426437b3.28.1724670593839; Mon, 26 Aug 2024
 04:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Mon, 26 Aug 2024 12:09:43 +0100
Message-ID: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
Subject: How to turn off rename detection for cherry-pick?
To: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

As far as I understand, the "ort" strategy does not allow turning off
rename detection. The best you can do is set the similarity index
threshold to 100%. However, it does not address the case of candidate
files being exactly the same.

So, it seems to me that the only way to do it would be to downgrade to
the "recursive" strategy and set the "no-renames" option:

    git cherry-pick --strategy=recursive --strategy-option=no-renames
<commit>...

Is my understanding correct? Thanks.

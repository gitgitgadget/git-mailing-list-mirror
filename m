Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5041D217
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538789; cv=pass; b=Xi5rutafMNXPNPFxVQHO37m/W1invlicsqBdPUuDN+h0KoQMsyN1plsuO5vivFxlOmqv6sNiTIHL8k3Ebc3FdxctkHES+QHckQ3cFPOq6YSdoZk36wlKTmBdJnOHidVfQdWad7wrEuSTNQfiu7iwxf8LKIEzLu5VDqYnG76sfVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538789; c=relaxed/simple;
	bh=xAEGsxikIr+Irx6WC0BJQmdqecknuZ1fk5wAAKjgttw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVW0dfzj33PQay1TKO0enq2LbIltqu1uoQH5RsHAKCRaXdC2wJLZ24t+OiDCnAN040PBDlDaz+Hai2kS6vg+WnA0O3D20ohVPBrtHmNuhhJ1VIsTgHNadG+vJh+fzCNHvX0E5WH6M4CaxDhf17gI73D+eFN+HHtPwqPN2gUe9EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHyTmJbl; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHyTmJbl"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab4b93bbe9so2097859a12.2
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 12:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790538786; cv=none;
        d=google.com; s=arc-20260327;
        b=Py0AbCXx58YK0l90jI5H/MlHUvTvFnSaT+XiWg42ut8CJVcoLUPQK7mUcqULrhPETH
         rN1DNNu3nXs6LkUJimo2UBl6w2QaQU83qZPwbdHILbLxN+aEuwU+NejhQBpocW97AroX
         +pfpaXdRyl+7syptuSqvDjGFZWdgYNugzgBfEfiTgHDDxwWcNSwn4SiHd0Xi0PBF9JF8
         eKWNVKfx0diCE08iv1TeG1rvHWtu9Kj6zLnpy6842ea3COPp4ufD0h28gcdDBpOFCHFD
         lwdiK3BFFHXWhBWYcea4j1vylai1/hbK91syqJL+vgh2/UIoqVIy4kXnqdMrwegte04U
         +2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JwESzjpuPAXHVCYhf5IkIX7Nw4UHsATlqL9/9c/Zdck=;
        fh=QPTjBnop8bsTdcll0grpV4HtWXLiPaZvX0IvTIcXu/E=;
        b=JIQwvybrLvl7ZNgghK887MCAejAW1iv2hLx417p7LE66BIdXb/2LqNzAxNpRvge0RT
         5mJUEHYfjxC9HYNBUKHGk0vePRDlpAOZh53DfBfw88NM1Iz+FNa7EjsQRVaANfaW54DL
         ujPItBIxJGpTKbIJFqPuFCjXFOVx+J3SgVQNK5Pn1gdmbGlfsxOQy6HT22v0kSmUEpZE
         v/Ii9/t74DeGQH6lg128IADgc3n0V0ZrIn7RSF7Bt8p2d1AYjOl9Jx/XRr+qebw89hNo
         FZktxnm4TWEwjToK25uNFMLsu2cKBrQLx6ZjqDK6xIlYZPIzrxexNAKHKgUhL7d6ww24
         bEXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790538786; x=1791143586; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JwESzjpuPAXHVCYhf5IkIX7Nw4UHsATlqL9/9c/Zdck=;
        b=JHyTmJblpN21KHeOtD3B7BeLoheZuyH2O76UWc7oO5j7aB/vY4GBCHQvnoGCZg2UKA
         gXbbUVUMfZHd/lUYNgHrDxkzo80tYn4B4S6Pdnp1lhsHnzLd9TLh9lz+wpFY8aKAZNQY
         YzhzYidwZpJQ7O/8Xjc066PP+qV2cqevrRnTtDKmafbgHVofBjhXcNU2ZKpoeIOpAEdC
         1aATCZzwTiqNkc4h9XfaAoRsSprWyEsYzE6ten+mMGOLZO3ASeCU9ItcDQ/KtZkD5bRi
         TS6YDyYCTnSm66cagTHudh8vunYszfyoIDJEHeGVBg98CROQ/MVHmAi/juPtFJfLpzSY
         LUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790538786; x=1791143586;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JwESzjpuPAXHVCYhf5IkIX7Nw4UHsATlqL9/9c/Zdck=;
        b=S3I7e70JyDJR13nw4kVgfRSye68w+zYWAUzfm/goWlb+q+GijKtnUx/FSgrioQCt2A
         dIltoPyxv6iK2jdZbTo8G0X53rXefWULtQF2YXRsS7oRSd6QhifeE3/8mmjbJ67ttET9
         ID4rh0D+Tshlzy14umcuqGOoXjWdWxORkcxHXIcfH1pMrLFd+iCU4Pag6CjsoFvp/6Mz
         FJUK3sZPnAYC7hagoUQqlBasGfWBED5iviAmqO6GEvuMD8xjfSDA438gA3HBbsJDdSG3
         dzuVKB7j7Cq8y9c5AbFvGV5qT53y26xeJwDwfHzlv07TSl0w5DmBy7aUSVS1dNhOUyUx
         C9sw==
X-Forwarded-Encrypted: i=1; AKwUvBxyGlEGkAE29rQOOtwIAYotgy/FZqCPFk+BxvZb0W/B0nizo9vddk/wAN4C+2Vtymhpiuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBARn3XcR6FE7cgfet83eAacvZVRPmYoaN5wlMQ0wWQKphDtFi
	Xig6+Xq5ooNlV/rXPZisQ6puhhnF7qFRwBrNGnxdpP8ZlFxaNm9mbjeOeoBy+laXysEmrWAThHA
	MHF+hhpgNfdXLWkkc5lFCDozgkvBJjSsdyJq5
X-Gm-Gg: AYBFou2QPITxITTGeZbRvYj//W5mgCVMOt5kwxisOxsl3TpE/Y/R8AIS2/w1wHh5uWd
	5VM+vhf674gVcwXr24PCEfbGEk1em8Zhm8kYqjYDNN0771J2gsp8B6N/AW9/bUwQnRGklw7gniG
	eYDgSw+LM2av7iFWIracxpL7NJKDnbPs9mmxHfMKECoc+LQiYL1ozrG0DzK1AyYuMjtoYWNTNax
	qdKff5LHRzsRHvStQiC5J1KdZhIpz3yYq7DqR6uK1wOzkCt3qS24e0lTsgpnwfo2Ustkes29zr6
	OojQ0Q2m4i3/3vd3vBm8S1CE3cyqe33F5vWmg2JEl69qdW8W+Fnoevw=
X-Received: by 2002:a05:6402:21c7:b0:6ac:6b18:344e with SMTP id
 4fb4d7f45d1cf-6ac6b18384dmr1147909a12.2.1790538785540; Sun, 27 Sep 2026
 12:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com> <fc4efe9f-69f4-4f58-9f7c-8f2e75a8e590@gmail.com>
In-Reply-To: <fc4efe9f-69f4-4f58-9f7c-8f2e75a8e590@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 27 Sep 2026 21:52:28 +0200
X-Gm-Features: AclHuK-v7naSgyqCiDH1bDbYhDl7gw9xDggFNr2e52S3ESCc_pMINWFSIfcOON8
Message-ID: <CAHwyqnVyDeZV7-ev6+BGeD+_qG89ZY_41dfs95FnouC0B+HJ8g@mail.gmail.com>
Subject: Re: [PATCH] ci: point leak-sanitizer failures at the actual test and error
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >      ci: point leak-sanitizer failures at the actual test and error
> >
> >      I discovered while running CI on another GitHub pull request that it's
> >      very hard to see where the error is for the leak tests.
> >
> >      This will stop each leak-sanitizer script at its first failure and
> >      points annotations at the real file and error.
>
> Putting the leak output in the test results is very welcome, but does
> this mean that if there are two leaks we only report one?

It already had a behavior where one failure made every subsequent test
in the script report "not ok" too, so lots of noise burying the real
leaks.

> >      Proof that it works:
> >      https://github.com/git/git/actions/runs/35871180948/job/107215430244
>
> Opening that link shows that the individual test failures are no-longer
> folded and I see some very strange scrolling behavior in firefox - when
> the page opens it scrolls to the bottom of the output of
> "ci/build-and-run-tests.sh" and if I try to scroll up it immediately
> scrolls back down as soon as my fingers leave the touchpad.

I'll take a look at that.

> The patch below seems to do more than just changing the output to
> display the leak backtrace - it adds some escaping and changes the
> annotations. There is no explanation of what these changes do or why
> they are required.

I'll expand the commit message.


Harald

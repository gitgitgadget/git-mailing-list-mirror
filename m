Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABA1836EE
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023780; cv=none; b=CGrp1uSW38/c0AQmcz9F5c+HtWqE5XxfeiMP2HTnTUHXQZ4xu5NtWuPgmlrRm1yB6/FuFbNOANkrCdWovNAv3OJjiffdyt7WoIG98lXrkcNz4yj8U4HY4OBtn3kM/fErVThAjyQm8wfS58vzwi6JJs6HckoPCUi4h75rUeUHMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023780; c=relaxed/simple;
	bh=q9RDYjrchSN03BxlCMt7C6raWo0g+R8v77aS5MeD8C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cjY71kKtfFeuFUNYG47sEoPPDL9xaptqWiB6t83xewyT+0EgDd+q77K28bj6/qUoL6HmoeBA/huV8qMCCsTgi4Vr7GWeGPHaKqBkeEM1FX6GdNpCGFrmHALLaF+uC70Uwucjl2TuDgvKNtTQEuZD8D4z8HhkIsMoxD4Bieadd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA1ZNI1o; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA1ZNI1o"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e039be89de9so2030110276.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023777; x=1720628577; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOzOLFyKvHYHOiAgR2WXPo3mlXwg4UfCEA9gW2jqUtQ=;
        b=cA1ZNI1oIDZb/nIGVxbJFKSpF9a5maP6d9bx8hXvlTFjoMQXkb7VaAEvIUAMQ6T6yj
         PwL4rNR7yqkj/WdoQBSFOPpAjwQgHaajFdM9nVZyzy7XICssfmvlvAklz5/FBymJDzEc
         dcT6+zfbWT7X7x2iMrpwtKsgNonWMjuaEVxoIo3Fb3Bhwbymq1DkRgfjZmsqZZi1T5mt
         5ehKcO2I11No+CH1G+piqsf+Xywvk4D8JKxGF649LR0G70xE7F9SzBDmH67otOoX3/1j
         274C9PoMI0jvDpeaIwzlOo6sIiOpQ0CcK873IYI6hOeuTOQV9hH7Smekw1p+MfHisJoS
         3OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023777; x=1720628577;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOzOLFyKvHYHOiAgR2WXPo3mlXwg4UfCEA9gW2jqUtQ=;
        b=WX5EwFjaSpgg3m2qSVwOdGezJ5vBqRu0h+yenmeZrrOmXn1Gk1Hjs688x1zmw4o/Ec
         xVqQXO2IJBruEN46DTUD3DmFoduWPrZK3k8cR9JDGNwiXO0sPwba0xtW5C4NcqwV/nfx
         qZKLb0hm8a4wAbVgYpIC8XkTNt+NDi086TkM0+bIL0cqOOb1bJruPc6IRtyryiWr+8RO
         d9YCkJ4Ge4CXEgvhuHthmYU6L60cy4Rc2oS8CCZA06BUlIaFG1izaPyeOQC+0MQWNEsp
         ggsIoQmZHr2zCFyD2+NnU5A0Sezv+TJCzs98JObVU2SOdkTYlwuxOfGS2nsdbIYU5gjD
         o2Sw==
X-Gm-Message-State: AOJu0YzPhBtcUsOiOfxaFPzRNjukOW+HmxWdmhjyZr55ZM4JiaYKMwxU
	0GmHD+d4qOrwvFulkroraEvfMVfaaI2H0aN+o3AyDWbsthtAnimaZkNqF7W/o1ojYsZ2FS/6333
	xgTuSRfsJB4eOPsrIoadLYHgJDOhokw==
X-Google-Smtp-Source: AGHT+IGpeOT8NiOXgzfs1GTkld7J25HZZdRR/4wi+V/5SXMeGtvBzX4EY1Xq4UrCz0NwTKVA9w0dsZJ0f0XDsZ38ncE=
X-Received: by 2002:a5b:70f:0:b0:e03:4648:5248 with SMTP id
 3f1490d57ef6-e036eb779e2mr13701674276.31.1720023777664; Wed, 03 Jul 2024
 09:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
 <082b01dacd61$81174a80$8345df80$@nexbridge.com>
In-Reply-To: <082b01dacd61$81174a80$8345df80$@nexbridge.com>
From: Emanuel Attila Czirai <corre.a.buscar@gmail.com>
Date: Wed, 3 Jul 2024 18:22:46 +0200
Message-ID: <CAFjaU5vvk-nNLvCyXAgU9C3ScKBNRPFB7=1PXejmLZi+r7EbNQ@mail.gmail.com>
Subject: Re: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in
 the wrong place) (just like gnu diff/patch)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >I consider that I don't know enough to understand how `git diff`/`git apply` works
> >internally (and similarly, gnu `diff`/`patch`) to actually change them and make them
> >generate unambiguous hunks where only the hunks that would've been ambiguous
> >have increased context size, instead of the whole patch have increased context size
> >for all hunks(which is what I did for `diffy` too so far, in that proof of concept patch),
> >therefore if a "fix" is deemed necessary(it may not be, as I might've missed
> >something and I'm unaware of it, so a fix may be messing other things up, who
> >knows?!) then I hope someone much more knowledgeable could implement
> >it(maybe even for gnu diff/patch too), and while I don't think that a "please" would
> >be enough, I'm still gonna say it: please do so, if so inclined.
> >
> >Thank you for your time and consideration.
>
> You make good points, but Rust code should not be put into the main git code base as it will break many non-GNU platforms. Perhaps rewriting it is C to be compatible with the git code-base.
> --Randall
>
Ah, definitely whoever writes the fix would do it in C for the git
code base, I didn't mean to imply it would be or should be done in
rust, therefore please excuse my failure to communicate that clearly.
The `diffy` proof-of-concept patch, is just for `diffy`, in rust, and
it's just to show a way this could be done and that "it works" that
way. It was easier for me to do it for `diffy` in rust, than in C for
git diff/apply or gnu diff/patch.
If a fix is to be implemented for `git diff/apply`, it would
definitely not be in rust by any means, but C, as you mentioned.
Thank you for your reply.

Also, I notice that I made a mistake when pasting the patch with the
context length of 4, it was a real patch not the one I used in the
examples, here's the corrected unambiguous patch:
```diff
--- original
+++ modified
@@ -1114,8 +1114,12 @@
                     self.config.shell().warn(msg)?
                 }
             }
         }
+        if seen_any_warnings {
+            //comment
+            bail!("reasons");
+        }
         Ok(())
     }

     pub fn set_target_dir(&mut self, target_dir: Filesystem) {
```

Cheers, have a great day everyone!

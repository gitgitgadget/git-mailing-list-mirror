Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSFPTU20"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843D1725
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:37:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507adc3381cso2657386e87.3
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700840222; x=1701445022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY/HfrmQEdgbjqLLsJWCYjgLXgQDpgxLvkIonnN05fU=;
        b=HSFPTU20XUSq64rok33d3vv2UGyof4QKzEK8H0if8GLOvXl4+olydl6K6PGOX7DWd/
         MccilPQoOpUdyUfQRc5ropHNH114d/K+PwqR1QUMyBbEKHEI3wqP7dD9G+5WjjeUGW+C
         vaYzyiTBvx9hrIsqPCAQ+lu8xQHzDWyyQ6MMDr2LSbLO5UQYEvTJ+DBMpxwHm10qutp1
         CVcNNTCUuNTj42KSlLq34bMzX3SkDH4ePcY/xkosS1YVPmOUH6IeU+Zf+s/vy2kBRVC3
         z31Sx7Z/ByfcW5JCQsMIj+u5HE4Md68dEc51lxbpI24S5uTC67Qbmd3sD0S6AMtrIg1J
         BOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840222; x=1701445022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY/HfrmQEdgbjqLLsJWCYjgLXgQDpgxLvkIonnN05fU=;
        b=vS1h41pqdrKxfl6ailVeNbZlpYifBmks9v5MXALOgKrB89J1nJosBqQJIXcx8M/sQG
         3hg/L1rJ8tgvMvwdNMcF7KF6/M8ZDCEAE8OtnVNjbu6Xc3wkSRFudjR2UoUUIitBXeJj
         IMF2+GSsTrdHgCNvSlEmUvoAr4vZJeDRYgRBd534fYDHm3CxjzY0MgvhlEMnQk2DN4jz
         51kT/vvjkUtU2t5LyeOCn0Oo29kp3O3hTokyjjZ8XWoTifuJ571LiEkgiiDmovtl0Jn/
         hlfD9DcCKjfg2ZVPljnqIXLfMVNMhxfNYklL2A95Jjw9btf4qsYdNa/ZdPa/UJIHBKKT
         06aw==
X-Gm-Message-State: AOJu0YzTvh8ZuQXKiepYT/UBMl7ENeb/cf1/HinM4VteXQPVHK+hwvIG
	edbg+uPKJYGtIpPVoKGHtJfif/k884xsXfqHsvE=
X-Google-Smtp-Source: AGHT+IGiZy+81WZKswmcOdYG1aebK1ylFJjNXQRrouMpChYs2lsignuooCud88p2fTzaOkLbXGHppv9Om2chw29AWwM=
X-Received: by 2002:a05:6512:3b96:b0:507:984e:9f17 with SMTP id
 g22-20020a0565123b9600b00507984e9f17mr2974059lfv.34.1700840222130; Fri, 24
 Nov 2023 07:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 24 Nov 2023 07:36:49 -0800
Message-ID: <CABPp-BGhHivx9_R6fwL--K5nTvz1sh67JDMtWG7WajxmX=56Fg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Switch links to https
To: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:35=E2=80=AFPM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> There are a couple of categories of http links...
>
> There are four categories worth changing:
>
>  * pages that have jittered a bit but are now available as https:
>  * pages which exist at both http: and https: and can be safely switched
>  * pages that have jittered a bit and are not available over https:
>  * pages that are gone and for which the best source is
>    https://web.archive.org
>
> And some categories that aren't being changed:
>
>  * links that are required to be http: because they're copied from someth=
ing
>    that mandates it (the apache license, xml namespaces, xsl docbook
>    things?)
>  * urls that were imaginary (e.g. http://example.com/repo.git)
>  * links in borrowed code where the http: form still works
>
> In order:
>
>  * doc: update links to current pages -- I found the current pages for
>    these, it should be easy enough to verify these / reject them
>  * doc: switch links to https -- the simplest
>  * doc: update links for andre-simon.de -- I've split this out, I don't l=
ike
>    the idea of having to download binaries over http. If this were my
>    project, I'd be tempted to remove the feature or self-host w/ https...
>  * doc: refer to internet archive -- the original urls are dead, I've fou=
nd
>    internet archive date links for them. (There are some in git already, =
so
>    this seemed like a very reasonable choice.)
>
> Changes from v1:
>
>  * Commit messages have been adjusted since v1
>  * files were dropped based on feedback from Junio
>
> Changes from v2:
>
>  * The first two commits have been swapped (favoring more complicated url=
s
>    over simply switching to https)
>  * The archive.org link for atomenabled.org has been dropped, we'll risk
>    users getting hacked content from an arbitrary MITM instead of taking
>    archived authenticated content based on the last time their web site w=
as
>    properly maintained.

As stated elsewhere, I'd be fine with using the archived link if the
justification presented in the series for using archived links was
consistent and mentioned both reasons for changes.  But, I think this
series is fine to merge down as-is if you don't want to go through the
trouble.  Especially given how long you've waited.

Anyway, I checked through every link in this series; it all looks good to m=
e.

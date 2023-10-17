Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1443102
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvvI7BaC"
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7558AC6
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 15:48:16 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e59894d105so3675459fac.1
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697582895; x=1698187695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t5o6hIaOHQUhhHgun/vqSl4wttFzfZ84RWOMXD6ToPU=;
        b=qvvI7BaCWIqUICCFAp/1ngr+04XfMYIoBdlB63ftGK4WB2O2dG1f5OhWTIoc1rXB/w
         qsTsTR/Wwry8qCQvH/uWC7wfTWC19lcIiNN5iGItUURTF9XfPLkXBNzq8woUQ9vy6W3l
         vZ9APvivdLhhrsYTRz65P9yKRzKWiIP65kQraXB5CAn1nKgtjx0EXfWcpTEqB/8iMqe8
         6gRydE9j9kz4ZhaIkejwbNx4XcZxq8BIviqOGM2tRmmBbbYwIrXZo5kQUvk3tDDEPR3e
         VYmkWcqfu9F6UhyUiNHJU54onK8ye7scVFLQ33t+XUsOpHdtrdEWL4NTEgleoXmLxGcY
         Np4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697582895; x=1698187695;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5o6hIaOHQUhhHgun/vqSl4wttFzfZ84RWOMXD6ToPU=;
        b=X7XHeSaRt9vZFccMH30CM7zz4gFlHLVCKudWIfBu0jO74T+2EdRxuP/+J33EXh73D0
         KeBSlPTmC+1dPeG4p2RRFQLE6Sby1iXNXmetOMxGulzOdA+xhlPfOoG1qHZyoao+1Mea
         ZcpgXpbIHH+07/SU4Lr12lfqwvpYcp0bc0BUvZSpfXqJKzmfvvQfz/LIX2Ykjuj0FsUW
         EWK/xr/Amu/5BxzbLsZoSGpJELAuSbap3h6b4KudGd1IwzvXT3D6Eq3vy/a6UXYRVlXX
         D/niZLPojSS7KewiocTZeH6BzycpA3MO6WZcPK9T6sOmUa3iKILqPT7cjtuvzZ4lv1ec
         PIFg==
X-Gm-Message-State: AOJu0Yyvgc7FWdrs/Lf3J4RFqvDkEXIqZ6TGnMTPdelUuKQdn4P8R0Pk
	SXHqr5y04w8VNaM8zMU4mFSbqyhHnJjfqmtgULUFxg==
X-Google-Smtp-Source: AGHT+IGBlbDyEv0FtzqJAADY+JxOrPki6tRJIKlPT6E9o4oHq8Zv/plcph6S2uOVUHLNWPPtmm0JxBJDUcx/oTUWV1M=
X-Received: by 2002:a05:6870:350f:b0:1ea:2d58:46e3 with SMTP id
 k15-20020a056870350f00b001ea2d5846e3mr4214240oah.33.1697582894734; Tue, 17
 Oct 2023 15:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanna Wang <jojwang@google.com>
Date: Tue, 17 Oct 2023 18:48:03 -0400
Message-ID: <CAMmZTi8swsSMcLUcW+YwUDg8GcrY_ks2+i35-nsHE3o9MNpsUQ@mail.gmail.com>
Subject: Re: Supporting `git add -a <exclude submodules>`
To: gitster@pobox.com
Cc: git@vger.kernel.org, Joanna Wang <jojwang@chromium.org>, 
	Joanna Wang <jojwang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

 > (2) does collect_some_attrs() or git_check_attr() leave enough
 >   information in check[] to tell between [a] the attr stack had
 >   no opinion on "bits" attribute and [b] the attr stack
 >   explicitly said "bits" attribute is unspecified?
I will double check this but IIUC, I could change this part
(https://github.com/git/git/blob/master/attr.c#L1100-L1105),
such that:
```
if (n == ATTR__UNKNOWN && v = NULL):
  // keep n equal to ATTR_UNKNOWN
```

And here: https://github.com/git/git/blob/master/attr.c#L1238,
if value == 'ATTR__UNKNOWN', then keep it at ATTR__UNKNOWN

> (1) where in that callchain would we intercept and insert our own
>   "bits" value based on the filesystem property?
I was planning to do that somewhere around here:
https://github.com/git/git/blob/master/pathspec.c#L764-L767
 and possibly combine it with adding a new match_mode (e.g.
MATCH_BITS) which would be set by parse_pathspec().
Something like:
```
else if (ATTR_UNKNOWN(value))
    matched = (match_mode == MATCH_BITS &&
!strcmp(item->attr_match[i].value, get_mode(path)));
```

I will dive into the code more to confirm, but that's my current
high-level plan, in case you immediately see something very wrong.

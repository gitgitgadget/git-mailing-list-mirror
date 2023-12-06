Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbUqiaT1"
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84228D4B
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 14:58:16 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58dd5193db4so39934eaf.1
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 14:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701903495; x=1702508295; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:user-agent:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PJ1qUDo4Jk5JHWsuchCMSOU6aVqMbMn3/MXHhprrTg=;
        b=nbUqiaT1pLrE/ZbECfxOKbjY/RI0UNYoMaTCQ+s04UpKx6yfviZGAxcxF3gDPFYeF1
         gifImcIcF/unOL/Dy8iB+qVBcfPTyDjiUBpr0GJR2sok5h4AiqqsWS3kI+mWJE2acsxW
         4Ow9DiyNDGIN2QMMuKRVy2pBHNIj6JkF3KN3EqWrwePVXNfqA384DnKTDpFf5q+sEsc4
         spg7ACfF24J6BsDz302y316w3e+7NF+c+VDe2D9uzvDAUwTjYJ1xSlWu/p1wx4h9jaSh
         6vWoR6JGQg2uaygyIp+ooQWnfzEE95OjW630oIRRmlChNnAHD5Gh0tiu4hg8zF4s5uIt
         vA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903495; x=1702508295;
        h=mime-version:message-id:date:subject:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PJ1qUDo4Jk5JHWsuchCMSOU6aVqMbMn3/MXHhprrTg=;
        b=nyyDXOSt+kqtEDbMUEnjoyjdW3nlGPSENoYckYo3t6fkAARt/aiSwFZtTCzAphsU/I
         TyNp/YL7xuqf8PLitpXVz4SozYY1yKEUWa6HE2G386X0apPr9jHmuquYMvqBD7IKUGhJ
         8HXNVgImmSgG6f5PhvJMsO2aWoX8ly4EsS6lV2Vpl9iAlriKvMDMJ7bwJiEPFlh1R9t3
         rW0aEvzsMXo6NCjS1t1zawRiRBZttPTKTEXqD4RYnvsf365olHKkL4NyabjM3aIFnXl3
         OerR95VgYXNziCxaLk3gsOKUF8AQZOQ516KOX5HkqXA3yvH9SP0lyi8A1uKmVU3UKXQM
         2NeQ==
X-Gm-Message-State: AOJu0YzU440x5BJpeq02qn6wW7nOqzUe4yS2SLqL/BT8ySorXF3UXGK5
	gaE3SeGc6eVCih9M98ycHCEZbpNXZ4U=
X-Google-Smtp-Source: AGHT+IG2IKUwVnbMfeBUaSZYR1JSjpoOqIg1jDvHi7ocToeTs9bZsiaR5w+qqWkwzXsDvsTzGja81g==
X-Received: by 2002:a05:6870:b4a0:b0:1fb:5e42:5096 with SMTP id y32-20020a056870b4a000b001fb5e425096mr2883080oap.5.1701903495485;
        Wed, 06 Dec 2023 14:58:15 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-j.epic.com. [199.204.56.215])
        by smtp.gmail.com with ESMTPSA id r19-20020ac87953000000b00423b5cf305bsm1638qtt.65.2023.12.06.14.58.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:58:15 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: git <git@vger.kernel.org>
Subject: What's the recommendation for forgetting all rerere's records?
Date: Wed, 06 Dec 2023 16:37:23 -0600
Message-ID: <m0y1e7kkft.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi all,

When outside the context of a conflict (no rebase/merge in progress),
what's the intended workflow to clear out the contents of
$GIT_DIR/rr-cache?

We have developers who'd like to discard their faulty resolutions after
completing a rebase gone awry (but not aborted). There doesn't seem to
be a recommendation in git-rerere(1) for how to deal with this
situation. (git-rerere-forget seems to only work in the context of an
active conflict -- and is documented as such.)

I'm wary of recommending `rm -rf "$(git rev-parse --git-dir)/rr-cache"`
-- it's hard to describe this as anything but hacky when the rest of the
experience is handled in porcelain.

Thanks!

--
Sean Allred

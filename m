Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C7146A78
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585174; cv=none; b=d2mc603bwxQn9pfbwcehH6xitbgugDoek9vH37lGUPROTYvXp28m7K1S2SKE7ULKf4KZ/MwPPgwiHpBsVBO7Jus1LcAD7oSBM6iAw5zL8O5JIUdpDJ9wqK2Ig9GycPpr6Ko7WeLgPLEkgffxPa0X2Tb7lq8sIR9/YvDQMHGruZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585174; c=relaxed/simple;
	bh=FFLfk7YPtXHYyPH5W9lVp29eJnzRJ8YMiWTkW01Dx80=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fya6d5dTX4OseruqmXw0rzvf0JxDLiX9GvO1lqm2NZNAIRPw8jNToL3Cg0mwZc7lKGykDOCHLujgfjxMkaTTmlCBtB8ryK8+sIpKc92CEGfCbmXOWm9xZKYAym6M16vfMdLsNcluWAITuhggUWjZJyPqqmcX5N6wj6pb8sDNd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wir6z171; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wir6z171"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36c67760b1aso19966475ab.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585172; x=1716189972; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FFLfk7YPtXHYyPH5W9lVp29eJnzRJ8YMiWTkW01Dx80=;
        b=Wir6z171NT6q8B2XPTHYYG5yuVQHSMtFggxLqOG8f6alqe2OqA3KEh/khRFWN7Vdbn
         VokY+EYaSiWebuu+RPew2fTA0SCFai1e+xAgaUIUZA+2FpC78+UcVse5LwMNOMENXAA7
         Y0lEY6uUka/TC0u3ATYt9JuHxtL/tYDUylis9x1PNSswC0NIJtNum3u/BHVQ2YIxIRCu
         +WAdbkqNtN/XHLD0CcNc8aGrjFwo1J2qNkUZm9VNfEplvu6tOlnRz5xpxBVhNmTjqEvK
         AREsCr3aXWFSUDe3yu8EU/3rE9Jr/GIwnRmmEonStOl6tdTPqu673WB2bplUMQB1zShN
         OFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585172; x=1716189972;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFLfk7YPtXHYyPH5W9lVp29eJnzRJ8YMiWTkW01Dx80=;
        b=ABgngmDNJGTMWhDZneVoPD/s7XhCZnIf5omzrRdaeH5mjXyKNiWW/AWX10BzQL5/2h
         8ZCUpguzdQAHWn2B0fiiZ9NCiWK1Ek3p/cjFQ+hApF35Q/KFJSdPUzWvE2cnT4xYUkMl
         OolXk+KBe71MTZ0JjgQeFJntmYFlYl4GyAUz4h5N3PtPxjxji/pdcAVLolb+6Urks3ru
         ykamDXPODjC7F7j+DH0MlCs/jNp5WJNJTvCLI0wmaLasf6LGY5MBeHKNT+3IJvwBLZHl
         NH2tnaVwunu3Ru/sKHG1c9+XLjxCtutWQZjdbLMYBW1PfWAkiCefmy2Rsi8S0OEp+bqv
         Ubvw==
X-Gm-Message-State: AOJu0YwPjZ0vqCfTUIxLQU4Yc8rktgKukQgtmOc3NENsL/27Hr/fFj0z
	M0u6swC1hggFmed5zfcIrFvdZZi9IaGsmNRhneE+P6HJzinqKrt0vswYLcY2eut8fQeTsLBNt3w
	pOO4cBeF1KWSoExScPZ0z2lEr6vQx7qp2
X-Google-Smtp-Source: AGHT+IHRPdq6Xf6hQgCejPO9acIYhcpKnr7YMR53Pqkuj9M8Q4J/MxUI3vcI5RMlJgc4VLoGfl2g9pJv1QCVUJOcfa4=
X-Received: by 2002:a05:6e02:1c29:b0:36b:bec:18ce with SMTP id
 e9e14a558f8ab-36cc16eea25mr102541445ab.31.1715585172261; Mon, 13 May 2024
 00:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondra Medek <xmedeko@gmail.com>
Date: Mon, 13 May 2024 09:26:00 +0200
Message-ID: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
Subject: Checkout to different directory at certain commit without changing index
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I need a simple script for unskilled users to do a fast checkout (LFS
friendly) of the current local Git clone at a certain commit to a
different directory I.e. something like "copy at a point in history".
IMO all possible solutions are summarized in this thread
https://stackoverflow.com/questions/160608/do-a-git-export-like-svn-export
I describe some of them with my remarks:

- git checkout-index : works with HEAD only.
- git archive: influenced by export-ignore and export-subst
attributes, so may not produce exact copy of sources. (And needs tar).
- git worktree add -d : needs cleanup: git prune or git remove.
- git clone: Unfortunately, -b param cannot work with commit hash and
does not respect local worktree settings (e.g. autocrlf). So, a
solution may be a bit complicated: git clone -s -n . dest/path ; cp
.git/config dest/path/.git ; cd dest/path ; git co -q <commit-ish> ;
rm -rf .git
- git checkout: Unfortunately, modifies Git index, so some action to
revert index is necessary after: git --work-tree=/path/to/checkout/
checkout -f -q <tree-ish> -- ./

For me, the best solution is with git clone, because it does not
modify Git index nor any source working tree settings, so no cleanup
is necessary. But it's a bit complicated, though. It seems to me that
"git checkout" could do this better and simpler if it would have some
param to not modify the Git index. Is it possible to enhance git
checkout? Or is there any other simple solution not mentioned in the
SO thread?

Thank you
Ondra Medek

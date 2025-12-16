Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312823182D
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927388; cv=none; b=BGilYe5jWls4zcq+cvdw/h405hdKNQ3FgmZhfHkb9zdqlPsSAQJkarYAtSpAGOzUUWKSy39WTRbDemhLHJF44UhNOnY6Zemrc6U0UA6KeWQgXy3wTYmR3B/KuNQ+PxxzGf5S4oZYVrWfJnCxw5f91Am1zG8hytKGLx1Dv90xsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927388; c=relaxed/simple;
	bh=cF8pg9dgOeZQ4l1PzXIvixeEeSkkri9gA3iWlZMF5lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHB2oxP2hrUWZrjcutB8TBNHhsd7TaJ2/mm/+NxwQTbZ42JoiRQdmCVfl0hT3/vJcl/5seLR3/eYFy0ikpozhFLDSHx16HvNMPP9wNZo/TZhRmS0p6se5zjRWD4dxtov/NSRNIp9hGPvX53ammKeriyfbqqTJVvIZSiB9SaxItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxyvTmMY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxyvTmMY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29e0753e5d8so41785ad.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765927386; x=1766532186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGO+I9JxBSAvM6c936+Xi+Ls/8rQ1aF6LGOkY+yfIOE=;
        b=zxyvTmMY25Y+1T7vjds/Xmj4OFjKyK1dJVS+x/2yxRGpIZWDYmvt5zivInyyEB/fy5
         8w5Igr14ZbhiIWTdf+w38RWoWgCFG5o0sxKUiX4oKASzdTST/MJkXiyN7hxDJXX8RYDO
         QU8+0hm1iJY8x9qBeJVXmjU/CJtRHd7binoCIYp11Nfyx7+CqYEohamGvznQrwzh01DD
         yRAiQ/JyTs848Kz4AVrdMCmTDD2+UssaYAih8t6fJx2C+xrYAOFya8loI+Jii4Dc5+kK
         PCPZ2n85e3J93r1tJbU0Z2KCK2vE3I64fP4pwNNQ3/NMjZVXK28sGWbmm5cMpSD+Y7Ji
         5rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765927386; x=1766532186;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGO+I9JxBSAvM6c936+Xi+Ls/8rQ1aF6LGOkY+yfIOE=;
        b=ce3H9c2gNC9GhttTA0tRdQOggpbhHRKRmZquFgEJgImhpGk9bpEFaf0ZyJzU31P9go
         A+AaUZsdbjgYUTTgu1SAgIKfzj+LsnvaDhR6bsjUMgVq7NP5hZaH9oiUg10LI/POTs/+
         tJBvT8UrsWu3qG/Ej+ltdxjfkJrownf5AnsK6H+j9bWVdJaJSdjleYb26LDGt1/iLNl4
         7BnzGZCnilPvVmz/GHRQq6qQ8gVHSYjbBG88v3WmJ3RxNOSMMWp8y+NZApOiJ5NL55YE
         Ammm+mS1AVwWQcki4U6VoBvOQR4DCi2/PY9FFXuNHL6PrbPk1YYJkSr/Nq1k0S9ubjm1
         7lew==
X-Gm-Message-State: AOJu0YwFthde+Jx8gcgcdSX/tdT0B72nTSVjBkDIE/px/WLmKSbBwXgG
	xJzIMkN5eX2WsN2jkBygoN/IEC4QNc1Yoon+3UAf9EiD5hFY6y438SeyTro4bFtumA==
X-Gm-Gg: AY/fxX6/gslGeFVgGtDfxX5CMz15SjgN3XN+U2c0ccX+O6YJfeTfih58DaVMyUkY95N
	T+Ond4ZZq4JRtn6OrittSa1o0SSyBKBZ9EUXdpEmfH8J6ER0HoNgcNkHH1Jlcezc5yqRSTG/wvb
	iYWmUQ4rcAV1OPSVCtfvu30xzE2h4uZxxOAn1QKPSk0e0alduzwL0k0ue/u2azLXZMlZzCgF/aB
	1iVVjQrjsRv7ADOiU2k2t5za7M9xf5mDwa4V/mKyeUfVTYCWM2QtmoLgldYBfaZLR/IB4P/hl7e
	tIxdDBl19BQAffaTt/05q20SgfNbt9cAxbgCmlle5j8XwiTytP2QW7aF4341ZytLAI+eflw5HF2
	2z6ZU2yjWngOEKJZzf9jg59aRP/X5WPdODBl9C/rhQCR4RT0d3Q5YoEtw87JSKK7mwMUCx1hPI3
	Ua3N8WI4CLtM1iWNBTbwfYWNeaJj6W/tokoQBibZYCfUY7THaLNSd1zUQ=
X-Google-Smtp-Source: AGHT+IEqUh9ay9nQgccAUMi8UdGh54KqqTZgySXTl+HXBQedqDf4LeNxOWQUQNpGTU6FHq1fbBkoyw==
X-Received: by 2002:a05:7023:a8c:b0:120:5719:1851 with SMTP id a92af1059eb24-1205c61ac00mr14616c88.15.1765927385068;
        Tue, 16 Dec 2025 15:23:05 -0800 (PST)
Received: from google.com ([2a00:79e0:2f0b:6:33c6:d628:8813:d90a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ae4f0546b8sm1773612eec.31.2025.12.16.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 15:23:04 -0800 (PST)
Date: Tue, 16 Dec 2025 15:22:59 -0800
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 04/10] submodule: introduce
 extensions.submodulePathConfig
Message-ID: <y7hfbq37mh2a6rnwvycul2e3fhxl7bljkdlukdpl3obgg57u3p@vgdsj2wo5nab>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213080817.347922-5-adrian.ratiu@collabora.com>

On 2025.12.13 10:08, Adrian Ratiu wrote:
> The idea of this extension is to abstract away the submodule gitdir
> path implementation: everyone is expected to use the config and not
> worry about how the path is computed internally, either in git or
> other implementations.
> 
> With this extension enabled, the submodule.<name>.gitdir repo config
> becomes the single source of truth for all submodule gitdir paths.
> 
> The submodule.<name>.gitdir config is added automatically for all new
> submodules when this extension is enabled.
> 
> Git will throw an error if the extension is enabled and a config is
> missing, advising users how to migrate. Migration is manual for now.

This part doesn't seem accurate in my testing. When cloning a project
with `--recurse-submodules` and with the extension enabled globally, the
resulting .git/config does not include gitdir configs for any of the
cloned submodules, yet no error occurs.

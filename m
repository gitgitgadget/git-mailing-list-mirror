Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3C14AD20
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470986; cv=none; b=MJpdOL0riBSjJdIrnvoZ0U6rEn5A22nCPIzJBL00Mx5oDD7rgj/KsDCgO6K0tqn10XQy5s2xBNBuZrjP0DigdHI475gMb1GaWhBeJ2wZqz2RbVhRrVkBlXOsLO4Blaj57gk3ynhfhQ+V1/CV5XdkQoNJ0BneLOooMOKPfNhO1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470986; c=relaxed/simple;
	bh=3KBXYEta5HGgg14ggZkbR799LQQbt+8eKiWtDgA0f/s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e5SP8+mMxD+BaHvJS/drKstB57Io4gs9qEKvZMqP9tmtWrbkVw6bvbmW4pCMOlCo4lS9LeU1Oeq8E1D3A+d3BOFF64dxaXVqLAHJxth3/JCu/T1aTMIRY7ZVzWgH3MyjPjxvFWXo0lHI6tKVVUvSwqthIYkCEIO9Aumbhd59u4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qZmyfCjJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qZmyfCjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739470977; x=1740075777;
	i=johannes.schindelin@gmx.de;
	bh=9WTubkY7bzFpq0QUUUj0nB3BfE5ECUCzn1lqHDjfWec=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qZmyfCjJBMbFrk9XLRb822QMiNEBwoxUnBmxORmZeU9ZQEYkJkNfpLebkOkjlGoI
	 +C6l4pkb1YoxEb3GFFvtP4/3lsOzzoV5SsxGblfiqjrS+fLZbXVFrw2wwAa6b8yn3
	 wZkG15YhjpxBovU97D2+Q8nmqkTdIdat8fxbGrAUgVZmgh5XveRxseImVTSriFfeC
	 ufV2n8pRwKUgTEpflm5qS1g+biQ02ReXlT/LKyxJjlLXuGZckN5Ze4yUfURHw6se8
	 dAgBvLdkro2GOnR07PnYh+Ecxu415v/AH0Y8db7oqPLzEA9nIydfkiGz+hTtHYPLE
	 g2YcE/KX/7U0lSD1dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.128]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1syXU12Ixc-00dFCz; Thu, 13
 Feb 2025 19:22:57 +0100
Date: Thu, 13 Feb 2025 19:22:57 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: Patrick Steinhardt <ps@pks.im>, 
    Edward Thomson <ethomson@edwardthomson.com>, 
    Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH v5 15/18] compat/mingw: split out POSIX-related bits
In-Reply-To: <c48e8fa2-cca4-4abc-95d2-234fa5c69b8d@kdbg.org>
Message-ID: <e202a870-921b-8f38-58af-3d44e94c447d@gmx.de>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im> <20250207-pks-reftable-drop-git-compat-util-v5-15-ba2adc79110f@pks.im> <c48e8fa2-cca4-4abc-95d2-234fa5c69b8d@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:agLuaZhpUq5iqx6XffvN0qdzpWXU5xWImSrBxc3b7t98Q+p4Y+p
 zlBgqHP13jBQL1Kbm1RrBxvK6hbkEcXMCxsjbiUyBxtv3eW14SDgLfDQ1DxPgejFGnmz8f7
 zVIsvSY+Qk3QzP29ITLV++se0gCXmz7u2GhPXnPNTAmyLOTXpXkWlZVjaYjPpZo4p+i+C6R
 9l+7m9CN0dJLM5MeiOv+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s8gn2Qvch8k=;A26/lobK2UqMSE4AJGvc3YxRuCb
 3ZyItKJLmPrFiBRP27w0j9JUAbd/SAwDTKxQiax4eQ5FGZwvqSr1FO8XSLaNUzgNXLVZIv/M+
 2sTMQoEtk1KpqApWQpbDY6mahBMa3RY8YjKPDdf+bJ6Kseao/Ru12no46w60NAiwT4ktYvu6O
 LvJ2V2BV17PnQJ09wSsx0kb8QpzDgPOWhUfg9a9Rg4k0EC4gjuNobp7f+WJzgr+o4lvvy3+bm
 pvB0dvJQpopMuHq6TFQ5bQSSbZ30U5fYrFergYQcTZXnenN0D0M13pvBdBUsZrBGdKTt8hIYx
 j2WVbUXLQHZbUqBYd0uAEdJxoGdTnKZ3gv4RAntO66aa1UDzzhDOfuK4SfQYdyb74fbybjRpo
 5MpWdSTGMtSQeOG4CmazEVpxOGvP6U0Hex+wnKZtIy3hhaBfN3IUWdO+YglAZiTvDOn/5IO42
 GCb/WwNY/+eznmxnc3cVPJcJhkipDNTsXkvg4nFri+D+/Ec1fgUGtwLe8IeIzTrI7QaoIXaim
 LUO/WdR1JiLZIxPa9dp+pRJJTO7+Pnh8tXxklKRO4usXcl+Z44rux0Emz6LKKnN6FhbWL7Jm6
 wxWSPR+o2fTn8h6hq0Bto92CiUXFdLsUAeJYEgl3rp90tgS7YjvZk/NQ656X5XE6gtfqjuSvK
 bLRL0zIbsy/MEQDX0kalYJh8Njggs02XQEZl95NgnSnt7/ubykvyokLd7JwrEt0+fA2xrTMFh
 xIK+knfOz00/rL3snSN4hHWokYCIl/GlYxJIg9hdQOO+Ein0z3a3m4udwn5fudyz2I0Q+pTzY
 we3MDNXDfVDOGW66GDzDipoXNNXN4pWA0coVJo64I0owUgC092h4qRwxduoysDV/+mzhARjqZ
 JBFNcWFgpsCx49lqdVUezKxpANTz9Ubo180Pvt5/OzYEif1N/Zr1cjJlY4jXOMQCGIVVn6uzS
 FmbEGxjTZXEhj9377qa6bKnxLZDFR94vvESPdmYQz3UCN1luyKGCxjlPWFqtsgZmrrvHWgFAw
 Qd81sZ5wxuc9g6bm95+xxzf4BxDkTzUOIvr//UN1R7bKIsp94GfS3/giNcqJhMFhyFelPgdRS
 2BozzK5CLhAfDjR4LzMbY+4IocwP86bFga5zsMlpRbLhU7UWiPM6t3n4EJW82Gb5LZu1TCNwl
 yp72qnJZSXlTJC/eo/reuFwbc4DwP/5C8rG9s73T4Ciprdb1wdek7qPFMd+o2lPjX3LAQ27ER
 p9CH66K3RYSrAigM/X2ePvlTRegM7nsF0LMsIHN4gznP3CSWe0nx+pWVm/ZHoyTOps6VwhVXl
 QZibH2887Tk0tFKpV2TgFp3Whl6zOC/U65pNzvShwCaD32iWZCiqtYlcNf8SNyNYQCmcaAlB/
 WhnEEVpnv+X/QE5o/mJjxuU1MqTgLe6U+cxihiCn0QXUICQzuhyr5BkwWeHJIqF0WWUlKShbb
 nkYp/+Gc7NlEeJw6G0Kn5c+6d7RlQII8P+Q2mSTbnmQGUiNZn
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

thank you for looping me in.

On Sun, 9 Feb 2025, Johannes Sixt wrote:

> Am 07.02.25 um 12:52 schrieb Patrick Steinhardt:
> > Split out the POSIX-related bits from "compat/mingw.h". This is in
> > preparation for splitting up "git-compat-utils.h" into a header that
> > provides POSIX-compatibility and a header that provides common wrapper=
s
> > used by the Git project.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  compat/{mingw.c =3D> mingw/compat-util.c} |  28 ++--
> >  compat/mingw/compat-util.h              | 220 +++++++++++++++++++++++=
+++++++++
> >  compat/{mingw.h =3D> mingw/posix.h}       | 216 +--------------------=
----------
> >  compat/msvc.c                           |   6 -
> >  compat/msvc/compat-util.c               |   6 +
> >  compat/msvc/compat-util.h               |   7 +
> >  compat/{msvc.h =3D> msvc/posix.h}         |   8 +-
> >  config.mak.uname                        |   6 +-
> >  contrib/buildsystems/CMakeLists.txt     |   2 +-
> >  git-compat-util.h                       |   4 +-
> >  meson.build                             |   8 +-
> >  11 files changed, 266 insertions(+), 245 deletions(-)
>
> I can agree with this rearrangement of compat/mingw.c. But the
> Git-for-Windows repository has much higher stakes with all the
> additional changes. I put Dscho on Cc.

This indeed causes massive friction. See for example
https://github.com/git-for-windows/git/actions/workflows/main.yml?query=3D=
branch%3Ashears%2Fseen,
which should ideally be updated with green builds as frequently as `seen`
is updated. It's dark red, and there are tons of gaps (which means that I
was not able to finish adapting to these changes).

Another problem introduced by this series is that now the same filename is
used in multiple directories, which makes it unnecessarily hard e.g. when
setting breakpoints in `gdb`, or when trying to follow `#include`s.

Granted, the problem already exists, e.g. with range-diff.c vs
builtin/range-diff.c, but I would hope that Git's source code would be
changed away from duplicate filenames instead of adding more.

Ciao,
Johannes

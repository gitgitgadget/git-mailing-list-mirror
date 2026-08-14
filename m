Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991C3546F2
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692268; cv=none; b=Kp9waJdCWWmlwVrEiCrTGgJoCSpaKm8S0tmW8eKumtwYFKe+PX9z+JEZ7oWUSToFs/9REBBiUf12HGUET2LHOMH7ooLYCoQz+HzTLdvz6StiA67k/AfR9tn4AC0P1z6csYVhSHzoSwuqJ5lsn3qwTwKtXwsay1MXxFJ5sbt4jM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692268; c=relaxed/simple;
	bh=9brsNyXetqJG/ZAuizlfJP5Y6+YHiv+MftuCj1wDBfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyJkg+Z3EYiYxDNtUUjPKZhsxn+kcOOD5Ttf9qY79sf7ylur0vuRMsr57FFKyjMmUPmt2fxWpSDFgpnkvGBvdhbeIdIFka9T/yH8CNh7hiJJ93PjFdwTq6HhQAJsM6jCOyuspC+A0JrrRLrQ0Y6i+hFXs8KfesCOyq7NZM98ETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=I9iNv8hN; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Dxv7Jzfe; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="I9iNv8hN";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Dxv7Jzfe"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=I9iNv8hNw61s9qBZgOiBAwmUV2y6gLwZuo5m6JrA8GZOvB/qEwfpeTSlKblqWiwpX18O//BUEY6SiqTt5Sg8mjxvyUw+zGS4geD0SoVb+MxkDrGsvxJcyPVV6UU32ITAg17pB0HoR5Po63aSoAGJvxsUCDd63oAdM2tJZ+qXTjIcOn85jYXRUlCJXhGQ15J6M3kJmOAn5+tKs9y5/GDg0MbBsBElPHMutNjkOkvsAgH3ttayfyVUKXHjd1FOdDD7JugjbZyAJ3+OJmJAQrTdTsDeDlTaUZM+ba9mb+0MnzNkzieGG35zst4HEgCRp5gAqKYB/wkHeu3BsC4B0eW6Dw==; s=purelymail3; d=malon.dev; v=1; bh=9brsNyXetqJG/ZAuizlfJP5Y6+YHiv+MftuCj1wDBfo=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Dxv7JzfeW5csC/ZFec53CurUioaVPiELoN0wdu26EQ4XrcHazMg2jjjjDT+L9rsGrMY/Erpe5MXB8bahQGjtbbw+VdlHlQifLgdKO0UnoTKB2OJk2uKkz9PuVmjI9hFUXjAZo97nOXhF9zzutZLsVcvsakw/GFtDfQ6rUYADlJaT33+GUTyzeJJmkk63OsWrlKMqj0KLo68Fd69zTGQc2sTZ8St7pRjyxou2YeGPu7TqmkEjdxXK17Nv93joelW29F+pgvq27tWm9AD0uFTW5ezb9Cl8nY0/hsdhFsVsGLaaGW5SUkD3uUNWdZUA9x1CO3yRPbG5vnV70Jb/uMguHg==; s=purelymail3; d=purelymail.com; v=1; bh=9brsNyXetqJG/ZAuizlfJP5Y6+YHiv+MftuCj1wDBfo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -946158751;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 14 Aug 2026 07:24:25 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>
Subject: [PATCH v5 0/2] repository: move fetch_if_missing into struct repository
Date: Fri, 14 Aug 2026 15:24:17 +0800
Message-ID: <20260814072419.1666358-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813061125.1089553-1-cat@malon.dev>
References: <20260813061125.1089553-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi all,

To continue the libification effort, this commit series aim to migrate
the global 'fetch_if_missing' into struct repository, making it a
per-repository configuration.

Changes since v4:

 - Use repo instead of the_repository in more call sites.

Tian Yuchen (2):
  pack-objects: give fetch_if_missing call sites access to 'repo'
  repository: move fetch_if_missing into struct repository

 Documentation/technical/partial-clone.adoc |  2 +-
 builtin/fetch-pack.c                       |  6 +++---
 builtin/fsck.c                             |  6 +++---
 builtin/index-pack.c                       |  8 +++----
 builtin/pack-objects.c                     | 25 ++++++++++++----------
 builtin/prune.c                            |  2 +-
 builtin/rev-list.c                         | 17 ++++++++-------
 common-init.c                              |  2 +-
 git.c                                      |  2 +-
 midx-write.c                               |  2 +-
 odb.c                                      |  4 +---
 odb.h                                      |  8 -------
 repository.c                               |  1 +
 repository.h                               |  6 ++++++
 revision.c                                 |  2 +-
 15 files changed, 47 insertions(+), 46 deletions(-)

--=20
2.43.0


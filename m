Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC6946C
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915014; cv=none; b=HlyHH20lZjjFMj190I4LyCXgEFf9RfzcXirEZbwIWiinUo/8gGEnhrshYlBsOvRtPvfsT5RvWyWXqt9tvP6M1AnvR4tS9dG15fgVVmsyzptAHuYHeSLNzsI2rwkVWfKlOq37qjq54yt38hKIHzQCpj/DIIwsgKBZKUjd5qIJI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915014; c=relaxed/simple;
	bh=xXGbyKnTBzkKKddrbIg5Z9xK+2wahtIar9JlvTDyRHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Aund7+SutXkgw8QUzekdKCtHsTmM/BqmvLZXXqMn6OTOL9k9DrqJUJDaa+B4gIB98f97Qb5P0qxmZR+yYwISLimcnXTD8Ndv8r9sT699WFUXW4duhJOKFIrwVOEVR/AlaH+Tcf0NR7Xf7DtKnAPQ7NM8kcqjLjT/Ytl7cylMYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in9dZehr; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in9dZehr"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so5256621fa.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 17:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727915009; x=1728519809; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXGbyKnTBzkKKddrbIg5Z9xK+2wahtIar9JlvTDyRHE=;
        b=in9dZehrfTEkEa9Ak2j3paQ9qVGEBN1BRgqqbZ4lhBYlnZr0oocKOZyYxfoEko3Gy2
         v/BK35CcRynrckwKmJTRIGLXNuRwtUSI0/Z3FIINMlzSKXX6n20Tb4iWDejciEd/D3Y+
         0SZOuWgDZbm34ykfNz2BcQLrR+YMnkG0x+3Y+kgbk1jgRQ/w5F+P+6jE1PAKuIPWUs59
         gEEl7MfihoUdwTTKufqfv3n4mFoH/8BSuYAHDIS9a2JZVvsnCUYYDlAYB13gi+7zFVfh
         l+y7ftXD8kkpYm7GqWdp/ADQagD2Jf+wrqfp2TZtut6cahFFhGRJ1mt+NZ9ZyPjBuo1L
         hXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727915009; x=1728519809;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXGbyKnTBzkKKddrbIg5Z9xK+2wahtIar9JlvTDyRHE=;
        b=c8oAmcVYuCabsX8bkmzXpI5xwSs4/GycqmLUHMI6inabeMDU+rw6eLHpbWPfrZZyRi
         WY6wbnRC8BVAe5saUlUYJhx806FuPtzQkiPA+EEm199oFxG+FRUYpnMU6rP3D7C4WLm2
         +KrMmTde5+80+NzmoPa1W5XNI3T1mpWxwptdKjc+932q/PWeKj1o3DcY9xmoANTNlIxD
         AqgvcO+kHa3zHlpVVCg/8xWYUxl0HsNzq+WYTikxqhouc9tqKmyADB7ZSEQa4BGfSEPH
         E3nWoIjwoc6RprgKhKtNG7FWjpmG6hg5F0gISJc8kPLFlQtvcdamAdKLI9NCDy/oe7f1
         G+Kw==
X-Gm-Message-State: AOJu0YwkxVNojA5LAdAet1kqAKZdtAxlnJ1R8vB5dXDui8mS1g3CKisW
	8zf+d4g0++hO2awHaBtoCLupxp3uUwckZ1CYzkc7B7pLfDPXKrMRGwXZJim0G57tjwpTp2L1eQf
	U0zfcivznKd2n/qGzGvyZviSGkBwbXACt
X-Google-Smtp-Source: AGHT+IGCVVuN0RiChpe+SyUiKWCbPt9uBXrlsmwulOOZkXWAJdmHfAdJlaHMmv9G/uFjXvXZ3+lh60oVU86IN2S+8aY=
X-Received: by 2002:a2e:a9a7:0:b0:2f3:f694:e973 with SMTP id
 38308e7fff4ca-2fae1016b98mr32159251fa.11.1727915009251; Wed, 02 Oct 2024
 17:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANp3UNBGd=jiSZyFSAdPjayvgHbP5SF4Dm-uCNwna_H16bRgRA@mail.gmail.com>
In-Reply-To: <CANp3UNBGd=jiSZyFSAdPjayvgHbP5SF4Dm-uCNwna_H16bRgRA@mail.gmail.com>
From: Sparr <sparr0@gmail.com>
Date: Wed, 2 Oct 2024 20:23:17 -0400
Message-ID: <CANp3UNCXqLJmAj2Vc7jB+i9qRjfKzrri_Mr9VvG4J5tUR-1HeQ@mail.gmail.com>
Subject: Lack of system-level excludesFile
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I found myself in a discussion online about where and how it is
appropriate to ask git to ignore the .DS_Store file that is often
created by macOS. This led me to considering disparities in the
current state of git-config and gitignore. In particular, git-config
has system-level configuration in $(prefix)/etc/gitconfig which can be
overridden on a line by line basis by configuration at the user,
repository, or command levels. However, gitignore does not have an
equivalent system-level layer. You can set core.excludesfile in the
system-level config file, but the user can only override that whole
file by changing that config option, they have no way to override
single exclude entries or even just add to the list for themselves at
the user ("global") level.

I think that a system-level ignore/exclude file would be the ideal
place for the git package on a particular OS to put OS-specific rules
like the following examples, if they wanted to do so, or for a
sysadmin or root user to do the same to cover all local accounts by
default if their OS package opted to not provide any exclude rules.
https://www.toptal.com/developers/gitignore/api/macos
https://www.toptal.com/developers/gitignore/api/windows
https://www.toptal.com/developers/gitignore/api/linux

Was the decision to not allow or implement such a file intentional, or
is it just an emergent property of the way the config system works and
how core.excludesFile was implemented? Would an implementation of a
new feature supporting this sort of thing be worth discussing?

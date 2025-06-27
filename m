Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4F1F8747
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053818; cv=none; b=SYlcATs+yWzzARPJloqu7GA7bdTXzQjxFBUPknJR0CND2FM74uBvoVaRUtdmVzSvMoWcp7WCdgvslce9U3Gq3PnEjLL40NDorT/OIMaaXR0ODdxwIY4AnKEKtzvm7UzQBbgfxnVJ0UZoluhusZzmBq6buG3nGn2Kb3SNMnWxS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053818; c=relaxed/simple;
	bh=12W5Zc8zuPQ3j4QjZ7IL38xPPy0LDgJXuUp0+l0Jxjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUI6H6+yAEoNX539Sy4r79sHtmOM8wR3T9OwaeMKfBP9HW2RTsdkMup6t4vGeVtc0TdxmS2grbZ80ysWnnMdXwX92ZK4FChAyrL6ysY322TXVQawgGS/a2TXVT7rJjSmhAcPCsLrLq4wexkSynN/9f9XTGTyVybVPkcIO1vvtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK1pw7eR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK1pw7eR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade5a0442dfso474156166b.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751053814; x=1751658614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12W5Zc8zuPQ3j4QjZ7IL38xPPy0LDgJXuUp0+l0Jxjc=;
        b=AK1pw7eRMpFnh/2TYpHwz1c+LO4apxvlkCzkbN+j0T9pA4gwM+9f10rfV8oVg8VkvM
         ULMTwWlMaMDxi6ZC+mvnUwXaq/AzKkytyyL48JzTGswf9HovOQQo04EpIEED9E/M0daD
         Ipque+RxWKNdfcTQhszov5E26p4CSFx+6oBYNRZ/Zd4XsSRPhmpHMqin/CU8mhLuwulp
         Gq2VqJF4+VxhRBnD6bNmQBbS8VEqRFLF/BtB85/UlSkHH86GfZ7aN50ieFUDS3hOqZuj
         fDxQpVxHc0o0zCW0ozf59yk6cLSuQZbCYTPdfTxSM+s0NmsjVI9pufFENIWYVldC1+fa
         nSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751053814; x=1751658614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12W5Zc8zuPQ3j4QjZ7IL38xPPy0LDgJXuUp0+l0Jxjc=;
        b=grAQRZrJEmDcsu0hc+jfZmoNz0Lu4gkfq7AIDhmL0PKLkWz9xbPLglmkZw8J3vBg1P
         GupRSs2BzuZfX1muv68Uy+5LvDItKJOyf5xJLwhX8ud7z15dM/hzclvTrzeD2SeFjnuc
         g7CrootdYiyo9fnFfCjc//4xaY/UVsDm6A0DtGlI5GlBXSGdm0rOUL/FuApDIipLBFre
         ZoS58nJTty+1VgAcCSQf+q79aCA8AfBGyqlKJrSIeSFsmWScXh/VFBz7o5ay8o4r3UlY
         4jqXJMCl9GeWGUqQMN7Kw4g2TEwUMbB3zp7OWNHB/uIvmuNpUVfJFaT5ohee1DSlZEkH
         sbAQ==
X-Gm-Message-State: AOJu0YyKpp+nUEj+uxIxMqitjCdXQtJprOi0nJp0MTvjxQHveCzFHJui
	Hh3U9cafuw8e4HCwpMy2AVrH/5IhA2ozuUZAc9INUAghkyXistwng4bZna94LGYWfwkvlXjtkbc
	DYbTsPdZutTURn2bZbh5+mshBp8BOMw6gjf53
X-Gm-Gg: ASbGncvKRtgz1SA7GKJWN+5FSgOhHFuCI11EjLwJXQ12KXodUs2LUTrENaQzPKh50lu
	clgFzLmBHTyFu1cheZbUpw/wpg3+aXwZ2UsaqPAMBo2zgeMMKMJGQ5ZBbJu4lKnLYNQjolYnZT7
	3EODY0R9Li0+M1DO+sP8RM9dS9Lrlw0vBV9C14c8epZQw=
X-Google-Smtp-Source: AGHT+IEwnzi9oomQfkz7+gQzS2df4NyYZGMe5A1wMQSOIx9v8n1Lo/2kg32KY5QIIBAGSDfxh0WkkD8IRyd4G4rlEY0=
X-Received: by 2002:a17:907:6c14:b0:ae3:5c44:6f4e with SMTP id
 a640c23a62f3a-ae35c447337mr289753866b.24.1751053813766; Fri, 27 Jun 2025
 12:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
In-Reply-To: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 27 Jun 2025 15:50:02 -0400
X-Gm-Features: Ac12FXyCWgKdtASzN6sek1rHhlnVimD1DmHWoQOUfalyuIpaVYihXHobZep7SNs
Message-ID: <CALnO6CAdftdE7uCrrRPRvqS5J8G_iFxoTY8GffxGEOZkJ98aWA@mail.gmail.com>
Subject: Re: Git "Permission Denied" errors on DFS path only with newer versions
To: Erwan Leroy <erwan@erwanleroy.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:14=E2=80=AFPM Erwan Leroy <erwan@erwanleroy.com> =
wrote:
>
> Hello.
>
> I'm writing to see if maybe this is a known issue, or if there is a
> possible known workaround. I've not been part of this mailing list
> before so I hope the format I'm using for reporting is going to be
> correct/helpful (this is attempt #2, I did not set plain text the
> first time).
>
> A bit of context:
> At work, we are fully Windows-based, and mount our network drives
> through DFS. We are fully cut-off from the internet so everything we
> run is local to the internal network, which makes certain tests a bit
> more time-consuming than they should be.
> We have been working for years with Git and a self-hosted gitlab
> server, and have had no issues.
> Recently, some of the new hires started reporting lots of Git errors,
> mostly apparent permission denied errors.
>
> One of the errors:
> PS Y:\Users\xx\Public\dev\test_for_it> git remote add origin
> git@gitlab.xx.local:xx/test.git
> Rename from '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/c=
onfig.lock'
> to '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/config'
> failed. Should I try again? (y/n) n
> error: could not write config file .git/config: Permission denied
> fatal: could not set 'remote.origin.url' to 'git@gitlab.xx.local:xx/test.=
git'
>
>
> What we found out:
> - The first thing we found out was that only network drives were affected=
.
> - The second thing we noticed was that not only new employees after a
> certain date were getting issues, but also longer employees getting
> new workstations. This started to make an actual permission issue less
> likely, as there was no change to their user permissions.
> - Then we noticed that the delimiting factor was the Git version:
> Users on Git 2.21 and older had no problems. Users on Git 2.36 and
> newer (we also had some users on 2.47, and today downloaded and tested
> the latest 2.50). I would have tested every version in the range 2.21
> to 2.36 to help narrow exactly where it breaks, but I can't find
> pre-compiled versions for old versions and I'm not currently set up
> for compiling from source.
> - We also recently found out it only breaks when accessing through
> DFS, if we directly access the corresponding UNC path (what DFS
> resolves to), we do not get the same error.
>
>
> It's not excluded that there is something wrong with our network, but
> the fact that it works with older git versions and not with newer ones
> makes me think git has a role to play in our issues.
> I wasn't able to find a changelog, if nobody is able to look into our
> issue closer I'd love to at least be pointed in the right direction to
> see the changes that happened between 2.21 and 2.36.

Changelogs are available with the source, for example on GitHub:

https://github.com/git/git/tree/master/Documentation/RelNotes

>
> Thank you in advance,
> Erwan
>


--=20
D. Ben Knoble

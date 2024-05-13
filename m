Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6972940B
	for <git@vger.kernel.org>; Mon, 13 May 2024 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623360; cv=none; b=bL8E49w+5gUnj3rf5Qg5fCilGI/Mijwxw/5VkRFk22VcWlktVt6OxQqBtc0XSdCzvg7+EIuN3bf8ZTaxu0sgfDIz0z2bOBYbW4I5WiD8/o70WOXqhSIN4No1AhS97WDw2ejPrT0SpidXglBKCRJQdGrzx0c7cBs478TcDm2bNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623360; c=relaxed/simple;
	bh=8p0VKOiyr/9x2bSQGCpvsnQKmA2RwDfnaxViM1SwWfo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8y6vJlCMXyEMnKaytC/9LdIK26hNRUzZG8ZukhwfzzevgXF2GuzWIflUD+ZvocZGkifV3ub07hxNvtuQzF0guROeZvtPPnYjbSFHPTOTp54B6d1wD08HEoGA6ivkaVCKW/LjwZHgHTY2pgPQAmDshhJ+Lyn3R6ClAhcHPoyHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l56O2whi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l56O2whi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso35749265ad.0
        for <git@vger.kernel.org>; Mon, 13 May 2024 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715623359; x=1716228159; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8bmHEnV3yKG7+Fas4V4EFl2MbrHhE/Jb5OeoJnupU4=;
        b=l56O2whivx/5Jfqb55JAfMHxDprbtO7+6Ca6ELUetKFQ8MXJCmEyiMy90MAhHg6+Bo
         9c05UrlDACYLqUyJHpjxD+rEVFtNjIM5XFVF25mrBmq4q85XQ1JXCjJcp7zlj7IswsRI
         KfL+/9fzewM2rJ3eZ4W56SR0rbLtBbTTpprlMrhYxnszcsQhaOSkM4ef9rEzItiSGnFs
         6CvSzMQIQBnFQKacTAVAHegbh0/yaBHfgpQej2nK/aQPpggts3DeUdQrK0HrpcX423uc
         nOfUOL11kbhEJHh0v+DUtQmzjRVo0ZXd6466LWPYYwXT20JbucTdqjbj1g5VeD80v6fj
         L+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623359; x=1716228159;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8bmHEnV3yKG7+Fas4V4EFl2MbrHhE/Jb5OeoJnupU4=;
        b=g9N5xrSrFQmx5Nc49dilmo/9CPPyR7PlTQ8uhwVC0sq5tfBcOFtjvCGIj4HIVp+GLF
         7bwgxgPtQrq/SNbxHgVlOpxv0H9PfyGBevyeOHeQdKMd7lE3Q97atSCwio13upTTZ94S
         JYafRMcl841IIrZK8uIRb3NLJ8jpIqU+T8qUMJdybK3D+f5fkrEt2yb3FGf5Z0wjwof+
         Z8ccbPQHXYsTrYTkwTFfoBDAS6axxEhnmE7hOiZpUapLIMCOP8jAJ4svW52B0G40mNHg
         wLl8OG/sAAw1LurH8Kd9NROJafruHLPDbCjVy1Y8VRwMATQDjve0NEHQmcdpLyOrlmBN
         HvqQ==
X-Gm-Message-State: AOJu0Ywr5/DRnmG7Oac3FTi1aRa9GvxkSV+tB1URWpbezocpXkpYxZ2I
	SS8Y/kjUTWDC7xtmuvy240xqBKAhhgXLW5XMnM/OquitmcKwNSMinClbkTi3
X-Google-Smtp-Source: AGHT+IHik4Xjx3n7qyb28vVFTO/xsdUClkTefLrUJOFeChLl9aABv+SyBXebvb+tafmEgTWQyGKHww==
X-Received: by 2002:a17:902:c94a:b0:1e8:26e4:d089 with SMTP id d9443c01a7336-1ef4404a1b8mr125894715ad.54.1715623358666;
        Mon, 13 May 2024 11:02:38 -0700 (PDT)
Received: from DESKTOPI2S1NGB (99-58-59-125.lightspeed.austtx.sbcglobal.net. [99.58.59.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad84f4sm82450385ad.91.2024.05.13.11.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 11:02:38 -0700 (PDT)
From: <lbdyck@gmail.com>
To: "'Sean Allred'" <allred.sean@gmail.com>
Cc: <git@vger.kernel.org>
References: <02f201daa547$503df630$f0b9e290$@gmail.com> <m0pltptx3h.fsf@epic96565.epic.com>
In-Reply-To: <m0pltptx3h.fsf@epic96565.epic.com>
Subject: RE: git client enhancement request
Date: Mon, 13 May 2024 13:02:36 -0500
Message-ID: <04a101daa55f$bd15ce50$37416af0$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGAerfcO1waJyo8uA6nqAp40soFFQIOt0DasjlS2kA=
Content-Language: en-us

Is this technically feasible - that I don't know but it would seem to =
be. Since there are tools for github/gitlab/bitbucket that can do it =
then why not the standard git client.

I know that for GitHub I can also do it with curl (haven't checked the =
others).

What I'm trying to do is to have a usable wrapper around git for the =
novice and not require other packages.

One would think that it would be comparable to a "git push" but with the =
addition of the "git url" and some indication if the new repo is to be =
public or private. If it already exists then return an error message. =
And if it doesn't already exist then do whatever the current web =
interface to the git server does to define an empty repository. Having a =
requirement for an existing local repository would be reasonable for =
this to work.

I'm just asking if it can be done.

Thank you


Lionel B. Dyck <><=20
Github: https://github.com/lbdyck
System Z Enthusiasts Discord: https://discord.gg/sze

=E2=80=9CWorry more about your character than your reputation. Character =
is what you are, reputation merely what others think you are.=E2=80=9D   =
- - - John Wooden

-----Original Message-----
From: Sean Allred <allred.sean@gmail.com>=20
Sent: Monday, May 13, 2024 12:56 PM
To: lbdyck@gmail.com
Cc: git@vger.kernel.org
Subject: Re: git client enhancement request

<lbdyck@gmail.com> writes:
> I would like to see the option to allow the git client to request the=20
> creation of a new empty git repository on the git server without=20
> having to open the web interface to the git server to define a new=20
> repository.
>
> Perhaps something like:  git server-repo public/private name

Is this even technically feasible? My understanding is that storage =
implementations of each forge vary *wildly*. I don't believe this would =
be under Git's ability to implement as a project.

You might look into combining your preferred forge's CLI with git
aliases:

  - GitHub has 'gh': https://cli.github.com
  - GitLab has 'glab' =
https://docs.gitlab.com/ee/editor_extensions/gitlab_cli

so you could alias

    git config alias.server-repo '!gh repo create'

to get something of what you want.

I believe GitLab also has a feature where you can create repositories =
just by pushing an existing repository to an empty project path.

--
Sean Allred


Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A317FE
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711306907; cv=none; b=nhG2RR2Etr+4axS2PkiJzM4REWVRI/0DbwSCcmd+cFzoLUzLe8xBIomYHNGzSgeHc7R0DkiOn2kzSIj3OuZw7ylGjAV/TLEnV0HAMZUrriWkVsPUD/1YsOHW1T+GtRMSAMxwz3FD59n0DYwnxgDNEQOUye44WfuM9OGU2SC0mmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711306907; c=relaxed/simple;
	bh=0emmVjiZD4tyn23RfbzLb/6fDElO5NstO4mrWXxzKic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKH2gu0AmDY9bzZAsJKc9+UfnnvEQcE7YD7+2VnPfuFdZGQe7POlRNqA1uBa6Mj4Lb2W2Ua8wLRrXKtec6QTaY6BS6NDYPc5SOpwNeruZecgR9nkj07aeIeC4Ebn+7WWNG2IZGl+QSmC8CwfVKrzBkv/9fAGLPuqmYVKDJmA2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZm2LD+I; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZm2LD+I"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29f1686ff12so2459480a91.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711306905; x=1711911705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0emmVjiZD4tyn23RfbzLb/6fDElO5NstO4mrWXxzKic=;
        b=eZm2LD+IYRdc7TFUZwfaU3gUAlGeB6QCnkBkeiiQBJDB3TaUkLfNkMAuHrr8J5UJd/
         jWLikkjTtTAd99E0ZSVOmPp7riTQ5AebFrK8y72C0ST6E5Ec3gAXumfODL9j7S7ENDKE
         v0lE5h/nNxebiMAzDL+kfmePguuEmy22354XQKLrZG7FbqbISe2exXKWprS6rVTxJOUT
         PlfnGVk27zSd3eA8I/ezGE+iAymimdLirYogJfS+loq/nMjBOF0O8XS3vr1aIjNTKkSw
         6PVligRNrUuS19XsqHd+2FUUsBXo4ETZF0ikr18WrewoXJPlAvIcprXa4BvnIzonCyFu
         tOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711306905; x=1711911705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0emmVjiZD4tyn23RfbzLb/6fDElO5NstO4mrWXxzKic=;
        b=hnZDSXZfCN9jcTtga8+t5AAxzRU4nBVi2GhZna8cUmggBlezI39KESeblhnmiFQkJu
         iF2Vcx54q4hJu/gDeA1r4toakcSIh4aNzboKkCTInqnvKTbRudMvQaMTmvpJ0bEhL39x
         pY4mgY954frcKP8hYkT7YyE4yh8yzwy+li5qv2hALvk1aLLdMwc/p31jHrHxHlUchozq
         8aCqqKoWzm/itcprFGmvT+Pr/G30alvRJ3TXwG3kRD2Y97vvB93MD6aPwJZFG0rZql6Z
         6u90KU5kJpzqq619Gih+JMSpdMpm5v90U2udOpXd5Zw6pAjLY23t+2t1mNxuhYzuvork
         J4LA==
X-Gm-Message-State: AOJu0YwaPwvqNh2prJMPX8rxWzd1/ZTxNfyL5rqiSSYSLNnffFTORr/X
	ubttBAnAyPQk7hQgV3TBkZx+pC6IzMUuCZTGj3DcG0ky7SccEBWMmPU6hl7wKxV7IpyyHuJezda
	F7Z0dj/NoEXTD/h/nHmovw2IzgzRL1D+5jgM=
X-Google-Smtp-Source: AGHT+IGq1f/QPEEvb1ZVpdIkUXiiJy8ulS5OPcm7FWgUbQORaogGJkdpS+n7MfdGjWxDhprKrnR9zVN7a4HHSmTgqH8=
X-Received: by 2002:a17:90a:e147:b0:29c:e2b:ace8 with SMTP id
 ez7-20020a17090ae14700b0029c0e2bace8mr3441375pjb.35.1711306905057; Sun, 24
 Mar 2024 12:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319203244.799796-1-mb@x14.nl> <CAGTqyRykxy2GJV6b4yavWnegbz0HwykaT7bExOXK4wENdoF+Qg@mail.gmail.com>
 <379141b4-d715-41b9-973f-ec0349ed11a5@x14.nl>
In-Reply-To: <379141b4-d715-41b9-973f-ec0349ed11a5@x14.nl>
From: Justin Donnelly <justinrdonnelly@gmail.com>
Date: Sun, 24 Mar 2024 15:01:08 -0400
Message-ID: <CAGTqyRywBKNooLuswSF9QDGgnS2J+R2cArdYyShKw6=s59WxpA@mail.gmail.com>
Subject: Re: [PATCH] git-prompt: GIT_PS1_SHOWCONFLICTSTATE variable fix
To: Michiel Beijen <mb@x14.nl>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 1:18=E2=80=AFPM Michiel Beijen <mb@x14.nl> wrote:
>
> On 19-03-2024 23:58, Justin Donnelly wrote:
>
> > Hi Michiel,
> > This is my code, so I'm really glad somebody else finds it useful!
> >
> >
> > On Tue, Mar 19, 2024 at 4:33=E2=80=AFPM Michiel W. Beijen <mb@x14.nl> w=
rote:
> >> There are a few environment variables that can influence the output fo=
r
> >> the __git_ps1 macro in git-prompt.sh. All settings that are 'on/off'
> >> types such as GIT_PS1_SHOWUNTRACKEDFILES and GIT_PS1_SHOWDIRTYSTATE
> >> just take any value, and in the tests are tested with 'y', however
> >> GIT_PS1_SHOWCONFLICTSTATE must be set to 'yes' otherwise it will not
> >> work.
> > I had actually considered using set/unset (for the same reason as you
> > - consistency), but was advised to use a boolean flag.
> >
> > See: https://marc.info/?l=3Dgit&m=3D165897458021238&w=3D2 and
> > https://marc.info/?l=3Dgit&m=3D165903017715652&w=3D2
>
> I read the comments in that thread. While requiring the setting be set
> to 'yes' explicitly might make it possible to change it to a three-way
> switch in some unknown future, I think right now it is confusing and
> strange that of the many settings for GIT_PS1 only this one requires the
> explicit value 'yes'.
>
> So I would still request to consider this change.

It's not clear to me who besides Junio has the authority to approve
(i.e. who you have to convince). But it isn't me. You might want to CC
a few others (maybe use `git-contacts` to determine who) and see if
anyone is interested in discussing this. Good luck!

>
> --
>
> Michiel
>

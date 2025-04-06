Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277935695
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743936287; cv=none; b=MyGl627PRRng8YuXU3Xvvg6zC8L/jlgoIVOkBWSUi/Ie9pSikhY0524kdz9ZRCrMtepUb9WoLpJvh45ZR4Kb4OXmM4WOYLIwzFt55+Z/wznzw5nD7iDsU1fFMiLkaj9uZh0pUiLMrkSIyn1EJ6HmX0IIR5nI/1CPO8h02FggADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743936287; c=relaxed/simple;
	bh=4wHczjUer/LEWh8JBp1NLOAGmrAIZT8pJskeR7YOmFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpYmKQKpFio76LuBtJFnL8a5+VryLOjw2vKgcsViWXwmp3I2j6cJltH8LyIsDlLyu5otboHcVEq7zYhVVNgDQve3k6CHlZF/PJeeMjtb2rcPRPoI8BA0MSzT4D3Nd5CwAnGQ2QyJ2Q+/ni3TP3DaaP2WR+aY1lKfncT3yEEPd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOpOcn8d; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOpOcn8d"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso2468286a91.1
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743936285; x=1744541085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ouCUrvgnfgwdH2iBKfxrxyf/JwSD5yxpBx9ZRQ/BiY=;
        b=XOpOcn8d6VY/9yzP30nVeM8WS7lRlh+Sv8NO4+2+eG2GORslH8xDtOijOpCphI0q7N
         kvPGgSXgRyIiTdI5CxLKb6wrXY0+NoXHFx9vrkY8hujTxQhSQgu6dfG6ZBqRy/NJdK2A
         F38OIiqEg8gBcngcGQpJROl+j1MKogHMcULzbeyBP8EIQcnE1m+4xOThl/Ww3K3IDxjx
         24qOHaUG4m8WMJzHl4s1agKh0RxAPuSlBjr5QAbUtj57V+6HcbdKj83DFzV5ig5QuYJF
         XfKPgoN3y2UH3SbdHSLcxwmPG0tyiyGe8CGuS2h48EfELnerJxXm7MpCETOg/tjgbxBG
         SV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743936285; x=1744541085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ouCUrvgnfgwdH2iBKfxrxyf/JwSD5yxpBx9ZRQ/BiY=;
        b=BNbynJ3dVQo309nTs+eeXgX+H8GHdPDNkyMbNBf2k8YBcZXbVvSR6zK6pT6lykiLtp
         j5Aw1A/QQ8DCbuDzLD352WZBdopFC1Jhz8TKwYaZ50VzFD8R2JM4yZcO/TOvo/8RvM0R
         krJLqbj35WLtTMToe3Dtzw2Qg/5TJgBwXm6MlUUnIjrxOvYM0nZi52kk3KA9bE98OlLj
         kV2BiYQTI2FLeN3gCiOEc8ShgT0sJ15f2Vfw0fb7hB//gRpg6fjw9wkW/u9LpOFyCE8T
         B+eVSQKdExJQUihqo+q0arYfNH20WI1q0S/iTpyaBSTmxCJJoolLFtIDvH8234tnMi6V
         o7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhVXR3oN9+hgNjzzSczzqDwLrAACRw49FbD9Oba2mGqZYrOfJM1GL5raaRpzZqNULZ8iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7QezHaTkxBlFJ9EG3EgfJzD8GGrsFTqXxf6+iu4aATpqKG2c
	YfglYaZHPXGvuiaxGaBF46b+JxfnJcJYWxH/x2Lnna9arMgk8EntnDWIT3jcPngrJXGutaSKoCY
	QLZLd+gK0DpAp91kg9KQOzLDN1wM=
X-Gm-Gg: ASbGncvL9bNkQlU6ixrbAezCDA/8QifprREeYFnlTXgO95bwEpbR/qCZJuI5YNXgbOu
	AG6iGGEtUxPHb9tKJFHmqbY7jQXVXytFAokOSnBRmAaWNSnrbiZoPJWrHotH+kiOss3oljTvrSd
	Vx7NTOXK8Vuab3Y33q52egH9PgOCE=
X-Google-Smtp-Source: AGHT+IF/Pd2ENtGUiczvNavywjl/Vl5ZvgpSwXhoc7ZInDzUsUWhaOO8oILMMJrdEAruVokvZf3PNVB/5AvpPS7dfh0=
X-Received: by 2002:a17:90a:f946:b0:301:c5cb:7b13 with SMTP id
 98e67ed59e1d1-306a4836e38mr12113510a91.3.1743936285374; Sun, 06 Apr 2025
 03:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
 <20250404085133.1098274-1-ayu.chandekar@gmail.com> <CAOLa=ZQ8KvAZjsDWerF0E9VUzsbNOj+Vcxo_mFL5Y3Of9iCAHQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZQ8KvAZjsDWerF0E9VUzsbNOj+Vcxo_mFL5Y3Of9iCAHQ@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sun, 6 Apr 2025 16:14:34 +0530
X-Gm-Features: ATxdqUHhJj4lF1xl0LxWDXZ8ZkOHRLSVAtTGlhCrRnwYgSRt-4w_m7SjK9sY8QY
Message-ID: <CAE7as+atJcycd4Awav6RKkTDvwiocyv4j=0rZvEhDcVpREsmqA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_v2=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im, 
	shejialuo@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> So the approach you suggest is to comb through the global variables and
> config and find new locations for them to be stored. While this is
> definitely a bunch chunk of the problem, shouldn't we also talk about
> how we can reduce usage of some of these variables?
>
> In particular, I'm wondering how you'd want to tackle 'the_repository'
> usage. There is some previous work done here, where Patrick added the
> '#define USE_THE_REPOSITORY_VARIABLE' definition which tracks usage of
> global variable and usage of them in different files.
>
> A possible approach which has been followed is to simply go from the
> bottom layers of the code upwards, cleaning up usage of global variables
> and ensuring we can remove '#define USE_THE_REPOSITORY_VARIABLE' from
> files. This is also the approach taken in some of the patches that
> you've linked.
>

Your approach makes a lot of sense to me, that is, picking a specific
subsystem or file and aiming to remove the `#define USE_THE_REPOSITORY_VARIABLE`
definition and thus 'the_repository' eventually. This was the method
used by Patrick to tackle
the object subsystem in [1]  and the path subsystem in [2] and you to
tackle the packfile in [3].
This approach also helps in removing some of the global variables used
within that particular
subsystem, which is a nice bonus.

However, this approach might not be feasible for the global variables that
arent tightly tied to a single subsystem. So what I can do is, for removing
`the_repository`, I can follow the approach you mentioned, and for relocating
the more general global variables, I can use the approach which I
talked about in the
proposal.

What do you think?

[1]: https://public-inbox.org/git/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im/
[2]: https://public-inbox.org/git/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im/
[3]: https://public-inbox.org/git/cover.1733236936.git.karthik.188@gmail.com/

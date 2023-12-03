Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEfuXZK5"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318DFE
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 21:58:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f8faf57bso5141181fa.3
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 21:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583078; x=1702187878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW/emFng1TAxJifFEGB6GePO9tGMk0EnIJ8G0R7icAY=;
        b=SEfuXZK5rlg8+cbWpmkTftd3/M9mA8TMLo5N/oyROwJ47jaWHR09dt2GI2Mk8s2HC2
         fWRbON/6CAMgCVvBr8mrjHUqNE32y5dm7pGdCybmMzFR13PDjbLOgPzgiBfv9apMq5fH
         /Q9LuqgBhVVVbP4AKIjtYFhbbHDUVHHMLrjE4cVwvKP8GIcJetHtoG0NgETRMIg7x6IY
         mcdIhYrEL0Z4sQW+R6WwMFINCKexI3knLoPVX5Ym6BhddwUkE/ItqFJC9PolRZdNnffd
         VAZbDRK7kwPT13vcCfcnn5WjtknH37PTSGakopionQIjuRn7O9C2LkcUqlCe4eNzz+8S
         jLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583078; x=1702187878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IW/emFng1TAxJifFEGB6GePO9tGMk0EnIJ8G0R7icAY=;
        b=QeYXnQpPnIbtTpPmD01RBwGPuSuk604zFntDdtITiOai6Oqz3koMmWefRS7WBk1GWH
         jxh3KvkFyvpiJ6Z9VTia8+Sxh/dZOGLNyRs7aIAxXAiJ19asMcudQt09+A3s+3qh7X+J
         3ocJlQYACmtzwYRdOKXAvkBa2CLW8Yly5B8iK4x0jijCUXAAlYmqMi0RA24KqGPkJGcg
         6NeJdWhoU0ix/0uexNZKdsJQoitgC6IBJ020Uo3MjQazrWE2S+bctbrTX7wH6KdDkAfB
         FCbYNc1VAwhY6eZ6n6uOdoAMmwBeI+5/m+2VPqazqNlo5m4xYg5YWXTMCE3/0eERE6Nh
         cR8w==
X-Gm-Message-State: AOJu0YwhwLnrQwg/eNW9yDFdou4E0IQEOTOicXjS+DxSUj+UCdCB1YP3
	Q4x7mwqTdx6j9xKFIAvWXt757ocjf4uLM8jLCwo=
X-Google-Smtp-Source: AGHT+IFHK0MJf7XLTjWKgzJCe2SxhMTsxgXdkU70fDRRcdky7nra6TrLlUs4DHqxRZaBRMcIjhoeB6hN1fHjXo6yVCE=
X-Received: by 2002:a05:6512:2089:b0:50b:e9ca:d994 with SMTP id
 t9-20020a056512208900b0050be9cad994mr593415lfr.95.1701583078186; Sat, 02 Dec
 2023 21:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
 <fe8669a3f4f05c186e497f870c7e7ba9a94ac63f.1700761448.git.gitgitgadget@gmail.com>
 <xmqqo7fk9cdt.fsf@gitster.g> <CABPp-BE73cDq-DBKzsw3R0awiKn5J5LCfdXRULHyPbrS9GEn4Q@mail.gmail.com>
 <xmqq34ws3rfa.fsf@gitster.g>
In-Reply-To: <xmqq34ws3rfa.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 2 Dec 2023 21:57:46 -0800
Message-ID: <CABPp-BHDx+e6dS9zNrS87-ROvr08p4YNqs5KUHF3E67DJRWihg@mail.gmail.com>
Subject: Re: [PATCH 4/4] completion: avoid user confusion in non-cone mode
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 5:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
[...]
> >> Hmph, would an obvious alternative to (1) check against the HEAD (or
> >> the index) to see if the prefix string matches an entity at the
> >> current directory level, and then (2) to prefix the result of the
> >> previous step with "/$(git rev-parse --show-prefix)" work?  That is
> >> something like this:
> >>
> >>     $ cd t
> >>     $ git sparse-checkout add help<TAB>
> >>     ->
> >>     $ git sparse-checkout add /t/helper/
> >
> > I thought bash-completion was only for completions, not for startings
> > as well.  Was I mistaken?
>
> To my mind, the completion is what I as an end user get when I type
> <TAB> to help me formulate input that is acceptable by the command.
> As I said, I consider it a bug (or UI mistake) in the a command if
> it pretends to work inside a subdirecctory but complains when it is
> given a path relative to the current directory, so I'd rather prefer
> the approach to "fix" the underlying command, but if that is too
> much work or cannot be done for whatever reason, the second best
> would be to turn whatever we can do to help the end-user input into
> a form that is accepted by the command without changing what the
> input means.  If it takes more than "appending at the end", that is
> fine, at least by me as an end user.
>
> If you are saying "completion code can only append at the end
> because we can only return strings to be appended, not the entire
> strings, to the readline machinery, so mucking with the start of the
> string is not doable", then sorry---I accept that what we cannot do
> cannot be done, and in that case you are "not mistaken".

This was what I thought; that bash completion didn't support this.

> But from the existing use of COMPREPLY[], it didn't look that way
> (it seems __gitcomp is equipped to take fixed prefix to all
> candidates by passing it in $2 and used to complete names of
> configuration variables in a section, but it seems to me that it can
> be repurposed when prefixing "$(git rev-parse --show-prefix)" to a
> given pathname relative to the $cwd).

Ooh, that's really interesting; I had no idea it had this kind of
flexibility.  It does feel like we're abusing "bash completions" to be
both "bash completions AND startings", but I agree that this is a case
where it makes sense to do so.

I changed patch 4 to implement this for non-cone mode, and submitted
v3 with that change.

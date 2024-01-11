Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7A3B198
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNRhdeFT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2c6d6aea44so105395666b.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705009347; x=1705614147; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JuoIMt1Jey87SrTh0mzdlk9X9CoSdxTR3ewPwYc5P3U=;
        b=fNRhdeFTrw4UfQAUCZgnZQOO6Eg8yxNY0Bhf4ZdVAdNgeBlDU+y2RqbHtmf8lfYSQ/
         E36myVLP4Oai3JuzgJcBVh+l3aCK0J+dKJ0adwqWaPcIgh4cWBZZK9kVqMSqtwc07u1G
         osQHD0WaZyt0EyqYze6dTPdzG2EsXQmQhMvIq5jnNsLdhU1iBsmLmnRbULm4oIhQEOsu
         SzutZ0t8DXOhmAfNiatFBFaVDe//Q6rqpT8yiD6tZEnSGn9VClK9x0931/Fph11TgLis
         7lyhFuDSyQ38Bd1CUAMTMjNjf8LAxTHWW2+EeFf51WoyPr5/c/3Srr3WvsJ56Hvz0/cF
         9sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009347; x=1705614147;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuoIMt1Jey87SrTh0mzdlk9X9CoSdxTR3ewPwYc5P3U=;
        b=rZsLaF9x91hi5m+jX6x2nQFNno3ySNcZihFiqmjrVFN/7T2TQFa26sp8lg9bvDY8Vg
         hTk8WF68FeNngTgqXpgXRQiKwnXrhw44bXTBalVu1sHuhTdA8mEUWfkJ52B/C7VGvm3z
         x/7j+S08vgGqZP5+rSfpGa1OCPvMO2AvFiKCP1tJaR5awjKU4nCkmlSXNorsylqatrE8
         SNHwj8/G5btS7I8yLVq+ZErKiobEk9tP4i/tqlH2eSoHOAv8nSpZ/48GyT3a8bOnHelO
         dGombX62zjZu9edtfGh0SQ9xoQ6sYiWXUtE65QCHWqWis3STErL2aug7x8jnGjm3ZOu/
         1CkQ==
X-Gm-Message-State: AOJu0YyNlow2OkH9GxlvC3faWznNi5wn5rKKGs2pko6B2MXDjs9xXnjO
	zDoz9OFKHORVGcGKFPhXdzQ0m1r4ifcb5IfnVoB9xCuCL/M=
X-Google-Smtp-Source: AGHT+IFtz/a5CdmY6wRWmPHISWjyjlLLr/B6t12qbN6gmBQepcNB5gzBpsCtW9ZSnQQRwlO1xkMCc7dPlZKoNVr5hTE=
X-Received: by 2002:a17:907:3688:b0:a28:fdac:c985 with SMTP id
 bi8-20020a170907368800b00a28fdacc985mr168882ejc.81.1705009346963; Thu, 11 Jan
 2024 13:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Thu, 11 Jan 2024 12:42:15 -0900
Message-ID: <CAC4O8c-tdkhhDYa9GaHZwhaC_0VG8x-v7eVULY7PiF1Z8ZgFXg@mail.gmail.com>
Subject: would these doc and completion patches like this welcome?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Someone mentioned that there were other places where <path> should be
<pathspec> and I looked through the docs a bit to see, and also noted
simple completion fixes.

There were a number of small issues I saw that I'll fix if there's
interest but I want to ask before spending time (I have a few patches
submitted at the moment and can't tell if they are unwelcome or what).

To give an idea what I have in mind the rough notes I made on a first
pass through are below.  Note that I haven't got as far as verifying
for sure e.g. what actually takes a pathspec so there may be mistakes
in here.

The question now is is there enough interest that I should proceed or not?


Here's the list:



git-am:

  doc: --exclude and --include probably take <pathspec>, but currently refer
       to <path>.  Note: Underlying git-apply currently says <path-pattern> in
       detailed description, <path> in synopsis

  doc: --directory=<dir> in synopsis and detailed description but should
       probably be <root> since the detailed description in git-am just says
       that "These flags are passed to the git apply"

  comp: --directory= takes and should complete a dir

git-archive:

  doc: is <path> argument really a <path> or should it be <pathspec>?

git-bisect:

  doc: mentions of path in main text should be <pathspec> (assuming
       guy on mailing list who said it actually takes a <pathspec> was right,
       check)

git-clone:

  doc: <directory> or <dir>? who cares I think but elsewhere some use <dir>
       <dir>

  comp: <directory> should be completed

  comp: <git-dir> should be completed

git-describe:

  doc: synopsis mentions <blob> but later text just mentions blob, I think this
       is not how other tools mention such things

git-diff:

  doc: are all the mentions of <path> really <path> or should they be
       <pathspec>?

  doc: is optional arg to --relative really a <path>, or is it a <pathspec>?

  comp: there are lots of options that aren't completed that should be

  comp: NOTE: <path> should not get completed as dir even if they aren't
        <pathspec> since they might be files

  comp: NOTE: the optional arg to --relative should not be completed as an
        actual dir

git-format-patch:

  doc: is optional arg to --relative really a <path>, or is it a <pathspec>?

  doc: what is <boundary>?

  doc: --from in main text but not synopsis

  comp: --to --cc --from don't have optarg completion help for format-patch
        as they do for send-email.  I notice that according to it's
        --git-completion-helper output format-patch doesn't implement --bcc
        hmnm is that really true so weird

  comp: NOTE: the optional arg to --relative should not be completed as an
        actual dir

git-init:

  doc: has both [--template=<template-directory>] and
       [--separate-git-dir <git-dir>], I see no reason one of these should get
       an = and the other not, seems like both should get = and that's how this
       command does it though other git commands seem to doc differently

  doc: <directory> is mentioned in synopsis but only underlined directory in
       body.  elsewhere in same file words like this do get their <> and are
       underlined also.  what is the
       actual git way for this?  Just underline?  Underline and <> (seems
       right to me?)  Underline seems to be the common utility way (for ls, cp,
       ln at least which I checked, but those don't use <> everywhere.  I
       guess I sort of think it should be one or the other not both and git
       uses <> everywhere for args and optargs.  FIXME: sheesh I can't quit
       tell when bold is even getting used in my terminal font it's similar
       enough but actuall bold and <> seems pretty common as well

  comp: arg to --template should be completed as a dir

  comp: arg to --separate-git-dir should be completed as a dir

  comp: the optional [<directory>] arg appears to be the only possible
        non-option argument and so should be easy to complete as a dir

git-log:

  doc: synopsis says <path>... probably it means <pathspec>... check

  doc: full text also mentions <paths> in a number of places, it should
       probably by <pathspec>... but at least <path>... (or sometimes just
       <pathspec> or <path>)

  doc: is optional arg to --relative really a <path>, or is it a <pathspec>?

  comp: NOTE: the optional arg to --relative should not be completed as an
        actual dir

git-pull:

  doc: one option description reads '--squash, --no-squash' while another reads
       '--[no-]verify'.  I think I like the first way better for easy search
       but I think the second might be more common.  Find out the preferred
       way and make consistent.

git-range-diff:

  doc: refers to <path> where it likely means pathspec.  highlights <path>
       but doesn't underline

git-reset:

  doc: says 'can copy the contents of a path out of a commit' I believe it
       really means 'contents of a pathspec' but that's so clunky to read
       and understand and so much less likely to be what someone is attempting
       if they're doing the already somewhat exatic thing described that it's
       probably better to just keep on being wrong here.

git-shortlog:

  doc: refers to <path> but should probably be <pathspec>

  doc: is optional arg to --relative really a <path>, or is it a <pathspec>?

  comp: NOTE: the optional arg to --relative should not be completed as an
        actual dir

  doc: mentions <paths> in one place ('as the <paths>' should be 'as a <path>')
       refers to <path> but should probably be <pathspec>

git-submodule:

  doc: <path> all over the place but then the text mentions <pathspec> in one
       place that looks representative so probably they should all be
       <pathspec>

  doc: describes <path> (an optional argument) under options

git-worktree:

  doc: NOTE: I don't think these should be doced as <pathspec> regardless of
       what the actual code takes.  Out of curiosity what does actual code
       take?

  comp: repair subcommand: <path> should be completed to a real dir in this
        case

gitk:

  doc: says <path> probably means <pathspec>

git-config:

  doc: <file-option> appears in synopsis but isn't mentioned in text

git-reflog:

  doc: takes <log-options>, argubly should be <log-option>...

git-repack:

  comp: --expire-to=<dir> should complete dirs

  comp: --filter-to=<dir> should complete dirs

git-bugreport:

  doc: in general (not just for this command) should opts that need a path
       that's a dir always call it <dir> rather than <path>?

  comp: completion needs implemented

  comp: -o/--ouput-directory should complete dirs

git-diagnose:

  comp: completion needs implemented

  comp: -o/--ouput-directory should complete dirs

git-difftool:

  comp: there are lots of options that need completion added for underlying
        git-diff.  For some reason git difftool --git-completion-help doesn't
        pull in the git-diff options (unlike send-email does format-patch
        options) perhaps this could be fixed?.  Or the git-diff options could
        be factored into a function so they can be used for both _git_diff
        and _git_difftool

git-merge-tree:

  doc: --stdin appears pretty significant, but doesn't have an entry of it's
       own in the OPTIONS section

  comp: not implemented at all yet

git-archimport:

  comp: not implemented, probably not worth it

git-cvsexportcommit:

  comp: not implemented, probably not worth it

git-cvsserver:

  comp: not implemented, probably not worth it

git-quiltimport:

  doc: --patches=<dir> might be better than --patches <dir>, how to handle this
       in general?

  comp: not implemented yet

  comp: --patches should complete dirs

git-send-email:

  doc: send-email docs --to --from --cc with different docs than the
       corresponding format-patch options.  Are they not just passed through in
       the case where format-patch is being done implicitly?  Do they override
       for an already-prepared patch series?  Hmm

  comp: all long opts of send-email and format-patch are accepted via
        the --git-completion-helper mechanism.  Unfortunately this means all
        git-format-patch opts are accepted even when --no-format-patch has been
        given.  Both commands support --git-completion-helper so in theory
        the wrong option set could be filtered back out.  It's not possible
        to do this from the arg since it probably isn't there yet and might
        be ambiguous anyway

    * there are at least some opts for which optargs aren't completed:

  comp: should --reply-to be completed like --to=*|--cc=*|--bcc=*|--from=* are?

  comp: should --envelope-sender be completed like
        --to=*|--cc=*|--bcc=*|--from=* are?

  comp: optarg to --smtp-encryption could be completed

  comp: optarg to --transfer-encoding could be be completed

  comp: optarg to --smtp-debug could be be completed

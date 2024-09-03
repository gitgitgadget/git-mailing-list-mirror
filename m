Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1F1D7E4C
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401491; cv=none; b=FbNQMcZ94ID2m4xuIveoNvd855s64Q0kaBFjO/KD8Rd1pNBaZzpu3bfFFcI/WeueEoYaDgp5cpqHDWulDdDdKy6+fs71l5NvY8Eu8A7LLDjvziEilxse+YxXt6nfFzYVQfnVpfqEB7oxu/HAIEp/T83ZluoFRrQlHin9jjjN/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401491; c=relaxed/simple;
	bh=C08jB2iTWeEB+npV7cYmZC61P1EF7EmAy+X6x4ZUp0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJWmpCaGxup8/KKjz3XF7099dahqmqgSniBFqbCG42ylIZErVmnufzeiQXWe4H/eN3seEymevSi5FZh9UZC7bPcX13ofkvMN6zN1bDmJtMEwF9+0kpJAxHegNtJrxMZqkzNzPPHid0ruloEYdG3d62iuMJJTOW/Wj6mU49XAhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqQEG+Yq; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqQEG+Yq"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a316f8ae1so167370539f.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401488; x=1726006288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAOsxT32qBucJfCONeTopZXSTR3mNH4ARmeZJWal3dE=;
        b=hqQEG+Yq2uWpBfMoeGAy1I4KMgnmZsi+82qYSp/gD3JYOPnH1cdQB1kuALGw9PMdI+
         HOANCUK3Q8J+OSEY4cKXPpB2MUh+U1LYqJMDp4buit0UkanpazdpJ2lvB3846cZD24PQ
         Hlhu4dow1NAXnOaDxfnfOntNSWWaFcC3Mp1rykkUXekLF5kSRfuanTDFQCgmTTu92RFt
         h75PGcTcLIH2I0z2srO2VskS6luMUwQTTsdCq/8/tV3IhDjpGrl6aSxeJWQJjTpBM55i
         +bTfQcuv8nBYF+zCysUdaVr6w5YSxrXsXYjO1VLfwJYM9mE6l51vy1Gx+eeQ5hPR7GJa
         US/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401488; x=1726006288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAOsxT32qBucJfCONeTopZXSTR3mNH4ARmeZJWal3dE=;
        b=TpF9XT72AXvOs8oZxk7CVYC5W4wtcBVHxICAQO1VuJU10ftcSRNo7n4XR7wRBunqKa
         BlCXG5WZoGPWeIwPlkOQZ5qtZfPBAgrBmhIPwbFoZAHUWDQb/F9sfgyYI0Ni9heR44at
         KyhpPNx9R5jpqQBwie8JCeI0UiuojKc8btWWgoQAMpSFvueS8O9upX3E+rWvziGMlRqg
         N83kkTRttVl1U/cTxc4L7bYrFDpP84mDv6Ndcv2jmkMNb9GKER7cbtWTLMJ4t/Nen5a9
         ukiNQHNWXIw8Nb3oNhA38gsqrfZmM4VbYooFsHGEnvpkwSaZPSPvhjVItneiShomG3pV
         eeEQ==
X-Gm-Message-State: AOJu0Yz1i3C7qru6kiwDHIBamNmdJJH6Gwf7V6DBP5+XI3Mr0augqbft
	u8m/gS47oI6qYexVc6fcxJfXHhVvhicpfW7yQAhONaawuW6E1mijgL2lKhVQQvBLDaw2xsmOh13
	Ye8iS+ERjEzTjbs3xhG8UGPMJ2micJV56
X-Google-Smtp-Source: AGHT+IHFW3XE5z7LECi2iRXelnkMt59/y55Im9d6CbRHCDBYj1/FYtMBzalqssaxC2tjtkalK2jjExjPQ7cWOOqGDDE=
X-Received: by 2002:a05:6602:3d4:b0:82a:4be0:94e2 with SMTP id
 ca18e2360f4ac-82a5eacb613mr814634539f.9.1725401488146; Tue, 03 Sep 2024
 15:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903194244.16709-1-zack@owlfolio.org>
In-Reply-To: <20240903194244.16709-1-zack@owlfolio.org>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Sep 2024 15:11:16 -0700
Message-ID: <CABPp-BFqbiS8xsbLouNB41QTc5p0hEOy-EoV0Sjnp=xJEShkTw@mail.gmail.com>
Subject: Re: [filter-repo PATCH]: add --callbacks option to load many
 callbacks from one file
To: Zack Weinberg <zack@owlfolio.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

Thanks for sending this in.

On Tue, Sep 3, 2024 at 12:43=E2=80=AFPM Zack Weinberg <zack@owlfolio.org> w=
rote:
>
> If you are trying to do something complicated with filter-repo,
> you might need to share state among several callbacks, which is
> currently impossible (short of poking values into someone else=E2=80=99s
> namespace) because each callback defined on the command line gets
> its own globals dictionary.

Sharing state is not impossible; it's done in multiple examples in
filter-repo.  If you want to do something complicated with
filter-repo, you can just import it as a library.
contrib/filter-repo-demos includes several more complicated examples,
including complete replacements for git-filter-branch and
bfg-repo-cleaner.  Let's look at how some of them hook up callbacks:

$ git grep 'callback=3D.*\.' contrib/
contrib/filter-repo-demos/bfg-ish:    self.filter =3D
fr.RepoFilter(fr_args, commit_callback=3Dself.commit_update)
contrib/filter-repo-demos/clean-ignore:  filter =3D fr.RepoFilter(args,
commit_callback=3Dchecker.skip_ignores)
contrib/filter-repo-demos/filter-lamely:
 commit_callback=3Dself.fixup_commit,
contrib/filter-repo-demos/filter-lamely:
 refname_callback=3Dself.tag_rename,
contrib/filter-repo-demos/filter-lamely:
 tag_callback=3Dself.deref_tags)

The fact that these callbacks point towards an instance method
function makes it clear that these functions will all have access to
the relevant instance ('self' or 'checker' in the examples above),
even when they are different callbacks.  They also have wider access
to whatever globals you might want to define in that file as well;
it's only the simple one-off defined-at-the-command-line callbacks
that were geared towards the simplistic cases that have a separation.

> Or, if you are trying to do something simple but long-winded, such as
> replacing the entire contents of a file, you might want to define long
> multi-line (byte) strings as global variables, to avoid having to deal
> with the undocumented number of spaces inserted at the beginning of
> each line by the callback parser.

Yeah, I can see how the added spaces would be slightly annoying for
the case of multi-line strings (though simple callbacks like
`--name-callback 'return name.replace(b"Wiliam", b"William")'` require
that some kind of leading whitespace be added, and the command line
--*-callback options are targetted towards the simpler usecases, after
all).  However, even in that case you can just use textwrap.dedent.
For example:

git filter-repo --blob-callback '
  import textwrap
  blob.data =3D bytes(textwrap.dedent("""\
    This is the new
    file that I am
    replacing every blob
    with.  It is great.
    """), "utf-8")
'

And now every file in your repository is replaced by one with the
following contents:
"""
This is the new
file that I am
replacing every blob
with.  It is great.
"""
Notice the lack of leading spaces.

> To facilitate these kinds of uses, add a new command line option
> `--callbacks`.  The argument to this option is a file, which should
> define callback functions, using the same naming convention as is
> described for individual command line callbacks, e.g.
>
>     def name_callback(name):
>         ...
>
> to set the name callback.  Any Python callable is acceptable, e.g.
>
>     class Callbacks:
>         def name_callback(self, name):
>             ...
>
>     callbacks =3D Callbacks()
>     name_callback =3D callbacks.name_callback
>
> will also work.  People who know about the undocumented second argument
> to some callbacks may define callbacks that take two arguments.
>
> The callbacks file is loaded as an ordinary Python module; it does _not_
> get any automatic globals, unlike individual command line callbacks.
> However, `import git_format_repo` will work inside the callbacks file,
> even if git_format_repo.py has not been made available in general.

What is this git_format_repo thing you speak of?

Anyway, separate from that and given the above comments I made about
importing git_filter_repo and textwrap.dedent, I'm a little unsure why
this new callbacks command line flag helps.  The usage of
git_filter_repo.py as a library exists for the general case already.
Simple command line flags like `--path` or `--replace-text` exist to
handle the simplest cases.  All the *-callback command line flags
exist to provide a middle ground where the user needs something a bit
more generic and programmatic, but is still targeting a certain piece
of data from the fast-export stream and doesn't want the little extra
verbosity from placing things in a separate file and importing
git_filter_repo and the few lines of glue necessary to hook it up.

In that scheme, this new --callbacks option doesn't seem to "fit" to
me.  It makes the middle ground more generic, but not as generic as
the ability to just import git_filter_repo and do whatever you want.
There's no specific targeting it provides, which makes it feel to me
as there's no specific reason for it to exist separate from the more
generic usecase.

> Tests are added which lightly exercise the new feature, and I have
> also used it myself for a real repo rewrite (of the =E2=80=9Csimple but
> long-winded=E2=80=9D variety).
>
> ----
>
> Also document (briefly) the existing feature of supplying a file
> name rather than an inline function body to --foo-callback options,
> and the availability of an unspecified set of globals to individual
> callbacks (with instruction to see the source code for details).

Thanks for being helpful.  Do note, though, that different logical
changes should be in separate patches.

> This patch introduces uses of the Python standard library modules
> errno, importlib, and inspect.  All functionality used from these
> modules was available in 3.6 or earlier.

Since I recently bumped the minimum required python to 3.6, this is
all good.  Thanks for calling it out.

> This patch introduces several new translatable strings and changes
> one existing translatable string.

Again, thanks for taking the time to call this out.

> ---
>  Documentation/git-filter-repo.txt |  39 ++++++-
>  git-filter-repo                   | 164 +++++++++++++++++++++++-------
>  t/t9391-filter-repo-lib-usage.sh  |   2 +-
>  t/t9392-python-callback.sh        |  57 ++++++++++-
>  4 files changed, 219 insertions(+), 43 deletions(-)

I skimmed over the patch briefly, and it seems to generally be
reasonable, but I didn't look real close since I'm not sure if the
feature "fits".  Does the knowledge about textwrap.dedent or the
ability to import git_filter_repo help you out?



Hope that helps,
Elijah

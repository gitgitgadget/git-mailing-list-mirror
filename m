Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263174E0C
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717358020; cv=none; b=N2jRhA7B2a/xjMrIaNeYeN+vqysAohwQkIEl6OvhP/0y0RztaADR6ASmXV+qqJHBC39wvxntKmkzUh9tT5mmXYbLFJ57iBxWRWpGNS3SawLJf1zRaKkac6mkKXE6WyFyI9jyHXEVofLOJHKCfmcKG0YrzezZyLjEw3eM1EgVc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717358020; c=relaxed/simple;
	bh=PujmOZnLndMJor4ocSXgoLfmLqx7Iq83guUWAhKUJtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFFLiM95Vnd5Km4mKOoaUqMLJcj2iAOQm0N290zAfQuoSSndId4I6h9OFPXd91+bAJb2Cw8/NKS8gnRVu39PNriwRYh1R+W18qMzAkQaocj/epkX6jpZEB5K5vI1U1sl8cN8iN0/Ebn6IRibMNF3iFOS8jwtQMMI8R1ex7b6TdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=efoxWwtd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="efoxWwtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717358009; x=1717962809; i=tboegi@web.de;
	bh=q/thjztwDSQ6ZYdMFxRNqZfVq8YahvdemT0Dw9ZqvnE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=efoxWwtdEPJd3+7axsAYZYUcUlj+JuBk2scdcyqVi500j7cl+K6nk0IgbNLp3SiV
	 yHtgR2Z43gpFfR5VwAP+oOm5NL09QQpFqgdX7TZE8361zLrN8t3Zjqjr80eZLJ6Ky
	 RN13hRjhMn0VCgkwtUj3b22CkPzcCV4C939tJcfbxVEkIZeeLlPJEloQ8JuHyErzC
	 eAov8pv3MKfCHfjX73bmOvLqwz1M81daJAnisuRfH5E5u6zKgt4Se5u8gzz73ly5D
	 /sSoXK6iMlpB+ZiPa4N/0FiGxr94G1XU1wun2vi3XhuMoBx1fyaIrgZMlOH5vKATI
	 T3QuqYqCwl3dJePHZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1sBe8Q1EBk-002ELl; Sun, 02
 Jun 2024 21:40:10 +0200
Date: Sun, 2 Jun 2024 21:40:08 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v4 1/1] macOS: ls-files path fails if path of workdir is
 NFD
Message-ID: <20240602194008.GA27539@tb-raspi4>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240531193156.28046-1-tboegi@web.de>
 <xmqqh6ecbqug.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6ecbqug.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:R9dMXq01h9U8d+NfHKRbC3rY9IigI2Q641JF39Nfg+7DlV7h8iS
 H+IgRbCgOSLW2NF3bqhGyqShogLkJ/TqXhSHsFqD4r6RHnPnCr91MoM7MiBi7V5LyTc9DLW
 YGrstYDUeohXwN7OxEZF+JdrUXyA3If4qPXi71qYUyVxSUxeDv1/5ZuNI8bBRq1uC017b8D
 Z4VNSELvog0JkS/2CcHtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YDJPLhZ5nuc=;runcgKvQqt7PTxkr+fSMq/LRAbD
 cSi0xnXnj6MHx1i7a9cbrl16vBWtQSUeihoS+8ltvkRxN04vv+Pu9WPvoB3lUzYmbI3yKkU5U
 q/dGZl+/uO9/sBxpFsWJs6nek7kZDv1g5a7vSMqhaWtFuIBzhuenVTtr/ddD0XQm2ngZXcZvJ
 tpPyq+eORghw8eRQfW/PvW8s98c7d4UvYO/Kdo04VjPYB16RBIj4BL1hGikJbmKNqSg3i6DeE
 8bUza6nvNhLVH0id3pJL7i+NgvoG26ScDnfuLX0Yt3/vi5qX+40iu0cXCYVorCrvM+Ohh2L10
 v5iq0T/RHWTO/3FvP/zfYtSqfkNu6GzCEyzRORu2aQ5JJnfahtNnl/jXKklU3wAjNSuCT4BUS
 pQu90waQrhR2ltJqjIJ2UlX8IM3aY1LFPj+PhDBQZUgdya3P9bPjtyJ4tnGnYthNFiB3u+iqt
 izyh+k+Jvwwgp9lnrN/08hlCqVA3fR2qL4ecZgyJt198n5QJ8vZoECS9YeipTvANMN1Lf3s2f
 YMwnkBCp+JWFOYH4odCXrx3+iWEHqvGmM7GyrGXwR6XdbxpkMdqNkY8fO+kPsuQ0LOwlba4cQ
 PdH5kvTQL1QBQ+ouADGOZVCEJgI9MAgYZGgXJy7CNXxeGTIExcxO7zKYWGDDZG6ht6ajrRw3g
 fSByjOat2Ib+i5we3WmfPhiCtsJn3iMFzff101tkaybQ01juxTHkRGXyVx+/fCgnyFW4ilTda
 qsUQ1zrWEOKd0m2PKFiTI0W6N04Fbl8MduaGWKUqq/O//92eHGCzxlampva4iToXt31hGEgW0
 drNKKauf1F6dena1VJ3a7FOL6jt4J1BEmEc05+oA/tPZ4=
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 01, 2024 at 08:55:03AM -0700, Junio C Hamano wrote:
> tboegi@web.de writes:
>
> > The problem is the_repository->config->hash_initialized
> > is set to 1 before the_repository->commondir is set to ".git".
> > Due to this, .git/config is never read, and precomposed_unicode
> > is never set to 1 (remains -1).
>
> The "is never read" part is a bit confusing and misleading.  If it
> were
>
>     At the point of code flow where we would want to learn the value
>     of precompose configuration, the local configuration has not
>     been read.
>
> then I would understand it, though.

Yes, the thing is that it has not been read, and will never been read,
in this very very usage of Git.

>
> Is the analysis telling us that we need to rethink the order of
> things setup_git_directory() does?  Or is this inherently unsolvable
> because we need to discover the .git/ directory and path to it
> before we can read configuration to learn from it, but we need the
> value of precompose setting to compute the "path to it"?
I think it is solvable, see below.
>
> Presumably chdir() done in setup_discovered_git_dir() can be done
> with either NFC or NFD if the filesystem is squashing the
> differences between them, so perhaps doing the repo_set_worktree()
> done in setup_discovered_git_dir() is wrong, and we could delay
> populating the .worktree member until much later?  For reading the
> local config, it does matter we know where the git-dir and
> common-dir are, but the location of worktree is immaterial.
>
> Anyway, thanks for a patch.  Will queue.

My understanding is that detecting the .git/ dir and then reading
the config file from here does not work here.
That may be better documented in this very commit message,
please feel free to ammend it.
The root cause may be fixed in a different commit later.

[snip]

The best info that I have at the moment is the call stack analysis
done by Jun. T, where the global core.precomposeunicode is not set,
and reading the local one "fails".
I hope this is a useful repetition:


  The following is some info I got (hope it is correct and useful),
  but I have no idea how to fix the problem.

  precompose_string_if_needed() works only if:
    precomposed_unicode is already set to 1, or
    git_config_get_bool("core.precomposeunicode") sets it to 1.

  But git_config_get_bool() reads the file .git/config only if:
    the_repository->commondir is already set to ".git".

  Back trace when the strbuf_getcwd() is called for the
  3rd time is (frame #4 is set_git_work_tree()):

    * frame #0: git`strbuf_getcwd(sb=3D0x00007ff7bfeff0a8) at strbuf.c:588=
:20
      frame #1: git`strbuf_realpath_1(resolved=3D0x00007ff7bfeff0a8, path=
=3D".", flags=3D2) at abspath.c:101:7
      frame #2: git`strbuf_realpath(resolved=3D0x00007ff7bfeff0a8, path=3D=
".", die_on_error=3D1) at abspath.c:219:9
      frame #3: git`real_pathdup(path=3D".", die_on_error=3D1) at abspath.=
c:240:6
      frame #4: git`repo_set_worktree(repo=3D0x000000010044eb98, path=3D".=
") at repository.c:145:19
      frame #5: git`set_git_work_tree(new_work_tree=3D".") at environment.=
c:278:2
      frame #6: git`setup_discovered_git_dir(gitdir=3D".git", cwd=3D0x0000=
000100435238, offset=3D16, repo_fmt=3D0x00007ff7bfeff1d8, nongit_ok=3D0x00=
00000000000000) at setup.c:1119:2
      frame #7: git`setup_git_directory_gently(nongit_ok=3D0x0000000000000=
000) at setup.c:1606:12
      frame #8: git`setup_git_directory at setup.c:1815:9
      frame #9: git`run_builtin(p=3D0x0000000100424d58, argc=3D2, argv=3D0=
x00007ff7bfeff6d8) at git.c:448:12
      frame #10: git`handle_builtin(argc=3D2, argv=3D0x00007ff7bfeff6d8) a=
t git.c:729:3
      frame #11: git`run_argv(argcp=3D0x00007ff7bfeff54c, argv=3D0x00007ff=
7bfeff540) at git.c:793:4
      frame #12: git`cmd_main(argc=3D2, argv=3D0x00007ff7bfeff6d8) at git.=
c:928:19
      frame #13: git`main(argc=3D3, argv=3D0x00007ff7bfeff6d0) at common-m=
ain.c:62:11

  At this point, precomposed_unicode is still -1 and
  the_repository->commondir is still NULL.
  This means strbuf_getcwd() retuns NFD, and the_repository->worktree is s=
et to NFD.

  Moreover, precompose_string_if_needed() calls
  git_config_get_bool("core.precomposeunicode"), and
  this function indirecly sets
  the_repository->config->hash_initialized =3D 1

  Later setup_git_directory_gently() (frame #7) calls
  setup_git_env() --> repo_set_gitdir() --> repo_set_commondir()
  and the_repository->commondir is now set to ".git".

  Then run_builtin() (frame #10) calls precompose_argv_prefix()
   --> precompose_string_if_needed(). Here we have
    precomposed_unicode =3D -1
    the_repository->config->hash_initialized =3D 1
  This means git_config_check_init() does not read
  .git/config (does not call repo_read_config()) even if
  the_repository->commondir is set to ".git",
  and precomposed_unicode is not set to 1.
  [snip]


Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D61FBEAC
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031673; cv=none; b=sfZm0KFUWYw8LQ4VWQVNJbBQO6CKedlhgUFRgy9oK1Up6SS5BOwqvLMAjkjsICs8yFL8iMGgsJnmGWwSw6Q3n+PuEQht19+AThSguvoC7MPv2ct9V78AF0V9wchSnHr6alEssXcErYLiC7RsN2Aymm/spX4hjHk89WBS1L9xllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031673; c=relaxed/simple;
	bh=EkzVYQuUN66o/E4FSkV6SybrO9dXjJcpOzhb2hsrF0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmR9958Tbr49l4uWlpK96ocE5efystHJnzYnb1CuyJ8/MiHILdFUJirZAZ+gOY0dwJg4QC/NWVMYRIuqfiNUnirESeiYwG2dEhaoFxwuHEtTqvNLqrmk70iJYcR5lHIN8fUQqsNxBORS+065M+i6Cv8/YRgD5iHiEYE8Z7PzVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fTlpJ5X5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fTlpJ5X5"
Received: (qmail 291660 invoked by uid 109); 21 Oct 2025 07:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EkzVYQuUN66o/E4FSkV6SybrO9dXjJcpOzhb2hsrF0k=; b=fTlpJ5X5NEvMk1ujIOuGNo4t+pDBeXLlfJqp0cZjPHlajRlOaUs00ute4OkL8FNrq1fHHQyn2csvE8rS1G7MGRIIqzw/NBVsJ6SikTOyR7SHHV90mF6A+gknOMnLFgyc86mM/Xf1eGkpckk67I1xAjmUVxITqVGFbHZYHjWPW6rm2792beBMKg3MhwWQ2m9pV+QGWtV1UW8faETKtAYg77Z7X1a6NSfsOiJ9HqRzXPrnaApIPwzHK6hPopQ7arSP/eIwMymMD2rZfPKit0tDCiCVViGOlyD7SouyfIeB8e2wUaC/bQpPwaC4WUUvOIqGycsq+djsYWMC33AR2AOmaw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Oct 2025 07:27:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 454417 invoked by uid 111); 21 Oct 2025 07:27:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Oct 2025 03:27:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Oct 2025 03:27:40 -0400
From: Jeff King <peff@peff.net>
To: El_Hoy <eloyesp@gmail.com>
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Making git grep ignore binary the default
Message-ID: <20251021072740.GA259661@coredump.intra.peff.net>
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
 <xmqqsefhxlmd.fsf@gitster.g>
 <0de410fa-22ef-4495-a6a9-dcd33a329201@virtuell-zuhause.de>
 <aPLkuPgirAVHkERr@fruit.crustytoothpaste.net>
 <0ef23314ca63d03467a50a93d2db1db3ad950ede.camel@virtuell-zuhause.de>
 <CAPapNH2UeRoKF9Tm5my59MXCxUQqEp+=4wzod8kYus_FQALwjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPapNH2UeRoKF9Tm5my59MXCxUQqEp+=4wzod8kYus_FQALwjQ@mail.gmail.com>

On Mon, Oct 20, 2025 at 02:20:06PM -0300, El_Hoy wrote:

> On point 2, as Thomas points, there are many factors that might break
> a script that rely on 'git grep' directly for a dangerous task, this
> makes me think that we could add a `--porcelain` option to `git grep`
> to be used on scripts and be reliable, and it might ignore the config.

Another option here is to provide a way for scripts to override the
ignore mechanism specifically (which would depend on how it is
implemented). For an example, see below.

> On point 3, the configuration could be made with more flexibility in
> mind, making it possible to ignore different files that are not binary
> (for example linguist-generated files). The downside of that approach
> is that it requires more configuration, while a single boolean for
> skipping binaries might be simpler. I'm ok with any approach.

One way to do this would be to provide a default pathspec for git-grep
when one is not defined. Something like:

diff --git a/builtin/grep.c b/builtin/grep.c
index 13841fbf00..7b6a6ba9c6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -42,6 +42,7 @@ static char const * const grep_usage[] = {
 };
 
 static int recurse_submodules;
+static struct strvec default_pathspec = STRVEC_INIT;
 
 static int num_threads;
 
@@ -320,6 +321,15 @@ static int grep_cmd_config(const char *var, const char *value,
 	if (!strcmp(var, "submodule.recurse"))
 		recurse_submodules = git_config_bool(var, value);
 
+	if (!strcmp(var, "grep.defaultpathspec")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (*value)
+			strvec_push(&default_pathspec, value);
+		else
+			strvec_clear(&default_pathspec);
+	}
+
 	return st;
 }
 
@@ -1169,7 +1179,7 @@ int cmd_grep(int argc,
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
-		       prefix, argv + i);
+		       prefix, i < argc ? argv + i : default_pathspec.v);
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;

Building with that lets you do something like this in git.git:

  $ ./git grep 'added by us:'
  po/bg.po:msgid "added by us:"
  po/ca.po:msgid "added by us:"
  po/de.po:msgid "added by us:"
  po/el.po:msgid "added by us:"
  po/es.po:msgid "added by us:"
  po/fr.po:msgid "added by us:"
  po/ga.po:msgid "added by us:"
  po/id.po:msgid "added by us:"
  po/it.po:msgid "added by us:"
  po/ko.po:msgid "added by us:"
  po/pl.po:msgid "added by us:"
  po/pt_PT.po:msgid "added by us:"
  po/ru.po:msgid "added by us:"
  po/sv.po:msgid "added by us:"
  po/tr.po:msgid "added by us:"
  po/uk.po:msgid "added by us:"
  po/vi.po:msgid "added by us:"
  po/zh_CN.po:msgid "added by us:"
  po/zh_TW.po:msgid "added by us:"
  t/t7060-wtstatus.sh:    added by us:     sub_second.txt
  wt-status.c:            return _("added by us:");

  $ git config grep.defaultPathspec :^po
  $ ./git grep 'added by us:'
  t/t7060-wtstatus.sh:    added by us:     sub_second.txt
  wt-status.c:            return _("added by us:");

And then scripts override it by providing a pathspec (like "." if they
want to see everything, which conveniently also works on old versions of
Git).

It isn't _quite_ the same as an option to ignore certain paths, as it's
a default replacement, and not additive (so as soon as I ask for
everything in "foo/", then "foo/bar" will be included even if I have
"^foo/bar" in my default pathspec). I'm not sure if that is a drawback
or a feature.

There may be other rough edges. It's not something I've thought that
carefully about yet. But it just gives an idea of a possible direction.

Of course you can already do the same thing with an alias right now[1].
You just need to remember to type the alias instead of "grep". That
requires some finger retraining, but it would eliminate any script /
compatibility questions.

-Peff

[1] The alias isn't quite trivial because we want to add our pathspecs
    at the _end_ of the command-line. But I think something like:

      [alias]
      gr = "!f() { exec git grep \"$@\" :^po; }; f"

    works.

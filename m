Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4D231CA4
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738903488; cv=none; b=WkBFxwYPqNQovmYz+tcH+iTjgDJYur/MW2pu80q0VcqmAgtVLV9lYVgZWtyPKHbkjwsL9n7dCsm2ly3lmTJYGyRHaqRxyrfq/JgkA8rVFjuk1g69LYw5NgdMx4nF351TSyKdWxNaSqfmEEy5b+ckfuvlV7fQBvn+qFMXlGuK5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738903488; c=relaxed/simple;
	bh=4qkvda96IyRLbUNg6Aogbu+g0AWHWjPOp0ieT603yww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3v/t7MPxxSUHHimX/o+XTfgdsJhJDSshiLILmlj6r9lY08VWou7MlW6kkynEjd/ETmJfY8Qa0wczYEKMSHdmS2tmyNmHzODHeo2NFLK7qEZtWmE6DMtqTjTWJfn7LeSPekAE7KKls4E8MRNtWNdvsPHJUVQY/b3alZ8YtfD06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaC/YbLC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaC/YbLC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso33455425ad.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 20:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738903485; x=1739508285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U+tzw4Ai6xPpd10x6fEMWLrkBrxCVISa7LTL4vobwBg=;
        b=UaC/YbLCSEeA2dr3feiKSg0cGZPzBjE6Hz79Dx8hpvNF8EK3XjgjSNO59+33zcv06v
         Tuguu8ghQwsgklm5fSuUDN9XOS6Q39i0Zimfp83sbRvclUUbkqLxmTSN64OeOuZlcxEz
         BwkY4IbH0tqQ5Jf82aIMfmQR887gfrlVQ5bCPzfByd3a2uuvWC9rYk0FeQlziY2h6bTI
         S7Xy5ASRvirO8wnEXMUHewBCfYqsdISHAWbOdXQVXp5FupsZsN2wFSvjZGiSFq2phTt/
         gQ5vhSmOvnTf/9ZPDsLM+3RW6OBgwSN3MTgSrLC6+xgszH5sYSnfPRit/8epf19/8JdL
         LwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738903485; x=1739508285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+tzw4Ai6xPpd10x6fEMWLrkBrxCVISa7LTL4vobwBg=;
        b=ayiVpq1s5l5fmEE+09phiDZEWKNnKiYc+qTQ2rKZPUhYTsaedKOBXY9PY1IvDNhkf7
         EvxlJ6Qw6UhFLxNs+b13C02V9YqOExbhdUF4vsUanihx0auiHu3RS65YGHrhJ24ykR2T
         j5XZqmB05OB+B6Vise5uId5meBOz7srCf8KomXpkJcmo7il75MEBXHFno6BVhXgvZ4QH
         Ei7/NKMI2mZ9dZ9AOOYm0i0F9gFhs31Ovj+frSe1sVRV9BbEPLrA0QOqOqkUcDQosQ8v
         H1lTnkQShLyMLaqhcKYjYuQ0pD1VaVt2amByNFaWRsTH/PVmrISkLqx4AzyA24EWp+2X
         P18Q==
X-Gm-Message-State: AOJu0YzKe/wx48FpNN5pBlArBHzNpxOTkNUjv02vbVJ/TCBNxoInPmEB
	H2/IIS9v6jXtuzuT0sgJRuuKqykCr1nnYvr7EblmhVzJ+k1maJGI
X-Gm-Gg: ASbGnculfgxn5FzF/7tCHIG4JxoOfetCt0932gRYs9I8+lnleiu6XmoOxVBSvNy+E6x
	zcdEFo3BkWxCrCZHjzUTm956gFC56yC0iXKq7/HQto/uiLhIJqkdBAPD0t2Vh67/49VMt7Y+9Eh
	R8erRFiny/VTboMWvOqtjFF08xvAbk2UGCLGMZVJNM8+1rxMBE5fqFlp5zysOTXDlTdRK2lPraf
	oylGZKvQt8dA8t8flKA9P+AiXQRG3l88J5eOoqmnDfPP8WNFvxKmxNiXaQpVqgzP9/18SThx/AJ
	1Mh9qoe1Bw==
X-Google-Smtp-Source: AGHT+IGM7BoXLFY8Fb90F7F+BSJym+Vjcl99bhj/CwA1s9wqWk4mW2pWVqClHzox6XuQpPeIL8nnIA==
X-Received: by 2002:a17:903:2f84:b0:212:63c0:d9e7 with SMTP id d9443c01a7336-21f4e110a0bmr32395335ad.0.1738903484956;
        Thu, 06 Feb 2025 20:44:44 -0800 (PST)
Received: from gmail.com ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365616d0sm21054715ad.93.2025.02.06.20.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 20:44:44 -0800 (PST)
Date: Thu, 6 Feb 2025 20:44:41 -0800
From: David Aguilar <davvid@gmail.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/3] difftool: eliminate use of global variables
Message-ID: <Z6WPudTWInXagCYg@gmail.com>
References: <20250206042010.865947-1-davvid@gmail.com>
 <CABPp-BGnRgDxwgfagyvhwjso_kWVgcR-NxOUwUSJve5RHwyFZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGnRgDxwgfagyvhwjso_kWVgcR-NxOUwUSJve5RHwyFZQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 12:29:46AM -0800, Elijah Newren wrote:
> On Wed, Feb 5, 2025 at 8:20 PM David Aguilar <davvid@gmail.com> wrote:
> > diff --git a/builtin/difftool.c b/builtin/difftool.c
> > index 03a8bb92a9..0b6b92aee0 100644
> > --- a/builtin/difftool.c
> > +++ b/builtin/difftool.c
> > @@ -36,18 +36,27 @@
> >  #include "entry.h"
> >  #include "setup.h"
> >
> > -static int trust_exit_code;
> > -
> >  static const char *const builtin_difftool_usage[] = {
> >         N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
> >         NULL
> >  };
> >
> > +struct difftool_options {
> > +       int has_symlinks;
> > +       int symlinks;
> > +       int trust_exit_code;
> > +};
> > +
> >  static int difftool_config(const char *var, const char *value,
> >                            const struct config_context *ctx, void *cb)
> >  {
> > +       struct difftool_options *dt_options = (struct difftool_options *)cb;
> >         if (!strcmp(var, "difftool.trustexitcode")) {
> > -               trust_exit_code = git_config_bool(var, value);
> > +               dt_options->trust_exit_code = git_config_bool(var, value);
> > +               return 0;
> > +       }
> > +       if (!strcmp(var, "core.symlinks")) {
> > +               dt_options->has_symlinks = git_config_bool(var, value);
> 
> It appears that the only use for has_symlinks....
> 
> >                 return 0;
> >         }
> >
> > @@ -291,13 +300,14 @@ static int ensure_leading_directories(char *path)
> >   * to compare the readlink(2) result as text, even on a filesystem that is
> >   * capable of doing a symbolic link.
> >   */
> > -static char *get_symlink(const struct object_id *oid, const char *path)
> > +static char *get_symlink(struct difftool_options *dt_options,
> > +                        const struct object_id *oid, const char *path)
> >  {
> >         char *data;
> >         if (is_null_oid(oid)) {
> >                 /* The symlink is unknown to Git so read from the filesystem */
> >                 struct strbuf link = STRBUF_INIT;
> > -               if (has_symlinks) {
> > +               if (dt_options->has_symlinks) {
> 
> Why is this based on dt_options->has_symlinks rather than dt_options->symlinks?
> 
> (I guess this question is equivalent to asking why the preimage code
> was using has_symlinks, instead of the symlinks parameter set from the
> command line option.  As far as I can see, has_symlinks is supposed to
> merely function as a default value for symlinks in the case no command
> line parameter is passed...but this is the one counter-example.  But
> was it an intentional counter-example, or an accident?)
> 
> That said, fixing this, if fixing is needed, doesn't belong in this
> patch; it'd probably be better as a preparatory patch.  But, it trips
> up reviewers (looks like Patrick was wondering about the same thing on
> v1 of your series), so it at least would probably be helpful to
> mention in the commit message if no other cleanup is needed with
> these.

Agreed. If we fix this it should be done in a separate patch and
we can explain why they were separate variables as part of that
commit message. I don't necessarily agree that it belongs in this patch.

Combining these two fields leads to test errors which is why
it wasn't touched in this round.


> > @@ -734,8 +749,8 @@ int cmd_difftool(int argc,
> >         };
> >         struct child_process child = CHILD_PROCESS_INIT;
> >
> > -       git_config(difftool_config, NULL);
> > -       symlinks = has_symlinks;
> > +       git_config(difftool_config, &dt_options);
> > +       dt_options.symlinks = dt_options.has_symlinks;
> 
> If the get_symlink() function should have been using
> dt_options.symlinks instead of dt_options.has_symlinks, then
> dt_options.has_symlinks is merely functioning as a default, but would
> actually be superfluous.  A follow-up patch could remove that extra
> field.

`has_symlinks` is currently providing both a default value and
controlling the behavior of the dir-diff mode, so it's not quite
merely functioning as a default.

My eyes gloss over comments because I completely missed the following
explanation in the comment above `get_symlink()`.
This comment explain why we have a separate `have_symlinks` field:

/*
 * Unconditional writing of a plain regular file is what
 * "git difftool --dir-diff" wants to do for symlinks.  We are preparing two
 * temporary directories to be fed to a Git-unaware tool that knows how to
 * show a diff of two directories (e.g. "diff -r A B").
 *
 * Because the tool is Git-unaware, if a symbolic link appears in either of
 * these temporary directories, it will try to dereference and show the
 * difference of the target of the symbolic link, which is not what we want,
 * as the goal of the dir-diff mode is to produce an output that is logically
 * equivalent to what "git diff" produces.
 *
 * Most importantly, we want to get textual comparison of the result of the
 * readlink(2).  get_symlink() provides that---it returns the contents of
 * the symlink that gets written to a regular file to force the external tool
 * to compare the readlink(2) result as text, even on a filesystem that is
 * capable of doing a symbolic link.
 */

In other words, we intetionally take the extra step to readlink(2)
symlinks in the dir-diff mode irrespective of the command-line option on
systems that support symlinks. That's why `has_symlinks` has to be
tracked separately.

In light of this, I suspect that we won't be combining these fields
because this behavior is intentional and necessary.

`git blame` claims that I wrote this comment 8 years ago, but that's
news to me!

Thanks for the thorough review. I'm not planning a re-roll since it
seems like this is fine as-is, but let me know if y'all feel otherwise.

One thing I would maybe change would be to rename `dt_options` to
`options`, but I also appreciate the verbosity of the dt_ prefix.

Interestingly, the `struct difftool_state` and `dt_state` names in the
original patch were chosen because the struct contained more than just
options. Specifically, it contains the `has_symlinks` field.
I'm not really sure it's worth splitting hairs over that detail,
but I'm all ears. struct difftool_options doesn't really bother me.

cheers,
-- 
David

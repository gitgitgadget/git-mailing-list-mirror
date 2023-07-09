Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF5EB64DC
	for <git@archiver.kernel.org>; Sun,  9 Jul 2023 06:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjGIGQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jul 2023 02:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjGIGQX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2023 02:16:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576281BE
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 23:16:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89600a37fso15835685ad.2
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688883381; x=1691475381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qhSzspSlKWsG/OtcOJwjcDfdpgWTqglhq2iHZaqqpk=;
        b=LTTdoIi5wGtKmlC2bY5e4JW6DjSeXrNpOnc3u/pw4bHlLtreI+YcMSl1XTtIBMILtT
         fdR0q0iS7oIk046H5W9qzWl1vZ5CiGW4WV6SP3nm9dGua9bmb5fXtpVvr1WzONcxfnfI
         rYZGzctaBOgleGVjPauPCMRNlfPYXSYUXQPwJlGD8oO3Mge6OzhtVSUyoReRdKBHXc8H
         2LCyqXs5BWlQTJz9E7Tbiu+zo6/vj8ubLh9ml3Fc0Un9n2GprlKvQzcJ7W5Oa3o1ci+d
         kJ5giFxPrzVfg7QD83PrRZtDNrJoK/4TWg4zfEhzwWPK2e2zsRkkP1/be5tmSv1Ia/MG
         P1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688883381; x=1691475381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qhSzspSlKWsG/OtcOJwjcDfdpgWTqglhq2iHZaqqpk=;
        b=axFBxkbKov4kzb6bTEaGDq90Kzr8xiG5XqvejEYtNvsJ2T4Xz1wKatk2XLyEPV8qHB
         5SRSN7oy8YQ0lyzX/MXjVg/4xVpfeyQOJOrWyHkMFQDncNhWx+HdPXUOhESiiJoKx7r1
         Psu0JdvEKvmZSvU6ty70DLNhrbpbAeRJah/sXy/o+RSpOs90dxpZDeG8qaKSyK71xVyd
         QzaUpNWZkBgMTRm8F/DJGHCB3ybRAsoS6n8deyt/27Sn2lXt4PTZzMBTHgBkIab2Fv6b
         cX5bDt2tuyK+vvyX4xJLJ2QTEpAuFwzlS5tmKyzhNJxWnLYcAH9ntw5Ak7H5jFR476mi
         sFAg==
X-Gm-Message-State: ABy/qLZSIpP4GUPEoloA6/TA5094iPjiPUkU+9ZOll5uZfbNxRLCA3II
        QIvyJ39ViId7QERoJBovq1WWh+6zbEY=
X-Google-Smtp-Source: APBJJlGyFw9haVgkOjJbcrZOX3+i4SUsaiwizf62uQ8or67DYROEWyBUA5wP6iVrEjmXgjrhciXq7w==
X-Received: by 2002:a17:902:f546:b0:1b8:af5e:853f with SMTP id h6-20020a170902f54600b001b8af5e853fmr9132934plf.24.1688883380613;
        Sat, 08 Jul 2023 23:16:20 -0700 (PDT)
Received: from five231003 ([49.37.159.174])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902820b00b001b9d8688956sm848691pln.144.2023.07.08.23.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 23:16:20 -0700 (PDT)
Date:   Sun, 9 Jul 2023 11:46:03 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: add new "describe" atom
Message-ID: <ZKpQo7WdQXk51MdN@five231003>
References: <20230705175942.21090-1-five231003@gmail.com>
 <20230705175942.21090-2-five231003@gmail.com>
 <xmqqbkgpdljy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkgpdljy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 06, 2023 at 09:58:09AM -0700, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> > +describe[:options]:: human-readable name, like
> > +		     link-git:git-describe[1]; empty string for
> > +		     undescribable commits. The `describe` string may be
> > +		     followed by a colon and zero or more comma-separated
> > +		     options. Descriptions can be inconsistent when tags
> > +		     are added or removed at the same time.
> > ++
> > +** tags=<bool-value>: Instead of only considering annotated tags, consider
> > +		      lightweight tags as well.
> > +** abbrev=<number>: Instead of using the default number of hexadecimal digits
> > +		    (which will vary according to the number of objects in the
> > +		    repository with a default of 7) of the abbreviated
> > +		    object name, use <number> digits, or as many digits as
> > +		    needed to form a unique object name.
> > +** match=<pattern>: Only consider tags matching the given `glob(7)` pattern,
> > +		    excluding the "refs/tags/" prefix.
> > +** exclude=<pattern>: Do not consider tags matching the given `glob(7)`
> > +		      pattern,excluding the "refs/tags/" prefix.
> 
> You are missing a SP after the comma in "pattern,excluding" above.
> 
> The above description is slightly different from what "git describe
> --help" has.  If they are described differently on purpose (e.g. you
> may have made "%(describe:abbrev=0)" not to show only the closest
> tag, unlike "git describe --abbrev=0"), the differences should be
> spelled out more explicitly.  If the behaviours of the option here
> and the corresponding one there are meant to be the same, then
> either using exactly the same text, or a much abbreviated
> description with a note referring to the option description of "git
> describe", would help the readers better.  E.g.
> 
>     abbrev=<number>;; use at least <number> hexadecimal digits; see
>     the corresponding option in linkgit:git-describe[1] for details.
> 
> which would make it clear that no behavioral differences are meant.
> 
> This new section becomes a part of an existing "labeled list"
> (asciidoctor calls the construct "description list").  Starting the
> new heading this patch adds with 'describe[:options]::' makes sense.
> It is in line with the existing text.
> 
> I however think that the list of options is better done as a nested
> description list.  Documentation/config/color.txt has an example you
> can imitate.  See how slots of color.grep.<slot> are described
> there.
> 
>   https://docs.asciidoctor.org/asciidoc/latest/lists/description/
>   https://asciidoc-py.github.io/userguide.html#_labeled_lists

I read through these and looked at the examples (on the git-scm website
where this is used as well). I'll make the changes. Thanks for this.

> > diff --git a/ref-filter.c b/ref-filter.c
> > index e0d03a9f8e..6ec647c81f 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -5,6 +5,7 @@
> >  #include "gpg-interface.h"
> >  #include "hex.h"
> >  #include "parse-options.h"
> > +#include "run-command.h"
> >  #include "refs.h"
> >  #include "wildmatch.h"
> >  #include "object-name.h"
> > @@ -146,6 +147,7 @@ enum atom_type {
> >  	ATOM_TAGGERDATE,
> >  	ATOM_CREATOR,
> >  	ATOM_CREATORDATE,
> > +	ATOM_DESCRIBE,
> >  	ATOM_SUBJECT,
> >  	ATOM_BODY,
> >  	ATOM_TRAILERS,
> > @@ -215,6 +217,13 @@ static struct used_atom {
> >  		struct email_option {
> >  			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
> >  		} email_option;
> > +		struct {
> > +			enum { D_BARE, D_TAGS, D_ABBREV, D_EXCLUDE,
> > +			       D_MATCH } option;
> > +			unsigned int tagbool;
> > +			unsigned int length;
> 
> The name "tagbool" sounds strange, as we are not saying
> "lengthint".

Yeah, it does sound strange now that you take the example of "lenghtint".
I'm thinking "use_tags" might be good, but I don't know.

> > +			char *pattern;
> > +		} describe;
> 
> I am a bit confused by this structure, actually, as I cannot quite
> guess from the data structure alone how you intend to use it.  Does
> this give a good representation for the piece of data you are trying
> to capture?
> 
> For example, %(describe:tags=no,abbrev=4) would become a single atom
> with 0 in .tagbool and 4 in .length, but what does the .option
> member get?

That is true. After I read your email, I started thinking of redesigning
it. My initial thought on doing this was to mimic the other atoms'
design in "struct used_atom" but now that I have read your email, it
seems that such a design doesn't work. Maybe I could do something like
how it is handled in pretty while also not losing the design of other
atoms in "struct used_atom".

> > @@ -462,6 +471,66 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
> >  	return 0;
> >  }
> >  
> > +static int parse_describe_option(const char *arg)
> > +{
> > +	if (!arg)
> > +		return D_BARE;
> > +	else if (starts_with(arg, "tags"))
> > +		return D_TAGS;
> > +	else if (starts_with(arg, "abbrev"))
> > +		return D_ABBREV;
> > +	else if(starts_with(arg, "exclude"))
> > +		return D_EXCLUDE;
> > +	else if (starts_with(arg, "match"))
> > +		return D_MATCH;
> > +	return -1;
> > +}
> > +
> > +static int describe_atom_parser(struct ref_format *format UNUSED,
> > +				struct used_atom *atom,
> > +				const char *arg, struct strbuf *err)
> > +{
> > +	int opt = parse_describe_option(arg);
> > +
> > +	switch (opt) {
> > +	case D_BARE:
> > +		break;
> > +	case D_TAGS:
> > +		/*
> > +		 * It is also possible to just use describe:tags, which
> > +		 * is just treated as describe:tags=1
> > +		 */
> > +		if (skip_prefix(arg, "tags=", &arg)) {
> > +			if (strtoul_ui(arg, 10, &atom->u.describe.tagbool))
> 
> This is not how you accept a Boolean.
> 
> "1", "0", "yes", "no", "true", "false", "on", "off" are all valid
> values and you use git_parse_maybe_bool() to parse them.

Will make this change.

> > +				return strbuf_addf_ret(err, -1, _("boolean value "
> > +						"expected describe:tags=%s"), arg);
> > +
> > +		} else {
> > +			atom->u.describe.tagbool = 1;
> > +		}
> > +		break;
> > +	case D_ABBREV:
> > +		skip_prefix(arg, "abbrev=", &arg);
> > +		if (strtoul_ui(arg, 10, &atom->u.describe.length))
> > +			return strbuf_addf_ret(err, -1, _("positive value "
> > +					       "expected describe:abbrev=%s"), arg);
> > +		break;
> > +	case D_EXCLUDE:
> > +		skip_prefix(arg, "exclude=", &arg);
> > +		atom->u.describe.pattern = xstrdup(arg);
> > +		break;
> > +	case D_MATCH:
> > +		skip_prefix(arg, "match=", &arg);
> > +		atom->u.describe.pattern = xstrdup(arg);
> > +		break;
> > +	default:
> > +		return err_bad_arg(err, "describe", arg);
> > +		break;
> > +	}
> > +	atom->u.describe.option = opt;
> > +	return 0;
> > +}
> 
> Even though the documentation patch we saw earlier said "may be
> followed by a colon and zero or more comma-separated options", this
> seems to expect only and exactly one option.  Indeed, if we run the
> resulting git like "git for-each-ref --format='%(describe:tags=0,abbrev=4)'"
> you will get complaints from this parser.
> 
> The implementation needs redesigning as the data structure is not
> equipped to handle more than one options given at the same time, as
> we saw earlier.
> 
> > @@ -664,6 +733,7 @@ static struct {
> >  	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
> >  	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
> >  	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
> > +	[ATOM_DESCRIBE] = { "describe", SOURCE_OBJ, FIELD_STR, describe_atom_parser },
> >  	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
> >  	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
> >  	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
> > @@ -1483,6 +1553,78 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
> >  	}
> >  }
> >  
> > +static void grab_describe_values(struct atom_value *val, int deref,
> > +				 struct object *obj)
> > +{
> > +	struct commit *commit = (struct commit *)obj;
> > +	int i;
> > +
> > +	for (i = 0; i < used_atom_cnt; i++) {
> > +		struct used_atom *atom = &used_atom[i];
> > +		const char *name = atom->name;
> > +		struct atom_value *v = &val[i];
> > +		int opt;
> > +
> > +		struct child_process cmd = CHILD_PROCESS_INIT;
> > +		struct strbuf out = STRBUF_INIT;
> > +		struct strbuf err = STRBUF_INIT;
> > +
> > +		if (!!deref != (*name == '*'))
> > +			continue;
> > +		if (deref)
> > +			name++;
> > +
> > +		if (!skip_prefix(name, "describe", &name) ||
> > +		    (*name && *name != ':'))
> > +			    continue;
> 
> This looks overly expensive.  Why aren't we looking at the atom_type
> and see if it is ATOM_DESCRIBE here?
> 
> > +		switch(opt) {
> > +		case D_BARE:
> > +			break;
> > +		case D_TAGS:
> > +			if (atom->u.describe.tagbool)
> > +				strvec_push(&cmd.args, "--tags");
> > +			else
> > +				strvec_push(&cmd.args, "--no-tags");
> > +			break;
> > +		case D_ABBREV:
> > +			strvec_pushf(&cmd.args, "--abbrev=%d",
> > +				     atom->u.describe.length);
> > +			break;
> > +		case D_EXCLUDE:
> > +			strvec_pushf(&cmd.args, "--exclude=%s",
> > +				     atom->u.describe.pattern);
> > +			break;
> > +		case D_MATCH:
> > +			strvec_pushf(&cmd.args, "--match=%s",
> > +				     atom->u.describe.pattern);
> > +			break;
> > +		}
> 
> Again, it is apparent here that the atom takes only one option at most.

Yeah. I'll reroll with the necessary changes so that we handle many
options like the Documentation patch says and also the other things you
pointed out.

Thanks

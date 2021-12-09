Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51971C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 23:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhLIXGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 18:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhLIXGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 18:06:53 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0742CC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 15:03:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 133so6413009pgc.12
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 15:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hhutKCxkZBKxd4GFbCNycHiNzJCpIiUMqhkxZpB2HPk=;
        b=gwZSSF35gtqHteP27V9Ii3CbCQ1gHgro0oQaQ2c1QIQw83jlU7EMzJsceiy9HWsYIs
         cQkIN3g1peEchgyzffHnfQmuGNKE9lS8aUzH1qUJkA6AgKCwIzH9Oml7cpdJ2Q1Fr2MI
         8mTs9t6omGln2dCfmcV+uVcKr9s3lTFBf9daY+ivMy1mCWpncedM/1T+HfTlFrg1NGLn
         IWbSzy6DECESDoF0z+K4x5Hsuvij7ELbh8KXTeMnKxbBaT6ot0V+pkawl9Meaaj0AoXz
         kdx6iJDldSuQoCEqhMdzGyl0MrtDH4tm1LsjkX+V8Hssy3VIjsdNnwEtnR3AqAmwtNt0
         JvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=hhutKCxkZBKxd4GFbCNycHiNzJCpIiUMqhkxZpB2HPk=;
        b=P2Km72kJ90r/A7UuH4Anx8f7FvM4CzkM3481pAzZPfjmI2shmepzKbvhBvCuSjXBhS
         /MKqviFunL++YldfAdHV3yhIBYxC0dHo56DjGcMco8JA5dCSC/doN3zzwSq0kQ5GKTgG
         4ntQBpyN2wRbUuNLTwZBZio+owuMPWJAWR3mjCtsJC/hQE5fIqb88D9uH7ZQp6wNnw/O
         v3lgW9vqfY8/7uVKp8lGqWbFJtvJDh+9LeSWsedawGsPa2vPW/qwe94p4geunkkKbCik
         kpY3xEuv1lxQhuBT6QDJpoIJqMl7tBUXUJC085Iw+e7JXxnrI4df/mGAJOTry0gPfiex
         UuHQ==
X-Gm-Message-State: AOAM531ed3wmj1UsgtwgbBf+W699gvaS27SfeuYnahClFSHBW+8ejOd4
        g5cZZMnBDJ8/RgdGFtgoHRXxOA==
X-Google-Smtp-Source: ABdhPJwgq7IERuGqFa7MTPmk87GOl1X5zun7KBgTGIrAT9jrq0tjsGmRgZZuC1bkuYzq0C/9cxkduA==
X-Received: by 2002:a63:4918:: with SMTP id w24mr36810866pga.598.1639090997807;
        Thu, 09 Dec 2021 15:03:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f4c9:bc3f:d5d6:ed2e])
        by smtp.gmail.com with ESMTPSA id q1sm769653pfu.33.2021.12.09.15.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 15:03:17 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:03:11 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Message-ID: <YbKLL2cQCxXQeQ5J@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        emilyshaffer@google.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <211207.86mtlcpyu4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211207.86mtlcpyu4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.07 09:57, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 06 2021, Josh Steadmon wrote:
> 
> > Add a new static variant of install_branch_config() that accepts
> > multiple remote branch names for tracking. This will be used in an
> > upcoming commit that enables inheriting the tracking configuration from
> > a parent branch.
> >
> > Currently, all callers of install_branch_config() pass only a single
> > remote. Make install_branch_config() a small wrapper around
> > install_branch_config_multiple_remotes() so that existing callers do not
> > need to be changed.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  branch.c | 120 ++++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 87 insertions(+), 33 deletions(-)
> >
> > diff --git a/branch.c b/branch.c
> > index 7a88a4861e..1aabef4de0 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -55,19 +55,24 @@ N_("\n"
> >  "the remote tracking information by invoking\n"
> >  "\"git branch --set-upstream-to=%s%s%s\".");
> >  
> > -int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
> > +static int install_branch_config_multiple_remotes(int flag, const char *local, const char *origin,
> > +		struct string_list *remotes)
> >  {
> >  	const char *shortname = NULL;
> >  	struct strbuf key = STRBUF_INIT;
> > -	int rebasing = should_setup_rebase(origin);
> > -
> > -	if (skip_prefix(remote, "refs/heads/", &shortname)
> > -	    && !strcmp(local, shortname)
> > -	    && !origin) {
> > -		warning(_("Not setting branch %s as its own upstream."),
> > -			local);
> > -		return 0;
> > -	}
> > +	int i, rebasing = should_setup_rebase(origin);
> > +
> > +	if (remotes->nr < 1)
> > +		BUG("must provide at least one remote for branch config");
> 
> Since it's unsigned IMO this would be clearer: if (!remotes->nr)

Fixed in v6.


> > +
> > +	if (!origin)
> > +		for (i = 0; i < remotes->nr; i++)
> > +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)
> 
> For this and others, since you don't use the [i] for anything except
> getting the current item using for_each_string_list_item() would be
> better.
> 
> Partially a nit, partially that I've got another WIP
> soon-to-be-submitted topic to fix overflow bugs in that API, and not
> having "int i" etc. hardcoded in various places
> helps. I.e. for_each_string_list_item() is future-proof.

Thanks. I somehow missed for_each_string_list_item() when I checked the
header file. Fixed in v6.

> > +			    && !strcmp(local, shortname)) {
> > +				warning(_("Not setting branch %s as its own upstream."),
> 
> Better to quote '%s', also s/Not/not/ (lower-case) for all error/warning/die etc.

Done (for now) in v6, but this might become moot as I address Junio's
review comments.


> > +					local);
> > +				return 0;
> > +			}
> >  
> >  	strbuf_addf(&key, "branch.%s.remote", local);
> >  	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
> > @@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  
> >  	strbuf_reset(&key);
> >  	strbuf_addf(&key, "branch.%s.merge", local);
> > -	if (git_config_set_gently(key.buf, remote) < 0)
> > +	/*
> > +	 * We want to overwrite any existing config with all the branches in
> > +	 * "remotes". Override any existing config with the first branch, but if
> > +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> > +	 * we've written so far.
> > +	 */
> > +	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
> >  		goto out_err;
> > +	for (i = 1; i < remotes->nr; i++)
> > +		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string, CONFIG_REGEX_NONE, 0) < 0)
> > +			goto out_err;
> >  
> >  	if (rebasing) {
> >  		strbuf_reset(&key);
> > @@ -87,29 +101,62 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  	strbuf_release(&key);
> >  
> >  	if (flag & BRANCH_CONFIG_VERBOSE) {
> > -		if (shortname) {
> > -			if (origin)
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> > -					  local, shortname, origin);
> > -			else
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track local branch '%s'."),
> > -					  local, shortname);
> > +		int plural = remotes->nr > 1;
> 
> This....
> 
> > +		int all_shortnames = 1;
> > +		const char *msg_fmt;
> > +		struct strbuf ref_string = STRBUF_INIT;
> > +
> > +		for (i = 0; i < remotes->nr; i++)
> > +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)) {
> > +				strbuf_addf(&ref_string, "'%s', ", shortname);
> > +			} else {
> > +				all_shortnames = 0;
> > +				strbuf_addf(&ref_string, "'%s', ", remotes->items[i].string);
> > +			}
> > +		/* The last two characters are an extraneous ", ", so trim those. */
> > +		strbuf_setlen(&ref_string, ref_string.len - 2);
> 
> languages RTL in around way wrong the be to going is thing of sort This.
> 
> :)
> 
> We deal with this in most other places by just formatting a list of
> branches. E.g. in the ambiguous object output:
> 
>     https://lore.kernel.org/git/patch-v5-4.6-36b6b440c37-20211125T215529Z-avarab@gmail.com/

Done, thanks for the suggestion.

> > +
> > +		if (all_shortnames && origin) {
> > +			if (rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s' by rebasing.";
> > +			else if (rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s' by rebasing.";
> > +			else if (!rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s'.";
> > +			else if (!rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s'.";
> 
> ...and this is hardcoding plural rules used in English that don't apply
> in a lot of other languages...
> 
> > +
> > +			printf_ln(_(msg_fmt), local, ref_string, origin);
> >  		} else {
> > -			if (origin)
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track remote ref '%s'."),
> > -					  local, remote);
> > -			else
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track local ref '%s'."),
> > -					  local, remote);
> > +			if (all_shortnames && !origin && rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track local branches %s by rebasing.";
> > +			if (all_shortnames && !origin && rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track local branch %s by rebasing.";
> > +			if (all_shortnames && !origin && !rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track local branches %s.";
> > +			if (all_shortnames && !origin && !rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track local branch %s.";
> > +			if (!all_shortnames && origin && rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track remote refs %s by rebasing.";
> > +			if (!all_shortnames && origin && rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track remote ref %s by rebasing.";
> > +			if (!all_shortnames && origin && !rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track remote refs %s.";
> > +			if (!all_shortnames && origin && !rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track remote ref %s.";
> > +			if (!all_shortnames && !origin && rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track local refs %s by rebasing.";
> > +			if (!all_shortnames && !origin && rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track local ref %s by rebasing.";
> > +			if (!all_shortnames && !origin && !rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track local refs %s.";
> > +			if (!all_shortnames && !origin && !rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track local ref %s.";
> 
> ...in English you've got one dog, then dogs, so == 1 and >1, but in
> various other languages it's:
> 
>     git grep Plural-Forms -- po
> 
> Anyway, this is easily solved, and even with less verbosity, see:
> 
>     git grep -E -W '\bQ_\('
> 
> For examples of how to use the magic of libintl to do this for you.

Thank you for the pointer. I looked specifically for dealing with plural
forms in our docs, but the referenced "Preparing Strings" gettext docs
were not helpful for this. (Although I see now I should have read
further in po/README.md to find the relevant advice).  I may send a
separate change to po/README.md to make it easier to find in the future.

> > +
> > +			printf_ln(_(msg_fmt), local, ref_string);
> 
> ...also s/Branch/branch/ for all of them/.

Done.

> >  		}
> > +
> > +		strbuf_release(&ref_string);
> >  	}
> >  
> >  	return 0;
> > @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  	advise(_(tracking_advice),
> >  	       origin ? origin : "",
> >  	       origin ? "/" : "",
> > -	       shortname ? shortname : remote);
> > +	       remotes->items[0].string);
> >  
> >  	return -1;
> >  }
> >  
> > +int install_branch_config(int flag, const char *local, const char *origin, const char *remote) {
> 
> nit: overly long line..

Fixed.


> > +	struct string_list remotes = STRING_LIST_INIT_DUP;
> 
> nit: an extra \n after variable decls...

Fixed.


> > +	string_list_append(&remotes, remote);
> > +	return install_branch_config_multiple_remotes(flag, local, origin, &remotes);
> > +	string_list_clear(&remotes, 0);
> > +}
> > +
> >  /*
> >   * This is called when new_ref is branched off of orig_ref, and tries
> >   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> 


Thanks for the review!

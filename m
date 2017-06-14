Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400341FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 00:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbdFNAsV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 20:48:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33114 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdFNAsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 20:48:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id w12so14095757pfk.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 17:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MeCvHyqcSf+CkVU/tsgcers35AutuUWcRVY3+NNhA2M=;
        b=nP7vmtfCTZLFPA7JOvEpQeOdHeYNP2eXHbArl3VsMaP23wbcMOAon5Vs5/Ce8la/me
         93Y5xIbT2lejui8paRdCHXtA6+RVMExJAsrZKE1v5tC272Dv+wZ62OnPPFTbYJEFiUhM
         sTyKrd3CFIpbP+b+sC6dE6+rRphCqL0UkUYSM1E/0MHajrMpHertRMs4KUgY8unixrbm
         1HzH/NXaOxRZ7vereURxUM2PzIYdcWEMn9GdAmOUclt7PLLK8YdZcHaMkKnkZ7vvzXXI
         rXuU8by2Y/AxCdVilHys3yxI3pxAQi6xBeN2GwbRydhag/07xsWeJQQ1E7UVGFdIXce5
         mg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MeCvHyqcSf+CkVU/tsgcers35AutuUWcRVY3+NNhA2M=;
        b=cD98+vrEVKFp0l4iv32EwgP6dGjHZJDn05eh/nLn/GHkzGFXcyPaW9m4piYJmcsg3h
         ow/MZJ+gmPaP73I29oS+3xfF5iYyVnZqu8ZvRnfT7bB0+2mrrRA7xoYo06Wv1e8zPK78
         nAmJeY7HB8628OOc/RQinAPjp+myZdJyZGxxhkJgnN3WZtG7OV8McjPkTzP7k0kJul+6
         BGzM+n5BKNp4UOq5ePYeZPKYUXKFDE616eK4uFO2OMjDsSfrJ1qeBIrAWbVIoUr3Pwul
         U9jFEORFo2JJHiD+rKZPOyft17Z+vJxPg66B3YHz2/lytNi8+OfM/CkcqH7ZdMl7edbj
         PSLg==
X-Gm-Message-State: AKS2vOxTpWV67GftpzQsWWNzMM+aAW942RxcMirFM6cDmyEocWmVGVjh
        hOr0mYp1Bngl0Q==
X-Received: by 10.84.131.1 with SMTP id 1mr2133575pld.232.1497401299889;
        Tue, 13 Jun 2017 17:48:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id f22sm29887363pfk.104.2017.06.13.17.48.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 17:48:18 -0700 (PDT)
Date:   Tue, 13 Jun 2017 17:48:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170614004816.GR133952@aiede.mtv.corp.google.com>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170530071244.32257-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

SZEDER Gábor wrote:

> The initial fetch during a clone doesn't transfer refs matching
> additional fetch refspecs given on the command line as configuration
> variables.  This contradicts the documentation stating that
> configuration variables specified via 'git clone -c <key>=<value> ...'
> "take effect immediately after the repository is initialized, but
> before the remote history is fetched" and the given example
[...]
> The reason for this is that the initial fetch is not a fully fledged
> 'git fetch' but a bunch of direct calls into the fetch/transport
> machinery with clone's own refs-to-refspec matching logic, which
> bypasses parts of 'git fetch' processing configured fetch refspecs.

Agh, subtle.

I'm hoping that longer term we can make fetch behave more like a
library and make the initial fetch into a fully fledged 'git fetch'
like thing again.  But this smaller change is the logical fix in the
meantime.

[...]
> diff --git a/remote.c b/remote.c
> index ad6c5424e..b8fd09dc9 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -626,6 +626,19 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
>  	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
>  }
>  
> +void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec)
> +{
> +	struct refspec *rs;
> +
> +	add_fetch_refspec(remote, refspec);
> +	rs = parse_fetch_refspec(1, &refspec);
> +	REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
> +	remote->fetch[remote->fetch_refspec_nr - 1] = *rs;
> +
> +	/* Not free_refspecs(), as we copied its pointers above */
> +	free(rs);
> +}
> +
>  static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
>  {
>  	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
> diff --git a/remote.h b/remote.h
> index 924881169..9ad8c1085 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -164,6 +164,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
>  
>  int valid_fetch_refspec(const char *refspec);
>  struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
> +void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec);
>  
>  void free_refspec(int nr_refspec, struct refspec *refspec);

I realize its neighbors don't have this, but can this function have a
brief comment explaining how it is meant to be used and what
guarantees it makes?

For example:

	/** Adds a refspec to remote->fetch_refspec and remote->fetch. */
	void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec);

I'm tempted to say that this one should be named add_fetch_refspec (or
something like remote_add_refspec) --- this is the only way to add a
fetch refspec in the public remote API, and the fact that it parses is
an implementation detail.  The private add_fetch_refpsec that builds
the fetch_refspec as preparation for parsing them in a batch is not
part of the exported API.

Also, now that the API is appending to remote->fetch instead of
allocating it in one go, should it use the ALLOC_GROW heuristic /
fetch_refspec_alloc size?

The caller adds one refspec right after calling remote_get.  I'm
starting to wonder if this could be done more simply by having a
variant of remote_get that allows naming an additional refspec, so
that remote->fetch could be immutable after construction like it was
before.  What do you think?

[...]
> +	/* Not free_refspecs(), as we copied its pointers above */
> +	free(rs);

Allocating an array to put the parsed refspec in and then freeing it
seems wasteful.  Should parse_refspec_internal be changed to take an
output parameter so it can put the refspec into remote->fetch
directly?

[...]
> +++ b/builtin/clone.c
[...]
> @@ -848,16 +853,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	const struct ref *our_head_points_at;
>  	struct ref *mapped_refs;
>  	const struct ref *ref;
> -	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
> +	struct strbuf key = STRBUF_INIT, default_refspec = STRBUF_INIT;

nit: since it's not part of a key, value pair like value,
default_refspec should probably go on its own line.

[...]
> --- a/t/t5611-clone-config.sh
> +++ b/t/t5611-clone-config.sh
> @@ -37,6 +37,50 @@ test_expect_success 'clone -c config is available during clone' '
>  	test_cmp expect child/file
>  '
>  
> +test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
> +	rm -rf child &&
> +	git update-ref refs/grab/it refs/heads/master &&
> +	git update-ref refs/leave/out refs/heads/master &&
> +	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
> +	git -C child for-each-ref --format="%(refname)" >actual &&
> +	cat >expect <<-EOF &&
> +	refs/grab/it
> +	refs/heads/master
> +	refs/remotes/origin/HEAD
> +	refs/remotes/origin/master
> +	EOF
> +	test_cmp expect actual
> +'

Can use <<-\EOF to save the reviewer from having to look for variable
interpolations.

optional nit: might be easier to read with a blank line before the
"cat >expect" line or the for-each-ref line.  That way, it's easier to
separate the validation of output from the commands being run at a
glance and see what the test is about.

> +
> +test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
> +	rm -rf child &&
> +	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
> +	git -C child for-each-ref --format="%(refname)" >actual &&
> +	cat >expect <<-EOF &&
> +	refs/grab/it
> +	refs/heads/master
> +	refs/remotes/origin/HEAD
> +	refs/remotes/origin/master
> +	EOF

Likewise.

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
> +	rm -rf child &&
> +	git clone --origin=upstream \
> +		-c "remote.upstream.fetch=+refs/grab/*:refs/grab/*" \
> +		-c "remote.origin.fetch=+refs/leave/*:refs/leave/*" \
> +		. child &&
> +	git -C child for-each-ref --format="%(refname)" >actual &&
> +	cat >expect <<-EOF &&
> +	refs/grab/it
> +	refs/heads/master
> +	refs/remotes/upstream/HEAD
> +	refs/remotes/upstream/master
> +	EOF

Likewise.  Nice.

> +	test_cmp expect actual
> +'
> +
>  # Tests for the hidden file attribute on windows
>  is_hidden () {
>  	# Use the output of `attrib`, ignore the absolute path

The rest looks good.  Thanks for a pleasant read.

Sincerely,
Jonathan

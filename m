Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC9D1F4C1
	for <e@80x24.org>; Mon, 14 Oct 2019 22:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfJNW16 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 18:27:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45548 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbfJNW16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 18:27:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so8576723pls.12
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sfzYwtmWmeUEf828RI+2km6hjvbceYDexyuRt+W8jG0=;
        b=lMgbsQqcuyjehlr7KZte2jedE5aNY8mHTzmdwc4z32ea6+xcg/Vmbv9wm5IsXns4Fs
         1cLO1/sgqN4fOFIa6lQVvoNu4Sh2eHr3ZKaHzxlHLKA9jQ2vXIZZOzXP0bFiTkkb2LCJ
         KwNqZ6OTZW1yxKECO/VLy7JrAetJkubC7ESSqu3IVe7c030EFeBnIrbM2Dh6y92yUNAP
         g/P7kHPkiAsvE+WiFbjZZpdScUxHohSOIvFLlv9pdo+4W5xxQgt1UR1EllJ+sjF4zPNU
         I5Q7zP7AeW8PMxoSbWqxC+dND5qTtoNzLbb/PRuhCn/6/jyRaxXtsmYUD/6P4wQN4mg1
         Sb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sfzYwtmWmeUEf828RI+2km6hjvbceYDexyuRt+W8jG0=;
        b=N2rgeiNa6mjQYNAqCZ2FFa4yJSJdntVZ7NltZDKEgzJ1JZt6P+/O+rZo8pffOeqBD8
         DiP35elZVZXkS6oH5OanWGwajriMenRmvgyDC4MS+98GeeULvDlXoDtmo8f+n6kt6OtL
         BuIbPysRhCgEsP9lV0CH8Q2gfbQh7nTTUJDOGTZKK/IsGLfDs64Av8kSzoVqSu0f/I3/
         GICu2JNV7QqQoEzbIr4WthPz+GSJT2fs6MeFSbZ9gohFgTFyoJjmwPMMVsAgXndXyYWi
         rj2QqAWmf3HuNZHcm5TMfzOdTZk3ZhPxtO5+MfAgu6qPDqMGBB0x6LS5GYXhi2C0+pH3
         377Q==
X-Gm-Message-State: APjAAAW2FquFguxgnr2+MZqyvBzg1ZBOEQhLfCurMTEWFZgRa+l5nfG+
        UU+Gk2k5/mw8htJf4PfnTbgKdT04JH1Mfg==
X-Google-Smtp-Source: APXvYqzz1ePF3NQe+uhNfS+2NcPhRfHQENYPQC2DK88VhIiFOCKkIV4d4h5kMrP/nr1zf/1DXBUOYw==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6mr32962776plr.197.1571092076740;
        Mon, 14 Oct 2019 15:27:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id o64sm41326540pjb.24.2019.10.14.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 15:27:55 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:27:49 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
Message-ID: <20191014222749.GB233821@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20190826214737.164132-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826214737.164132-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a few questions below, but they're probably due to lack of a full
understanding on my part of how packfiles are managed.

On 2019.08.26 14:47, Jonathan Tan wrote:
> The specification of promisor packfiles (in partial-clone.txt) states
> that the .promisor files that accompany packfiles do not matter (just
> like .keep files), so whenever a packfile is fetched from the promisor
> remote, Git has been writing empty .promisor files. But these files
> could contain more useful information.
> 
> So instead of writing empty files, write the refs fetched to these
> files. This makes it easier to debug issues with partial clones, as we
> can identify what refs (and their associated hashes) were fetched at the
> time the packfile was downloaded, and if necessary, compare those hashes
> against what the promisor remote reports now.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> As written in the NEEDSWORK comment, repack does not preserve the
> contents of .promisor files, but I thought I'd send this out anyway as
> this change is already useful for users who don't run repack much.
> ---
>  builtin/repack.c         |  5 +++++
>  fetch-pack.c             | 41 ++++++++++++++++++++++++++++++++++++----
>  t/t5616-partial-clone.sh |  8 ++++++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 632c0c0a79..8c1621d414 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -232,6 +232,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  		/*
>  		 * pack-objects creates the .pack and .idx files, but not the
>  		 * .promisor file. Create the .promisor file, which is empty.
> +		 *
> +		 * NEEDSWORK: fetch-pack generates non-empty .promisor files,
> +		 * but this would not preserve their contents. Maybe
> +		 * concatenate the contents of all .promisor files instead of
> +		 * just creating a new empty file.
>  		 */
>  		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
>  					  line.buf);

Since this is just diagnostic information, it seems fine. Maybe
explicitly note in the comment what information is being lost?

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 65be043f2a..07029e1bbf 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -758,8 +758,33 @@ static int sideband_demux(int in, int out, void *data)
>  	return ret;
>  }
>  
> +static void write_promisor_file(const char *keep_name,
> +				struct ref **sought, int nr_sought)
> +{
> +	struct strbuf promisor_name = STRBUF_INIT;
> +	int suffix_stripped;
> +	FILE *output;
> +	int i;
> +
> +	strbuf_addstr(&promisor_name, keep_name);
> +	suffix_stripped = strbuf_strip_suffix(&promisor_name, ".keep");
> +	if (!suffix_stripped)
> +		BUG("name of pack lockfile should end with .keep (was '%s')",
> +		    keep_name);
> +	strbuf_addstr(&promisor_name, ".promisor");
> +
> +	output = xfopen(promisor_name.buf, "w");
> +	for (i = 0; i < nr_sought; i++)
> +		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
> +			sought[i]->name);
> +	fclose(output);
> +
> +	strbuf_release(&promisor_name);
> +}
> +

I am not sure why we want to tie creating the .promisor to creating the
lockfile. I'll keep reading and see if it becomes clear later. Other
than that, the logic here seems clear.

>  static int get_pack(struct fetch_pack_args *args,
> -		    int xd[2], char **pack_lockfile)
> +		    int xd[2], char **pack_lockfile,
> +		    struct ref **sought, int nr_sought)
>  {
>  	struct async demux;
>  	int do_keep = args->keep_pack;
> @@ -821,7 +846,13 @@ static int get_pack(struct fetch_pack_args *args,
>  		}
>  		if (args->check_self_contained_and_connected)
>  			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
> -		if (args->from_promisor)
> +		/*
> +		 * If we're obtaining the filename of a lockfile, we'll use
> +		 * that filename to write a .promisor file with more
> +		 * information below. If not, we need index-pack to do it for
> +		 * us.
> +		 */
> +		if (!(do_keep && pack_lockfile) && args->from_promisor)
>  			argv_array_push(&cmd.args, "--promisor");
>  	}
>  	else {

This makes me wonder why we don't also change index-pack to write a
similar message to the .promisor. I guess there's potentially too much
information to shove all the refs on the command-line?

> @@ -859,6 +890,8 @@ static int get_pack(struct fetch_pack_args *args,
>  		die(_("fetch-pack: unable to fork off %s"), cmd_name);
>  	if (do_keep && pack_lockfile) {
>  		*pack_lockfile = index_pack_lockfile(cmd.out);
> +		if (args->from_promisor)
> +			write_promisor_file(*pack_lockfile, sought, nr_sought);
>  		close(cmd.out);
>  	}
>  

Apart from using the lockfile name as the base for the .promisor
filename, I'm still not seeing why we need to tie this to the fact that
we're creating a lockfile. Could we instead just unconditionally create
the .promisor when args->from_promisor is set, and then remove the logic
in the previous chunk that adds the "--promisor" flag to the index-pack
call?

> @@ -1009,7 +1042,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  		alternate_shallow_file = setup_temporary_shallow(si->shallow);
>  	else
>  		alternate_shallow_file = NULL;
> -	if (get_pack(args, fd, pack_lockfile))
> +	if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
>  		die(_("git fetch-pack: fetch failed."));
>  
>   all_done:
> @@ -1458,7 +1491,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  
>  			/* get the pack */
>  			process_section_header(&reader, "packfile", 0);
> -			if (get_pack(args, fd, pack_lockfile))
> +			if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
>  				die(_("git fetch-pack: fetch failed."));
>  
>  			state = FETCH_DONE;
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 565254558f..486db27ee0 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -46,6 +46,14 @@ test_expect_success 'do partial clone 1' '
>  	test "$(git -C pc1 config --local core.partialclonefilter)" = "blob:none"
>  '
>  
> +test_expect_success 'verify that .promisor file contains refs fetched' '
> +	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
> +	test_line_count = 1 promisorlist &&
> +	git -C srv.bare rev-list HEAD >headhash &&
> +	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
> +	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
> +'
> +
>  # checkout master to force dynamic object fetch of blobs at HEAD.
>  test_expect_success 'verify checkout with dynamic object fetch' '
>  	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 

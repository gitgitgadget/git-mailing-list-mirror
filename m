Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D21C10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837192464B
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JWNFT88N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCIQUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:20:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54177 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgCIQUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 12:20:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 952A4553A3;
        Mon,  9 Mar 2020 12:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pOYwjVUfRbc3rZRwjMWgiiJh/G4=; b=JWNFT8
        8N1dA9LjKfcKQbE0S/SKFjUXLnIeynF4WDxQ5Q9bAVnoDgCOfL5J7Paa2p571zMO
        bbBkVi/8JuHRgwZcrRDZPrI1wmku/RpcnzaaU6amZ1eumqWu3ClcWKqJLDXdOkIf
        jL0nlTaOwamlJKCO9ZnRHCgdfRfsM8QfPGQdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Luc809j4ZuRqS7ICcYGAtwClSI73XMca
        HPyqQJuUz4GhZpALiZfO444aykgdDPFBnxj1UeLkqtuyxc5+IHd47X94zZi24kC/
        +dX9VFOpm2J6VE5AIVivC54Jp9j9R9jQ0njT44iT/g9saCDLLLtgoTY9CHbZEidv
        KxOkGjxyHQw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88FD5553A0;
        Mon,  9 Mar 2020 12:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BEA45539C;
        Mon,  9 Mar 2020 12:20:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] git-merge: add option to format default message using multiple lines
References: <2f0417b3-9e9e-f0db-ab11-92dd7cd2b29a@dark-templar-archives.net>
        <20200309120722.4987-1-darktemplar@dark-templar-archives.net>
        <20200309120722.4987-2-darktemplar@dark-templar-archives.net>
Date:   Mon, 09 Mar 2020 09:20:04 -0700
In-Reply-To: <20200309120722.4987-2-darktemplar@dark-templar-archives.net>
        (i. Dark Templar's message of "Mon, 9 Mar 2020 15:07:21 +0300")
Message-ID: <xmqqblp51owb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6CF92D4-6221-11EA-8F72-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"i.Dark_Templar" <darktemplar@dark-templar-archives.net> writes:

> +static int use_multiline = -1;
>  
>  int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>  {
> @@ -32,6 +33,8 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>  			merge_log_config = DEFAULT_MERGE_LOG_LEN;
>  	} else if (!strcmp(key, "merge.branchdesc")) {
>  		use_branch_desc = git_config_bool(key, value);
> +	} else if (!strcmp(key, "merge.usemultiline")) {
> +		use_multiline = git_config_int(key, value);
>  	} else {
>  		return git_default_config(key, value, cb);
>  	}
> @@ -413,6 +416,39 @@ static void shortlog(const char *name,
>  	string_list_clear(&subjects, 0);
>  }
>  
> +static int fmt_merge_refs_count(void)
> +{
> +	int i = 0;
> +	int j = 0;
> +	int objects_count = 0;

Call it "object_count" and drop "j"; that's shorter.

Also, this is a "STATIC" function, an implementation detail of the
fmt_merge_msg program.  There is no need to repeat that fact by
replicating fmt_merge_ in its name to differenciate with other
things, unlike the functions that are visible from other places.

Just call it "count_srcs()" or something like that and do not use
the word "ref" in its name, as "merging refs" is probably too
ancient, limiting and misleading concept---we do not merge "refs".
We merge commits (and more recently) tags, and "refs" is merely one
of the ways to name these things that are merged.


> +	for (i = 0; i < srcs.nr; i++) {
> +		struct src_data *src_data = srcs.items[i].util;
> +
> +		if (src_data->head_status == 1) {
> +			++objects_count;
> +			continue;
> +		}
> +		if (src_data->head_status == 3) {
> +			++objects_count;
> +		}

This part deserves commenting.  The bit #0 of head_status is special
in that it signals a pull of the default branch (HEAD) of the remote
repository, and it is special because in that case (and only in that
case) none of the string lists in src_data is updated, so the number
of merged heads is one more than the case where the bit #0 is off.

> +		for (j = 0; j < src_data->branch.nr; j++) {
> +			++objects_count;
> +		}
> +		for (j = 0; j < src_data->r_branch.nr; j++) {
> +			++objects_count;
> +		}
> +		for (j = 0; j < src_data->tag.nr; j++) {
> +			++objects_count;
> +		}
> +		for (j = 0; j < src_data->generic.nr; j++) {
> +			++objects_count;
> +		}

Isn't it sufficient to add .nr to object_count?  Why increment
object_count by one as many times as j counts up from 0 to .nr?

If the merge involves only the remote HEAD, then the lists are all
empty, isn't it?  I do not see the point of treating the case where
head_status is 3 == 1|2 any special, so the following is sufficient
as the replacement for the above and should be far easier to follow,
no?  Or am I missing something subtle in your version?

		if (src_data->head_status & 01)
			/* 
                         * the set of merged heads includes the
                         * default branch of the remote, aka HEAD,
			 * which is not counted in any of the lists
			 * in src_data.
			 */
			object_count++;

                object_count += (src->data->branch.nr +
                                 src->data->r_branch.nr +
                                 src->data->tag.nr +
                                 src->data->generic.nr);

By the way, if you read the original code, you may have noticed that
our codebase prefers post-increment over pre-increment, when the
difference does not matter (in other words, "a = ++b;" is perfectly
legit; it is just that we do not say "++b;" when "b++;" would do).

> +	}
> +
> +	return objects_count;
> +}
> +
>  static void fmt_merge_msg_title(struct strbuf *out,
>  				const char *current_branch)
>  {
> @@ -467,6 +503,68 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  		strbuf_addf(out, " into %s\n", current_branch);
>  }
>  
> +static void fmt_merge_msg_title_multiline(struct strbuf *out,
> +				const char *current_branch, int count)
> +{
> +	int i = 0;
> +	int j = 0;
> +
> +	if (!strcmp("master", current_branch))
> +		strbuf_addf(out, "Merge %d %s\n", count, (count == 1) ? "commit" : "commits");
> +	else
> +		strbuf_addf(out, "Merge %d %s into %s\n", count, (count == 1) ? "commit" : "commits", current_branch);

Overlong lines.

> +	strbuf_addch(out, '\n');
> +
> +	if (count == 1)
> +		strbuf_addstr(out, "Following commit is merged:\n");
> +	else
> +		strbuf_addstr(out, "Following commits are merged:\n");

The above makes me wonder if you are better off having "if there is
only one, do these things, otherwise do these other things" at the
top level, i.e.

	if (count == 1) {
		strbuf_addstr(out, "Merge 1 commit");
		if (strcmp(current_branch, "master"))
			strbuf_addstr(out, " into %s", current_branch);
		strbuf_addstr(out, "\n\nFollowing commit is ...");
	} else {
		...similarly...
	}

But stepping back a bit, is there a point in handing count==1 case
in this new format in the first place?  Why waste the most precious
information real estate, which is the title line, to say a lot less
informative "merge 1 commit" instead of what topic is merged there?

Also, I am not sure if "Following commits are merged" is a good
message for a few reasons.

 - Obviously, we allow pulling and merging a signed tag and in that
   case, we are merging a tag, not a commit.

 - When we pull a topic branch and nothing else, the above code
   would say "Merge 1 commit", but there may probably be more than
   one commit on the history leading to that commit we are merging
   into our history.


What actually is happening, instead of "merge 1 commit", is that we
are merging one lineage of history, which may have one or more
commits.  The phrase suitable to call the lineage of history may be
"a topic branch", but it may be "a release tag", in which case what
you are merging would be the entire history built while developing
towards that tag that you have been missing.


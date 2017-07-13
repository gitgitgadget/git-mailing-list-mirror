Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F207202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdGMSyI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:54:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35677 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdGMSyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:54:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so8138163pfq.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iySgA3Yq8RXn25l1g8TVlVx6u2vtIMcJyOJgWw0c+Fw=;
        b=krb7xYD+YUk3CtbAckFtD2XAzgRcePOco+CR1RrY85V2m/rSdzklQO4YCrdx1zZZCf
         SEvWH5HyxbffosDheEWg7ypat0XCMNYJjhQ6SvNWiTjVZGEOeIHmd4nT9O+2REyR5i1d
         jB00BIIdTle5mfwMLVaORXy203KO46tbG3CnoL420j/4PWx3rg8g2Y1HZvJvh4DkTU2O
         x6mJRhOtTYqT+ZeDwGWmsuThSFqTZM8onntyuR1VkyjN3x2eXIZ0rmebOpd8PS72kHbu
         9lMjaIV5EO2TdqeDM5VnJAA/W8RzAIDVhJcWB2zWm/yaMdn9JNlWX4kXDQABUoh3MbAJ
         JE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iySgA3Yq8RXn25l1g8TVlVx6u2vtIMcJyOJgWw0c+Fw=;
        b=KvwCIyDMvDsy0+O4syJiOOfyEKcX4Tt+oYUHEmDUgvJ4Cw+RoKrX/j6Gy595PZsp4W
         KF080+VGOjKcNcOvXC2lwxJzfZHDG4/m3jn7qr0bZybSMc4JGqY2BrV1gnWTla9gXC6g
         gmfA9QIX3k2GZxmMWOqm0m/iSlbB+29S2y6KZdbt/8lkJ8Q1fWGbhSqtlfsKlkqOaMoy
         wgIBHpiLT6KjMcTFcDTxooBw2nPNdYx2lr+o2t+TXElrhezcyeA2XpBAcHKwschVAzIX
         P+VDvJcvc14H4FaaNdb174+ffvpTW1KG/1t7GEE+5yTBR7axV09VFLNI6rOqYiy90zeZ
         aKYw==
X-Gm-Message-State: AIVw110jGHuXS/XUqrHoadwXmVAM2WOzOx8TjadbmNPxJGawzPdSFt59
        Amh29bnwyNEIHg==
X-Received: by 10.99.53.135 with SMTP id c129mr10608036pga.68.1499972046365;
        Thu, 13 Jul 2017 11:54:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id b8sm15731486pfd.65.2017.07.13.11.54.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 11:54:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit: convert lookup_commit_graft to struct object_id
References: <20170713004415.5051-1-sbeller@google.com>
Date:   Thu, 13 Jul 2017 11:54:04 -0700
In-Reply-To: <20170713004415.5051-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 12 Jul 2017 17:44:14 -0700")
Message-ID: <xmqq60ewxj5f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> With this patch, commit.h doesn't contain the string 'sha1' any more.

;-)  Nice.

commit_graft_pos() still thinks we only deal with SHA-1, but that
needs to wait for oid_pos().  The function has only two callers that
do not pass X->oid.hash so it may be a good candidate to convert.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Before diving into the "RFC object store" series further, I want to get
> rid of the final sha1s in {commit,tag}.{c,h}.
>
>  commit.c  | 6 +++---
>  commit.h  | 2 +-
>  fsck.c    | 2 +-
>  shallow.c | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index cbfd689939..e0888cf0f7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -199,11 +199,11 @@ static void prepare_commit_graft(void)
>  	commit_graft_prepared = 1;
>  }
>  
> -struct commit_graft *lookup_commit_graft(const unsigned char *sha1)
> +struct commit_graft *lookup_commit_graft(const struct object_id *oid)
>  {
>  	int pos;
>  	prepare_commit_graft();
> -	pos = commit_graft_pos(sha1);
> +	pos = commit_graft_pos(oid->hash);
>  	if (pos < 0)
>  		return NULL;
>  	return commit_graft[pos];
> @@ -335,7 +335,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>  	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
>  	pptr = &item->parents;
>  
> -	graft = lookup_commit_graft(item->object.oid.hash);
> +	graft = lookup_commit_graft(&item->object.oid);
>  	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
>  		struct commit *new_parent;
>  
> diff --git a/commit.h b/commit.h
> index 4127c298cb..6d857f06c1 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -249,7 +249,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>  
>  struct commit_graft *read_graft_line(char *buf, int len);
>  int register_commit_graft(struct commit_graft *, int);
> -struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
> +struct commit_graft *lookup_commit_graft(const struct object_id *oid);
>  
>  extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
>  extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
> diff --git a/fsck.c b/fsck.c
> index b4204d772b..2d2d2e9432 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -736,7 +736,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>  		buffer += 41;
>  		parent_line_count++;
>  	}
> -	graft = lookup_commit_graft(commit->object.oid.hash);
> +	graft = lookup_commit_graft(&commit->object.oid);
>  	parent_count = commit_list_count(commit->parents);
>  	if (graft) {
>  		if (graft->nr_parent == -1 && !parent_count)
> diff --git a/shallow.c b/shallow.c
> index 54359d5490..f5591e56da 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -107,7 +107,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  		cur_depth++;
>  		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
>  		    (is_repository_shallow() && !commit->parents &&
> -		     (graft = lookup_commit_graft(commit->object.oid.hash)) != NULL &&
> +		     (graft = lookup_commit_graft(&commit->object.oid)) != NULL &&
>  		     graft->nr_parent < 0)) {
>  			commit_list_insert(commit, &result);
>  			commit->object.flags |= shallow_flag;
> @@ -398,7 +398,7 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
>  	for (i = 0; i < sa->nr; i++) {
>  		if (has_object_file(sa->oid + i)) {
>  			struct commit_graft *graft;
> -			graft = lookup_commit_graft(sa->oid[i].hash);
> +			graft = lookup_commit_graft(&sa->oid[i]);
>  			if (graft && graft->nr_parent < 0)
>  				continue;
>  			info->ours[info->nr_ours++] = i;

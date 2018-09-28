Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA861F453
	for <e@80x24.org>; Fri, 28 Sep 2018 04:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeI1KrX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 06:47:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1KrX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 06:47:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so2867994pgq.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fNwngDVqQK5Y2UVy72PXOmCNjj22PgLAlzHVXF3+oo8=;
        b=J7AvSU+XLehjW7B1firq0Or06eyy+8a+EiFc3/BTNoQh2a217GHbePz8f8kPakCiKD
         JlLMiC9WELbzETNMBx4It7/fcRhDupgFynru0vDPG7i9rIaQc5NwCqsgQDL627lJAZVD
         TvmEXfiZDFSeqPbpWy+nn3+Qe2XjKWkKvLRucerE/ABcgLR218v0vApmdppWxGXpo0y9
         P1p8ftaZnoZp9i7d9xedUkJrjNUzwvXXzKVFoG/tqRWmRSwD/lZdGYUQ9QONv/CY3gt3
         necbQPK8n10xKN5PlsmOZzpHQedfMnbDwQ0R8smsdIPRE6nejMy7+e6qjuXHqQUdcgwP
         X3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fNwngDVqQK5Y2UVy72PXOmCNjj22PgLAlzHVXF3+oo8=;
        b=RAtyEJghS9a25P7LsqQmRrnwe5KzVnorgrq5rYYuwp7lAR7FLEDqgMt0QisUNkahvm
         rymWvtVu2jDD5pDOsl/qAPdgNQxIXK9SupTim9aESZ3kYmyBpIdaK3St/FKLY45fK3uS
         eAsOh6nEzU9zH7aIsreYRc58sPesnchWL0jp+hmUkhfcINlRC/tYX5e9cDBur0NaezAj
         Ofdsb5lrWHwpSHYjWlJrKFuDvfl7/77EqzD4xHNSm7CPQz1tcGGz3pX1cerK8wDOKbtp
         2XI942HlGWoKPWIBOgnFL3lD/3IQyF/egj3Wcd2sjpjB3QORN5E+tdtWbz3+NzBznxgC
         RT+Q==
X-Gm-Message-State: ABuFfogrLMvumBtaiDWPhDXkwv6C6lPxEiRlEDZ1JKsLvsgCezpY6TP9
        xKf2sbjnQcimEH19oxOjVvKxLPaHJHOVDA==
X-Google-Smtp-Source: ACcGV60icMSbD2/tbtKmpZtUqyVA06xPDUxrDgW2xfCyN16cIbyrBpdgWtGnxMzPqaWORZCKxEGDMQ==
X-Received: by 2002:a65:5347:: with SMTP id w7-v6mr13224216pgr.17.1538108736515;
        Thu, 27 Sep 2018 21:25:36 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id 22-v6sm5702105pfl.126.2018.09.27.21.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 21:25:35 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:25:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v3 0/4] Filter alternate references
Message-ID: <cover.1538108385.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537466087.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the third re-roll of mine and Peff's series to introduce
'core.alternateRefsCommand', and 'core.alternateRefsPrefixes' to filter
the initial ".have" advertisement when an alternate has a pathologically
large number of references.

A range-diff against v2 is included below, but the major changes between
the two revisions are as follows:

  1. Documentation and testing clean-up, per helpful input from Junio,
     Peff, and brian carlson.

  2. Included also is a preparatory patch from Peff, to change the
     requirement that we provide refnames for alternate references. We
     no longer allow this, and the first commit sent makes that such
     change.

I imagine that we may hit one more re-roll, depending on the outcome of
this review. The series has not fundamentally changed since v2, so I
think that we are at a point of stasis there. Anything that is left
outstanding from v3 should hopefully be similarly-not-earth-shattering
;-).

Thanks in advance for your review.

Thanks,
Taylor

Jeff King (1):
  transport: drop refnames from for_each_alternate_ref

Taylor Blau (3):
  transport.c: extract 'fill_alternate_refs_command'
  transport.c: introduce core.alternateRefsCommand
  transport.c: introduce core.alternateRefsPrefixes

 Documentation/config.txt | 18 +++++++++++++
 builtin/receive-pack.c   |  3 +--
 fetch-pack.c             |  3 +--
 t/t5410-receive-pack.sh  | 57 ++++++++++++++++++++++++++++++++++++++++
 transport.c              | 38 +++++++++++++++++++++------
 transport.h              |  2 +-
 6 files changed, 108 insertions(+), 13 deletions(-)
 create mode 100755 t/t5410-receive-pack.sh

Range-diff against v2:
-:  ---------- > 1:  037273dab0 transport: drop refnames from for_each_alternate_ref
1:  6e3a58afe7 ! 2:  9479470cb1 transport.c: extract 'fill_alternate_refs_command'
    @@ -24,7 +24,7 @@
     +	cmd->git_cmd = 1;
     +	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
     +	argv_array_push(&cmd->args, "for-each-ref");
    -+	argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
    ++	argv_array_push(&cmd->args, "--format=%(objectname)");
     +	cmd->env = local_repo_env;
     +	cmd->out = -1;
     +}
    @@ -39,7 +39,7 @@
     -	cmd.git_cmd = 1;
     -	argv_array_pushf(&cmd.args, "--git-dir=%s", path);
     -	argv_array_push(&cmd.args, "for-each-ref");
    --	argv_array_push(&cmd.args, "--format=%(objectname) %(refname)");
    +-	argv_array_push(&cmd.args, "--format=%(objectname)");
     -	cmd.env = local_repo_env;
     -	cmd.out = -1;
     +	fill_alternate_refs_command(&cmd, path);
2:  9797f52551 ! 3:  2dbcd54190 transport.c: introduce core.alternateRefsCommand
    @@ -3,24 +3,24 @@
         transport.c: introduce core.alternateRefsCommand

         When in a repository containing one or more alternates, Git would
    -    sometimes like to list references from its alternates. For example, 'git
    -    receive-pack' list the objects pointed to by alternate references as
    -    special ".have" references.
    +    sometimes like to list references from those alternates. For example,
    +    'git receive-pack' lists the "tips" pointed to by references in those
    +    alternates as special ".have" references.

         Listing ".have" references is designed to make pushing changes from
         upstream to a fork a lightweight operation, by advertising to the pusher
         that the fork already has the objects (via its alternate). Thus, the
         client can avoid sending them.

    -    However, when the alternate has a pathologically large number of
    -    references, the initial advertisement is too expensive. In fact, it can
    -    dominate any such optimization where the pusher avoids sending certain
    -    objects.
    +    However, when the alternate (upstream, in the previous example) has a
    +    pathologically large number of references, the initial advertisement is
    +    too expensive. In fact, it can dominate any such optimization where the
    +    pusher avoids sending certain objects.

         Introduce "core.alternateRefsCommand" in order to provide a facility to
         limit or filter alternate references. This can be used, for example, to
    -    filter out "uninteresting" references from the initial advertisement in
    -    the above scenario.
    +    filter out references the alternate does not wish to send (for space
    +    concerns, or otherwise) during the initial advertisement.

         Let the repository that has alternates configure this command to avoid
         trusting the alternate to provide us a safe command to run in the shell.
    @@ -38,15 +38,15 @@
      	expect HEAD to be a symbolic link.

     +core.alternateRefsCommand::
    -+	When listing references from an alternate (e.g., in the case of ".have"), use
    -+	the shell to execute the specified command instead of
    -+	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
    -+	Output must be of the form: `%(objectname) SPC %(refname)`.
    ++	When advertising tips of available history from an alternate, use the shell to
    ++	execute the specified command instead of linkgit:git-for-each-ref[1]. The
    ++	first argument is the absolute path of the alternate. Output must be of the
    ++	form: `%(objectname)`, where multiple tips are separated by newlines.
     ++
     +This is useful when a repository only wishes to advertise some of its
     +alternate's references as ".have"'s. For example, to only advertise branch
     +heads, configure `core.alternateRefsCommand` to the path of a script which runs
    -+`git --git-dir="$1" for-each-ref refs/heads`.
    ++`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
     +
      core.bare::
      	If true this repository is assumed to be 'bare' and has no
    @@ -74,8 +74,7 @@
     +	git clone fork pusher &&
     +	(
     +		cd fork &&
    -+		git config receive.advertisealternates true &&
    -+		cat <<-EOF | git update-ref --stdin &&
    ++		git update-ref --stdin <<-\EOF &&
     +		delete refs/heads/a
     +		delete refs/heads/b
     +		delete refs/heads/c
    @@ -88,23 +87,19 @@
     +	)
     +'
     +
    -+expect_haves () {
    -+	printf "%s .have\n" $(git rev-parse $@) >expect
    -+}
    -+
     +extract_haves () {
    -+	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
    ++	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
     +}
     +
     +test_expect_success 'with core.alternateRefsCommand' '
     +	write_script fork/alternate-refs <<-\EOF &&
     +		git --git-dir="$1" for-each-ref \
    -+			--format="%(objectname) %(refname)" \
    ++			--format="%(objectname)" \
     +			refs/heads/a \
     +			refs/heads/c
     +	EOF
     +	test_config -C fork core.alternateRefsCommand alternate-refs &&
    -+	expect_haves a c >expect &&
    ++	git rev-parse a c >expect &&
     +	printf "0000" | git receive-pack fork >actual &&
     +	extract_haves <actual >actual.haves &&
     +	test_cmp expect actual.haves
    @@ -122,7 +117,7 @@
     -	cmd->git_cmd = 1;
     -	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
     -	argv_array_push(&cmd->args, "for-each-ref");
    --	argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
    +-	argv_array_push(&cmd->args, "--format=%(objectname)");
     +	const char *value;
     +
     +	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
    @@ -135,7 +130,7 @@
     +
     +		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
     +		argv_array_push(&cmd->args, "for-each-ref");
    -+		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
    ++		argv_array_push(&cmd->args, "--format=%(objectname)");
     +	}
     +
      	cmd->env = local_repo_env;
3:  6e8f65a16d ! 4:  48eb774c9e transport.c: introduce core.alternateRefsPrefixes
    @@ -12,9 +12,7 @@
         'core.alternateRefsCommand' would have to do:

           $ git config core.alternateRefsCommand ' \
    -          git -C "$1" for-each-ref refs/tags \
    -          --format="%(objectname) %(refname)" \
    -        '
    +          git -C "$1" for-each-ref refs/tags --format="%(objectname)"'

         The above is cumbersome to write, so let's introduce a
         "core.alternateRefsPrefixes" to address this common case. Instead, the
    @@ -41,7 +39,7 @@
      +++ b/Documentation/config.txt
     @@
      heads, configure `core.alternateRefsCommand` to the path of a script which runs
    - `git --git-dir="$1" for-each-ref refs/heads`.
    + `git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.

     +core.alternateRefsPrefixes::
     +	When listing references from an alternate, list only references that begin
    @@ -63,7 +61,7 @@

     +test_expect_success 'with core.alternateRefsPrefixes' '
     +	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
    -+	expect_haves one three two >expect &&
    ++	git rev-parse one three two >expect &&
     +	printf "0000" | git receive-pack fork >actual &&
     +	extract_haves <actual >actual.haves &&
     +	test_cmp expect actual.haves
    @@ -77,7 +75,7 @@
     @@
      		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
      		argv_array_push(&cmd->args, "for-each-ref");
    - 		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
    + 		argv_array_push(&cmd->args, "--format=%(objectname)");
     +
     +		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
     +			argv_array_push(&cmd->args, "--");
--
2.19.0.221.g150f307af

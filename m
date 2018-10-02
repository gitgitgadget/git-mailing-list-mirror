Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5611F453
	for <e@80x24.org>; Tue,  2 Oct 2018 02:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJBJEo (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 05:04:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39809 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBJEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 05:04:43 -0400
Received: by mail-io1-f66.google.com with SMTP id z16-v6so550193iol.6
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XNgyMtSCH8t3zUWTbCJp8mtY+2IHOeZ3sKqp6K5V9QY=;
        b=O6HTSUYV3UHHjcZJiu3FShjY8Sa98OLLW5Dx96kgYJXz6qIpMpusoRLt0b0oHVEuTu
         T4pE9ywtD12pT4Y07qGZ/L/R5WI9DO1abnOPD/vGkEqrCxmaKYKm7rFkv4l+VSvVbsGT
         c5pzggDyFl3QkZKO7yPwMxq6QtJneCU3FMB3zdNYokYSk55uLcGB0r7zZ+UlgJz1V32O
         wYZoMWdP7YnH+0AayDkYXdf2xQ6ZJVzKUxPM/eDpQeIfzYhpY1VkCjgtLk27QsgtqAKX
         rcHB9+YJO+e/hIDxyiXbP9357JnV0kVILDm0V9w7NDCsG+3jH0s6FVAbueRLYbhV6E3x
         YEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XNgyMtSCH8t3zUWTbCJp8mtY+2IHOeZ3sKqp6K5V9QY=;
        b=j3H8RcMCmsWWNd9yfCDM6GsrllV5Cb1Cyy86HoL0rnKcwOi8FNjcIARKbB+yY64jkc
         wtF7VE6qbQ/s1qKDlI7uB7+zAKBF0hNby5UeOm9IJbGp6OPFMMiZB/sKFlGsGg+wf05M
         slpxPMLFncSXba1O/TtaxV+sdw7HBdMbpq471S5r7eQLoBwyE8t5uGFH1mAoce+YR3Hk
         QApv/GX5MkgjiU00eCd43rd9n972Hiq7aLLYYUmWr9/athxmJEBpw6AeV+1B0q1/hDxJ
         rnHYUbvik/N3NMIrchBoAyYykfOYn0DMn1jLpDQXiRRWTAEbLrMkfZv8wPvFGUDwn3U1
         s4sA==
X-Gm-Message-State: ABuFfohGAqnTJdWKQaOekI8ZfHBRy722jYav+d+4Qrt5tmncJ4aeWcaM
        0lW77rRsADxO3Dkj0V8yWpgEoQ0Ex884ag==
X-Google-Smtp-Source: ACcGV638fbH0ZNCMxvZMO9WCMz0SxRPzBq61lJK/yUWTsxPZ+ssAnGPhUF2cZDaJi5C4AEC2fYVh+A==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7-v6mr7607797plt.274.1538447032805;
        Mon, 01 Oct 2018 19:23:52 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id v190-v6sm22362205pgb.16.2018.10.01.19.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:23:51 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:23:48 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v4 0/4] Filter alternate references
Message-ID: <cover.1538446826.git.me@ttaylorr.com>
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

Attached is the fourth re-roll of a series to teach
'core.alternateRefsCommand' and 'core.alternateRefsPrefixes' to filter
refs from an alternate from being visible to the fork. This is done in
order to optimize a case described in patch [3/4].

As always, a range-diff is included below, showing that not much has
changed of significance since last round. I mostly focused my efforts on
taking Peff's suggestion towards a more straightforward implementation
of the test setup.

Some extra documentation was written and a couple of commit messages
amended, but no C code has changed since the v2.

Thanks again for all of your review.

Thanks,
Taylor

Jeff King (1):
  transport: drop refnames from for_each_alternate_ref

Taylor Blau (3):
  transport.c: extract 'fill_alternate_refs_command'
  transport.c: introduce core.alternateRefsCommand
  transport.c: introduce core.alternateRefsPrefixes

 Documentation/config.txt           | 23 +++++++++++++++++
 builtin/receive-pack.c             |  3 +--
 fetch-pack.c                       |  3 +--
 t/t5410-receive-pack-alternates.sh | 41 ++++++++++++++++++++++++++++++
 transport.c                        | 38 +++++++++++++++++++++------
 transport.h                        |  2 +-
 6 files changed, 97 insertions(+), 13 deletions(-)
 create mode 100755 t/t5410-receive-pack-alternates.sh

Range-diff against v3:
1:  037273dab0 ! 1:  491f258f50 transport: drop refnames from for_each_alternate_ref
    @@ -14,6 +14,7 @@
         bare minimum.

         Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Taylor Blau <me@ttaylorr.com>

      diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
      --- a/builtin/receive-pack.c
2:  9479470cb1 = 2:  6119de15f2 transport.c: extract 'fill_alternate_refs_command'
3:  2dbcd54190 ! 3:  aadb27c010 transport.c: introduce core.alternateRefsCommand
    @@ -24,9 +24,7 @@

         Let the repository that has alternates configure this command to avoid
         trusting the alternate to provide us a safe command to run in the shell.
    -    To behave differently on each alternate (e.g., only list tags from
    -    alternate A, only heads from B) provide the path of the alternate as the
    -    first argument.
    +    To find the alternate, pass its absolute path as the first argument.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    @@ -40,51 +38,41 @@
     +core.alternateRefsCommand::
     +	When advertising tips of available history from an alternate, use the shell to
     +	execute the specified command instead of linkgit:git-for-each-ref[1]. The
    -+	first argument is the absolute path of the alternate. Output must be of the
    -+	form: `%(objectname)`, where multiple tips are separated by newlines.
    ++	first argument is the absolute path of the alternate. Output must contain one
    ++	hex object id per line (i.e., the same as produce by `git for-each-ref
    ++	--format='%(objectname)'`).
     ++
     +This is useful when a repository only wishes to advertise some of its
    -+alternate's references as ".have"'s. For example, to only advertise branch
    ++alternate's references as `.have`'s. For example, to only advertise branch
     +heads, configure `core.alternateRefsCommand` to the path of a script which runs
     +`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
    +++
    ++Note that the configured value is executed in a shell, and thus
    ++linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
    ++the path argument specially.
     +
      core.bare::
      	If true this repository is assumed to be 'bare' and has no
      	working directory associated with it.  If this is the case a

    - diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
    + diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
      new file mode 100755
      --- /dev/null
    - +++ b/t/t5410-receive-pack.sh
    + +++ b/t/t5410-receive-pack-alternates.sh
     @@
     +#!/bin/sh
     +
    -+test_description='git receive-pack test'
    ++test_description='git receive-pack with alternate ref filtering'
     +
     +. ./test-lib.sh
     +
     +test_expect_success 'setup' '
    -+	test_commit one &&
    -+	git update-ref refs/heads/a HEAD &&
    -+	test_commit two &&
    -+	git update-ref refs/heads/b HEAD &&
    -+	test_commit three &&
    -+	git update-ref refs/heads/c HEAD &&
    -+	git clone --bare . fork &&
    -+	git clone fork pusher &&
    -+	(
    -+		cd fork &&
    -+		git update-ref --stdin <<-\EOF &&
    -+		delete refs/heads/a
    -+		delete refs/heads/b
    -+		delete refs/heads/c
    -+		delete refs/heads/master
    -+		delete refs/tags/one
    -+		delete refs/tags/two
    -+		delete refs/tags/three
    -+		EOF
    -+		echo "../../.git/objects" >objects/info/alternates
    -+	)
    ++	test_commit base &&
    ++	git clone -s --bare . fork &&
    ++	git checkout -b public/branch master &&
    ++	test_commit public &&
    ++	git checkout -b private/branch master &&
    ++	test_commit private
     +'
     +
     +extract_haves () {
    @@ -95,11 +83,10 @@
     +	write_script fork/alternate-refs <<-\EOF &&
     +		git --git-dir="$1" for-each-ref \
     +			--format="%(objectname)" \
    -+			refs/heads/a \
    -+			refs/heads/c
    ++			refs/heads/public/
     +	EOF
     +	test_config -C fork core.alternateRefsCommand alternate-refs &&
    -+	git rev-parse a c >expect &&
    ++	git rev-parse public/branch >expect &&
     +	printf "0000" | git receive-pack fork >actual &&
     +	extract_haves <actual >actual.haves &&
     +	test_cmp expect actual.haves
4:  48eb774c9e ! 4:  0d3521e92a transport.c: introduce core.alternateRefsPrefixes
    @@ -12,7 +12,8 @@
         'core.alternateRefsCommand' would have to do:

           $ git config core.alternateRefsCommand ' \
    -          git -C "$1" for-each-ref refs/tags --format="%(objectname)"'
    +          f() { git -C "$1" for-each-ref \
    +                  refs/tags --format="%(objectname)" }; f "$@"'

         The above is cumbersome to write, so let's introduce a
         "core.alternateRefsPrefixes" to address this common case. Instead, the
    @@ -38,8 +39,8 @@
      --- a/Documentation/config.txt
      +++ b/Documentation/config.txt
     @@
    - heads, configure `core.alternateRefsCommand` to the path of a script which runs
    - `git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
    + linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
    + the path argument specially.

     +core.alternateRefsPrefixes::
     +	When listing references from an alternate, list only references that begin
    @@ -52,16 +53,16 @@
      	If true this repository is assumed to be 'bare' and has no
      	working directory associated with it.  If this is the case a

    - diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
    - --- a/t/t5410-receive-pack.sh
    - +++ b/t/t5410-receive-pack.sh
    + diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
    + --- a/t/t5410-receive-pack-alternates.sh
    + +++ b/t/t5410-receive-pack-alternates.sh
     @@
      	test_cmp expect actual.haves
      '

     +test_expect_success 'with core.alternateRefsPrefixes' '
    -+	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
    -+	git rev-parse one three two >expect &&
    ++	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
    ++	git rev-parse private/branch expect &&
     +	printf "0000" | git receive-pack fork >actual &&
     +	extract_haves <actual >actual.haves &&
     +	test_cmp expect actual.haves
--
2.19.0.221.g150f307af

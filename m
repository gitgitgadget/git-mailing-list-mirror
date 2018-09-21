Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF301F453
	for <e@80x24.org>; Fri, 21 Sep 2018 18:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391223AbeIVAhu (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:37:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54673 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAht (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:37:49 -0400
Received: by mail-it1-f194.google.com with SMTP id f14-v6so3159239ita.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EzH8MnhvBKYvRRAoeAf2AgqzmIo2pOxzyhq+MSm+8k8=;
        b=iNLTc/YlHNaJkGR86p8SNCnLkts0m9cOKAgxh2cbmezBL4h4rwTSbIJ7LjK+5syqwe
         W4ljGAkJPXanTdRHpNIZAWLvoQ9II2u2C5Ne3SqWt112Fgya3q6UDjbwofmaACSmekib
         5E3rHi0XinJ7/5GKMkjl9wLeKMKH1smogc8zANPSraxadA+pIzwJgAqQcXqu/+WJB6Gm
         rtDUcKYisuxUgRrwm2na+cVI6RInippIjQWZBtSOw40rn38OHAQyj0+WyakgV8PsLiD/
         IKBqxBTw7b57VtTDdFngqxHyHRlMpJnYUlIk3e/Lj+ioV9LMQkBK9BGhhXkSICYV2GRT
         A8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzH8MnhvBKYvRRAoeAf2AgqzmIo2pOxzyhq+MSm+8k8=;
        b=AZup0bkodvwo7GT+edfylQJ3EADO5ASapAcxSVk9xMaIKB2Szt3/qrP76yo1DGebnd
         Aj1SBjoUY+ge9esP1E10YJQqiHi2lXzrkH1oTobNJz1bdZaACvho6K8TmHCJFjAwdoHQ
         BTxQIBfXSmDPeYPBuGgXSn4TPJrk6sJFbWVj9iK64i9YeehR2NRL4AnJSougmFH0tyHy
         oWeLg7Xkb5ScyHweJkiRjhzA2KmMpU49xNrnkBZ9txAq4uEe/8iRYLAMSTo5TeUdVY8l
         TvOX0Hz1N7CI7O6mxX0hFz0tDZh9yafh47tbafysmbebzWmhtuT6yfezITKA9cxuFHyu
         +ckw==
X-Gm-Message-State: APzg51C5pHbNvsODE0vbQb2ZvUp8wq2MDAmlfLsnqwiDdo7Zlah3YlfW
        oIEZLBDAVk53iDAHlAjLLb7y53pgJ4U=
X-Google-Smtp-Source: ANB0VdbPBu4wKupd8iENljNJYCzlnY9SttlEdMp/PJJm6TdbZw9lLR9Ov9ami4H5emgCISjIuthBXA==
X-Received: by 2002:a24:4a83:: with SMTP id k125-v6mr7120359itb.121.1537555659163;
        Fri, 21 Sep 2018 11:47:39 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id e140-v6sm2717079itc.24.2018.09.21.11.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:47:37 -0700 (PDT)
Date:   Fri, 21 Sep 2018 14:47:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v2 0/3] Filter alternate references
Message-ID: <cover.1537555544.git.me@ttaylorr.com>
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

Attached is the second re-roll of my series to teach
"core.alternateRefsCommand" and "core.alternateRefsPrefixes".

I have included a range-diff below (which I have taught my scripts to do
by default now), but will summarize the changes as usual:

  * Clean up t5410 according to Peff's suggestions in [1]:

    * Simplify many `git update-ref -d`'s into one `git update-ref
      --stdin`.

    * Use `echo >`, instead of `printf >` to write an alternate
      repository.

    * Avoid placing Git on the left-hand side of a pipe.

    * Use 'write_script', instead of embedding the same code in a
      lengthy 'test_config'.

  * Add a motivating example in Documentation/config.txt, per Peff's
    suggestion in [1].

  * Use `printf "%s .have\n"` with many arguments instead of another
    `cat <<-EOF` block and extract it into `expect_haves`, per [2].

  * Do not use `grep -o` in `extract_haves`, thus making it portable.
    Per [3].

[1]: https://public-inbox.org/git/20180920193751.GC29603@sigill.intra.peff.net/
[2]: https://public-inbox.org/git/CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com/
[3]: https://public-inbox.org/git/xmqqlg7ux0st.fsf@gitster-ct.c.googlers.com/

Taylor Blau (3):
  transport.c: extract 'fill_alternate_refs_command'
  transport.c: introduce core.alternateRefsCommand
  transport.c: introduce core.alternateRefsPrefixes

 Documentation/config.txt | 18 ++++++++++++
 t/t5410-receive-pack.sh  | 62 ++++++++++++++++++++++++++++++++++++++++
 transport.c              | 34 ++++++++++++++++++----
 3 files changed, 108 insertions(+), 6 deletions(-)
 create mode 100755 t/t5410-receive-pack.sh

Range-diff against v1:
1:  6e3a58afe7 = 1:  6e3a58afe7 transport.c: extract 'fill_alternate_refs_command'
2:  4c4900722c ! 2:  9797f52551 transport.c: introduce core.alternateRefsCommand
    @@ -42,6 +42,11 @@
     +	the shell to execute the specified command instead of
     +	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
     +	Output must be of the form: `%(objectname) SPC %(refname)`.
    +++
    ++This is useful when a repository only wishes to advertise some of its
    ++alternate's references as ".have"'s. For example, to only advertise branch
    ++heads, configure `core.alternateRefsCommand` to the path of a script which runs
    ++`git --git-dir="$1" for-each-ref refs/heads`.
     +
      core.bare::
      	If true this repository is assumed to be 'bare' and has no
    @@ -70,32 +75,39 @@
     +	(
     +		cd fork &&
     +		git config receive.advertisealternates true &&
    -+		git update-ref -d refs/heads/a &&
    -+		git update-ref -d refs/heads/b &&
    -+		git update-ref -d refs/heads/c &&
    -+		git update-ref -d refs/heads/master &&
    -+		git update-ref -d refs/tags/one &&
    -+		git update-ref -d refs/tags/two &&
    -+		git update-ref -d refs/tags/three &&
    -+		printf "../../.git/objects" >objects/info/alternates
    ++		cat <<-EOF | git update-ref --stdin &&
    ++		delete refs/heads/a
    ++		delete refs/heads/b
    ++		delete refs/heads/c
    ++		delete refs/heads/master
    ++		delete refs/tags/one
    ++		delete refs/tags/two
    ++		delete refs/tags/three
    ++		EOF
    ++		echo "../../.git/objects" >objects/info/alternates
     +	)
     +'
     +
    ++expect_haves () {
    ++	printf "%s .have\n" $(git rev-parse $@) >expect
    ++}
    ++
     +extract_haves () {
    -+	depacketize - | grep -o '^.* \.have'
    ++	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
     +}
     +
     +test_expect_success 'with core.alternateRefsCommand' '
    -+	test_config -C fork core.alternateRefsCommand \
    -+		"git --git-dir=\"\$1\" for-each-ref \
    -+		--format=\"%(objectname) %(refname)\" \
    -+		refs/heads/a refs/heads/c;:" &&
    -+	cat >expect <<-EOF &&
    -+	$(git rev-parse a) .have
    -+	$(git rev-parse c) .have
    ++	write_script fork/alternate-refs <<-\EOF &&
    ++		git --git-dir="$1" for-each-ref \
    ++			--format="%(objectname) %(refname)" \
    ++			refs/heads/a \
    ++			refs/heads/c
     +	EOF
    -+	printf "0000" | git receive-pack fork | extract_haves >actual &&
    -+	test_cmp expect actual
    ++	test_config -C fork core.alternateRefsCommand alternate-refs &&
    ++	expect_haves a c >expect &&
    ++	printf "0000" | git receive-pack fork >actual &&
    ++	extract_haves <actual >actual.haves &&
    ++	test_cmp expect actual.haves
     +'
     +
     +test_done
3:  3639e90588 ! 3:  6e8f65a16d transport.c: introduce core.alternateRefsPrefixes
    @@ -40,13 +40,14 @@
      --- a/Documentation/config.txt
      +++ b/Documentation/config.txt
     @@
    - 	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
    - 	Output must be of the form: `%(objectname) SPC %(refname)`.
    + heads, configure `core.alternateRefsCommand` to the path of a script which runs
    + `git --git-dir="$1" for-each-ref refs/heads`.

     +core.alternateRefsPrefixes::
     +	When listing references from an alternate, list only references that begin
    -+	with the given prefix. To list multiple prefixes, separate them with a
    -+	whitespace character. If `core.alternateRefsCommand` is set, setting
    ++	with the given prefix. Prefixes match as if they were given as arguments to
    ++	linkgit:git-for-each-ref[1]. To list multiple prefixes, separate them with
    ++	whitespace. If `core.alternateRefsCommand` is set, setting
     +	`core.alternateRefsPrefixes` has no effect.
     +
      core.bare::
    @@ -57,18 +58,15 @@
      --- a/t/t5410-receive-pack.sh
      +++ b/t/t5410-receive-pack.sh
     @@
    - 	test_cmp expect actual
    + 	test_cmp expect actual.haves
      '

     +test_expect_success 'with core.alternateRefsPrefixes' '
     +	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
    -+	cat >expect <<-EOF &&
    -+	$(git rev-parse one) .have
    -+	$(git rev-parse three) .have
    -+	$(git rev-parse two) .have
    -+	EOF
    -+	printf "0000" | git receive-pack fork | extract_haves >actual &&
    -+	test_cmp expect actual
    ++	expect_haves one three two >expect &&
    ++	printf "0000" | git receive-pack fork >actual &&
    ++	extract_haves <actual >actual.haves &&
    ++	test_cmp expect actual.haves
     +'
     +
      test_done
--
2.19.0.221.g150f307af

Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00190C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA38722522
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBYx0Xiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAWP0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:26:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46250 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAWP0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 10:26:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so3482377wrl.13
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fuiZP4jw+7Dhwq5jpQ8O41Q4YUv1SunyszY1eP0aZl8=;
        b=pBYx0Xiwm3g33cjVrv8BacmYJKJ89NNSlwRvcfLkbYJRf20xqNPHC9FB5uS7FVhIUD
         gWmpRP1o0VwV0JSjHtK3SC2i36AHxnUqd3OO8KZ8MD4QSto+fOAc7cyyWWd7fU4G+vSV
         byJBpsXC/yglP72ZZMkD2fHGNsisvyjkVqf7U6RVZ9/z3tuX9JkB7vbV3/XEzOlXpBy2
         +lGAqljle94Tac3RVO8iumohaqc10S5GqsYW8nJIg0VP/VSJ9jjFa0ajL8Mkv2WwYn+f
         Xm6EaiFKXWtwSqINvGGRTsFrxxYxf4X5TPcXVwFsksULIlH1cE5JZ1uVNHQgP+YeHcga
         vU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fuiZP4jw+7Dhwq5jpQ8O41Q4YUv1SunyszY1eP0aZl8=;
        b=uSposTIBm3dzIJCZ4qlkiSvAwNqs+hG3ZSWcsbuud/92PLT6Z/N/g9yBqKRV2JKWV9
         ulo3bOwgwyD7FZvXAUElGbxw/n5YaqASzM1TBTpG/AW7uC4i1uzf8YRhqFwVpLgfxSCR
         s2B5tB7cFHUAHOgeeEIXP5R+L5mr2o6NhvUeg1b8BIIPnwuvoy02UmSkPclc61TqymWs
         ajQbxtmj0f643iwsykrVIc0mXSynP+chdibZmPp1Y3b+l2QT1JPnwpiH/YnQV8s2FW8R
         L5N3v6ffsxLXu/s9OgW9Tx61SlZ4K0sttV9eidfkGiJO/to5zliCEWz2Ptn3Bx2D8fZr
         kN/w==
X-Gm-Message-State: APjAAAXt77ZTAyqlqOgxmPpO1aErQeJHL1WnglQURXpmfeWMTARQXdAt
        W2vfNbWR5EqDaMBSZAQ+MjYCETVd
X-Google-Smtp-Source: APXvYqzPMa7Xv58uj7lSXt52O/vvpS05rKGCbqXPZK4Dvp+xW9naaH/iCqNc6aM/MyTizd//uViyDA==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr18025577wrp.322.1579793209204;
        Thu, 23 Jan 2020 07:26:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm3532649wrs.10.2020.01.23.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:26:48 -0800 (PST)
Message-Id: <pull.510.v2.git.1579793207.gitgitgadget@gmail.com>
In-Reply-To: <pull.510.git.1578423871.gitgitgadget@gmail.com>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 15:26:43 +0000
Subject: [PATCH v2 0/4] fsmonitor: start using an opaque token for last update
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only change for this version is to sync the watchman script that is in
templates with the one in t/t7519 since it had some commented out debug code
that could be useful.

Also haven't received any feedback on this patch series which would be good
to make sure I'm not making any obvious mistakes.

Thanks!

Kevin Willford (4):
  fsmonitor: change last update timestamp on the index_state to opaque
    token
  fsmonitor: handle version 2 of the hooks that will use opaque token
  fsmonitor: add fsmonitor hook scripts for version 2
  fsmonitor: update documentation for hook version and watchman hooks

 Documentation/config/core.txt              |  11 ++
 Documentation/githooks.txt                 |  13 +-
 cache.h                                    |   2 +-
 fsmonitor.c                                | 120 ++++++++++----
 t/helper/test-dump-fsmonitor.c             |   2 +-
 t/t7519-status-fsmonitor.sh                |   7 +-
 t/t7519/fsmonitor-all                      |   1 -
 t/t7519/fsmonitor-all-v2                   |  21 +++
 t/t7519/fsmonitor-watchman                 |   3 +-
 t/t7519/fsmonitor-watchman-v2              | 173 +++++++++++++++++++++
 templates/hooks--fsmonitor-watchman.sample | 168 +++++++++++++-------
 11 files changed, 434 insertions(+), 87 deletions(-)
 create mode 100755 t/t7519/fsmonitor-all-v2
 create mode 100755 t/t7519/fsmonitor-watchman-v2


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-510%2Fkewillford%2Ffsmonitor_opaque_token-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-510/kewillford/fsmonitor_opaque_token-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/510

Range-diff vs v1:

 1:  679bf4e0dd = 1:  679bf4e0dd fsmonitor: change last update timestamp on the index_state to opaque token
 2:  f969c4bc17 = 2:  f969c4bc17 fsmonitor: handle version 2 of the hooks that will use opaque token
 3:  e1fd5924d0 ! 3:  ecc288c848 fsmonitor: add fsmonitor hook scripts for version 2
     @@ -236,13 +236,16 @@ $^
      -my ($version, $time) = @ARGV;
      +my ($version, $last_update_token) = @ARGV;
       
     - # Check the hook interface version
     --
     +-# Check the hook interface version
     ++# Uncomment for debugging
     ++# print STDERR "$0 $version $last_update_token\n";
     + 
      -if ($version == 1) {
      -	# convert nanoseconds to seconds
      -	# subtract one second to make sure watchman will return all changes
      -	$time = int ($time / 1000000000) - 1;
      -} else {
     ++# Check the hook interface version
      +if ($version ne 2) {
       	die "Unsupported query-fsmonitor hook version '$version'.\n" .
       	    "Falling back to scanning...\n";
     @@ -273,7 +276,7 @@ $^
       launch_watchman();
       
       sub launch_watchman {
     -+	$o = watchman_query();
     ++	my $o = watchman_query();
      +	if (is_work_tree_watched($o)) {
      +		output_result($o->{clock}, @{$o->{files}});
      +	}
     @@ -281,6 +284,12 @@ $^
      +
      +sub output_result {
      +	my ($clockid, @files) = @_;
     + 
     ++	# Uncomment for debugging watchman output
     ++	# open (my $fh, ">", ".git/watchman-output.out");
     ++	# binmode $fh, ":utf8";
     ++	# print $fh "$clockid\n@files\n";
     ++	# close $fh;
      +
      +	binmode STDOUT, ":utf8";
      +	print $clockid;
     @@ -293,7 +302,7 @@ $^
      +	my $response = qx/watchman clock "$git_work_tree"/;
      +	die "Failed to get clock id on '$git_work_tree'.\n" .
      +		"Falling back to scanning...\n" if $? != 0;
     - 
     ++
      +	return $json_pkg->new->utf8->decode($response);
      +}
      +
     @@ -328,9 +337,20 @@ $^
       		}]
       	END
       
     -@@
     ++	# Uncomment for debugging the watchman query
     ++	# open (my $fh, ">", ".git/watchman-query.json");
     ++	# print $fh $query;
     ++	# close $fh;
     ++
     + 	print CHLD_IN $query;
     + 	close CHLD_IN;
       	my $response = do {local $/; <CHLD_OUT>};
       
     ++	# Uncomment for debugging the watch response
     ++	# open ($fh, ">", ".git/watchman-response.json");
     ++	# print $fh $response;
     ++	# close $fh;
     ++
       	die "Watchman: command returned no output.\n" .
      -	    "Falling back to scanning...\n" if $response eq "";
      +	"Falling back to scanning...\n" if $response eq "";
     @@ -358,11 +378,23 @@ $^
      +
      +sub is_work_tree_watched {
      +	my ($output) = @_;
     -+	if ($retry > 0 and $output->{error} and $output->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
     ++	my $error = $output->{error};
     ++	if ($retry > 0 and $error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
       		$retry--;
     - 		qx/watchman watch "$git_work_tree"/;
     +-		qx/watchman watch "$git_work_tree"/;
     ++		my $response = qx/watchman watch "$git_work_tree"/;
       		die "Failed to make watchman watch '$git_work_tree'.\n" .
     -@@
     + 		    "Falling back to scanning...\n" if $? != 0;
     ++		$output = $json_pkg->new->utf8->decode($response);
     ++		$error = $output->{error};
     ++		die "Watchman: $error.\n" .
     ++		"Falling back to scanning...\n" if $error;
     ++
     ++		# Uncomment for debugging watchman output
     ++		# open (my $fh, ">", ".git/watchman-output.out");
     ++		# close $fh;
     + 
     + 		# Watchman will always return all files on the first query so
       		# return the fast "everything is dirty" flag to git and do the
       		# Watchman query just to get it over with now so we won't pay
       		# the cost in git to look up each individual file.
     @@ -383,8 +415,8 @@ $^
       
      -	die "Watchman: $o->{error}.\n" .
      -	    "Falling back to scanning...\n" if $o->{error};
     -+	die "Watchman: $output->{error}.\n" .
     -+	"Falling back to scanning...\n" if $output->{error};
     ++	die "Watchman: $error.\n" .
     ++	"Falling back to scanning...\n" if $error;
       
      -	binmode STDOUT, ":utf8";
      -	local $, = "\0";
 4:  8d381b7d44 = 4:  1db2a699ba fsmonitor: update documentation for hook version and watchman hooks

-- 
gitgitgadget

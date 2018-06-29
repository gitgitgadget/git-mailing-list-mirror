Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97541F516
	for <e@80x24.org>; Fri, 29 Jun 2018 13:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeF2NUH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 09:20:07 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:33691 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeF2NUG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 09:20:06 -0400
Received: from [192.168.2.201] ([92.22.40.40])
        by smtp.talktalk.net with SMTP
        id YtJifYP0PwhzSYtJjfuo6t; Fri, 29 Jun 2018 14:20:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1530278404;
        bh=qO0xreIpJmzjzIMd221g7odeBZyhtIbyi0arcLjz2/4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fpJO8V6OTrfeFW4LWI+s5YUmUWNURe8XNyBplEFtWQduStsFmIAgyNqW5BCfzcvCc
         Y+XLytvPmGVM1phWo9nQN+rtbShc0gBw32yeFINZDSzJm6YM+ZuHv5AqiQJr1qN9jX
         KmsR8LlrhIZ15//mslGInbErt0LR7YVfX0C4Eyv4=
X-Originating-IP: [92.22.40.40]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=D3TgM3KkWO1kDtfjHkA1ew==:117
 a=D3TgM3KkWO1kDtfjHkA1ew==:17 a=IkcTkHD0fZMA:10 a=I1oCBdh9zLvSzUSBPT0A:9
 a=NbOAvp6TBx0qi2zb:21 a=YCtPEwc2WiBYqiXh:21 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/9] Document/fix/warn about rebase incompatibilities
 and inconsistencies
To:     Elijah Newren <newren@gmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20180625161300.26060-1-newren@gmail.com>
 <20180627072319.31356-1-newren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <0ec512fd-eaff-21c6-17c0-31c02cd1c7a3@talktalk.net>
Date:   Fri, 29 Jun 2018 14:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627072319.31356-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO47U9feBtZHsxVfRPv2BeOmG2/6L0v0UiT5487Dxch20XYLZj36SumFtEV4kyOnTVUKLdXdebyahuy8dIlezEIUxxcmG7reem82Fz6n12nn3EzEi0hO
 t8+Jwu2pYPQJ1oIQpk8sEENE93nsV62E+4Rz1i2OcZ38X6mM5Mf8if+pYTrLzpCrlJV1+6POuc7fRtFCdCRk4B4d+mfWR/WWkLJcY5G5rbzb8JfnmP8XIB2D
 ncs8whqErkNI8pxAKVUug3iYbWzF5S+F/n2wtUwDGV4ycqG1LudQhpR0lFj2xevB/wHXKs/s4d6v0Z8SNpNXkKTQghy9zoPvkItf09nJto7fZKIyfjccH+uE
 LW9No0pt63nPU7oZxXCM/0Y5Zq+ekA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 27/06/18 08:23, Elijah Newren wrote:
> git-rebase has lots of options that are mutually incompatible.  Even among
> aspects of its behavior that is common to all rebase types, it has a number
> of inconsistencies.  This series tries to document, fix, and/or warn users
> about many of these.
> 
> Changes since v4 (short branch-diff at the end):
>   - Fixed --strategy vs. --strategy-option (in patch 3, carries over to
>     context region in later commit)
> 
> v4 didn't get a lot of feedback (though it was picked up by Junio), so I'll
> repeat the areas that would be of most note for reviewers since v3:
> 
>   * I have left patch 9 in RFC state; since v3 it has an expanded the
>     commit message with an in-depth usability rationale for the
>     change.
>   * It sounded like Junio was slightly unclear about the intent of the
>     wording in Patch 1.  Not sure if my answer (in email) was sufficient or
>     if there are wording improvements others might suggest.
>   * I'm assuming the --keep-empty and/or --empty={drop,halt,keep} (see
>     comments on patch 5 of v3) can be resolved in a later series.

I'm sorry I've not got round to looking at the last couple of versions.
Unfortunately I'm about to go off-line for a couple of weeks so I just
wanted to let you know I wasn't ignoring you!. If they haven't been
merged when I get back on-line I'll have a look then

Best Wishes

Phillip

> Elijah Newren (9):
>   git-rebase.txt: document incompatible options
>   git-rebase.sh: update help messages a bit
>   t3422: new testcases for checking when incompatible options passed
>   git-rebase: error out when incompatible options passed
>   git-rebase.txt: address confusion between --no-ff vs --force-rebase
>   directory-rename-detection.txt: technical docs on abilities and
>     limitations
>   git-rebase.txt: document behavioral differences between modes
>   t3401: add directory rename testcases for rebase and am
>   git-rebase: make --allow-empty-message the default
> 
>  Documentation/git-rebase.txt                  | 135 ++++++++++++++----
>  .../technical/directory-rename-detection.txt  | 115 +++++++++++++++
>  git-rebase.sh                                 |  43 +++++-
>  t/t3401-rebase-and-am-rename.sh               | 105 ++++++++++++++
>  t/t3404-rebase-interactive.sh                 |   7 +-
>  t/t3405-rebase-malformed.sh                   |  11 +-
>  t/t3422-rebase-incompatible-options.sh        |  88 ++++++++++++
>  7 files changed, 462 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/technical/directory-rename-detection.txt
>  create mode 100755 t/t3401-rebase-and-am-rename.sh
>  create mode 100755 t/t3422-rebase-incompatible-options.sh
> 
>  1: 3f454ebc5e =  1: 3f454ebc5e git-rebase.txt: document incompatible options
>  2: 31a5a071a6 =  2: 31a5a071a6 git-rebase.sh: update help messages a bit
>  3: 5a2b5eec79 !  3: bc3a5a3f95 t3422: new testcases for checking when incompatible options passed
>     @@ -62,7 +62,7 @@
>      +
>      +	test_expect_failure "$opt incompatible with --strategy-option=ours" "
>      +		git checkout B^0 &&
>     -+		test_must_fail git rebase $opt --strategy=ours A
>     ++		test_must_fail git rebase $opt --strategy-option=ours A
>      +	"
>      +
>      +	test_expect_failure "$opt incompatible with --interactive" "
>  4: 1e1c83724a !  4: ca3b8327f7 git-rebase: error out when incompatible options passed
>     @@ -104,7 +104,7 @@
>      -	test_expect_failure "$opt incompatible with --strategy-option=ours" "
>      +	test_expect_success "$opt incompatible with --strategy-option=ours" "
>       		git checkout B^0 &&
>     - 		test_must_fail git rebase $opt --strategy=ours A
>     + 		test_must_fail git rebase $opt --strategy-option=ours A
>       	"
>       
>      -	test_expect_failure "$opt incompatible with --interactive" "
>  5: 51023269d3 =  5: 6ac359359e git-rebase.txt: address confusion between --no-ff vs --force-rebase
>  6: f017d45dd9 =  6: e5c5db9110 directory-rename-detection.txt: technical docs on abilities and limitations
>  7: 0a359df404 =  7: e330437305 git-rebase.txt: document behavioral differences between modes
>  8: beaadceaef =  8: f704f7eee8 t3401: add directory rename testcases for rebase and am
>  9: 431b2c36d5 =  9: 436f597487 git-rebase: make --allow-empty-message the default
> 


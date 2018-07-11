Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B6B1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 20:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbeGKUeB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 16:34:01 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34384 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733237AbeGKUeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 16:34:01 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so51689655ois.1
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ge1MsvXSrg77p8SpAjNvwQPa0AMnUqkjPhzh08+RhzI=;
        b=GnQ6ihlKcULGvKS1iooAVz9Y/eCny9WoplYgm0djM+pXMLHmzdEoErjFfR53M19eQB
         JZlZpKo6pPpvxyEQ55VbtrFHZfHM7Ihe9rQ5WR94mZ55DRxqPPk2jFqgWsz6y3hILI7l
         P//LZzfeOOie/oQgzoyfLTXqUv0h6ovV+U3KbLRLmG7TKHxOaWhamnhR8Fa3Fwg+j2rU
         JeV6G4zXkdpLyHbkikMo0LypTCYjtuqotJAF7VYQEI409A8zOP3Rujl4SbMkdsDqjcEI
         Xt8cIYepSD3Qvf6/9eMPjqD+jmEUBduit7U0szxDdctfZ+0lIDwX8Iq5jhg4/Nv6AhqU
         JBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ge1MsvXSrg77p8SpAjNvwQPa0AMnUqkjPhzh08+RhzI=;
        b=ZaIjob47fyfI1EX4f0lfbbZotRHfOyTYtVD5+3fHrJ3LV/lG/0GVee+2rMFVis9tzX
         w3SgwICMOD1oIXYUv+EyNIPp4S3uXc62HP8JnPvdO13mRbmIAC1cxlD2Z6u4VZrkrarv
         xFi+h/ZXGythQNaAXTz+NWFkRRHNaifHzEE18Scuof1agKzTmX0JnnzWOD6tcVUP5vtB
         VfWisuFZqzLr2f+BUrdQ2SWAtGMVHjYFkV/hollmnHVy02/q1HKS2/R71kKouuwxKkEb
         492WMyDPZ1CH6tifYWiSm1UIhDSfQySLHVOLwWlRXA3q1U2DN/5cu2dZ6QCtyHFiW3H1
         Kxeg==
X-Gm-Message-State: AOUpUlHdPnTOM7LvvArUPoRj+aP4SeCN57Ch0voBHbd5fPbFx8kOoZ44
        E6gEoyCN+F7kPa6lXGxnDCQ=
X-Google-Smtp-Source: AAOMgpfBm58GVQ2LnmHCZX7l0k1bQd2FC4j6nxRCtBIS7kxYN1zbBYOGVoVyBG2lz4l02ydNdZqUpw==
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr179712oif.348.1531340879401;
        Wed, 11 Jul 2018 13:27:59 -0700 (PDT)
Received: from [172.16.100.100] (cpe-70-113-92-26.austin.res.rr.com. [70.113.92.26])
        by smtp.gmail.com with ESMTPSA id j193-v6sm1781299oih.55.2018.07.11.13.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 13:27:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2] add -p: fix counting empty context lines in edited
 patches
From:   Jeff Felchner <jfelchner1@gmail.com>
In-Reply-To: <20180611094602.17469-1-phillip.wood@talktalk.net>
Date:   Wed, 11 Jul 2018 15:27:57 -0500
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Agren <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9B989D9-5148-4AF1-80EB-ADFAE0DB8FF8@gmail.com>
References: <20180601174644.13055-1-phillip.wood@talktalk.net>
 <20180611094602.17469-1-phillip.wood@talktalk.net>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all, I assumed this was going to be in 2.18, but I'm still having =
the same issue.  What's the plan for release of this?

> On 2018 Jun 11, at 4:46, Phillip Wood <phillip.wood@talktalk.net> =
wrote:
>=20
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
> recount_edited_hunk() introduced in commit 2b8ea7f3c7 ("add -p:
> calculate offset delta for edited patches", 2018-03-05) required all
> context lines to start with a space, empty lines are not counted. This
> was intended to avoid any recounting problems if the user had
> introduced empty lines at the end when editing the patch. However this
> introduced a regression into 'git add -p' as it seems it is common for
> editors to strip the trailing whitespace from empty context lines when
> patches are edited thereby introducing empty lines that should be
> counted. 'git apply' knows how to deal with such empty lines and POSIX
> states that whether or not there is an space on an empty context line
> is implementation defined [1].
>=20
> Fix the regression by counting lines that consist solely of a newline
> as well as lines starting with a space as context lines and add a test
> to prevent future regressions.
>=20
> [1] =
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
>=20
> Reported-by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
> Reported-by: Oliver Joseph Ash <oliverjash@gmail.com>
> Reported-by: Jeff Felchner <jfelchner1@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>=20
> Thanks for the feedback, the only changes since v1 are to fix the
> commit message to match what was in pu and to change '$_' to '$mode'
> in the comparison as I think that is clearer. In the end I decided to
> leave the tests as they are.
>=20
> git-add--interactive.perl  |  2 +-
> t/t3701-add-interactive.sh | 43 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index ab022ec073..8361ef45e7 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1047,7 +1047,7 @@ sub recount_edited_hunk {
> 			$o_cnt++;
> 		} elsif ($mode eq '+') {
> 			$n_cnt++;
> -		} elsif ($mode eq ' ') {
> +		} elsif ($mode eq ' ' or $mode eq "\n") {
> 			$o_cnt++;
> 			$n_cnt++;
> 		}
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index e5c66f7500..f1bb879ea4 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -175,6 +175,49 @@ test_expect_success 'real edit works' '
> 	diff_cmp expected output
> '
>=20
> +test_expect_success 'setup file' '
> +	test_write_lines a "" b "" c >file &&
> +	git add file &&
> +	test_write_lines a "" d "" c >file
> +'
> +
> +test_expect_success 'setup patch' '
> +	SP=3D" " &&
> +	NULL=3D"" &&
> +	cat >patch <<-EOF
> +	@@ -1,4 +1,4 @@
> +	 a
> +	$NULL
> +	-b
> +	+f
> +	$SP
> +	c
> +	EOF
> +'
> +
> +test_expect_success 'setup expected' '
> +	cat >expected <<-EOF
> +	diff --git a/file b/file
> +	index b5dd6c9..f910ae9 100644
> +	--- a/file
> +	+++ b/file
> +	@@ -1,5 +1,5 @@
> +	 a
> +	$SP
> +	-f
> +	+d
> +	$SP
> +	 c
> +	EOF
> +'
> +
> +test_expect_success 'edit can strip spaces from empty context lines' =
'
> +	test_write_lines e n q | git add -p 2>error &&
> +	test_must_be_empty error &&
> +	git diff >output &&
> +	diff_cmp expected output
> +'
> +
> test_expect_success 'skip files similarly as commit -a' '
> 	git reset &&
> 	echo file >.gitignore &&
> --=20
> 2.17.0
>=20


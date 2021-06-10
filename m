Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66746C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF57613C8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFJPQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:16:56 -0400
Received: from mout.web.de ([212.227.17.12]:38863 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhFJPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623338091;
        bh=0KXsAKNUm5MzTwnv7yLTy79mEIRx0zY3iwyevVSX4O0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pkNMEMDT+tGIJX4WAuwJLOo/tQj5Xn5NFGo4QKnpdrAyvPBc8bxztMX/iOVIlk2Hk
         8m5+SmkNKpj5v5wARfMyb3r5i4gjt8oMzz6tScueqEaA7XWJUUq+Njn+c4FtjfL41j
         S+CldgzC+aU04RJttNKvdhQ44A2pAO0Y8krP54/g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lo0V2-1lOuOp0kiu-00g4BB; Thu, 10 Jun 2021 17:14:51 +0200
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
 <87wnr4394y.fsf@evledraar.gmail.com>
 <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
 <87lf7k2bem.fsf@evledraar.gmail.com> <xmqq4ke6ffqv.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f7a54b2d-42c6-1308-f1b0-2f67b2dcadc7@web.de>
Date:   Thu, 10 Jun 2021 17:14:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ke6ffqv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HExekTEUJ4Bn5QiUaLQK5CkrpyYL34wZiCm0dfp8vDmtbzZFKlR
 v2jeP52l5HBxzoMtSahtrCH3SJhoiQG/zr+Q5BH9koWdIM1lwfWSRmW0FoGIqgOeM9TQF98
 OQCsYBNWy3xSiVuqysFSRySs5pKGhhMcHxHqeug4LG+W4+CFFHvS33bnK4IABui1A/6MsR8
 9tNof7E0aaTA6G2bhAgFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Ni4lnXXQ+U=:8bdY0u5glIaA7NGGBuLpJm
 1dl8sECCLCRfeccrbKHwZGjVbPWJek3KU8FIHuU4+c3lUeYPMuoLOXCu4onaezxCSkhwWRpQM
 evJDWt2kY7DiCmSvszbljraJzKL72Xjl/7xtyK0Urc7VJMZOMXTMwX6El7hbrSi0u4c2Fhibo
 SNxdA800qLGzIee2eNkKsgj+8m0N09uQ/qsgXvBjRyTTNkYfkZJC+3tY+gCytOCK5gRegfkYM
 uIYFkrBLqruwK1Bt56iY2pIHDayIqZ+9ZW1oDBXfdM/D5ZyZ6qzsXDUSJd/Z+Zg7LU95FkzCh
 9I4CZWkK8sLsTK2XQ7dzZ7vrIhNa5y5YRMD389ALDatFcNgp+rkgiKOpqY91JiSuChvJajYWS
 QNvi76BNl5tKZ4HJHK2T3CGW/nCrEz4eAfRWWLQNh5jN9HyrT1XwQ97Pz0+1OhKn9Q1uIozgw
 K//quPCr8Zlq03RyBDqigfbjnE/lw3ePcwi1ONQsTIwzdAfvDIkSa/avmqAJP01kV4UqH2I09
 M+AqE6PUh/S7R7+AfBXkirOVzvIex5MiMAO9TDAW4xjLuFWdiY1wqkxYTeyXqPyZNYP4GDU5r
 ysRe1pmk3ImmqIuPVVDJUK2ORayHD4NTtMJh2J/16jXhr+UdqRQS3pf2tfMkp8bqkWUQBjX9i
 jv8C/ED+BRz7elNrFtBkL41sIOl6DeHdvCIua45HIm8UM7U0iGU54YrjIwhpCh9gzC1+gyO2x
 Dy09Da7TMEO2w515O4w3xca/rCMSYBAVtCgAed0I6q/hXRlF1iWDNfnHCD3NaU64/bl7rCGJ/
 CSCqKjYzUYc9lfI8QPCSquHEzd1D7iWb+qNrjKtkzp8WDTMfRZIHo4b1CJUsfAJKXZYKX8DYQ
 OBtjMo/yN2L4DiaW62rXjxRRWWDjEsO+svBCh9ry/rjNRT8grO2SBmWlJYPecwydDDasEYVMy
 Msjh4DPE2nV/o2YLQOg9assW8SU6utW8CAyaCvpV/ibHxI6gSS49JFSg547c1XbyXugTfNXSG
 c+AdEXWtBgMilRTMkupHstWnCccmiA3g25AMi9Em1bak5L5xGUPMU5CfYNDRgZrVKKBfUWwny
 OeXT7cuaXQcbevf1G1paAjnKMKrm+hBTfPL
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.06.21 um 07:30 schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I was too quick with that "But yes, I agree with the issue in theory".
>>
>> Having thought about it some more I think you're wrong, it doesn't make
>> sense to use the API in the way you're suggesting.
>
> Sorry, I've read the message I am responding to a few times, but I
> couldn't tell what you are arguing against in the suggestion given
> earlier by Ren=C3=A9, which offered two possibile ways to consistently
> call display() with the number of things that we have DONE
> processing (not the number of things that we are about to touch) [*1*].

Same here.

Perhaps a demo helps.  The patch at the bottom adds an echo command to
the test helper.  This way we can intersperse the progress lines with
indications when items are processed.

So here's the pattern for calling display_progress at the top of the
loop and again with the number of items after the loop:

  $ (
    for i in 0 1 2
    do
      echo progress $i
      echo update
      echo echo WORK
    done
    echo progress 3
  ) | ./t/helper/test-tool progress --total 3 test 2>&1 | tr '\r' '\n'

  test:   0% (0/3)
  WORK
  test:  33% (1/3)
  WORK
  test:  66% (2/3)
  WORK
  test: 100% (3/3)
  test: 100% (3/3), done.

The progress lines reflect the number of finished items at all times.

Here's the pattern for display_progress at the bottom of the loop:


  $ (
    for i in 0 1 2
    do
      echo echo WORK
      echo progress $(( $i + 1 ))
      echo update
    done
  ) | ./t/helper/test-tool progress --total 3 test 2>&1 | tr '\r' '\n'

  WORK
  test:  33% (1/3)
  WORK
  test:  66% (2/3)
  WORK
  test: 100% (3/3)
  test: 100% (3/3), done.

Same here, the progress line shows the correct number of finished items.

Here's the pattern suggested in your patch:

  $ (
    for i in 0 1 2
    do
      echo progress $(( $i + 1 ))
      echo update
      echo echo WORK
    done
  ) | ./t/helper/test-tool progress --total 3 test 2>&1 | tr '\r' '\n'

  test:  33% (1/3)
  WORK
  test:  66% (2/3)
  WORK
  test: 100% (3/3)
  WORK
  test: 100% (3/3), done.

It reports one item too many in the intermediate progress lines and
is correct only at the very end.

Ren=C3=A9


diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe789..b6589f3878 100644
=2D-- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -65,6 +65,8 @@ int cmd__progress(int argc, const char **argv)
 			display_throughput(progress, byte_count);
 		} else if (!strcmp(line.buf, "update"))
 			progress_test_force_update();
+		else if (skip_prefix(line.buf, "echo ", (const char **) &end))
+			fprintf(stderr, "%s\n", end);
 		else
 			die("invalid input: '%s'\n", line.buf);
 	}

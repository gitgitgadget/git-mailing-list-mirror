Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DDBC43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGPQuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGPQuN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:50:13 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3064E1DA4D
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990203;
        bh=gsY7oqnL1tBJdOy3DC5y2HVEInO0CFyVG8kzLi9+3QA=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=ksSEPfqFSljz9pHz0RHR1AGvn8oNjgIHS0J28vKSCkXVGcefCbu1jYajGftDQPwP5
         jKmZfBxjDw4OzJPQ7aGnGKgN2W3UGgfaDe7N+GoNsiOL81HkIr7pY58Hy/O2y4LMUK
         YujDf256MLtbnniCVp2Q39ePrvhmWLWZ/vn15dkk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Euv-1oGJtP3Pyv-003nZA; Sat, 16
 Jul 2022 18:50:02 +0200
Message-ID: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Date:   Sat, 16 Jul 2022 18:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
X-Mozilla-News-Host: news://public-inbox.org:119
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 00/10] typed sort of linked lists
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bw1UOXqVvD1AuURE7H5zbbDjVKB/7+2eREPOgfUypiRi3jZaAJx
 dbluvevriTiP1cCq/5tkXAsId2kdMApMhXqWVMPhyQa3l7i+FDs2r4dZOD1mMTI06MRNoFW
 PWKBUhJ50Ii0zA8Sv/dTslKP60Y3nXOwxlQkmhrNy976pLmBoupnLTtNJJ2l2Wa6iEJ9Fg+
 viZbnbwWfazxnCugfUMqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WjrbK3nCUMU=:g/vNnZuMWUBTt+iGLRQOTh
 9W/re1exRUW6s1r578bSCd/nJ77/aDGJGWnjCFjVrEb42j9ujVkCMpt0BlFA2/Dq9Ywjq1wJw
 gjZInml3vWn9/GJa8cntImm2qP00KfVEb51SNbL6/MqrtHKFyLLgNsKXWugYG8j0PQeIVI5Qt
 RRqv/uO24WOIXUthdg5njsNRNsHmf1Z9vkRGnB0Co8WHAIc3wHe+2WA5jMRycAP1mQFD7mn82
 SSydtYHMh5oZsY3wnM11Lt6B+/xW4GWY6idpJkpLe38vi4ATxdcPyzGJMLFP2z5pqRHeOVPNH
 RVPBWvCTzuL7OKzOrZrxnw6UtJlnUZWO6sbMgUkfw14pzy9XzvSLycxXo98N47FSipb8jD7ah
 /RXzhMOlCjvakJtwxmtz8O0e7SF3sYeZRba1ELOoQcA+quCv8ZzhgmHPeikI7Wp1WDrV50XHz
 HFbAjKIm2UVaKxSJPBubYAK5IGdX+cCLQrBUZrsnqFcT6IwusjmBHehUe15198xZ2CYhZqPTp
 mgBOwbdLUTdrawAhOdKI6zIUdT/sEtlE61LAeS9J9wUkdTtWUGChHu1F0g7jkQHi00GT104c/
 JD+DQ5/tMeh2mJ/WGTSO5Kfc/4hiMhrADTtNAU7CbQ4nsz1iKq+r7Y91fswvQGfhSSlC8A6MG
 sr4lQz8XFZSsDntv05woDrm+aqNf2s6NtvHn+Ur2m5dB2zdmiEpuZCwf8CFa2RJsb0Qcuu54n
 Ogswh3GttQ41pQOF2PJgBKhKzBULcYaFn05lB4jbD2iW/CM61pD/NGKgBBHC/m9ImAexNjG6d
 gWeojwSzZRqAWAuK6N8CIFiuzbkHHp4aDlcAfA9lebKKUhVGb0v8OON8BQEkn7lHY7anHhNeG
 EfXOzg1ROvXYKGAh/fm1WreRmwD9lg4vKCIhiHgJnWwsveDCYmRXurYAIZZupPls9BBS1VTl+
 5DDGk/sAgVbcbPH9epn4Cc9ZhBoztkfUxCKpLVaz5J9e0UbjhqmN9rMFL7gsZIc0E6zVM5Jn8
 t1Ymi6kvVo6oS8OnMfritGZKjGJ3DRlOGAEqBeq97yfXfeFqgd2BUpL0BjLdLqFlOzTe4WbJb
 O+qx3XbZuV2WccOQHahWr6fbK2dDs84dzZh
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

llist_mergesort() is a function for sorting linked lists of any type
without any dynamic memory allocation.  It just requires the programmer
to define two accessor functions and doesn't need an embedded struct
or magic next pointer placement, which makes it relatively easy to use.

These accessor functions impose function call overhead and a barrier to
type checking.  This series aims to avoid that by giving the compiler
full type information and allow it to inline them.  Programmers don't
need to write the accessor functions anymore and get to use typed
comparison functions -- no more casts from void *.  Sorting gets a bit
quicker.  The cost: Increased binary size.

It starts by making llist_mergesort() leaner without reducing its
performance:

  mergesort: unify ranks loops
  mergesort: tighten merge loop

This matters for the next step, which creates the macro version of
that function:

  mergesort: add macros for typed sort of linked lists

The next two patches show the impact of using the macro on performance
and object text size of the test helper:

  test-mergesort: use DEFINE_LIST_SORT_DEBUG
  test-mergesort: use DEFINE_LIST_SORT

Then all llist_mergesort() callers get converted:

  blame: use DEFINE_LIST_SORT
  commit: use DEFINE_LIST_SORT
  fetch-pack: use DEFINE_LIST_SORT
  packfile: use DEFINE_LIST_SORT

... and the final patch removes the function which has become unused:

  mergesort: remove llist_mergesort()

 Makefile                  |   1 -
 blame.c                   |  30 ++++-------
 commit.c                  |  20 +++----
 fetch-pack.c              |   8 +++
 mergesort.c               |  84 -----------------------------
 mergesort.h               | 108 ++++++++++++++++++++++++++++++++++----
 packfile.c                |  18 ++-----
 remote.c                  |  22 --------
 remote.h                  |   2 -
 t/helper/test-mergesort.c |  34 +++---------
 t/perf/p0071-sort.sh      |   4 +-
 t/t0071-sort.sh           |   2 +-
 12 files changed, 134 insertions(+), 199 deletions(-)
 delete mode 100644 mergesort.c

=2D-
2.37.1

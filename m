Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83CF1202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 12:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbdJCMvO (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 08:51:14 -0400
Received: from mout.web.de ([212.227.17.12]:49809 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752249AbdJCMvN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 08:51:13 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MD8BU-1e77Ts1Cw8-00GVWE; Tue, 03
 Oct 2017 14:51:08 +0200
Subject: Re: [PATCH] tag: avoid NULL pointer arithmetic
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <20171003102215.9952-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
Date:   Tue, 3 Oct 2017 14:51:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171003102215.9952-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:oeP3R/r8czI27d1O8yEduNB+PJVlMfv3LT0j5sy0sIwSSsSiLWM
 wkGug218OChhEOB4H6VefNzq8BpDpNqnXO9avvet59JTiDHbMwHcuow6mrJxOYto3elfK+A
 bIHCGIp2cUOLn9PNw/iHQ6fwhEzVVmsMP4cxedSNqvEYUYThqBQJKLNetc+vxiAfnbTDzPl
 owNrVDSDbzoAd5+IuJpdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JYUtAwFSGsU=:wL+NbAXH4ZgdoVN7NBIsMd
 h0Q4GQj5PcG+HhU9fepeimqGV6iQwhRP0kuj1PkvCTHnyncfVfVTWuaOhtHo1t+y+JCUw+z9s
 Rq9DynmWLDfZVlPtqtjB4SvnYg5gY/GF+MQtrgq8EJa8UbDGuUnAcbSkUbRWFEPoUqDv81Mj7
 f6562l8CpGL4rjGqPVgl9b38N7DtauN4bXeGWd9OZK2nsile95CiOquw7AxxcwAt1d9PR4Han
 Pu6Hj7tBlTJZGp0SdazJm7SpbyFh7gkpFo0cmyzH5m7euN2wEtttwqkrlurgX8Jop1oy/DU/d
 hvfqCIwja+jN68uhcHw0lVEjQlzeTHt5q9yi05vii4DOhRrSQtSFOtBTLLnzRP16hK0j5XbsD
 OBMC822HZw4Dh1f3qdaB7kNem7oypMCOgW+cqHRCYXbS/8wkucyDs6iJLGJy8mw9UpTY8awoG
 nqjk5lupwq2Oh8HfTzeaPUoN4kHS30DfGwnZqEi3iO6vLO6V4VRDcRIKMN/YUMzWz9PGMHnym
 PmgNiJSHJpRCq/PQXxg09nWfKuy15rPHqV9P8V2LaawXaCpr6LlqUhCVAWyxTCOFgcr1951UF
 X02TBw1wsb3LQ56JpYMPgMoBNUTCKeuJbfmQ9BPM/E9rw06NRyc2rRRz1smZFao8kQBeDctjS
 YPP3QXyfkB7XGGw+j62trJcHpDUWOCtDSJq1N0v95M1cOd+PzKNXbkRSDO9RaU4eD9O8bzSZO
 buXNI+JQNOgq7c1mO6vOr+QRqDDDbO+pE8LCc/B3/WvLOhj8wFJaG+CCF4nsrPLGBL7Hz05aS
 Twq5Mf9YITQmPO29x/zWja22zIl3vX4ft9Xbo2oAeJOFkkCrIU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2017 um 12:22 schrieb SZEDER Gábor:
>> lookup_blob() etc. can return NULL if the referenced object isn't of the
>> expected type.  In theory it's wrong to reference the object member in
>> that case.  In practice it's OK because it's located at offset 0 for all
>> types, so the pointer arithmetic (NULL + 0) is optimized out by the
>> compiler.  The issue is reported by Clang's AddressSanitizer, though.
>>
>> Avoid the ASan error by casting the results of the lookup functions to
>> struct object pointers.  That works fine with NULL pointers as well.  We
>> already rely on the object member being first in all object types in
>> other places in the code.
> 
> This sounds like the main goal of the patch is to avoid an ASan error,
> but I think it's more important to avoid (and to be more explicit
> about avoiding) the undefined behavior.  I.e. along the lines of
> s/In theory it's wrong/It's undefined behavior/ and
> s/ASan error/undefined behavior/

You are probably right, but I struggle to pin down the difference.  Another
try: Adding zero to a NULL pointer is undefined, but is either optimized
out or has no effect.  That's why the code doesn't crash without ASan and
UBSan.  Relying on undefined behavior is wrong nevertheless, so let's stop
doing it.

> Furthermore, fsck.c:fsck_walk_tree() does the same "immediately
> reference the object member in lookup_blob()'s and lookup_tree()'s
> return value" thing.  I think those should receive the same treatment
> as well.

Hmm, are put_object_name() and all the walk() implementations ready for
a NULL object handed to them?  Or would we rather need to error out
right there?  Other suspicious places in this regard are (at least):
builtin/merge-tree.c, cache-tree.c, http-push.c, list-objects.c,
merge-recursive.c, and shallow.c. :-/

René

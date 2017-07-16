Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153382027C
	for <e@80x24.org>; Sun, 16 Jul 2017 15:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdGPPXL (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 11:23:11 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:10634 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbdGPPXK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 11:23:10 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id WlO0dtc4fQ527WlO0dR3D2; Sun, 16 Jul 2017 16:23:08 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=NEAV23lmAAAA:8 a=5rxgeBVgAAAA:8 a=7Z7lRQPynSVTmlnBxFoA:9 a=wPNLvfGTeEIA:10
 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <C299C45128634A21AF9D65E1B2B52C5B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jonathan Tan" <jonathantanmy@google.com>, <git@vger.kernel.org>
Cc:     "Jonathan Tan" <jonathantanmy@google.com>,
        "Ben Peart" <peartben@gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
Subject: Re: [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing blobs")
Date:   Sun, 16 Jul 2017 16:23:06 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170716-0, 16/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDJvLPni0qqo2H3vEU7T9PHpdxYS4cEIABnoq7l2JcblepGX/JWa3IBtaQzgBct6/IcKCIRw7MLK1Rj+cZ2srj0i2xVzQRsy85Lrn98AOhCnieAbz2/x
 QVhCSJS36/rDuysAeg/QBbmAGzeLdl+d4C7tKm+JfLJ2RKBc00HP73SW9kyjaDNSHIa+gLy4P40pERQKruohWOVeWla5zZHfk9opHJL2cA8w8Kcn2E2AITW2
 Bk2KUxV7w+Q6R708V6LATNK8OuR7HGc5xK1D9rixOjY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jonathan Tan" <jonathantanmy@google.com>
Sent: Tuesday, July 11, 2017 8:48 PM
> These patches are part of a set of patches implementing partial clone,
> as you can see here:
>
> https://github.com/jonathantanmy/git/tree/partialclone
>
> In that branch, clone with batch checkout works, as you can see in the
> README. The code and tests are generally done, but some patches are
> still missing documentation and commit messages.
>
> These 3 patches implement the foundational concept - formerly known as
> "missing blobs" in the "missing blob manifest", I decided to call them
> "promised blobs". The repo knows their object names and sizes. It also
> does not have the blobs themselves, but can be configured to know how to
> fetch them.
>
If I understand correctly, this method doesn't give any direct user 
visibility of missing blobs in the file system. Is that correct?

I was hoping that eventually the various 'on demand' approaches would still 
allow users to continue to work as they go off-line such that they can see 
directly (in the FS) where the missing blobs (and trees) are located, so 
that they can continue to commit new work on existing files.

I had felt that some sort of 'gitlink' should be present (huma readable) as 
a place holder for the missing blob/tree. e.g. 'gitblob: 1234abcd' (showing 
the missing oid, jsut like sub-modules can do - it's no different really.

I'm concerned that the various GVFS extensions haven't fully achieved a 
separation of concerns surrounding the DVCS capability for on-line/off-line 
conversion as comms drop in and out. The GVFS looks great for a fully 
networked, always on, environment, but it would be good to also have the 
sepration for those who (will) have shallow/narrow clones that may also need 
to work with a local upstream that is also shallow/narrow.

--
Philip
I wanted to at least get my thoughts into the discussion before it all 
passes by.

> An older version of these patches was sent as a single demonstration
> patch in versions 1 to 3 of [1]. In there, Junio suggested that I have
> only one file containing missing blob information. I have made that
> suggested change in this version.
>
> One thing remaining is to add a repository extension [2] so that older
> versions of Git fail immediately instead of trying to read missing
> blobs, but I thought I'd send these first in order to get some initial
> feedback.
>
> [1] 
> https://public-inbox.org/git/cover.1497035376.git.jonathantanmy@google.com/
> [2] Documentation/technical/repository-version.txt
>
> Jonathan Tan (3):
>  promised-blob, fsck: introduce promised blobs
>  sha1-array: support appending unsigned char hash
>  sha1_file: add promised blob hook support
>
> Documentation/config.txt               |   8 ++
> Documentation/gitrepository-layout.txt |   8 ++
> Makefile                               |   1 +
> builtin/cat-file.c                     |   9 ++
> builtin/fsck.c                         |  13 +++
> promised-blob.c                        | 170 
> +++++++++++++++++++++++++++++++++
> promised-blob.h                        |  27 ++++++
> sha1-array.c                           |   7 ++
> sha1-array.h                           |   1 +
> sha1_file.c                            |  44 ++++++---
> t/t3907-promised-blob.sh               |  65 +++++++++++++
> t/test-lib-functions.sh                |   6 ++
> 12 files changed, 345 insertions(+), 14 deletions(-)
> create mode 100644 promised-blob.c
> create mode 100644 promised-blob.h
> create mode 100755 t/t3907-promised-blob.sh
>
> -- 
> 2.13.2.932.g7449e964c-goog
> 


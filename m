Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949612090A
	for <e@80x24.org>; Mon, 20 Mar 2017 21:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754858AbdCTVjQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 17:39:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62846 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754711AbdCTVjP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 17:39:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD30E80CDC;
        Mon, 20 Mar 2017 17:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=E
        O4NrqkWKC6sJS/YDkHdfGkQQ7k=; b=gYC9WZ+tlJ/MVSXgp9MCjlycam78PpeQn
        aOXzwb7dFa6LTuMWfmGod6klkhwbxytEmcJm6Fi9NlpdUErKJVEFIycy7fDv1ph2
        qnv4yGZCDWhDQL94fLEhLtR9Pcenjvp19rqoQC5UK1hafSCE7InzBg6ab6T4v3He
        QqmNJJaliU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=WIe9+xHBH5Q0lZ5QYD4etqauIhtALqy3sBmPmaJ4AE6vJ6WZl2J6u3IL
        taMexklJkXPyf8XAg8zutlXPFUdsCE6iLDBYjzeoj1nxSb/Um2dVecIHdZU71WCX
        YDMjQ66b3JPaF1mjoxsu80T0MT0aNVtMSrvZC/H+QfRGuo3ElMg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C56AF80CDB;
        Mon, 20 Mar 2017 17:39:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2431180CD7;
        Mon, 20 Mar 2017 17:39:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.12.1
Date:   Mon, 20 Mar 2017 14:39:11 -0700
Message-ID: <xmqqzigftyps.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8E093DC-0DB5-11E7-95FC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.12.1 is now available at
the usual places.

The tarballs are NOT YET found at:

    https://www.kernel.org/pub/software/scm/git/

but hopefully will be in a few days (I am having trouble reaching
there).

The following public repositories all have a copy of the 'v2.12.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.12.1 Release Notes
=========================

Fixes since v2.12
-----------------

 * Reduce authentication round-trip over HTTP when the server supports
   just a single authentication method.  This also improves the
   behaviour when Git is misconfigured to enable http.emptyAuth
   against a server that does not authenticate without a username
   (i.e. not using Kerberos etc., which makes http.emptyAuth
   pointless).

 * Windows port wants to use OpenSSL's implementation of SHA-1
   routines, so let them.

 * Add 32-bit Linux variant to the set of platforms to be tested with
   Travis CI.

 * When a redirected http transport gets an error during the
   redirected request, we ignored the error we got from the server,
   and ended up giving a not-so-useful error message.

 * The patch subcommand of "git add -i" was meant to have paths
   selection prompt just like other subcommand, unlike "git add -p"
   directly jumps to hunk selection.  Recently, this was broken and
   "add -i" lost the paths selection dialog, but it now has been
   fixed.

 * Git v2.12 was shipped with an embarrassing breakage where various
   operations that verify paths given from the user stopped dying when
   seeing an issue, and instead later triggering segfault.

 * The code to parse "git log -L..." command line was buggy when there
   are many ranges specified with -L; overrun of the allocated buffer
   has been fixed.

 * The command-line parsing of "git log -L" copied internal data
   structures using incorrect size on ILP32 systems.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.12.0 are as follows:

Allan Xavier (1):
      line-log.c: prevent crash during union of too many ranges

Jeff Hostetler (1):
      mingw: use OpenSSL's SHA-1 routines

Jeff King (3):
      http: restrict auth methods to what the server advertises
      http: add an "auto" mode for http.emptyauth
      add--interactive: fix missing file prompt for patch mode with "-i"

Johannes Schindelin (3):
      Travis: also test on 32-bit Linux
      t1501: demonstrate NULL pointer access with invalid GIT_WORK_TREE
      real_pathdup(): fix callsites that wanted it to die on error

Jonathan Tan (1):
      http: attempt updating base URL only if no error

Junio C Hamano (2):
      Preparing for 2.12.1
      Git 2.12.1

Maxim Moseychuk (2):
      stop_progress_msg: convert xsnprintf to xstrfmt
      bisect_next_all: convert xsnprintf to xstrfmt

Vegard Nossum (1):
      line-log: use COPY_ARRAY to fix mis-sized memcpy


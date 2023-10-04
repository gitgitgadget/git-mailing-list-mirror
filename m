Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B3E8FDC4
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 01:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbjJDBVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbjJDBU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 21:20:57 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B4B7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 18:20:54 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44804)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qnqZH-00GFFI-6x; Tue, 03 Oct 2023 19:20:51 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42902 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qnqZG-001iaB-2H; Tue, 03 Oct 2023 19:20:50 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Eric W. Biederman" <ebiederm@gmail.com>
References: <xmqqedic35u4.fsf@gitster.g>
Date:   Tue, 03 Oct 2023 20:20:24 -0500
In-Reply-To: <xmqqedic35u4.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        02 Oct 2023 17:30:43 -0700")
Message-ID: <875y3n4207.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qnqZG-001iaB-2H;;;mid=<875y3n4207.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18BkgQ7r/mt6OE58U0EBjOcqdJ9f1Gu+lQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * eb/hash-transition (2023-10-02) 30 commits
>  - t1016-compatObjectFormat: add tests to verify the conversion between objects
>  - t1006: test oid compatibility with cat-file
>  - t1006: rename sha1 to oid
>  - test-lib: compute the compatibility hash so tests may use it
>  - builtin/ls-tree: let the oid determine the output algorithm
>  - object-file: handle compat objects in check_object_signature
>  - tree-walk: init_tree_desc take an oid to get the hash algorithm
>  - builtin/cat-file: let the oid determine the output algorithm
>  - rev-parse: add an --output-object-format parameter
>  - repository: implement extensions.compatObjectFormat
>  - object-file: update object_info_extended to reencode objects
>  - object-file-convert: convert commits that embed signed tags
>  - object-file-convert: convert commit objects when writing
>  - object-file-convert: don't leak when converting tag objects
>  - object-file-convert: convert tag objects when writing
>  - object-file-convert: add a function to convert trees between algorithms
>  - object: factor out parse_mode out of fast-import and tree-walk into in object.h
>  - cache: add a function to read an OID of a specific algorithm
>  - tag: sign both hashes
>  - commit: export add_header_signature to support handling signatures on tags
>  - commit: convert mergetag before computing the signature of a commit
>  - commit: write commits for both hashes
>  - object-file: add a compat_oid_in parameter to write_object_file_flags
>  - object-file: update the loose object map when writing loose objects
>  - loose: compatibilty short name support
>  - loose: add a mapping between SHA-1 and SHA-256 for loose objects
>  - repository: add a compatibility hash algorithm
>  - object-names: support input of oids in any supported hash
>  - oid-array: teach oid-array to handle multiple kinds of oids
>  - object-file-convert: stubs for converting from one object format to another
>
>  Teach a repository to work with both SHA-1 and SHA-256 hash algorithms.
>
>  Breaks a few CI jobs when merged to 'seen'.
>  cf. <xmqqbkdmjbkp.fsf@gitster.g>

I see that you have picked up the v2 version.  Thank you.

I pushed v2 out precisely because it contains fixes that should have
fixed all of the CI breakages.

I am not really familiar with github but looking at the recent CI runs
it appears since v2 landed the seen branch has been building cleanly.

I haven't misread something have I?

I just don't want people to avoid reviewing it because it is that huge
patchset that causes problems in seen.

Eric



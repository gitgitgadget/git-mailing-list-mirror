Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E10820A17
	for <e@80x24.org>; Mon, 16 Jan 2017 23:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdAPXRs (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 18:17:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50702 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751624AbdAPXRr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 18:17:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DEB761C71
        for <git@vger.kernel.org>; Mon, 16 Jan 2017 18:17:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=C
        mg1UxXp/ZVB+9128nmdSuQU3Do=; b=MWxSIjUL+IRCrA3VFTQnsV1P5ZMa7BSWL
        HPosfXZAGJtoySpmwchRAvs5TARZr6rPClF+TtS3RLRIs1mQrIX8s5RO/xmDSzOG
        F4LDXywIopATc4zkloPzjddeUX3Nv+HX71LCthtI/hK/wtuu5cKUMSaeLX9CJYxm
        IeDSWEIZaE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13D4761C70
        for <git@vger.kernel.org>; Mon, 16 Jan 2017 18:17:33 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6904661C6F
        for <git@vger.kernel.org>; Mon, 16 Jan 2017 18:17:32 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Subject: HEAD's reflog entry for a renamed branch
X-Attribution: Kyle
Date:   Mon, 16 Jan 2017 18:17:29 -0500
Message-ID: <87pojmwq5y.fsf@kyleam.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5195860-DC41-11E6-B7D0-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=mesmtp;
 bh=Cmg1UxXp/ZVB+9128nmdSuQU3Do=;
 b=rASCEd3VOHeSTUqLhaudyY3nsuq/Y8XhQITodGd8MbEXbCb2N64XG1MoA6+NoKVpZe9nY1w7IEo2q0QzmIfthL+wjfIVn6vDp05HLhnbQunP/tqhmMkRdq/sJ5MAT7EqV4e9b4F2M19SXlmEekOEHeKMu+ujT8EXecBdCplGlkc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I noticed that, after renaming the current branch, the corresponding
message in .git/logs/HEAD is empty.

For example, running

    $ mkdir test-repo
    $ cd test-repo
    $ git init
    $ echo abc >file.txt
    $ git add file.txt
    $ git commit -m"Add file.txt"
    $ git branch -m master new-master

resulted in the following reflogs:

   $ cat .git/logs/refs/heads/new-master
   00000... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	commit (initial): Add file.txt
   68730... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	Branch: renamed refs/heads/master to refs/heads/new-master

   $ cat .git/logs/HEAD
   00000... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	commit (initial): Add file.txt
   68730... 00000... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500

I expected the second line of .git/logs/HEAD to mirror the second line
of .git/logs/refs/heads/new-master.  Are the empty message and null sha1
in HEAD's entry intentional?

--
Kyle

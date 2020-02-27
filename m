Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32579C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C46246A0
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oUfhUNpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgB0QKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:10:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57739 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgB0QKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 11:10:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E98642760;
        Thu, 27 Feb 2020 11:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c/ZhtOz56IteI25njGd3rvT6qWc=; b=oUfhUN
        ppbkW6L8akkyDXEdOqM4RCA31GxZJ492f0hGPWYr5vO5UTu/FaxnXQlTkLuDRVAi
        lbsZ94/ojrkDQJg9IKGiRP9GMFS00i6/OoJVazhFrYHgeE+e8IRhL+xJDiPDHh4j
        NnFJkbidvmusMa3C0ap/XDMg+EsveDq6kMHY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=INGHtk7san6Zn3m1D7cV6+QTWjXu9Z6x
        QqPxsUZ4+VxbHlX2re7Y1fryJArU13E7ebjeTRciH10fTttXhy/1Z3VXK9BT9QPJ
        Fol7LVEAYdpGiGgIHRLrLIyeU2bQvDbNZTeJrctL6UiLAj0dYCDHoTIhWgOCb8KD
        7cijxhi6Wec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46F3C4275E;
        Thu, 27 Feb 2020 11:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D98C4275D;
        Thu, 27 Feb 2020 11:10:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-remote: don't use '-h' for options
References: <b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl>
        <20200227130833.GA10339@danh.dev>
        <03985e4099e82f04709d5ea9ca2a56a6@pascalroeleven.nl>
Date:   Thu, 27 Feb 2020 08:10:20 -0800
In-Reply-To: <03985e4099e82f04709d5ea9ca2a56a6@pascalroeleven.nl> (Pascal
        Roeleven's message of "Thu, 27 Feb 2020 15:10:17 +0100")
Message-ID: <xmqqa754gger.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7A3C678-597B-11EA-B6B8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pascal Roeleven <dev@pascalroeleven.nl> writes:

> In my case I looked into the documentation, used '-h' exactly as
> described ('<refs>' is optional) and it didn't produce the output as
> described. If you ask me, either the code or the documentation should
> be changed.

Yeah, I tend to agree that documentation could be better.  

You may think that nobody would ask your opinion, but proposing a
change by sending a patch often makes you heard around here ;-)

Thanks.

-- >8 --
Subject: [PATCH] Documentation: clarify that `-h` alone stands for `help`

We seem to be getting new users who get confused every 20 months or
so with this "-h consistently wants to give help, but the commands
to which `-h` may feel like a good short-form option want it to mean
something else." compromise.

Let's make sure that the readers know that `git cmd -h` (with no
other arguments) is a way to get usage text, even for commands like
ls-remote and grep.

Also extend the description that is already in gitcli.txt, as it is
clear that users still get confused with the current text.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-remote.txt | 4 +++-
 Documentation/gitcli.txt        | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index a2ea1fd687..0a5c8b7d49 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -28,7 +28,9 @@ OPTIONS
 	Limit to only refs/heads and refs/tags, respectively.
 	These options are _not_ mutually exclusive; when given
 	both, references stored in refs/heads and refs/tags are
-	displayed.
+	displayed.  Note that `git ls-remote -h` used without
+	anything else on the command line gives help, consistent
+	with other git subcommands.
 
 --refs::
 	Do not show peeled tags or pseudorefs like `HEAD` in the output.
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 373cfa2264..92e4ba6a2f 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -126,6 +126,11 @@ usage: git describe [<options>] <commit-ish>*
     --long                always use long format
     --abbrev[=<n>]        use <n> digits to display SHA-1s
 ---------------------------------------------
++
+Note that some subcommand (e.g. `git grep`) may behave differently
+when there are things on the command line other than `-h`, but `git
+subcmd -h` without anything else on the command line is meant to
+consistently give the usage.
 
 --help-all::
 	Some Git commands take options that are only used for plumbing or that

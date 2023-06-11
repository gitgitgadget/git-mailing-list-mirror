Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F162C83005
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjFKSRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKSRR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:17:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0CAC
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:17:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 80A5C3200657;
        Sun, 11 Jun 2023 14:17:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 11 Jun 2023 14:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1686507432; x=1686593832; bh=SLUBLYVI3thgCeKRj21Q+mvDh
        3N58ReHLSvcn5oCHzI=; b=m0s2AaLxAjresaVBACUn6oD1CgfwROZX6XBhqSz3t
        v3+NMSyKXb2CP7sb2PIbXonjFNuXpkaGmCE0HryOkbnsmaZCoHu6OGdYPyJzF1bF
        JRVUijhOg61y4FGPXMqRU2SKhGQoN32773IbwouQYQ8Fp69a9L62GERWC8D2ve9P
        cU1oH+o2h8LfoyVd369VcBdLPOkSUm3NwR07K8k1i7JAkC6cpmgg+Lo3vMVdPfPT
        ZvppdGO2is/TlAcazMs7EyyLGZDZDr6p1u95krGNywZgU5tNeoQpLnFLw+u978bD
        AidwGufjdjYfCa6LHfeFazHj5URi959BsMdPlPPiPYj7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686507432; x=1686593832; bh=SLUBLYVI3thgCeKRj21Q+mvDh3N58ReHLSv
        cn5oCHzI=; b=DezGgZzDN8G1vgK27Zc9TU4bKwmmzqhxx97n41HVkoVSo3bzQwD
        js/KA3cS/iN7sACymCjUzzChjXXU9+Q1fE8F10nt9nkGbIORmatP9vqmLcdF/x7z
        dyhRq6PgxPOT9G0AzdG7GipV8qNh4AJfwi/TSGSy49D/fzurnwptHndOTs0dIsoe
        6EhN8qf5yEuQjMN+4Z7ji3p8cVCxWdzJH4z1ts6XWTZSM0CosdHrphzatGCBgof5
        GKoRVlHzhQkagIPGK6t2aDCfKZcDM6Q4Azmxtnc6kcQL2KJFpoCnmDYykPmzWtMG
        94ob09dNFOMi1rsqUvQ9NlpuffL6eXjeeIA==
X-ME-Sender: <xms:pw-GZOfm6zHhkgF37tMlnRCr-8dkch0bdsETzgp7PD_DaXmUbujHsqQ>
    <xme:pw-GZIP2zqmNRl0wpxR5pjDTz2iphUOlL2eV2f1cWRR1IOT0wMXF9jBqenxrhhPqg
    cQxPZmMWTCeANTHbA>
X-ME-Received: <xmr:pw-GZPj_vBBUyStCAHUrZQIyigqBkUHx9xmOapd3GoYN-BFX6mw_Yl5O9INm8Th02zAh1ch1KKyq0Gtf810fe2d3goLgAtfxk0kX40w8N647HapfbVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuieeuffeuffethffhfeellefhueehteet
    tdehveegjeethefgveffuefggfelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:pw-GZL849TuHN0ePl-DTcynbEzshwt0elQSiJvzoKGiRT1-PH35JTA>
    <xmx:pw-GZKuHvAbJV04Jzg_ZetulrfylYa2onVUCnjOLudK5-o4UF1yFlQ>
    <xmx:pw-GZCECtBxEgjDWasfhxC00jblt0grCzWWikve56HEAEdfvredG1A>
    <xmx:qA-GZOIq9DP8UykJWfP0qwrhwb5N6IN-rWUOiEJ9R0qNcmH8dOI32A>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jun 2023 14:17:10 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 0/3] range-diff: treat notes like `log`
Date:   Sun, 11 Jun 2023 20:15:53 +0200
Message-ID: <cover.1686505920.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1685441207.git.code@khaugsbakk.name>
References: <cover.1685441207.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first normal (not RFC) version of this series. The following
cover letter is identical to the previous one up to but not including
section “RFC and version 1”.

Cheers

🙛 🙙

Currently, `range-diff` shows the default notes if no notes-related
arguments are given. This is also how `log` behaves. But unlike
`range-diff`, `log` does *not* show the default notes if
`--notes=<custom>` are given.

These changes are supposed to make `format-range` behave like `log` with
regards to notes.

These changes also fixes an issue with notes being shared in the cover
letter via `range-diff`, and that’s really the main motivation for
making these changes.

§ How `log` works

`log` shows the default notes if no notes arguments are given. But if
you give it specific notes to show then it forgets about the default
notes. Further, there is the convenience `--notes` option which will
show the default notes again. These options are cumulative. For example:

    git log --notes --notes=custom

Will show the default notes as well as the `custom` notes.

See discussion in: https://lore.kernel.org/git/20110329143357.GA10771@sigill.intra.peff.net/

§ How `range-format` works

`range-format` passes `--notes` to `log`, which means that it does not
have the default behavior of `log` (forget the default logs if you say
e.g. `--notes=custom`). However, the man page says that (under
`--[no-]notes[=<ref>]`):

> This flag is passed to the git log program (see git-log(1)) that generates the patches.

This makes me (at least) think that `range-format` is supposed to work
just like `log` with regards to notes.

§ `format-patch` and the difference between showing and sharing

`format-patch` has a different default: it shows no notes. This makes
sense in my opinion since `format-patch` is meant to be used to share
changes with others, and you might be surprised if your notes (which
might have only been notes to yourself) are sent out in your emails
(keep in mind that notes refs are *not* pushed by default).

But the slightly faulty behavior of `range-diff` bleeds through to
`format-patch` since the latter calls the former; if you have default
notes they can be shared in the range-diff on the cover letter, even
though `format-patch` isn’t supposed to show them.

§ Code layout and approach to the problem

As I’ve said, my focus was on fixing `format-patch`, so I’ve considered
how `format-patch` calls `range-diff` which in turn calls `log`.

`format-patch` is a command which is defined in `builtin/log.c`. For
notes in particular it in fact has some explicit logic for handling
notes based on the value of `rev`. (There seems to be no issues with
this part of the code; only the code in `range-diff.c` which passes the
default argument to `log`.) It then calls
`range-diff.c:show_range_diff`. That function on `master` loads some
default arguments, among them `--notes`. It then eventually calls `log`
as a subprocess.

My change consists of co-opting the deprecated `--standard-notes` and
changing its behavior so that it can be used in
`range-diff.c:show_range_diff`.

Using a special switch/option was the only way I found in order to fix
this problem.

I could have also created a new option but I thought that doing a
smaller change initially would be better.

§ RFC and version 1

The previous sendout was an RFC. There are no changes since the RFC.

The series was rebased on `v2.41.0`.

Kristoffer Haugsbakk (3):
  range-diff: treat notes like `log`
  doc: pretty-options: remove documentation for deprecated options
  revision: comment `--no-standard-notes` as deprecated

 Documentation/pretty-options.txt |  1 -
 range-diff.c                     |  2 +-
 revision.c                       |  8 ++++++--
 t/t3206-range-diff.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

--
2.41.0

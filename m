Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D9E202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 21:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdJ2VT0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 17:19:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55672 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751666AbdJ2VTZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 17:19:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 90EA06044A
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509311962;
        bh=v5LMh8hNI5AJeFotyeDzJR/oYWuvNCOKVcYZtLJjzZQ=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Yn6pbHnGIKmzKwl7dpxwBcfQIlvMxLZdX5nWoDxOnTrvYkxDO4cSKxLe4na14RTyb
         vOwzuiUbJUsh09lwXtsariKWpeYcTyPonp4E1UhQOhUon3g5G/VP76xvQLrU/lenTz
         5LBzhtS+Abw2V6VS27ABDTksEaoCBHJyMYuqKtCWam0xdh8yYfzs64vszzHaSbkQEM
         pLNwaL7IqLbCoO80Nq/XKn6zjDVwiJ15CJTMW9lFryu9X72YI+8ny7W8zEGfmEFWOg
         RxFpjKlvUQn6nKPmnSH+jNHTar+RPOXsB2QsVJRSMvdAaQb9nlXp/mGrRKzIiVE4CT
         x19/Gv2y98uLwHSApHUPq6O5sr6Y0hKQcKrDQfAnem3LEcSZqZjwgi8JnwfIGxxAht
         rWNEGqINLTiWu/qxfZO6qx54yVK3iItCoPEt8WeOuHC0IEWAJG/oJ8SFyYIcFXn5O/
         PXB0vZP1UuzOUwtzEDpiYsD+ZYwMNGkGlegdPNxhTz8nIC5ZEYX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] Convert SubmittingPatches to AsciiDoc
Date:   Sun, 29 Oct 2017 21:13:06 +0000
Message-Id: <20171029211308.272673-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc2.357.g7e34df9404
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series converts SubmittingPatches into AsciiDoc and builds it as
part of the technical documentation.  The goal is to provide a format
that is more easily linkable both from our website and by others, as the
Git Project's patch submission standards are widely referenced and used
as examples.

The decision of what anchors to provide was mostly a matter of judgment,
but as a rule, I provided anchors to anything I've seen referenced in
blog posts or other coding standards.  Opinions on my anchor names are
welcome.

As explained, I preferred to avoid renaming SubmittingPatches since it's
referred to in so many places, including our own website.  If the list
decides that it's better to just rename, I can do that; it does simplify
the patch somewhat.

The documentation has been tested with both AsciiDoc and Asciidoctor and
looks and functions fine either way.  (I normally use Asciidoctor, but
did test both.)

The first patch is a bridge to help AsciiDoc and Asciidoctor
compatibility.  It enables Asciidoctor's compatibility mode, which
currently has no effect on our codebase[0].  I wrote it thinking that I
would use the AsciiDoc curly quote syntax, but realized that we use the
plain ASCII version everywhere.  It can be kept or dropped, but I hope
that it might avoid some future compatibility issues down the line.  I
had intended to add it originally when writing the USE_ASCIIDOCTOR
support, but it slipped my mind.

I will admit that this series benefits me personally, as I do want to
link to our docs in this way, but I've seen other people want to as
well, and I feel that helping people find documentation on writing
better commit messages and such would be beneficial for the open source
community as a whole.

I expect to be sending a series on top of this one that provides support
for reproducible builds when built with a suitable version of
Asciidoctor.

[0] Running "make clean && make html" results in no changes to the
Documentation directory outside of the change to the Makefile itself.

brian m. carlson (2):
  Documentation: enable compat-mode for Asciidoctor
  Documentation: convert SubmittingPatches to AsciiDoc

 Documentation/.gitignore        |   1 +
 Documentation/Makefile          |   6 +
 Documentation/SubmittingPatches | 331 +++++++++++++++++++++-------------------
 3 files changed, 184 insertions(+), 154 deletions(-)

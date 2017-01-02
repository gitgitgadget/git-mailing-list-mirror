Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08362205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756254AbdABQEM (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:04:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:50296 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756234AbdABQEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:04:09 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXqaN-1c2nAX0fWJ-00WpT9; Mon, 02
 Jan 2017 17:04:06 +0100
Date:   Mon, 2 Jan 2017 17:04:05 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] giteveryday: unbreak rendering with AsciiDoctor
In-Reply-To: <cover.1483373021.git.johannes.schindelin@gmx.de>
Message-ID: <c3b21bbec96408c4d6698129fd336c24c9e2f0f0.1483373021.git.johannes.schindelin@gmx.de>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ymBtQeDogXL9GbK6eeMJBTfZDp/L2h/rAR/uTnmRel66a8mJdCG
 LdsgH28+vlwiRi2FddU5ulWBy6QRNFJsrNW1/Q2pPizj7FwP4IAWRrV7SQNXR5iWA8mV2Jt
 K203mh8PiyHNi59KEJa4hZHf3pFqIQH8Obt1DHCCXDNBCuej+JkbOFt1nz6Hs6FtHM6tmZp
 zZjh/aoat8tOMPXYxwnFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GDqpCmJRNho=:5CJKg7l/li00dEvW1/fPOO
 Rfh07k8BuH/aUXvZSqvOHtSC1eJVQVGIxj/hx/Uv3gRgi4WY/8DigIrI4PricAF6G3C3xN4mC
 5kLx5SJLAwaNjkPQ1klpQGh0ta53ygWwYxnnwkD9WhX7xDjr0oi2YZTW8qPBQBlWe4xfze1Kj
 L1Wzd+yIMy89cJavvkOqJ3F4z9Viey+9ldwzsIqpMAD3ouw6Jz7YOaVTVNTH1u0gra7z5I2mw
 mtsTF0ZLbEN50g3MEBVk+y3XXJEn0uaTpCdYrylnC4boqvfjrtIX+5RixR4rR3p1uCcX7/Dip
 ki8WiB6hnn9ugaeAsJAgNHViI6MhhCwzW/Kw8C7zIkPcU6j40vZ5qvL5cH8reilkUcxXL5jjN
 4l7qudpCeDNzT5xhRk/hvoQ91LznZi4EbG3KhBffwq7HLB2CKhoNwrz38HtpHxDhGvO5qSkbZ
 e+6ytkJaSA4FhyVpXHsPtsGlJfD5z2DHf6ma8d+1eOPksHKlAupbvrl+9tSBK3jvyUrx4xK0A
 fgxD5CZqa7n2URAGxAYXnCV6rDbD9wADC8SJ8oppfZsIcigIT6dPOV2M/O2oubsVw/I/1jdkx
 D1QeGtU8pdmJb++ftvp0i05FQTHUqrlnsbrORWwNIgCh4KHSqo1GKWBis9469B2WtXgQoLc2r
 m7bGYLTqmzcu7cHhSJn/2kYLJz4g5Pcx3jbb+nepmRwvyoFS3r44BPlczeWmWVUWUpDOft7kz
 E2chIDqckv3DiLMql4YvnESwLhyk0ByktlJFEfYHn8L4L6kN3hB+4u9SSWn3KB69nUzLCJREm
 0QOnSDz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "giteveryday" document has a callout list that contains a code
block. This is not a problem for AsciiDoc, but AsciiDoctor sadly was
explicitly designed *not* to render this correctly [*1*]. The symptom is
an unhelpful

	line 322: callout list item index: expected 1 got 12
	line 325: no callouts refer to list item 1
	line 325: callout list item index: expected 2 got 13
	line 327: no callouts refer to list item 2

In Git for Windows, we rely on the speed improvement of AsciiDoctor (on
this developer's machine, `make -j15 html` takes roughly 30 seconds with
AsciiDoctor, 70 seconds with AsciiDoc), therefore we need a way to
render this correctly.

The easiest way out is to simplify the callout list, as suggested by
AsciiDoctor's author, even while one may very well disagree with him
that a code block hath no place in a callout list.

*1*: https://github.com/asciidoctor/asciidoctor/issues/1478

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/giteveryday.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 35473ad02f..10c8ff93c0 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -307,9 +307,16 @@ master or exposed as a part of a stable branch.
 <9> backport a critical fix.
 <10> create a signed tag.
 <11> make sure master was not accidentally rewound beyond that
-already pushed out.  `ko` shorthand points at the Git maintainer's
+already pushed out.
+<12> In the output from `git show-branch`, `master` should have
+everything `ko/master` has, and `next` should have
+everything `ko/next` has, etc.
+<13> push out the bleeding edge, together with new tags that point
+into the pushed history.
+
+In this example, the `ko` shorthand points at the Git maintainer's
 repository at kernel.org, and looks like this:
-+
+
 ------------
 (in .git/config)
 [remote "ko"]
@@ -320,12 +327,6 @@ repository at kernel.org, and looks like this:
 	push = +refs/heads/pu
 	push = refs/heads/maint
 ------------
-+
-<12> In the output from `git show-branch`, `master` should have
-everything `ko/master` has, and `next` should have
-everything `ko/next` has, etc.
-<13> push out the bleeding edge, together with new tags that point
-into the pushed history.
 
 
 Repository Administration[[ADMINISTRATION]]
-- 
2.11.0.rc3.windows.1

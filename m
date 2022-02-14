Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1C1C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 18:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357393AbiBNSP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:15:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiBNSP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 13:15:56 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128F6541B
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:15:48 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDD8B181465;
        Mon, 14 Feb 2022 13:15:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SjWE+DpWeeQKNxo8yN7pjYHqxe9U+hAHSVkEyO
        Iu+2g=; b=hpa+Xn5umj7+Xz3PV7yYMBiIq6Ji8gjD35pYdUltdi+2hItwAoqaK1
        N12ah7LUKSeIrE7fPc8xwRxIXaYy2kaC8w9S3tJErKNDVRZ4Gep6ritEE/8EjPIS
        2KkBZKJpAxecRtvfRcHQsFvGU6aILBcqFCNpuyf3BUb34PIgnD8mA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6D6B181462;
        Mon, 14 Feb 2022 13:15:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C3A7181461;
        Mon, 14 Feb 2022 13:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for
 .gitattributes eol
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
        <20220214020827.1508706-1-sandals@crustytoothpaste.net>
Date:   Mon, 14 Feb 2022 10:15:43 -0800
In-Reply-To: <20220214020827.1508706-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 14 Feb 2022 02:08:25 +0000")
Message-ID: <xmqqilth2u28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2092F9EC-8DC2-11EC-87A0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I was answering a question on StackOverflow recently about the
> interaction between text=auto and eol, and someone pointed out to me
> that what I had written, which was based on the documentation, was not
> correct as of Git 2.10 (and more specifically 6523728499 ("convert:
> unify the "auto" handling of CRLF", 2016-06-28)).
>
> When I set out to document the behavior correctly, I ran into the fact
> that the tests, where I looked for examples of how this behaves, didn't
> have any tests for some of these cases, and so I had some trouble
> documenting this clearly and accurately.  So this series basically just
> adds some tests for existing behavior so we don't change it (and so I
> could figure out how it works) and then updates the documentation
> accordingly.

This seems to be a replacement of the two-patch series that was
merged to 'master' at 8db2f665 (Merge branch 'bc/clarify-eol-attr',
2022-02-11) and was merged to 'next' at dc1db4bd (Merge branch
'bc/clarify-eol-attr' into next, 2022-02-04).  The changes seem to
be in the second step to update Documentation/gitattributes.txt and
it needs to be made an incremental update.

Thanks.

---- >8 -----
From: brian m. carlson <sandals@crustytoothpaste.net>
Subject: doc: clarify interaction between 'eol' and text=auto

The `eol` takes effect on text files only when the index has the
contents in LF line endings.  Paths with contents in CRLF line
endings in the index may become dirty unless text=auto.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git c/Documentation/gitattributes.txt w/Documentation/gitattributes.txt
index 60984a4682..a71dad2674 100644
--- c/Documentation/gitattributes.txt
+++ w/Documentation/gitattributes.txt
@@ -161,11 +161,12 @@ unspecified.
 
 This attribute sets a specific line-ending style to be used in the
 working directory.  This attribute has effect only if the `text`
-attribute is set or unspecified, or if it is set to `auto` and the file
-is detected as text.  Note that setting this attribute on paths which
-are in the index with CRLF line endings may make the paths to be
-considered dirty. Adding the path to the index again will normalize the
-line endings in the index.
+attribute is set or unspecified, or if it is set to `auto`, the file is
+detected as text, and it is stored with LF endings in the index.  Note
+that setting this attribute on paths which are in the index with CRLF
+line endings may make the paths to be considered dirty unless
+`text=auto` is set. Adding the path to the index again will normalize
+the line endings in the index.
 
 Set to string value "crlf"::
 

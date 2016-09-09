Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38D41F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 19:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbcIITVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:21:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64605 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754406AbcIITVH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:21:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A23CB3CB16;
        Fri,  9 Sep 2016 15:21:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c2gKb6D7NpycBfTFoBIiwW30Qag=; b=cYYSlF
        BHPxdIIFGQkFNOl3jRYqIao5ZgAdcg/lylUx2os9S3JONIXm6w+lfmbV+Z6vXUa9
        VfmbSUkIfJb3UWNDVw+yBk+gwtvOOWJj2MTL9LwiyuC71UKBnkF0lOy/VwCkT4ga
        9lDyA/yvUpkkUw9v5ib5JptZcExYyIwyhzjO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dobVPiVLmJuylc/HuTnDfz6ofxIVsiIQ
        dlMnglVKtTQMNJReCJvb3GNG2K5vgOxs0In74J/+WohChJ3XgrcIHqH0eaIPujkC
        /GvSIc2bvkSgxV6/zfGD72LR9zioCHPj5y5l1KchoRJj6qCKiX2CYs9JtEgqAnNw
        7yQghITIl5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 997C83CB15;
        Fri,  9 Sep 2016 15:21:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18E1F3CB13;
        Fri,  9 Sep 2016 15:21:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] checkout.txt: document a common case that ignores ambiguation rules
References: <20160822123502.3521-1-pclouds@gmail.com>
        <20160907111941.2342-1-pclouds@gmail.com>
        <20160907111941.2342-3-pclouds@gmail.com>
        <xmqq7famgnwo.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 09 Sep 2016 12:21:02 -0700
In-Reply-To: <xmqq7famgnwo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 08 Sep 2016 13:03:03 -0700")
Message-ID: <xmqqfup8c21t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D81244C-76C2-11E6-B548-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll queue the following as "fixup!" for now.  It reminds me that
the title also needs rewording; we do not have rules to make things
ambiguous ;-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 46b04b1..8e2c066 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -419,14 +419,17 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
 
-ARGUMENT AMBIGUATION
---------------------
+ARGUMENT DISAMBIGUATION
+-----------------------
 
 When there is only one argument given and it is not `--` (e.g. "git
-checkout abc"), "abc" could be seen as either a `<tree-ish>` or a
-`<pathspec>`, but Git will assume the argument is a `<tree-ish>`, which is
-a common case for switching branches. Use `git checkout -- <pathspec>`
-form if you mean it to be a pathspec.
+checkout abc"), and when the argument is both a valid `<tree-ish>`
+(e.g. a branch "abc" exists) and a valid `<pathspec>` (e.g. a file
+or a directory whose name is "abc" exists), Git would usually ask
+you to disambiguate.  Because checking out a branch is so common an
+operation, however, "git checkout abc" takes "abc" as a `<tree-ish>`
+in such a situation.  Use `git checkout -- <pathspec>` if you want
+to checkout these paths out of the index.
 
 EXAMPLES
 --------
-- 
2.10.0-339-gc0c747f


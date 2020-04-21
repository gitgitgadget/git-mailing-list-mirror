Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF8CC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A00206B8
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcg6DZw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgDUNtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728479AbgDUNtp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:49:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DE0C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:49:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t14so16502120wrw.12
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EAz6eucluXU1PPqzi+V2SuJck4Ciac3eS5HWRcQfRVc=;
        b=Qcg6DZw2PQ9EONcTAoixYGXZ9qZp2Z2MvlMVAMrC1r224W5heY2yTKtyEMjI2OOcFx
         DFPsYL7q13NNaoae8NKHOH/h1m5cKFAl2tuUUdrSRrYA5rMS2KfDEYdRl6Ts9Jj9sGtY
         DIVp50fyga7AZimKFfxX4vhRbY8aswJ2uwltpy36p20peCeIxGxCehBfolIGsHh9WDqI
         auADELz7GSJwG8Qs6bzpyyBtbsnmv5H9n2emBkdGzDGP9pKuB0JBn919xc6E4EeI0XCi
         JzF7G9+oAdIfeYB8rnregCjhBy0Fgs8Z9rIBJliWSBmthE3XBzRER7KumCQ3TsXi70e1
         0NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EAz6eucluXU1PPqzi+V2SuJck4Ciac3eS5HWRcQfRVc=;
        b=Lx6ft+7zgus2AVKTSgMX0JMAILJpEUYbXviqyDCyXr/+PDr1Wy0vxpt08Gyl5LiQHs
         uz6Gi+uy4tOc8IoqtRR7g3QR5S/J2UhcsKpi/4YH+KpemFbHfBitCkBhV7So8qGbZK0K
         zpbYHJr4fuVj1A7kqgeIEKke7O3uoIe1LdcRJVBktlBLfkpMkwli5sj5CAx4BNpbGhGr
         6/ujk2Gj2sWk0uQVR9LChOYatBwgqPVVuh4b3+AcBIfAAYgBp9aNkQLynI+8+7hcaVPQ
         tYgYgLRugZyAX0UoVjcThqQx0CEYB54mCpjw7WVK9953EMwC+II4nTWyPhqelfjX/PVf
         SG9w==
X-Gm-Message-State: AGi0PuY5Rvz8mrH2wZWow/1jzykWPD3vxB9mHVg1/Bam/JcZJff2/BdI
        md8RK49AGgKPDq4UfFdOUfHYJGTCw5kZd9xOBW0Sl6tk1l8=
X-Google-Smtp-Source: APiQypLRxTJRQHHw2fnaOpTyfeDF3nN1Quw8Q0Yg/uKh8jRaemjwNn2GiFuyNuSbYuQt9V4fJbXJWqTgAfe44EhSbEk=
X-Received: by 2002:adf:8284:: with SMTP id 4mr24390119wrc.6.1587476983734;
 Tue, 21 Apr 2020 06:49:43 -0700 (PDT)
MIME-Version: 1.0
From:   Will Palmer <wmpalmer@gmail.com>
Date:   Tue, 21 Apr 2020 14:49:07 +0100
Message-ID: <CAAKF_ubf3EMK6sTrvZo1OSVHLiLjnY=S=W7s1CNCkZLSteaa+g@mail.gmail.com>
Subject: Possible documentation error for "git revisions"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Documentation/revisions.txt page may have a couple of errors in
it, regarding "searching for commits by commit message"

it states:

':/<text>', e.g. ':/fix nasty bug'::
A colon, followed by a slash, followed by a text, names
a commit whose commit message matches the specified regular expression.
This name returns the youngest matching commit which is
reachable from any ref, including HEAD.
The regular expression can match any part of the
commit message. To match messages starting with a string, one can use
e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
literal '!' character, followed by 'foo'. Any other sequence beginning with
':/!' is reserved for now.
Depending on the given text, the shell's word splitting rules might
require additional quoting.

However, I believe that the ":/<text>" syntax now *always* refers to a
file in the tree-object,
never a search-by-commit-message. (I wasn't previously aware of this
change, but I like it!)

Instead, the syntax "HEAD^{/<text>}" *does* appear to perform the
search described by the
documentation for ":/<text>". This includes the possibility of
matching HEAD itself. in my
own workflow, I've never noticed the distinction, but this does feel
like a possible error in code,
rather than documentation. That said, removing the ability for
"HEAD^{/text}" to match HEAD
would potentially leave rev-parse with no method for referring to "the
first match, even if that
match is HEAD itself", which I think would be bad to remove.
Personally, I always type
HEAD^{/text} (or HEAD^{/!-text}) when searching for something "before"
HEAD, but I do feel
that I would "expect" that to match HEAD as well, for what it's worth.

Though fixing this as a matter of documentation would be a very small
change, I don't have
time right now personally to make it (including necessary steps of
verification, tracing the
history of when the documentation became out-of-date, ensuring this is
a documentation, not
code, issue, etc). So I'm unfortunately probably going to "fire and
forget" this bug report.

Thanks to anyone who can complete this!

-- Will Palmer

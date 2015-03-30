From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Mon, 30 Mar 2015 11:29:46 +0200
Message-ID: <5519178A.6080408@gmail.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com> <xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, sorganov@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:30:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcW1F-0008EC-PT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 11:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbbC3JaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 05:30:02 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:33921 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbbC3JaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 05:30:00 -0400
Received: by qcay5 with SMTP id y5so65327672qca.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2Zqe0k15iJkJd8+mY6+USV6+X9JItvWDCRxPIk9mEUY=;
        b=Z/L0PAXBCUexmBrnvQkewKgzgRQhUg6+GnWxGSrv6RyzLg7wp9YVjNG4ufJ+WO1R/C
         fRP7P/xwWN7lXpKf6y9esoIyjzsnAA/SIwYxgPBupxe6iIAI2HBFWmNfxnxsAF+cmtzl
         SItPJzuJbVPFxhEnCid8ehtY1pM/1JILbRGpcYifEQqelQGH2RqYj9EZyyUxTVQc95+4
         Wv/pR4cgD6FqZELqQ5lPO9MkafxT3QBL0924v0QzbEqkuMJfJ7tV5AzXoXRWMJ5wccUO
         ohXgyMweZ60wrkN30WxKwh6x8fb9XN7GfMuxT0h1YVWw4J3gcyVTYm5fmAUtVuZfzac6
         cD8g==
X-Received: by 10.140.201.74 with SMTP id w71mr27771353qha.51.1427707799749;
        Mon, 30 Mar 2015 02:29:59 -0700 (PDT)
Received: from [10.223.42.70] ([131.228.216.128])
        by mx.google.com with ESMTPSA id u48sm223534qgd.34.2015.03.30.02.29.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 02:29:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266450>

On 3/26/2015 19:18, Junio C Hamano wrote:

> Although I fully agree that the new text is better than the original,
> I think the new text fails to point out one major aspect by not
> mentioning "linear" or "flatten" anywhere.  The point of "git rebase"
> without "-p" is not just to replay but to flatten

I think it's a bit odd to say that "-p" does not flatten if the whole current rebase docs do not use the terms flattening / linearize at all. If we say that that "-p" does not flatten, we should say that a "standard" rebase wihtout "-p" does. I plan to send a patch for that later.


> 	Instead of flattening the history by replaying each
> 	non-merge commit to be rebased, preserve the shape of the
> 	rebased history by recreating merge commits as well.

Personally, I like "positive logic" better here, i.e. start with saying what the option does, not what it does not do.

So how about:

[PATCH] docs: Clarify what git-rebase's "-p" / "--preserve-merges" does

Ignoring a merge sounds like ignoring the changes a merge commit
introduces altogether, as if the merge commit was skipped or dropped from
history. But that is not what happens if "-p" is not specified.

Instead, what happens is that the individual commits a merge commit
introduces are replayed in order, and only any possible merge conflict
resolutions or manual amendments to the merge commit are ignored. Get this
straight in the docs.

Also, do not say that merge commits are *tried* to be recreated. As that is
true almost everywhere it is better left unsaid.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-rebase.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d728030..47984e8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -362,7 +362,9 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 
 -p::
 --preserve-merges::
-	Instead of ignoring merges, try to recreate them.
+	Recreate merge commits instead of flattening the history by replaying
+	commits a merge commit introduces. Merge conflict resolutions or manual
+	amendments to merge commits are not preserved.
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
-- 
1.9.5.msysgit.1

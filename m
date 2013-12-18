From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH] docs: add filter-branch note about The BFG
Date: Wed, 18 Dec 2013 01:04:26 +0000
Message-ID: <CAFY1edaEZzDUuG9kopbAp9h2Frc2aLRKkjKMUnpSonML2xZN=A@mail.gmail.com>
References: <1387277599-69719-1-git-send-email-roberto.tyley@gmail.com>
	<xmqqk3f3mjl5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jeff King <peff@peff.net>,
	tr@thomasrast.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 02:04:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt5Z3-0008Cz-7C
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 02:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab3LRBEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 20:04:37 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64085 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3LRBE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 20:04:27 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so9427355ieb.22
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 17:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=82/e1wGOe7oyBO62a2i7XneKCwfJB54tyULUy8/oZbI=;
        b=xwokBKncht04Z2XUS8odLyiZSzucWshn3ps9OC63IIZpWZiaY+ZAS5prYRafPGsQ+d
         w9ccPLHoBuv4212nSg4YVoN5TvPzHNIXHBheB9o3mZIdMb1sfH7ACNmFePWpS4NoV7iY
         8QLA7Q+4g0KP2rcw6O3lkPHXccSZrS2bJrmYqd5zeyRItG1lqwwsguLMA890XBz+sg4w
         fx3N5Pwb/+q24Oz/Ysw64Eoz0gv9Jty3HOrGi4JXvEGeCTDed8Vq88JIayiwi9srUPuP
         8LdXrJynWPZYiN8RNgV0FckHxnfOkNJwR7Lgigjc0YnjU5Faw2Buo+8iSyHssoys0bwE
         /+5A==
X-Received: by 10.50.114.168 with SMTP id jh8mr5867566igb.6.1387328666611;
 Tue, 17 Dec 2013 17:04:26 -0800 (PST)
Received: by 10.64.8.229 with HTTP; Tue, 17 Dec 2013 17:04:26 -0800 (PST)
In-Reply-To: <xmqqk3f3mjl5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239419>

On 17 December 2013 18:13, Junio C Hamano <gitster@pobox.com> wrote:
>
> Having said that, "You may want to use ..." without giving the
> reason why we recommend the other tool leaves the reader wondering
> what the pros and cons are, and why git-filter-branch exists if BFG
> is the first thing its document recommends even before it describes
> what git-filter-branch is and does.  "You may want to check ..."
> might be slightly better, but probably by not that much improvement.
>
> Rewriting "it's generally faster ..."  part to give a bit more info
> to allow readers decide the pros and cons themselves may be needed.

Thanks for that feedback, it makes sense. Here's an alternative
version which gives more information on the pros and cons of each
tool, and why you might want to use either - as Jonathan suggested,
this would be for the NOTES section at the bottom of the file, where
it's less intrusive:

Notes
-----

git-filter-branch allows you to make complex shell-scripted rewrites
of your Git history, but you may not need this flexibility if you're
simply _removing unwanted data_ like large files or passwords. For
those operations you may want to consider
link:http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner],
a JVM-based alternative to git-filter-branch, typically at least
10-50x faster for those use-cases, and with quite different
properties:

* The BFG takes advantage of multi-core machines, cleaning commit
file-trees in parallel, which git-filter-branch currently does not do.
* Any particular version of a file is cleaned exactly _once_. The BFG,
unlike git-filter-branch, does not give you the opportunity to handle
a file differently based on where or when it was committed within your
history.
* The link:http://rtyley.github.io/bfg-repo-cleaner/#examples[command-set]
is much more restrictive than git-filter branch, and dedicated just to
the tasks of removing unwanted data - e.g. `--strip-blobs-bigger-than
1M`.


I can re-submit this as a patch if it's acceptable?

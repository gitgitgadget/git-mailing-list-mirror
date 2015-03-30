From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Mon, 30 Mar 2015 10:23:20 -0700
Message-ID: <xmqqfv8mxuuv.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<5519178A.6080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, sorganov@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:23:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcdPY-0006KO-3h
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbbC3RXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:23:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753090AbbC3RXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:23:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73B98436F8;
	Mon, 30 Mar 2015 13:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JGDo2aDcHT4XEp0+98p/JNnv/zQ=; b=qSNAUz
	kgF6YNQXxgdF2ZI6YuGn1kRc7ZIYXRHlpYMenmAL5YEL7cB026VeqrFRwur7QCKP
	nnLTTRtaZfJjbl4//AJg1gLp/rppxmAg3bE0D0mhYtIqdCadFVztTCKRZZoRT/6q
	5mIuSs5TzZGmau4jwiOdGLATv4T/px4qDwOKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HQoxhXE3bXTeq4o7052E5joc4C62PgnE
	6yHVys0fIdr3TEFtPyt73ZPiPPL6JJHTO+/Iq3MiuDJIHcwPsyff8ZsU2vamTEVc
	8e+AWH02Gc12lmfJ2bD/cdWiIQR2fryTuE9uDsgVR00ar/feRHjJRjP655nkJ0N5
	SyPFQSTd+gU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BB1C436F7;
	Mon, 30 Mar 2015 13:23:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF38B436F4;
	Mon, 30 Mar 2015 13:23:22 -0400 (EDT)
In-Reply-To: <5519178A.6080408@gmail.com> (Sebastian Schuberth's message of
	"Mon, 30 Mar 2015 11:29:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77A17792-D701-11E4-8DE7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266458>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> So how about:
>
> [PATCH] docs: Clarify what git-rebase's "-p" / "--preserve-merges" does
>
> Ignoring a merge sounds like ignoring the changes a merge commit
> introduces altogether, as if the merge commit was skipped or dropped from
> history. But that is not what happens if "-p" is not specified.

Every time I read the above (which is essentially the same from your
first edition I think) I find the "ignoring the changes a merge
commit introduces altogether" and "as if the merge commit was
skipped" somehow contradicting with each other.  If the latter were
"as if the side branch that was merged was skipped or dropped", I do
not see the room for such a misinterpretation.

That is, at least to me,

         D---E---F
        /         \
    ---A---B---C---G---H

the former, i.e. "the changes the merge G introdues", is "diff C G",
while "merge commit was skipped" would mean a history like this:

    ---A---B---C---D'--E'--F'--H'

And I think with "as if the side branch that was merged was
dropped", this misinterpretation will become impossible.  It can
only mean this history:

    ---A---B---C---.---H'

> Instead, what happens is that the individual commits a merge commit
> introduces are replayed in order, and only any possible merge conflict
> resolutions or manual amendments to the merge commit are ignored. Get this
> straight in the docs.
>
> Also, do not say that merge commits are *tried* to be recreated. As that is
> true almost everywhere it is better left unsaid.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-rebase.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index d728030..47984e8 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -362,7 +362,9 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
>  
>  -p::
>  --preserve-merges::
> -	Instead of ignoring merges, try to recreate them.
> +	Recreate merge commits instead of flattening the history by replaying
> +	commits a merge commit introduces. Merge conflict resolutions or manual
> +	amendments to merge commits are not preserved.

The patch text itself reads fine.

>  +
>  This uses the `--interactive` machinery internally, but combining it
>  with the `--interactive` option explicitly is generally not a good

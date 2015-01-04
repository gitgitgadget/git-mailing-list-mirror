From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Sun, 04 Jan 2015 12:02:20 -0800
Message-ID: <xmqqh9w6qppv.fsf@gitster.dls.corp.google.com>
References: <1420157910-2252-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 21:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7rNg-0001lT-Og
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 21:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbbADUC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 15:02:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752751AbbADUC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 15:02:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02D4E2C7FC;
	Sun,  4 Jan 2015 15:02:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gq2/8x6cwrlqbQQA2zbg78HAn44=; b=GLsDGM
	ES4RqOc0OI7pj2m2KHPkAyPiD+DuMm50wswQF2rAfd83YT9busI+FSan9UBEu9g+
	3HBRNkA8Pz2qK6WyP+feNHYH1r0x38IJwNIczVrw7ggngRIR6GKzgoUjBeh+4WUW
	mhaPPew1V/Hhf1YlI2GowcJvF9AwnXirarFro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S4FW1z1LK7cmHzrfql7whVVlz21JNnCR
	fggVwV6Tl0C31mlpiPCproTvBaUM54fsNrnsdbCH8zz7yN43xvXntiiSTAW7jPJK
	zOO3ZrsXG+y2l+4NFFLKCRNQAjkDy35EufGn2n2XOQEbd7GwQBRo14tXdxErlJyl
	CBwgdfmkC4o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECBAA2C7FB;
	Sun,  4 Jan 2015 15:02:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FD192C7F6;
	Sun,  4 Jan 2015 15:02:21 -0500 (EST)
In-Reply-To: <1420157910-2252-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Fri, 2 Jan 2015 00:18:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 980403A8-944C-11E4-B19A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262008>

Philip Oakley <philipoakley@iee.org> writes:

> The assume-unchanged bit, and consequently core.ignoreStat, can be
> misunderstood. Be assertive about the expectation that file changes should
> notified to Git.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> Overhaul the general wording thus:
>     1. direct description of what is ignored given first.
>     2. example instruction of the user manual action required.
>     3. use sideways indirection for assume-unchanged and update-index references.
>     4. add a 'normally' to give leeway for the change detection.
>
> This version is on top of the current master, and replaces the patch in next.

Sorry, you do not replace anything in 'next', once it is in.

I was about to say that I'll try to see if I turn it into
incremental (at which point some of the above four points after the
three-dash line might want to be in the log message proper), but the
AsciiDoc mark-up looks somewhat suspect (we usually do not see
indentation in the paragraphs continued with "+").  Does this format
fine for manpage and HTML?

Thanks.

> ---
>  Documentation/config.txt | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6862e3e..32e42dd 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -375,13 +375,17 @@ This is useful for excluding servers inside a firewall from
>  proxy use, while defaulting to a common proxy for external domains.
>  
>  core.ignoreStat::
> -	If true, commands which modify both the working tree and the index
> -	will mark the updated paths with the "assume unchanged" bit in the
> -	index. These marked files are then assumed to stay unchanged in the
> -	working tree, until you mark them otherwise manually - Git will not
> -	detect the file changes	by lstat() calls. This is useful on systems
> -	where those are very slow, such as Microsoft Windows.
> -	See linkgit:git-update-index[1].
> +	If true, Git will avoid using lstat() calls to detect if files have
> +	changed. Git will set the "assume-unchanged" bit for those tracked files
> +	which it has updated identically in both the index and working tree.
> ++
> +	When files are modified outside of Git, the user will need to stage
> +	the modified files explicitly (e.g. see 'Examples' section in
> +	linkgit:git-update-index[1]).
> +	Git will not normally detect changes to those files.
> ++
> +	This is useful on systems where lstat() calls are very slow, such as
> +	CIFS/Microsoft Windows.
>  	False by default.
>  
>  core.preferSymlinkRefs::

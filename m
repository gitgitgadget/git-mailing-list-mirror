From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add Code Compare v2.80.4 as a merge / diff tool for
 Windows
Date: Wed, 08 Aug 2012 14:26:13 -0700
Message-ID: <7v1ujhrs7e.fsf@alter.siamese.dyndns.org>
References: <5022CC90.3060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDlm-0007kN-1t
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 23:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab2HHV0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 17:26:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab2HHV0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 17:26:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82F799FED;
	Wed,  8 Aug 2012 17:26:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hX6vvyxwF6RUspsrv/LmDKrHxPY=; b=GW9IAt
	XG7yv7Gn1c62/Csrbwi5ZMGsHmOjeOngAwB/U+1S14aypuT0Rpb3givohQcpVbjI
	gBODXAA36j+BtcY9swygAjEIEmIJRFDL1rmliglH1Y8ST4/vUIgjNYMe+nmczy3L
	1dZ0FYsXCfRzkCv92mvJcAJ6bMyjXdyxch/gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JbYZNldTcv1ov38OXOnK4Tuytw44sQf2
	WwxEnXGYFbLntt79uwzwZnPZpychpQ0hK91b+hR8U+9CSQlIPJXM7KrQpTxVeV13
	DjBUPx3G3cU5eCVSl4jkssidPNKraLBlythuHItW4sLGVBZIljYeJgZ9tSHQmG8+
	ouN6b2eC6VE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70ACB9FEC;
	Wed,  8 Aug 2012 17:26:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA8019FEA; Wed,  8 Aug 2012
 17:26:14 -0400 (EDT)
In-Reply-To: <5022CC90.3060108@gmail.com> (Sebastian Schuberth's message of
 "Wed, 08 Aug 2012 22:31:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEDECF02-E19F-11E1-9AB9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203134>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Code Compare is a commercial file comparison tool for Windows, see
>
>     http://www.devart.com/codecompare/
>
> Version 2.80.4 added support for command line arguments preceded by a
> dash instead of a slash. This is required for Git for Windows because
> slashes in command line arguments get mangled with according to these
> rules:
>
>     http://www.mingw.org/wiki/Posix_path_conversion
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/merge-config.txt         |  8 ++++----
>  contrib/completion/git-completion.bash |  2 +-
>  git-mergetool--lib.sh                  |  2 +-
>  mergetools/codecompare                 | 25 +++++++++++++++++++++++++
>  4 files changed, 31 insertions(+), 6 deletions(-)
>  create mode 100644 mergetools/codecompare
>
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index 861bd6f..e9e0d55 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -54,10 +54,10 @@ merge.stat::
>  merge.tool::
>  	Controls which merge resolution program is used by
>  	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
> -	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
> -	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
> -	and "xxdiff".  Any other value is treated is custom merge tool
> -	and there must be a corresponding mergetool.<tool>.cmd option.
> +	"bc3", "codecompare", "diffuse", "ecmerge", "emerge", "gvimdiff",
> +	"kdiff3", "meld", "opendiff", "p4merge", "tkdiff", "tortoisemerge",
> +	"vimdiff" and "xxdiff".  Any other value is treated is custom merge
> +	tool and there must be a corresponding mergetool.<tool>.cmd option.
>  
>  merge.verbosity::
>  	Controls the amount of output shown by the recursive merge

I do not have a strong reason to vote for or against inclusion of
yet another tool as mergetool backends (read: Meh), but what this
patch does to Documentation/merge-config.txt is actively unwelcome.

As we discussed earlier in

    http://thread.gmane.org/gmane.comp.version-control.git/201913/focus=201976

the longer term direction is to reduce the names of tools listed
there.

I am somewhat saddened to find your name in that thread; you should
have been aware of that discussion when you wrote this patch.

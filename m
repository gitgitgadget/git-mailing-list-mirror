From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-branch: Indentation for show-branch usage
Date: Thu, 08 Jan 2015 12:05:09 -0800
Message-ID: <xmqqsifldone.fsf@gitster.dls.corp.google.com>
References: <1420740516-20836-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:05:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9JKZ-0002VA-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbbAHUFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 15:05:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752213AbbAHUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 15:05:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1697A2EDCD;
	Thu,  8 Jan 2015 15:05:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YhM3aWRPVOZMtBWT/Uf5SJ9Cmro=; b=SvWmpS
	H+TQVHwqCd17SuTi8oVTpqHE6iU/9i68PvSfop76n93gii4pqgs/X1wzqCT4rAJU
	ZvsWBrRrSkLDxiq0wPtBLfR3osmTgVSRB9GPtsLxN8tjAE3M50mBvnFMMHC0Mw36
	8Yp/GNORqwT773628GDiEeCLN5shU8rj/NjfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vBeeAOh2KEwVrdk2ynuNePIWTKng9awR
	u3U/76AxbMfCHx1YHH4UiU4G8eHkiwhnWKThpOwiq/KmvxV9Fwj3tWHZdyGo1U6I
	1WVb1Io0rI38eu0rMZYXfZcAcQlNJQnvXpZUSYHkbCMnJEf6U0F33d7FcUjjpBoK
	GDFi0+GXs+c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F009D2EDCC;
	Thu,  8 Jan 2015 15:05:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FC172EDC8;
	Thu,  8 Jan 2015 15:05:10 -0500 (EST)
In-Reply-To: <1420740516-20836-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 9 Jan 2015 00:08:36 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A63C6AE6-9771-11E4-95DF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262218>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

s/Indentation for/line-wrap/, perhaps?

What the patch wants to do makes sense to me, but I haven't seen a
long multi-line string, each lines in which is terminated with "\n\"
in the source, fed to N_() macro anywhere else in the existing
codebase, which makes me a bit nervous.

Would writing it this way instead, i.e. making it more obvious where
each line begins and how long the indentation of subsequent lines are,
also work?

	N_("git show-branch [-a|--all] ...\n"
           "                [--current] [--color[=<when>]] ...\n"
           ...
           "                [--no-name ...");

Or does it break N_() macro?

Thanks.


>  builtin/show-branch.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 270e39c..2e60107 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -6,7 +6,10 @@
>  #include "parse-options.h"
>  
>  static const char* show_branch_usage[] = {
> -    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
> +    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order]\n\
> +                       [--current] [--color[=<when>] | --no-color] [--sparse]\n\
> +                       [--more=<n> | --list | --independent | --merge-base]\n\
> +                       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
>      N_("git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]"),
>      NULL
>  };

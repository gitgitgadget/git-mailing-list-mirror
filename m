From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch] color of branches in git status -sb
Date: Wed, 16 Nov 2011 17:13:04 -0800
Message-ID: <7v4ny3pn4v.fsf@alter.siamese.dyndns.org>
References: <CA+TMmKns-9jiedxY4FiJoBg8akkxwkPBib11EmvCD3r7mRA6vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Dudebout <nicolas.dudebout@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 02:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQqXS-0000dD-S0
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 02:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab1KQBNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 20:13:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460Ab1KQBNH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 20:13:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB99E5F56;
	Wed, 16 Nov 2011 20:13:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ETicYaJtkwq/QrVzGUCmkfhmFx4=; b=gCOlFJ
	cz3xiyXZZFx/BQ+JfmNmtJZr57rVN6taA7ljtW5MRoJKuZ25cPEj48aTEGaEGIxE
	flmGScLnmurIBq8rmY0dowZqD18JQIY+jqvnFG1CQA0MpoJew8lHSDX299+sbDjr
	PwWLloZiSr3rqRfUpNJzAcefF+4nRN3dszCzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kawOa9yeD6Dqv4Y43liACQZ1WbzHOdfR
	f7TFpeY6f8rApA6B77wb2GX+31aVv7whH8rpA9S6eGTMjalIQw16kVxvpsluOO72
	1bBRUso0fVCECsXF2QVdZHjs7cR5mO/fOV2UpQ+F23LUlWf9PIYMZ4hPCGQTRgET
	s/mtKByxTz0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D19CC5F55;
	Wed, 16 Nov 2011 20:13:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E63E5F53; Wed, 16 Nov 2011
 20:13:06 -0500 (EST)
In-Reply-To: <CA+TMmKns-9jiedxY4FiJoBg8akkxwkPBib11EmvCD3r7mRA6vQ@mail.gmail.com> (Nicolas
 Dudebout's message of "Wed, 16 Nov 2011 19:39:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E268CC0-10B9-11E1-8D1C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185566>

Nicolas Dudebout <nicolas.dudebout@gmail.com> writes:

> The following patch fixes the fact that two colors of the status
> output could not be configured in .git/config.
>
> The color of the current branch could not be modified because of the
> name WT_STATUS_ONBRANCH having been changed to WT_STATUS_LOCAL_BRANCH.
>
> The color of the remote branch was not defined at all.
>
> By the way, when I do 'git status' instead of git 'status -sb' the
> local and remote branch do not get colored. Is this a desired
> behavior?
>
> Nicolas

Please follow Documentation/SubmittingPatches.

Also expect that patches to add new feature this deep in the pre-release
feature freeze period is not likely to get reviewed by regular list
members.

>
> 	Modified   Documentation/config.txt

Don't do this. We can tell what is modified from "diff --git" lines.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5a841da..7a0ddd6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -809 +809,2 @@ color.status.<slot>::
> -	`branch` (the current branch), or
> +	`branch` (the current branch),
> +        `remote` (the remote branch) or

Don't do this. Proper patches have context lines for good reasons.

> 	Modified   builtin/commit.c
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c46f2d1..4674600 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1118 +1118,3 @@ static int parse_status_slot(const char *var, int offset)
> -		return WT_STATUS_ONBRANCH;
> +		return WT_STATUS_LOCAL_BRANCH;
> +	if (!strcasecmp(var+offset, "remote"))
> +		return WT_STATUS_REMOTE_BRANCH;

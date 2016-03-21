From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: do not lose SQUASH_MSG contents
Date: Mon, 21 Mar 2016 15:34:13 -0700
Message-ID: <xmqqpounjw9m.fsf@gitster.mtv.corp.google.com>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
	<xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
	<xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com>
	<xmqqziu7h01f.fsf@gitster.mtv.corp.google.com>
	<56E5B3F9.6070404@cs-ware.de>
	<xmqqpouwapnd.fsf@gitster.mtv.corp.google.com>
	<xmqq4mc8ak3n.fsf@gitster.mtv.corp.google.com>
	<56F075D4.2020002@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:34:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai8Oy-0006V7-J8
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 23:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbcCUWeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 18:34:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750745AbcCUWeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 18:34:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEFAE4E0EE;
	Mon, 21 Mar 2016 18:34:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uuGquaWaWgI99emCMXiT8VJ8f9o=; b=rfeTXH
	2GjsjxaeZi+tgC4WZ9o444otRXlhDtwzYSrFk4yE+LQy1hciP/DhFDafKSuqrH4L
	dmTyl0m/imoa5N7IFmYURe80/bD7uuuWO9JKsYC53UN8cqHaPtZfLGJpYmlHBBR6
	2E1cVOfR5yszpDtrnDTBg/PIMjhy1ANSVJiFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X3k66ZISwWr71EqW8O/IMY6inw8bPAmh
	hzpudE/A+70GnNXHEHirZcyQwAGdnouFTOAM7mOFqaZg5q4p9GqU45dVkzCwIdSI
	i7lRZwfamNWvV25v8/+xZz2fzBzxrKkJaECfjQOJAgtuntKr0KteMlPNB+9lWlfQ
	eXjXq434MOc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C68374E0ED;
	Mon, 21 Mar 2016 18:34:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 45C3C4E0EC;
	Mon, 21 Mar 2016 18:34:14 -0400 (EDT)
In-Reply-To: <56F075D4.2020002@cs-ware.de> (Sven Strickroth's message of "Mon,
	21 Mar 2016 23:29:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A250166-EFB5-11E5-B354-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289473>

Sven Strickroth <sven@cs-ware.de> writes:

> When concluding a conflicted "git merge --squash", the command
> failed to read SQUASH_MSG that was prepared by "git merge", and
> showed only the "# Conflicts:" list of conflicted paths.
>
> Place the contents from SQUASH_MSG at the beginning, just like we
> show the commit log skeleton first when concluding a normal merge,
> and then show the "# Conflicts:" list, to help the user write the
> log message for the resulting commit.
>
> Test by Junio C Hamano <gitster@pobox.com>.
>
> Signed-off-by: Sven Strickroth <sven@cs-ware.de>
> ---

You must somehow read my mind, as I was about to send a friendly
ping to you saying "unless you have a reroll, I'll squash the test
in" ;-)

Will replace those two commits with this one (after fixing one nit).

Thanks.

>  builtin/commit.c | 11 ++++++++++-
>  t/t7600-merge.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d054f84..d40b788 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -726,9 +726,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				      &sb, &ctx);
>  		hook_arg1 = "message";
>  	} else if (!stat(git_path_merge_msg(), &statbuf)) {
> +		/*
> +		 * prepend SQUASH_MSG here if it exists and a
> +		 * "merge --squash" was originally performed
> +		*/

Here is a nit ("*/" needs one more space indent to align).

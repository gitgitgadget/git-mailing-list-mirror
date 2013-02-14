From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Documentation: filter-branch env-filter example
Date: Thu, 14 Feb 2013 07:49:55 +0100
Message-ID: <511C8913.9090203@viscovery.net>
References: <511BEDDF.7010800@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tade <yess@hell.org.pl>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:50:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5seK-000829-To
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 07:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab3BNGuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 01:50:03 -0500
Received: from so.liwest.at ([212.33.55.24]:34049 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352Ab3BNGuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 01:50:02 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1U5sdo-00046a-HX; Thu, 14 Feb 2013 07:49:56 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2DA1B1660F;
	Thu, 14 Feb 2013 07:49:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <511BEDDF.7010800@hell.org.pl>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216300>

Am 2/13/2013 20:47, schrieb Tade:
> filter-branch --env-filter example that shows how to change the email address
> in all commits by a certain developer.
> ---

You should sign off your patch. Use a full real name, please.

>  Documentation/git-filter-branch.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/git-filter-branch.txt
> b/Documentation/git-filter-branch.txt
> index dfd12c9..2664cec 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -329,6 +329,19 @@ git filter-branch --msg-filter '
>  ' HEAD~10..HEAD
>  --------------------------------------------------------
>  
> +You can modify committer/author personal information using `--env-filter`.
> +For example, to update some developer's email address use this command:
> +
> +--------------------------------------------------------
> +git filter-branch --env-filter '
> +    if [ $GIT_AUTHOR_EMAIL =john@old.example.com  ]

This should read

	if [ "$GIT_AUTHOR_EMAIL" = john@old.example.com  ]

(double quotes, spaces around '='). The paragraph before the example talks
about both author and committer, but the example handles only the author;
it should handle the committer as well.

> +    then
> +        GIT_AUTHOR_EMAIL=john@new.example.com
> +    fi
> +    export GIT_AUTHOR_EMAIL
> +' -- --all
> +--------------------------------------------------------
> +

The place where you inserted the example is reasonable, IMO.

>  To restrict rewriting to only part of the history, specify a revision
>  range in addition to the new branch name.  The new branch name will
>  point to the top-most revision that a 'git rev-list' of this range

-- Hannes

From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD
 as refs
Date: Wed, 08 Jul 2015 19:46:48 +0200
Message-ID: <559D6208.8090607@kdbg.org>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com> <1436316963-25520-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:47:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCtQy-0003G9-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 19:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759417AbbGHRqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 13:46:53 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:37271 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758785AbbGHRqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 13:46:52 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mRSkM3Qkyz5tlM;
	Wed,  8 Jul 2015 19:46:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6313B52BD;
	Wed,  8 Jul 2015 19:46:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1436316963-25520-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273695>

Am 08.07.2015 um 02:55 schrieb David Turner:
> Instead of directly writing to and reading from files in
> $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
> and REVERT_HEAD.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
...
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 366f0bc..e2c5583 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -415,9 +415,9 @@ __git_ps1 ()
>   			fi
>   		elif [ -f "$g/MERGE_HEAD" ]; then
>   			r="|MERGING"
> -		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
> +		elif git rev-parse --quiet --verify "CHERRY_PICK_HEAD" >/dev/null; then
>   			r="|CHERRY-PICKING"
> -		elif [ -f "$g/REVERT_HEAD" ]; then
> +		elif git rev-parse --quiet --verify "REVERT_HEAD" >/dev/null; then
>   			r="|REVERTING"
>   		elif [ -f "$g/BISECT_LOG" ]; then
>   			r="|BISECTING"

We are trying very hard not to spawn any new processes in __git_ps1(). 
So, I raise a moderate veto against this hunk.

-- Hannes

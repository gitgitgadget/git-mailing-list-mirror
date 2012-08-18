From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH v3 2/2] git-svn.perl: keep processing all commits in parents_exclude
Date: Sat, 18 Aug 2012 12:51:44 -0700
Message-ID: <502FF250.6010402@vilain.net>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com> <1344705265-10939-2-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, avarab@gmail.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 21:59:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2pBP-0005KF-LH
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 21:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2HRT7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 15:59:33 -0400
Received: from uk.vilain.net ([92.48.122.123]:44001 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab2HRT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 15:59:32 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 793618283; Sat, 18 Aug 2012 20:51:48 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.136] (c-50-136-135-232.hsd1.ca.comcast.net [50.136.135.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id E45F78272;
	Sat, 18 Aug 2012 20:51:45 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <1344705265-10939-2-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203690>

On 08/11/2012 10:14 AM, Steven Walter wrote:
> This fixes a bug where git finds the incorrect merge parent.  Consider a
> repository with trunk, branch1 of trunk, and branch2 of branch1.
> Without this change, git interprets a merge of branch2 into trunk as a
> merge of branch1 into trunk.
>
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> ---
>   git-svn.perl                                     |    1 -
>   t/t9164-git-svn-fetch-merge-branch-of-branch2.sh |   53 ++++++++++++++++++++++
>   2 files changed, 53 insertions(+), 1 deletion(-)
>   create mode 100755 t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
>
> diff --git a/git-svn.perl b/git-svn.perl
> index abcec11..c4678c1 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3623,7 +3623,6 @@ sub parents_exclude {
>   				if ( $commit eq $excluded ) {
>   					push @excluded, $commit;
>   					$found++;
> -					last;
>   				}

I could believe that, too.  I like this change: one line of code, 53 
lines of test and a paragraph of explanation :-).

Cheers,
Sam.

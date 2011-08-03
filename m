From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v14 8/8] bisect: change bisect function to update BISECT_HEAD, rather than HEAD.
Date: Wed, 3 Aug 2011 06:43:08 +0200
Message-ID: <201108030643.09014.chriscool@tuxfamily.org>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com> <1312323362-20096-9-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 06:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoTIl-00038u-5u
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 06:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab1HCEnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 00:43:21 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49406 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab1HCEnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 00:43:18 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 898C7A619E;
	Wed,  3 Aug 2011 06:43:10 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312323362-20096-9-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178539>

I think a better title for this patch would be something like:

bisect: update BISECT_HEAD, rather than HEAD, when using --no-checkout

But anyway in my opinion the patch series would be better if this patch was 
squashed into the previous patches.

On Wednesday 03 August 2011 00:16:02 Jon Seymour wrote:
> This function modifies git-bisect so that the --no-checkout option
> uses BISECT_HEAD rather than HEAD to record the current bisection
> head.

s/This function/This patch/
 
> The intent is to reduce the confusion that uses of --no-checkout

s/uses/users/

> may experience when using the --no-checkout option since the bisection
> process will no longer introduce spurious differences between the
> HEAD reference and the working tree and index.
> 
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  Documentation/git-bisect.txt |    8 ++++----
>  bisect.c                     |    2 +-
>  builtin/bisect--helper.c     |    2 +-
>  git-bisect.sh                |   17 +++++++++++++----
>  t/t6030-bisect-porcelain.sh  |   30 +++++++++++++++---------------
>  5 files changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 2014894..a9b217b 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -267,9 +267,9 @@ OPTIONS
>  -------
>  --no-checkout::
>  +
> -This option is used to specify that 'git bisect' should not modify the
> working -tree or index on each iteration of the bisection process but
> should -update HEAD instead.
> +This option is used to specify that 'git bisect' should not checkout the
> +new working tree at each iteration of the bisection process but should
> +instead update BISECT_HEAD.

I would say something like:

Do not checkout the new working tree at each iteration of the bisection 
process. Instead just update a special reference named 'BISECT_HEAD' to make 
it point to the commit that should be tested.

>  +
>  This option is useful in circumstances in which checkout is either not
>  possible (because of a damaged respository) or is otherwise not required.

Thanks,
Christian.

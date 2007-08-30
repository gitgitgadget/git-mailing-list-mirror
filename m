From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-filter-branch: document --original option
Date: Fri, 31 Aug 2007 00:00:13 +0200
Message-ID: <85d4x4d6oi.fsf@lola.goethe.zz>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
	<1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
	<11884938431525-git-send-email-giuseppe.bilotta@gmail.com>
	<7vy7fs7kmc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 00:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQs3t-0001k7-SI
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762007AbXH3WAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 18:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761243AbXH3WAU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 18:00:20 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:60438 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758011AbXH3WAS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2007 18:00:18 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 1DA0E4C50E;
	Fri, 31 Aug 2007 00:00:17 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 0A7B32D3788;
	Fri, 31 Aug 2007 00:00:17 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-062-190.pools.arcor-ip.net [84.61.62.190])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id DC0AE376447;
	Fri, 31 Aug 2007 00:00:16 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1F1BF1D3DB8A; Fri, 31 Aug 2007 00:00:13 +0200 (CEST)
In-Reply-To: <7vy7fs7kmc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 30 Aug 2007 14\:55\:39 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4109/Thu Aug 30 19:18:52 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57079>

Junio C Hamano <gitster@pobox.com> writes:

> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> +--original <namespace>::
>> +	Use this option to set the namespace where the original commits
>> +	will be stored. The default value is 'refs/original'.
>> +
>
> The default seems to be "refs/original/".
>
> Even worse.
>
> I think if you say --force --original refs/head (notice the lack
> of "s" nor slash at the end), the code will get you in a *lot*
> of trouble.
>
> Dscho, don't we want to do something like this?
>
> ---
>  git-filter-branch.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 0190060..a7f50a6 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -134,6 +134,7 @@ do
>  		filter_subdir="$OPTARG"
>  		;;
>  	--original)
> +		case "$OPTARG" in */) ;; *) OPTARG="$OPTARG/" ;; esac
>  		orig_namespace="$OPTARG"
>  		;;
>  	*)

orig_namespace="${OPTARG%/}/"

Sure, it does not win the "portable to Version 7" price, but our
scripts don't do that, anyway.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

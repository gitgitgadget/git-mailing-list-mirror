From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase-i: print an abbreviated hash when stop for editing
Date: Mon, 28 Mar 2016 11:43:12 -0700
Message-ID: <xmqqshzaxx33.fsf@gitster.mtv.corp.google.com>
References: <1458844281-13107-1-git-send-email-ralf.thielow@gmail.com>
	<1459180800-5744-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:43:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akc8G-0007py-EA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 20:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbcC1SnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 14:43:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752327AbcC1SnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 14:43:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE7294E2BC;
	Mon, 28 Mar 2016 14:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yNzcEyrk4753pEIogwuDyr/v4mQ=; b=ZH2VOQ
	qT9aIV5d3CuFbTvb+0Xh4XgvayxoWNBCZkr9yxQlynLLNCFmAnL5Yz3vkSW/gGJv
	PMa3IGADyvuhdUUDsroJ15r2MEQfk7SCf9rpP9EitxEYI0irdlvu1tTWokPSgSRx
	Har3h3ckRsBulOnUjQY3FWDMr1YrF531q2Pmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XFcfjeQus/BI8Cnries5xkD7CCU7mCCM
	Nj2Xs9N2/y7gmwinK06zWIemHi8OJsTU/uaCJJScImxcVH32XHAPdc2P8YKYnC/b
	6TJTRvjpzrdobaFA56w+zaBd+2aHkO5DwNjJGoCD5kC8xQKS4mt50ll2FJUUucDg
	wNb+U3MBonc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6A204E2BA;
	Mon, 28 Mar 2016 14:43:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C7914E2B8;
	Mon, 28 Mar 2016 14:43:13 -0400 (EDT)
In-Reply-To: <1459180800-5744-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 28 Mar 2016 18:00:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED4A9BF4-F514-11E5-862A-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290055>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The message that is shown when rebase-i stops for editing prints
> the full hash of the commit where it stopped which makes the message
> overflow to the next line on smaller terminal windows.  Print an
> abbreviated hash instead.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

Thanks, will queue.

>  git-rebase--interactive.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 4cde685..9ea3075 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -548,7 +548,8 @@ do_next () {
>  
>  		mark_action_done
>  		do_pick $sha1 "$rest"
> -		warn "Stopped at $sha1... $rest"
> +		sha1_abbrev=$(git rev-parse --short $sha1)
> +		warn "Stopped at $sha1_abbrev... $rest"
>  		exit_with_patch $sha1 0
>  		;;
>  	squash|s|fixup|f)

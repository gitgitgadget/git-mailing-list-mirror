From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Mon, 07 Jul 2014 10:05:40 -0700
Message-ID: <xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CMU-0000Yr-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbaGGRFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:05:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57995 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbaGGRFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:05:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A2D026070;
	Mon,  7 Jul 2014 13:05:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wys6nCfuwWyoHJ5MqshRoxVeFPo=; b=P+f6mx
	+ZSNKizaPM8qkcvytS+FKyqta8SHK3c8posoSBW4THTxbVREagcX9ArpdhmRp2+0
	g9UToY4318hRbMWcpKrS6Krw5vAbJ1KMzNNltMdUMBjFRT6u/4rM46eozHd4WDtT
	EN9jbDECJp3u31hQ7koFffzt8oM9KdLSzHjVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rq134+jSzsFRoViN8R7BFP0IC++bjr6d
	zALwl56Lzt5zn8rP/ZlZvnDfDUHq+u6toi5KkkUAz4DFz0ypmWJjCqZ/tOb0zHnZ
	f3IQaIb0Drp9CSqQRvAqmIEW/H28dKOE25owbpEVqdTGervAllElRnVIMvgA6Fxs
	KlnljxTyvQ4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5ABE32606E;
	Mon,  7 Jul 2014 13:05:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A33822605D;
	Mon,  7 Jul 2014 13:05:28 -0400 (EDT)
In-Reply-To: <53B5C7AC.4040701@web.de> (Jens Lehmann's message of "Thu, 03 Jul
	2014 23:14:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E567F75E-05F8-11E4-A548-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252970>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Junio, do you want me to resend 02/14 without the non-portable "echo -n"
> or could you just squash the following diff in?

Amended locally here already; thanks, both.

>
> -----8<----
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 24c9fd7..3584755 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -304,7 +304,7 @@ test_submodule_switch () {
>  		(
>  			cd submodule_update &&
>  			git branch -t add_sub1 origin/add_sub1 &&
> -			echo -n >sub1 &&
> +			>sub1 &&
>  			test_must_fail $command add_sub1 &&
>  			test_superproject_content origin/no_submodule &&
>  			test_must_be_empty sub1
> @@ -547,7 +547,7 @@ test_submodule_forced_switch () {
>  		(
>  			cd submodule_update &&
>  			git branch -t add_sub1 origin/add_sub1 &&
> -			echo -n >sub1 &&
> +			>sub1 &&
>  			$command add_sub1 &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_dir_is_empty sub1
> -- 2.0.1.458.gf680257.dirty

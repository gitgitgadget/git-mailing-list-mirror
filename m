From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 18/25] setup.c: support multi-checkout repo setup
Date: Wed, 26 Mar 2014 14:03:39 -0700
Message-ID: <xmqqd2h8ises.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-19-git-send-email-pclouds@gmail.com>
	<5330469D.9020008@web.de>
	<CACsJy8DQ16xd+LOki0pxDVwPyWJ_hYLqJjW4-4VXa92yo1rD1A@mail.gmail.com>
	<20140325140710.GA25789@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gers?= =?utf-8?Q?hausen?= 
	<tboegi@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:03:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSuzG-0004up-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbaCZVDq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 17:03:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756110AbaCZVDp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 17:03:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B907778B98;
	Wed, 26 Mar 2014 17:03:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0ifREiwq1Yz9
	T13992uVOSNvZjc=; b=t12e2Ya5e88/XK3zPo5f6fs6SpLpRY7mQIqBHILatLVN
	BtzxsMtXJvDdOxk5SqTtwRWER1776liCFHW6Nq4hRyiKvua16oO6tnZcsYP04OCY
	1ipCB9yFbctGovits2iUY9AvtEb6D4Qdn+rB2eyNgnldXTaNmSFWNZ/kyOiuJvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pUnJcz
	30idVRcGc+EA8/d9kVDJajnJ2sP6sRjzLsrHiVe3piseOlGpPcNyH/zKNtmptIUF
	ttWaAJhJjL4z87I2Z/TFtvmlC9KtYj7fjTgOIXOsrXpehTT7LZp4tSGyfuWkZuhW
	4sAEsOWQm+n3lXFqkEhBdl2M1BK15I597Y75c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2DD678B97;
	Wed, 26 Mar 2014 17:03:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D324D78B95;
	Wed, 26 Mar 2014 17:03:43 -0400 (EDT)
In-Reply-To: <20140325140710.GA25789@lanh> (Duy Nguyen's message of "Tue, 25
	Mar 2014 21:07:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D754FF4-B52A-11E3-8F1F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245227>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 25, 2014 at 08:52:13PM +0700, Duy Nguyen wrote:
>> On Mon, Mar 24, 2014 at 9:52 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>> > Did I report that t1501  fails when  there is a softlink in $PWD ?
>> > /home/tb/projects is a softlink to /disc5/projects/
>>=20
>> Yes you did and I forgot. I have fixed it, running test suite and wi=
ll
>> send the reroll soon.
>
> Junio, it seems you have picked up all minor changes after
> v5. Resending the whole series for one fix seems overkill. Could you
> just --autosquash this one in?

Gladly; thanks for a quick turnaround.

> -- 8< --
> Subject: [PATCH] fixup! setup.c: support multi-checkout repo setup
>
> ---
>  t/t1501-worktree.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index 2ac4424..e6ac7a4 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -359,7 +359,7 @@ test_expect_success 'GIT_DIR set (1)' '
>  	(
>  		cd work &&
>  		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
> -		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
>  		test_cmp expect actual
>  	)
>  '
> @@ -370,7 +370,7 @@ test_expect_success 'GIT_DIR set (2)' '
>  	(
>  		cd work &&
>  		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
> -		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
>  		test_cmp expect actual
>  	)
>  '
> @@ -381,7 +381,7 @@ test_expect_success 'Auto discovery' '
>  	(
>  		cd work &&
>  		git rev-parse --git-common-dir >actual &&
> -		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
>  		test_cmp expect actual &&
>  		echo haha >data1 &&
>  		git add data1 &&
> @@ -399,7 +399,7 @@ test_expect_success '$GIT_DIR/common overrides co=
re.worktree' '
>  	(
>  		cd work &&
>  		git rev-parse --git-common-dir >actual &&
> -		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
>  		test_cmp expect actual &&
>  		echo haha >data2 &&
>  		git add data2 &&

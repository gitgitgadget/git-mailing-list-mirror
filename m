From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] worktree: add "unlock" command
Date: Tue, 31 May 2016 11:31:05 -0700
Message-ID: <xmqqmvn63wra.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-7-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:31:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7oRe-0005Iu-HN
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbcEaSbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 14:31:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753822AbcEaSbI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 14:31:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40D4A1EAE3;
	Tue, 31 May 2016 14:31:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h3AZFzpqe3yn
	cFsAqsLxwsa6+00=; b=CroJCwlgDB8AJirpf3TcttKUgXxCnhdP1g+SAkSehVa4
	fyOfM0cnF3zvSGHA1XR1bqwJ4yCP5SbPdm28a4I/jq2Pog0Wcqfa7+zVObSZsJe1
	ybZGUKHHCrvCvqLNRMZZlNoUYupOt6Deg9Yis9iZpaUKt8SKsfPPNMu8/yJw5aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s6htBc
	bO7Ek1TriQ8EpGoj5/e6w8uZTu36ZK7oBNBTD2yiilDNj2LDkSDAiIXB1U8iKmXL
	vOoKZbIFLV5SFPzpdskGu9R2EQge/vmFQVbCK0qogg+5xxcbHpGxAtG24PtaVcWf
	Ac6LftHjqoDz3W7f7lavfG402yOQu+s2ovIHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 393D11EAE2;
	Tue, 31 May 2016 14:31:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC7681EAE1;
	Tue, 31 May 2016 14:31:06 -0400 (EDT)
In-Reply-To: <20160530104939.28407-7-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Mon, 30 May 2016 17:49:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6A328A0-275D-11E6-BFBE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296007>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-worktree.txt         |  5 +++++
>  builtin/worktree.c                     | 28 ++++++++++++++++++++++++=
++++
>  contrib/completion/git-completion.bash |  2 +-
>  t/t2028-worktree-move.sh               | 14 ++++++++++++++
>  4 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> index 6fca6cf..6a5ff47 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  'git worktree list' [--porcelain]
>  'git worktree lock' [--reason <string>] <worktree>
>  'git worktree prune' [-n] [-v] [--expire <expire>]
> +'git worktree unlock' <worktree>

Again, this seems to be built on an unseen version.  I think I fixed
these up (and also the "missing second colon in the doc"), but please
double check what I push out later today.

Thanks.

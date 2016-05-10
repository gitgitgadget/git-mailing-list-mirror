From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/13] worktree.c: mark current worktree
Date: Tue, 10 May 2016 16:03:06 -0700
Message-ID: <xmqqzirxldn9.fsf@gitster.mtv.corp.google.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-6-git-send-email-pclouds@gmail.com>
	<CAPig+cQszEZLaebwqXNny6_EnhFpwU1xYqEX2_0N=vTEXTk2Fw@mail.gmail.com>
	<CACsJy8D+anuZ-278kaz2ewpcLCGOSrdn2Qq1F7fFTuVUTLv5Yw@mail.gmail.com>
	<20160510141416.GA22672@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 01:03:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0GgW-0001Q4-QG
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 01:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbcEJXDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 19:03:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751938AbcEJXDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 19:03:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B5371BCC1;
	Tue, 10 May 2016 19:03:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ywsmbvABU0cp2iNoiy6+4VIn/0=; b=pZGWND
	BWfBNPF5DETIVeJAq7iqIU2S3CI6JP5qun3/AI/dv/u/LHpMl7JSW4PxomyATmet
	7u0Q3oQ/QAsrpnBUBT6C8Wtw3VW8w8FOWD7pXU56p2oAQJcy0p8XXHdV7yk80Sin
	ky+M81DTiIy9Ze9m9WPVhjhX04xmJ2DheYxJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rWnE5sKwDmnl2s5oEq+nvjd6SDZKSNwW
	rayKRMNEd3bCQICcX2YflBDsz3ldq9J3JGFSFroHvqObhPTXi4+FB6A6igevjm/m
	bZtL7QiyPMc2BKDca8e09qr3Y3uCBSHiGgkPGaunIOfaRwYDFOoRU0w08jplC4o6
	Vrc+Mi4v7TY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 13C361BCC0;
	Tue, 10 May 2016 19:03:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A3AF1BCBF;
	Tue, 10 May 2016 19:03:08 -0400 (EDT)
In-Reply-To: <20160510141416.GA22672@lanh> (Duy Nguyen's message of "Tue, 10
	May 2016 21:14:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C78B780-1703-11E6-913C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294205>

Duy Nguyen <pclouds@gmail.com> writes:

> On second thought, why hold patches back, lengthen the worktree-move
> series and make it a pain to review? I moved a few patches from
> worktree-move into this series and I took two other out to create
> nd/error-errno. So I'm going to take more patches out of it, creating
> two bite-sized series, to be sent shortly.
>
> The first one is purely cleanup (ok, 1/7 is not exactly cleanup)
>
>   [1/7] completion: support git-worktree
>   [2/7] worktree.c: rewrite mark_current_worktree() to avoid
>   [3/7] git-worktree.txt: keep subcommand listing in alphabetical
>   [4/7] worktree.c: use is_dot_or_dotdot()
>   [5/7] worktree.c: add clear_worktree()
>   [6/7] worktree: avoid 0{40}, too many zeroes, hard to read
>   [7/7] worktree: simplify prefixing paths

Where are these patches designed to apply?

It appears that this depends on something in 'next' (probably
nd/worktree-various-heads topic?)

>
> And the second one adds "git worktree lock" and "git worktree
> unlock". This series is built on top of the first one, it needs 1/7.
>
>   [1/5] worktree.c: add find_worktree_by_path()
>   [2/5] worktree.c: add is_main_worktree()
>   [3/5] worktree.c: add is_worktree_locked()
>   [4/5] worktree: add "lock" command
>   [5/5] worktree: add "unlock" command
>
> After this, worktree-move becomes ~10 patch series.

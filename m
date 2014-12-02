From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Tue, 02 Dec 2014 09:23:13 -0800
Message-ID: <xmqqh9xem0e6.fsf@gitster.dls.corp.google.com>
References: <cover.1417033080.git.johannes.schindelin@gmx.de>
	<cover.1417041787.git.johannes.schindelin@gmx.de>
	<ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de>
	<xmqqr3wjnd65.fsf@gitster.dls.corp.google.com>
	<xmqqk32aoowa.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412020909020.13845@s15462909.onlinehome-server.info>
	<xmqqzjb6m3a2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:23:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrAd-0005YC-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbaLBRXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:23:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753974AbaLBRXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:23:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86B1D2354C;
	Tue,  2 Dec 2014 12:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crGOJwACAHCReqwVi4ITb6ensbk=; b=XYnhBI
	L5AdYy37Ax74dtCBIMZbE3srrrHWMZbKEt7fYUvmXUI0sw3P+BcvU9/33dTXJ0DY
	A02MJzEqbJMlnxpi7/xjnWWv2Shh523bdrlYhHe+Edc0wwFJS4NgbyrHVNkHXK7z
	IfF4VxSq0zcMkzcOzzYNjVJ6ZUEGy0poNJ8es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Co5wgL0ZuE7k4wD5p2PRecmCvUc4PNww
	q9LJ2GyUu17MxG2laX+X4CVizQL3uFMY4CsKNIPCRUje8uoH0aHeRRb+8GhBEQFd
	Cg4MhbX97bR4tSWx/231d96Teznn6IqKeHaPPkFdgsJFUlEGYVRA1dzm6P8mpbZL
	E3qjfD8LYgM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E2022354B;
	Tue,  2 Dec 2014 12:23:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8C622353F;
	Tue,  2 Dec 2014 12:23:14 -0500 (EST)
In-Reply-To: <xmqqzjb6m3a2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Dec 2014 08:20:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5F13BE0-7A47-11E4-B44C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260580>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> This is because you know receive-pack runs inside the $GIT_DIR,
>>> whether it is a bare or non-bare repository, so either core.worktree
>>> points at a directory that is otherwise unrelated to the $GIT_DIR
>>> (but is the correct $GIT_WORK_TREE), or the top of the working tree
>>> must be ".." for a non-bare repository....
>
> And this reasoning may be broken, unfortunately.
>
> In a repository with separate-git-dir, we enter $GIT_DIR that is
> pointed by the "gitdir: $over_there" thing, and once we go there,
> we have no linkage back to find where the working tree is unless
> there is core.worktree set, do we?
>
> This feature (with or without the push-to-checkout hook, as that
> shares exactly the same logic that discovers, or fails to do so,
> where the working tree is) needs to be documented with an entry in
> the BUGS section, saying that it will not work in a repository that
> is tied to its working tree via the "gitdir:" mechanism.
>
> It actually is a lot worse than merely "it will not work", when this
> problem ever manifests itself.  The use of this mechanism in such a
> repository will destroy the contents of a wrong directory that
> happens to be the parent directory of a repository pointed by the
> "gitdir:" mechanism, unless core.worktree is set.  Fortunately, real
> submodule directories found in the ".git/modules/" directory of the
> superproject, even though they are bound to their checkout locations
> in the working tree of the superproject using "gitdir:" mechanism,
> do maintain their core.worktree when "git submodule" manages them,
> so the use of the mechanism in submodule setting may be safe.

Actually the other part of the system that uses "gitdir:" mechanism,
i.e. "git init --separate-git-dir $real $worktree", does add the
core.worktree configuration in $real/config pointing at $worktree,
so the above is simply me being overly worried.  If somebody uses
the "gitdir:" mechanism without setting core.worktree to point back,
that is a misconfigured repository/worktree pair, so there is no
need for any BUGS entry.

Sorry about the noise.

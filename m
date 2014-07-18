From: Junio C Hamano <gitster@pobox.com>
Subject: Re: a more helpful message on "git status" output
Date: Fri, 18 Jul 2014 12:29:11 -0700
Message-ID: <xmqq38dympo8.fsf@gitster.dls.corp.google.com>
References: <CAKQhN+rK0ftwC5hX4hDhXZbcEGAfCCBXRaQXYnMFLmR=n21OLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Juli=C3=A1n?= Landerreche <maniqui@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:29:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8DqP-0005Bk-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 21:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422939AbaGRT3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 15:29:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63093 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbaGRT3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 15:29:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5029428845;
	Fri, 18 Jul 2014 15:29:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SHK+AFRzyWO3
	F29xlKKopUrV1cA=; b=v882PeObt4hymSJ7ZQh7t29M+WGDyC0OKD6ug5AkZhPy
	dahF/HQ5dKyVybr02GJlaW9oMeTr5+9Zf0CTM8kFrIF9QYobVvYVM63kMJnw901d
	UqQMdh6wVW94xRC4vEArDP7wthOz1ZCRRPbZqaGYYbvQvSpTV3MujOuNPZs8OUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PVlRx7
	2feeGJ/ZiLjZVaKRmKAHQXw3GSdK7XphpzafwGOCeittIeUOdxjlrT2sIQM3ToKM
	l6smj4m0wsoYV9ldFqDAd0NdaM6JtjAOEP0R81BS/VnHD+4LjEzdORYQ4II1kgVz
	4QdPY2oL7hnQbtuLixuFTNHp6JmVdvwQ8e4n0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E01028844;
	Fri, 18 Jul 2014 15:29:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A2E52882C;
	Fri, 18 Jul 2014 15:29:13 -0400 (EDT)
In-Reply-To: <CAKQhN+rK0ftwC5hX4hDhXZbcEGAfCCBXRaQXYnMFLmR=n21OLA@mail.gmail.com>
	(=?utf-8?Q?=22Juli=C3=A1n?= Landerreche"'s message of "Fri, 18 Jul 2014
 16:03:43 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CCCC2276-0EB1-11E4-9D28-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253841>

Juli=C3=A1n Landerreche <maniqui@gmail.com> writes:

> when running "git status", if the current branch can be
> fast-forwarded, the user get this message:
>
>   On branch master
>   Your branch is behind 'origin/master' by 6 commits, and can be fast=
-forwarded.
>     (use "git pull" to update your local branch)
>
> The suggestion of using "git pull" for updating the local branch,
> although it will work, might not be a proper choice or advice in term=
s
> of what is really needed to just update the local branch.
>
> As the user already has the newer commits locally (ie. the commits
> have been already "git fetch"ed), he just needs to merge them. Runnin=
g
> "git pull" will unnecessarily try to fetch commits from upstream
> again.

By running "git pull", the user may obtain yet newer commits from
the upstream, which very likely will happen in an active project, or
"git fetch" launched by "git pull" will return without doing
anything after noticing there is nothing new.

As long as the updates to the upstream is also a fast-forward, it
will still fast-forward you, but to an even newer state of the
upstream.

There is no harm done[*1*] by suggesting "git pull" over "git
merge", no?


[Footnote]

*1* There is a bigger problem with this message, especially when the
user sees it on 'master', but your message is about the case where
you are strictly behind and that bigger problem will not be an
issue, so I won't discuss it further.

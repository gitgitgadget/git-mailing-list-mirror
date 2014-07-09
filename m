From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 09 Jul 2014 12:22:24 -0700
Message-ID: <xmqqr41u9w27.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BD7A36.2030300@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Torsten =?utf-8?Q?B=C3=B6gershaus?= =?utf-8?Q?en?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 21:22:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4xRv-0008Kz-OB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 21:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbaGITWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 15:22:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51723 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756210AbaGITWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 15:22:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F10502876A;
	Wed,  9 Jul 2014 15:22:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9+KS7Y1mIHZSAJoQJbDIYDJwGOI=; b=MKcala
	zCKyRPhzEGcRh0cU8uYdeIcOnU0ZobLtMfPpS/saAlOzxgz0DJqjjwgKwTB7wpIz
	gqpJgpT9L42SCny+SNRJjXfqb8wNgR9O8ooQ3RF0J8nfDHIbMTFMc0pXg7l4Dsiu
	diEbXzG3FdKB1BovV2ZpiQub4PuJ0Nad2+fPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImrZcOdWD65BJ+TR16ORCgYPVb1FC41O
	TRZ7VCk4PAt01x8tY0bCr99Pb7rMWc3aXzaNVPCo5LhX6V+jKtseDYddqWyDKhRV
	lggDieGgdJ3IX9I4GIKCDmjEwD7TK4CLZZOtP1ZUPjH0hx4YTHc+TAi2SwqsHYD4
	Ee3jxLMm9os=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E561828769;
	Wed,  9 Jul 2014 15:22:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2C8328762;
	Wed,  9 Jul 2014 15:22:11 -0400 (EDT)
In-Reply-To: <53BD7A36.2030300@kdbg.org> (Johannes Sixt's message of "Wed, 09
	Jul 2014 19:21:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53A4059A-079E-11E4-BE21-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253139>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 08.07.2014 21:34, schrieb Jens Lehmann:
>>> And Msysgit complains 
>>> error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/submodule_update_repo/.git/modules/sub1/config.lock failed: Function not implemented
>> 
>> I'm not sure what this is about, seems to happen during the "cp -R" of
>> the repo under .git/modules into the submodule.
>
> No. It happens because fchmod() is not implemented in our Windows port.
>
> Please see my band-aid patch at
> http://thread.gmane.org/gmane.comp.version-control.git/248154/focus=20266
> The sub-thread ended inconclusive.

We need to start somewhere, and a no-op fchmod() in your patch may
be as a good place to start as anything.  At least we would then
keep the old behaviour without introducing any new failure.

An alternative might be to use chmod() after we are done writing to
the config.lock in order to avoid the use of fchmod() altogether,
which I think can replace the existing two callsites of fchmod().
That approach might be a more expedient, but may turn out to be
undesirable in the longer term.

I also wonder if this "carry forward the original permission bits
when updating an existing file by first writing the updated contents
into a lockfile and then renaming it after we are done" pattern
ought to be done in the lockfile API at commit_lock_file() time (Duy
and Michael Cc'ed for their input, as they have recently touched
lockfile API implementation in their series somewhat), not at the
level of the user of the lockfile API like Eric's patch daa22c6f
(config: preserve config file permissions on edits, 2014-05-06) did
only for the config file.

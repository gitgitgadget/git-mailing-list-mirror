From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Wed, 23 Jul 2014 11:24:54 -0700
Message-ID: <xmqqa980djbd.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<53CFC414.1010601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:25:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1Dz-0005Rf-6m
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbaGWSZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:25:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65000 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932766AbaGWSZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:25:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B01F528A19;
	Wed, 23 Jul 2014 14:25:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gm4QoCykN3t1G3dduJ8owB9cbP8=; b=AzSHmz
	86Dzs3zic9Z/9y2/MguZRhrc+PfiZmVGjS6Lm4byy8KwitYMP5kdGIotmaQqOPdL
	7/7/lwg0D5ePSvDemEdOKcDdmLmO8UUEbLpLKbMOHtpEuEaZP9fm/Hg+kfHI5Dk6
	DOkU4Gc6aMzVG2CBdi9lMQ0L0O/1lUV4WLLHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=foZ3p7Roph/NRx49/oRuNIMOBVY5a0cm
	GO6YAGG0nUktegY9lH8b3kxCFlCe1EjgQkUNlwUzg0vXviG4ICfXPvYt4RlHPO2o
	NRNfZseltDs6d3L5HCjJw6bynuwFD1PppAnhdP077e0uEcSagsbliffOZSHJw/Kk
	dX5+4lyDHjg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77F0628A17;
	Wed, 23 Jul 2014 14:25:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2CF9028A0D;
	Wed, 23 Jul 2014 14:24:56 -0400 (EDT)
In-Reply-To: <53CFC414.1010601@gmail.com> (Karsten Blees's message of "Wed, 23
	Jul 2014 16:17:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A5AD4B64-1296-11E4-9117-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254100>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 22.07.2014 23:44, schrieb Junio C Hamano:
>> 
>> * sk/mingw-uni-fix-more (2014-07-21) 14 commits
>> ...
>> * sk/mingw-tests-workaround (2014-07-21) 6 commits
>> ...
>
> Yes, I think both series are ready.
>
> Compiles with msysgit and MSVC (with NO_CURL=1).

Thanks.

> With the version in pu, three tests fail. t7001 is fixed with a newer 'cp'.

It seems that the only use of the "copy symlinks as-is" in that test
are to move trash/submodule/.git to trash/.git/modules/submodule;
as the longer-term direction is not to rely on symlinks in .git/
(and we have got rid of HEAD -> refs/heads/master long time ago),
perhaps we do not even want to have "-P" there?

> The other two are unrelated (introduced by nd/multiple-work-trees topic).
>
> * t1501-worktree: failed 1
>   As of 5bbcb072 "setup.c: support multi-checkout repo setup"
>   Using $TRASH_DIRECTORY doesn't work on Windows.
>   
> * t2026-prune-linked-checkouts: failed 1
>   As of 404a45f1 "prune: strategies for linked checkouts"
>   Dito.
>
> * t7001-mv: failed 6
>   'cp -P' doesn't work due to outdated cp.exe.

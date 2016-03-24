From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 09:11:27 -0700
Message-ID: <xmqqpoujama8.fsf@gitster.mtv.corp.google.com>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stanislav Kolotinskiy <stanislav@assembla.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:11:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj7rD-00045d-Co
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbcCXQLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 12:11:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751303AbcCXQLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 12:11:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5440B4AF34;
	Thu, 24 Mar 2016 12:11:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E2j5MvaVIG9tgIQl/AbYXLbiJmc=; b=vYWWIM
	YlORhICojL9n7nvdvDbTILWdGaHXPUhMnE3Ajm3gqoS8Q/j6tKY/26giR/KpIsHG
	wSmkhvkcZK/ABFFjsMvYhUYl/ofpXQFdaKB1YGG2ndcIJN7qzR0snJUW0r7M4EQL
	nD/jjxmg+mDw7aUDvZqnt5cj4bXKI8DjbFAwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IjDCwQEnOiSpq/YSejA+N9/EXaFH095K
	G3yAypuW3pe4C1RH/jn4J8rhEqp6UUF4bnyUjZpSiz1ck1t6WYqexLhLQOjbMXIt
	wk3grnhJ/Qb3qDF6+btL6KViOihh49EhUYFdKfyfj/rUnxB/eoGOfY8Pms6i5sP7
	+29pHJvg1d4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B55E4AF32;
	Thu, 24 Mar 2016 12:11:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B212F4AF31;
	Thu, 24 Mar 2016 12:11:28 -0400 (EDT)
In-Reply-To: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
	(Stanislav Kolotinskiy's message of "Wed, 23 Mar 2016 18:24:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10D882E4-F1DB-11E5-9EEC-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289755>

Stanislav Kolotinskiy <stanislav@assembla.com> writes:

> Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory

Please see "git shortlog --no-merges" output from recent history and
notice that s/Fix/fix/ would make things more consistent.

> When using git send-pack with --all option and a target directory,
> usage message is being displayed instead of performing the actual
> transmission.
>
> The reason for this issue is that refspecs variable is being
> calculated in a different way comparing to previous versions, and
> even though the number of refspecs (nr_refspecs) is 0, refspecs
> contain all the arguments and switches passed to send-pack.

Thanks for noticing; the above explanation however does not make it
very clear why the symptom exhibits itself only when "directory" is
given (it also is unclear if "target" being a directory is special,
or if any remote repository specification, e.g. host:/path/to/dir,
triggers the same problem).

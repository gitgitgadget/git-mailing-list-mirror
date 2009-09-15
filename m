From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Colouring whitespace errors in diff -B output
Date: Tue, 15 Sep 2009 13:12:54 -0700
Message-ID: <7vab0w55mh.fsf@alter.siamese.dyndns.org>
References: <1252995306-32329-1-git-send-email-gitster@pobox.com>
 <20090915155209.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 22:13:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MneP2-0008SS-9P
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 22:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbZIOUNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 16:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbZIOUNA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 16:13:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbZIOUM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 16:12:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93E11528FF;
	Tue, 15 Sep 2009 16:13:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QJCPT9TeaqJB1HcabK/3t36rBGw=; b=dwZCqh
	8hYUIwoEFcKjMP2Yl7etnYaBzfoyW/KtZxg4xOYpbypICj3pcKthh6OoTjiTXllu
	tsTBWdxqKS4aSjIUjtUYXswuIC6Ju3GHtTse/xGCWIELA3qBHZ7sUXrKgtGN28cH
	66Hx/F1JLyxjdpfGxqu/Ckp3vZusNtsrN6HqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qmso+gr/ggkki0bJb7NCzs/OmoySVULl
	IP0fW8OfP2ahOkvFacVBHLnvt+HhbKj+6PEMVngj443qMjurfbAwVDEG5YK/GJOo
	Td6iSkipfNeBH16R5nmJ8uSv9qKYoMucm2S0NoeVNpv0gmEv56oRyD31RrnO9tgY
	wUzHyQ76VeI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77D4A528FD;
	Tue, 15 Sep 2009 16:12:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31017528FB; Tue, 15 Sep 2009
 16:12:55 -0400 (EDT)
In-Reply-To: <20090915155209.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue\, 15 Sep 2009 15\:52\:09 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29EA6F34-A234-11DE-85BF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128584>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> The last one hooks "diff -B" logic to the per-line output routines in a
>> way that mimicks how the normal patches are fed to them better, in order
>> to take advantage of all the existing whitespace error detection and
>> colouring logic.
>>
>> Junio C Hamano (4):
>>       diff.c: shuffling code around
>>       diff.c: split emit_line() from the first char and the rest of the line
>>       diff.c: emit_add_line() takes only the rest of the line
>>       diff -B: colour whitespace errors
>>
>>  diff.c |  327 +++++++++++++++++++++++++++++++++++-----------------------------
>>  1 files changed, 180 insertions(+), 147 deletions(-)
>
> Sorry, but I don't seem to be able to apply these patches anywhere.

There is a subtle bug in "split emit_line()" patch I sent out, but later I
noticed the problem and fixed it in my tree, so please use the updated one
instead from my tree.

The series applies cleanly at the tip of jc/maint-1.6.0-blank-at-eof, but
the result of applying them will have large conflicts whether you are
merging that into 'maint', 'master', or 'next'.  It's probably easier to
use the merge I've prepared to resolve them in my tree.

I have these two topics:

 - jc/maint-1.6.0-blank-at-eof forks from old 1.6.0 codebase to contain
   the above fixes (and the ones that are already in 'next'); and

 - jc/maint-blank-at-eof that forks from 1.6.4 codebase and merges the
   above branch.  This branch does not have any commit on its own, but
   does a rather nasty conflict resolution.

I'll push out the result, merging the latter to 'next' (and 'pu'),
sometime in the next few hours.

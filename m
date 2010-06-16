From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere.txt: Document forget subcommand
Date: Wed, 16 Jun 2010 10:33:06 -0700
Message-ID: <7vljaeg9wt.fsf@alter.siamese.dyndns.org>
References: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
 <ebd2b2b5bb3352c6204f181416a7a521f8c6abf7.1276582759.git.git@drmicha.warpmail.net> <7vr5k86ylg.fsf@alter.siamese.dyndns.org> <4C188060.5000903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 16 19:33:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOwUY-00022N-WD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 19:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759330Ab0FPRdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 13:33:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759306Ab0FPRdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 13:33:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F8DBCC04;
	Wed, 16 Jun 2010 13:33:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qFNhEA7MAwNNW+1xUi6CFGWUEyg=; b=P3S+qg
	DqoUsWS1SR74hwBBEckcKVC7IJZFQXIcsm/yzlnB2e9AUqiCoBOziyvrJHOHg/dX
	+8VWzWuixDxc07EhN7OFB5/pi2LqZkeQs+7qdJzdgSL+AHJn5P08N4wgcDPAuLEF
	xY19Fxqa7dwn30whB6jhxoxgSrD0d0y+QWZFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v05BJMQyq7omAxQFibgq7VLPeiHCU8ev
	92UtacwK/7PqVmh2BFfPJ+l3VqT66riD3he75Al6xj2MT3+LW8rDlBJRFO41SoNi
	te18rjbS1pLSuh2+010PeeMOt1hypMuCRnUhMbqOrw9v15hMFNSlUM4oYcSSZDoD
	6gtF1h8/iUU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D97BCC03;
	Wed, 16 Jun 2010 13:33:12 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A47D8BCBFF; Wed, 16 Jun
 2010 13:33:08 -0400 (EDT)
In-Reply-To: <4C188060.5000903@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 16 Jun 2010 09\:42\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D047F72-796D-11DF-AA23-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149268>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 15.06.2010 18:37:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>> +'forget' <pathspec>::
>>> +
>>> +This resets the conflict resolutions which rerere has recorded for <pathspec>.
>> 
>> This description is not _incorrect_ per-se, but it does not convey one
>> important aspect of the subcommand; unlike "clear" and "gc", "forget" only
>> works in the context of the _current_ conflict resolution, just like
>> "diff" and "status".
>
> Does "current context" mean
>
> - any recorded resolutions for the hunks which are currently recorded as
> in in conflict
>
> or
>
> - the resolution which has (just) been recorded for the current conflict?

The latter.  You can have more than one rerere database entries for the
same path (i.e. merge conflict resolutions for unrelated branches, each of
which changes unrelated things that happen to be in the same path).  The
entries in the rerere database are "when we see a conflict of this shape
(anywhere), the user wants to resolve it this way", indexed by the shape
of the conflict.  There is no "path" recorded in the database.

When "rerere forget" is run, it needs to be told which entry to forget,
and this is done by regenerating the conflict you just had (and possibly
have already resolved, if you are using recent enough git that knows
"resolve undo") using the information in the index, and <pathspec> is used
to limit this set (i.e. when you have more than one path conflicted in the
current merge).

> In any case, rerere forget is not a solution for the original "amend
> merge commit and forget previous resolution" question, I guess (I just
> happened to note it's undocumented). One would have to redo the merge to
> get the conflict info into the index, right?

Once you write the result of a merge out to a tree, the tree does not even
know if there was a conflict.  It does not know how you arrived to that
state in general.  You simply don't have enough information after reading
a tree into your index in order to "amend" it.  When reading a tree that
belongs to a merge commit into the index, we _could_ try to regenerate the
conflicted state and immediately resolve them to the tree's state but I
don't think it is worth the cost and complexity.  Besides, at that point
you do not even know what merge strategy (and which version of that
strategy) was originally used.

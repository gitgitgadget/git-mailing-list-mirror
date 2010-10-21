From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [long] worktree setup cases
Date: Thu, 21 Oct 2010 16:06:30 -0700
Message-ID: <7vlj5rrvrd.fsf@alter.siamese.dyndns.org>
References: <20101020085859.GA13135@do>
 <7v8w1svate.fsf@alter.siamese.dyndns.org>
 <20101021190146.GC28700@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Fri Oct 22 01:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P94Dc-000793-Px
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 01:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0JUXGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 19:06:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0JUXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 19:06:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DBD8E01A1;
	Thu, 21 Oct 2010 19:06:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EUIE/bHv/RbDXanHfkvV9sN58e4=; b=q5Sd7w
	pHi/8GhHyCvyIyXDMQF5ARiXR+Y8dJBS87rmEXnzSP0QwJRaHEk+euqa45w3IIva
	Vw9wtlbWqSQw9aD5YKOepKLUJ6l+V37v1lhZVPPiyfxOQHJgLUc0SUgWSU6ypaI7
	gtGFULwmwXJogXTdKtnHeZXT9KkrESH9g33Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OaXdxmU9h/q012bPjV0e+PNkQ01DDaPZ
	PkhSC+CIb0N/YWshmjf6sryp0y+PyeS0xThwYqMz+nQ09JX0YY3JaZBMnHGPwbk0
	UCEkz5TYUIc/nlTrAVaHsj0pNC/Boc0oqi99gZfhIwP16BUM+vLuu3gAZG+A4GIp
	jWWg7oPkbUg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1492FE019E;
	Thu, 21 Oct 2010 19:06:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0917CE017F; Thu, 21 Oct
 2010 19:06:31 -0400 (EDT)
In-Reply-To: <20101021190146.GC28700@nibiru.local> (Enrico Weigelt's message
 of "Thu\, 21 Oct 2010 21\:01\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9D7A14A-DD67-11DF-8778-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159586>

Enrico Weigelt <weigelt@metux.de> writes:

> * Junio C Hamano <gitster@pobox.com> wrote:
>
>> If you set GIT_DIR, we do no discovery, so git will work only from the
>> root level of the working tree (or bare repository operation) if you do
>> not tell us where the working tree is.
>
> Well, we could look at config whether it's an non-bare repo and then
> lookup worktree via core.worktree (which would default to "../").

core.worktree is "you tell us where the working tree is" in the above.

> BTW: the whole discovery process IMHO should start w/ looking for 
> the gitdir. Could be done this way:

That should be more or less what we have been doing since the first day we
started supporting git operations from subdirectories around d288a70
([PATCH] Make "git diff" work inside relative subdirectories, 2005-08-16).

It is possible that we might have broken some over the course while adding
core.worktree and GIT_WORK_TREE support, but I doubt it.

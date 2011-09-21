From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Wed, 21 Sep 2011 13:35:43 -0700
Message-ID: <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
 <7vr53a2icn.fsf@alter.siamese.dyndns.org>
 <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Alexander Pepper <pepper@inf.fu-berlin.de>
X-From: git-owner@vger.kernel.org Wed Sep 21 22:35:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6TWH-0005tF-S2
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 22:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967Ab1IUUfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 16:35:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab1IUUfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 16:35:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA5B68BD;
	Wed, 21 Sep 2011 16:35:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=angcp6rcXBVggzpiKs4RL7XGO9g=; b=JIaoLS
	EdsZgxXWsGRDTHiUlVYR8GCkAyLIBCje0XAYZalWmzAK1K7puLoWsCCnads4/O3C
	5/3iA+5ohPR22PjKameonkUKmElzO+v5jb/CuCfw6u40io2W2jp5AZkV6Pf7dyuf
	991NicLkidbsQpaO4IYi2KjPvquCHZ83wJtcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sMdWKMoZ8spGRDC7e2MKLUt4wsiyAZGV
	RaZakMluTUHTBhfaDxeg9eL3MRaoC7fQwwo4F6lib9TTPqpBzLBrDKPbNiRmY+AQ
	CJSud21ZkOgRMneKdWsgUk9KbsFi/jjRQshsAt0yRLqqo2iXNzvOxAuSFN0Uc9Xz
	dQjZWJ9H3g4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9417468BC;
	Wed, 21 Sep 2011 16:35:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1306668BB; Wed, 21 Sep 2011
 16:35:44 -0400 (EDT)
In-Reply-To: <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
 (Alexander Pepper's message of "Wed, 21 Sep 2011 16:23:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 480687CC-E491-11E0-810D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181862>

Alexander Pepper <pepper@inf.fu-berlin.de> writes:

> Am 21.09.2011 um 14:24 schrieb Junio C Hamano:
>>> $ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
>>> [...]
>>> 11      10      src/java/voldemort/server/storage/StorageService.java
>> 
>> Didn't we update it this already? I seem to get 10/9 here not 11/10.
>
> Current 'maint' (cd2b8ae9), 'master' (4b5eac7f)...

That's a tad old master you seem to have.

Strangely, bisection points at 27af01d5523, which was supposed to be only
about performance and never about correctness. There is something fishy
going on....

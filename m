From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG?: git-filter-branch removes mergetags
Date: Tue, 23 Sep 2014 13:26:34 -0700
Message-ID: <xmqqk34uhymd.fsf@gitster.dls.corp.google.com>
References: <20140923191317.GA3755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:28:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWWfa-0000q0-5w
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbaIWU0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Sep 2014 16:26:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60347 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbaIWU0h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 16:26:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E622E3AD36;
	Tue, 23 Sep 2014 16:26:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NrrnDaqN7mJ9
	CE+bquTVduZB4Cg=; b=V8Vj3GHdWog2SfyC9gU86NCW2T+sv9vI4L6ZRmu9Y2HY
	gQ5VfReeJYAZe+ojifZ3Zff73+mIjI24RapnfBDSzK8GZQBehmynSNEtV1ejkSmM
	Z7u2e4mReer1xnpDet1lU7AibeDhrqWgdCnTojOms0hAdpHkHnBPsRhKxEOTuPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BZh+4U
	obF+f721MrLCmPTsqPlPc15uab6XuIDBSLIgUkO3mud40oNexfEjKOP10/zMSQCT
	lA/Vc3lS7v+JX8scJsiQ4CnFu1CNKS1fJj8jBZMP+/KpoTkwZV9BYOE8YLqfawWY
	g2TBPgKgF85p07Bs6sFkdh11fypJzz+IjbXiU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAAD03AD35;
	Tue, 23 Sep 2014 16:26:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 488C33AD34;
	Tue, 23 Sep 2014 16:26:36 -0400 (EDT)
In-Reply-To: <20140923191317.GA3755@pengutronix.de> ("Uwe =?utf-8?Q?Kleine?=
 =?utf-8?Q?-K=C3=B6nig=22's?=
	message of "Tue, 23 Sep 2014 21:13:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA7EB4AE-435F-11E4-9B50-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257438>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> 	--- /dev/fd/63	2014-09-23 21:07:49.987065017 +0200
> 	+++ /dev/fd/62	2014-09-23 21:07:49.991064988 +0200
> 	@@ -3,32 +3,6 @@
> 	 parent 954263938706bf62d36e81b6b49f313390f2ed35
> 	 author Linus Torvalds <torvalds@linux-foundation.org> 1411488823 -0=
700
> 	 committer Linus Torvalds <torvalds@linux-foundation.org> 1411488823=
 -0700
> 	-mergetag object 954263938706bf62d36e81b6b49f313390f2ed35
> 	- type commit
> ...
>
> I expected the signature to not disappear such that in the example ab=
ove
> no change is introduced.

Yeah, I agree that the above shows that in the rewritten merge
commit, the side parent 95426393... has not changed from the
original and the mergetag can be taken as a still valid one.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 09:38:17 -0700
Message-ID: <7v8v3e7udi.fsf@alter.siamese.dyndns.org>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud1CN-0001C4-L1
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab3EPQiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:38:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab3EPQiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:38:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 995301E921;
	Thu, 16 May 2013 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6rGZcW0+gPi/jlcwHmR6D1rcUgw=; b=m3pF8P
	Ax02X1G5TOcCQT5Moc1L16F9cwGESIXvluXPBYswhIEfHmQdEUbxkaU3PJ5GgMBH
	sWQEckCXRf4mkDl6AdsYXNEbABoPcXyhtp9I6TqCSzmCy0ynRtSNRwzvo/ydUGmG
	XfBd1T9GxIy9A7NOk6Ug6cUcAKcD4aKOlGjP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ubmZrUN4lyCPXPB9Mx581ekdxAVvS+Jd
	n6c/V+TzP4/GizXd5pS+UTOZR4pd16ER4BnVJ2kyMUK/XfLxJp/T/Mrx4KUMz/Xi
	IVbMg7Gyw3DGIVHY3Lk95H9CDL9hahIj8nlGfxEhghUMBgx16foXl4384F8KZ21o
	1T1tEy9937U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FE851E91F;
	Thu, 16 May 2013 16:38:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9FC21E90F;
	Thu, 16 May 2013 16:38:18 +0000 (UTC)
In-Reply-To: <CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 11:26:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03C3DCF4-BE47-11E2-8495-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224598>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> That doesn't change the fact that 'git fetch .' does not make any
> sense whatsoever. The user *will* get confused when (s)he does 'git
> fetch' and nothing happens. The problem is not solved.
>
> % git checkout -b fixes master
> % git fetch
> % git branch -u master
> % git fetch
>
> # scratch head

# reads manual, perhaps?

Why do you declare without justification that "git fetch ." does not
make sense?  If you come from "git pull" is "git fetch" + "git merge",
and if your current branch is integrating with your local branch, it
is natural that "git fetch" that does not say where to fetch from
fetches from your local repository (object-transfer wise, it is a
no-op) and update FETCH_HEAD.  You can say "it is not necessary, as
we can directly go to @{u}", but that is different from "it does not
make any sense".

I think the real cause of the problem is that some people advocate
the use of "git fetch" that does not say "from where" and "get
what".  When the user understand what it does and what it does it
for, not having to type is a convenience, but as a recipe to be
blindly followed, it leaves the new people in the dark.

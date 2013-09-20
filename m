From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On the behavior of checkout <branch> with uncommitted local changes
Date: Fri, 20 Sep 2013 15:58:27 -0700
Message-ID: <xmqq1u4jp0bw.fsf@gitster.dls.corp.google.com>
References: <8904036.vOg3y5OkbU@ipht-ia-004976>
	<xmqqfvt0u2q3.fsf@gitster.dls.corp.google.com>
	<2132571.7BXlKkKRkA@ipht-ia-004976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: r.ductor@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 21 00:58:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN9ek-0001DP-Ax
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 00:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab3ITW6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 18:58:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3ITW6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 18:58:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83C5F439F3;
	Fri, 20 Sep 2013 22:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zPdM5KJpSaqvL1i4t02laec1dR4=; b=tiWKhoO/MZae0gM9HYjl
	6p5UujvDQSd6nTyVeZY0n45y86NHVHfp0eHkmFAd7+vb4cJvlUOY7gDxJWhTMAtV
	7j7N6uT+8MeqYeNczqaiixZh638O1LXqnF+m1rszP5Rdncb70wqoRzcLmTq8U2rP
	4iYOehZ4Q1ieSOYKtQfFSbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YjIH341CkpbjKdJ1z6CAA4lpq11HWCoigo2fVgSCeXH7w+
	7DkZRsmoWivwNoAIwAx/thj3GilsP+H51AWFn6Hob2i74abpqw9fsPL9SZAxdGx3
	/ENXu+0DkzSkuav9uTWP3QOYu1qxuoppOlL4wGuV+5YN/u7QhRcl/jU+JaIfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C06439F2;
	Fri, 20 Sep 2013 22:58:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E39A0439F0;
	Fri, 20 Sep 2013 22:58:28 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2A07E9D6-2248-11E3-B545-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235088>

r.ductor@gmail.com writes:

> mmm maybe I'm wrong, but it seems to me that the first statement
> on the index (above) is oversimplifing.

Yes, it was simplified to illustrate the principle, not even trying
to be exhaustive.

The principle is that we allow you to check out a different branch
when you have local changes to the working tree and/or to the index,
as long as we can make the index and the working tree pretend as if
you reached that locally modified state, starting from a clean state
of the branch you are checking out.

That is what "your modifications in context" in the description of
the "-m" option refers to.

It directly follows that a local change to the index at a path is
carried forward when you check out a different branch, if HEAD and
the branch you are checking out have the same contents registered at
the path.

The message you are responding to illustrated that principle by
talking about changes to the working tree but the same principle
applies to changes to the index, as changes to the working tree is
much easier to picture in your mind.

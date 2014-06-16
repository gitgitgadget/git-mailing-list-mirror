From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary directories
Date: Mon, 16 Jun 2014 11:17:46 -0700
Message-ID: <xmqqtx7kra5x.fsf@gitster.dls.corp.google.com>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com>
	<87k38ir4p0.fsf@red.patthoyts.tk>
	<20140615163227.GE368384@vauxhall.crustytoothpaste.net>
	<20140615214928.GA619@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:18:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbTk-0001ZC-PO
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbaFPSRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:17:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64404 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932396AbaFPSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:17:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7628200A6;
	Mon, 16 Jun 2014 14:17:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BmK62cqVcK3D+3YxiAIA6ExZ86Y=; b=lCiuAx
	C3zlaqPHJBhMeXDs/k5SEIq/3TOtOxjmiJXYncz/X424dmumc7BDRRzawL1tXjV9
	WI1qAKqZE++5+iYZ06Rgqa3wQBAAwkYEvjnvYfQPIY0Lgek/jU1kAR+Yy+MmDbXT
	JAeE2TwjnwDdGFpAv/dPfDI6877+5XVOsvXPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e/Nm+kjlNz+3TvrIzGHhZuk/WZJO0UZy
	jCpxIgzN2CqsAGligHMfiedct2sYxhBdhLOQwtNnn7O4XxpvWp6NbErqtXoM0P1Y
	phkhH2mmvNUzNBekZFlk+EEtBNlUPlqejpbKvDdUTeYWc5ItAIeo1MaZTg2ZTmIh
	0qbYr2IndQI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDF03200A4;
	Mon, 16 Jun 2014 14:17:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8CBE02009D;
	Mon, 16 Jun 2014 14:17:45 -0400 (EDT)
In-Reply-To: <20140615214928.GA619@gmail.com> (David Aguilar's message of
	"Sun, 15 Jun 2014 14:49:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83BAFB22-F582-11E3-8CFA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251792>

David Aguilar <davvid@gmail.com> writes:

> Hmm.. I guess what I could do is keep the old behavior (having gitk ignore TMPDIR)
> on Windows and only use the new code path on non-Windows.

Or perhaps attempt to create, catch error and then retry the old way?

Hopefully Windows folks do not have to worry about forgetting to
update the codepath when they update their tcl/wish if you did it
that way, no?

>
> That seems like it'd be the simplest implementation (no need to check versions)
> and the least harmful to existing users (avoids a tcl upgrade or mkdtemp installation
> for Windows users).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] allow git-svn fetching to work using serf
Date: Mon, 08 Jul 2013 09:22:23 -0700
Message-ID: <7vip0l10ow.fsf@alter.siamese.dyndns.org>
References: <1373170849-9150-1-git-send-email-mackyle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 18:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwECz-00051C-PT
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 18:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab3GHQW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 12:22:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab3GHQW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 12:22:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D68AC2C6C7;
	Mon,  8 Jul 2013 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LxxqxjzL68jLSkViWTMQkF7mrsg=; b=qTZ1lO
	4p8oXfZ3QSz20783ndVcfiJ7chnfYkLq957Iv8KLxeGhUpRtZB0fkqL0+Ee1KGaL
	1xv7Bc4BG8jTg9CO2ngKPDFm+krs4rnjpVeAvIt4uCOLgBl2aGjHha+xit9ZNYsZ
	ntFPtX0oz2JRXIu004fBhiPyT8FRcxKHXelS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JP3Vxs8M7vLvatWlMldM28vxUSZeg4ds
	7wx1TdUmwhEHFjXmteKcwpyFWW0RNsOLeqvMHsnhkrBDm0N6AzGlJDEzWDY7lxLV
	REvnPbMloWcHiUd0jkhVfybOMilOlKENZBN493KnWApxfKH6WSGEK4ynPYSS/CSM
	rWky2P3+bq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C877F2C6C6;
	Mon,  8 Jul 2013 16:22:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3222D2C6C2;
	Mon,  8 Jul 2013 16:22:25 +0000 (UTC)
In-Reply-To: <1373170849-9150-1-git-send-email-mackyle@gmail.com> (Kyle
	J. McKay's message of "Sat, 6 Jul 2013 21:20:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 932E3796-E7EA-11E2-B4F2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229873>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> From: "Kyle J. McKay" <mackyle@gmail.com>
>
> This patch allows git-svn to fetch successfully using the
> serf library when given an https?: url to fetch from.
>
> Unfortunately some svn servers do not seem to be configured
> well for use with the serf library.  This can cause fetching
> to take longer compared to the neon library or actually
> cause timeouts during the fetch.  When timeouts occur
> git-svn can be safely restarted to fetch more revisions.
>
> A new temp_is_locked function has been added to Git.pm
> to facilitate using the minimal number of temp files
> possible when using serf.
>
> The problem that occurs when running git-svn fetch using
> the serf library is that the previously used temp file
> is not always unlocked before the next temp file needs
> to be used.
>
> To work around this problem, a new temp name is used
> if the temp name that would otherwise be chosen is
> currently locked.
>
> Version v2 of the patch introduced a bug when changing the _temp_cache
> function to use the new temp_is_locked function at the suggestion of a
> reviewer.  That has now been resolved.

Thanks; I've queued this version to 'pu' at least tentatively.

Is everybody who discussed the issue happy with the direction of
this patch?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 00/48] Use ref transactions
Date: Thu, 12 Jun 2014 15:15:30 -0700
Message-ID: <xmqqoaxx4vwd.fsf@gitster.dls.corp.google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 00:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvDHY-0000Vq-SL
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 00:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbaFLWPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 18:15:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51168 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbaFLWPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 18:15:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C43D61E67E;
	Thu, 12 Jun 2014 18:15:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vcxfb50bV0Ox+HS8EFA9dfxq0PI=; b=gFkCm0
	zhDihHMJMEyouBMs/MrShe0Qc2RyfcLw9t9uvBSrgUXBew3+E65UXWL0uObTNE7+
	5Qmjr7PHcPBKVipn/UvS6xPc6kDi5dYrRUBN3Yet/lGNRgX4iz+sEOB5bDfj0dKA
	2qfK2IM9gxmjPxZsk32GaK4IH5b4eQcE3BQRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vnh6+C7G+cca8ARpbRh+dVMapxZFXdmE
	CYlHU2YxTvV4gzzOVextUpYNpTPG9JptXD74QP78Jm26m/RfKoyxfG0boRsYpful
	1RNuROL8GRX6oEtF9hj3d/GmvLjILpub1MpGv44wctqCnuy1gUzlpRHUZeStwaSw
	k0pG1rTi67M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B9AD51E67D;
	Thu, 12 Jun 2014 18:15:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C013F1E674;
	Thu, 12 Jun 2014 18:15:31 -0400 (EDT)
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 10 Jun 2014 15:28:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1166D83A-F27F-11E3-91E2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251503>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Final version.
>
> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions
>
> This patch series is based on next and expands on the transaction API. It
> converts all ref updates, inside refs.c as well as external, to use the
> transaction API for updates. This makes most of the ref updates to become
> atomic when there are failures locking or writing to a ref.
>
> This version completes the work to convert all ref updates to use transactions.
> Now that all updates are through transactions I will start working on
> cleaning up the reading of refs and to create an api for managing reflogs but
> all that will go in a different patch series.

As this seems to be based on the old 'next' before it got rewound,
it was a bit painful to rebase it on top of 'master' (so that it
won't have to wait for other topics if we wanted to graduate it
earlier than others).  It also had interactions with various topics
still in flight in 'pu'.  I managed to coax it on 'pu' somewhere
above the commit that is equivalent to 'next', but I am reasonably
sure there are mismerges, as the conflicts were many X-<.

I'd appreciate it if you can eyeball the result with

  $ git show --first-parent -m 'origin/pu^{/^Merge branch .rs/ref-transactions}'

when I push it out.

Thanks.

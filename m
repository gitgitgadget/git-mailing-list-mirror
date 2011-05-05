From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Wed, 04 May 2011 19:26:29 -0700
Message-ID: <7vwri5c27e.fsf@alter.siamese.dyndns.org>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net> <7v4o5afht7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>,
	Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Thu May 05 04:26:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHoH8-0002pG-1G
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 04:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab1EEC0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 22:26:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab1EEC0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 22:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 388DA4616;
	Wed,  4 May 2011 22:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jOMtbnjfNEaW5x9mqnnpq98Clzs=; b=iDe6J2
	MpZJUucbWbY4yfrW1gUP3zZIRyehfCNyCzybgonRPdK2UQY+ee1QRfgXxPQAveGb
	JJUJt8GoOoL5Z8LBgwSVwsNkEgDEhhZURMXQESLL9MW/j/b5a2ub3txyyILbxI0t
	dMnd7p2lcxPdtQRlW+Bhz7jO04I+3Wz4/+kFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b4wdxleOR3/ismmeI9rc65wiUKGEmD+x
	t5BioTBxaig5UPO8o91bCDT3pGd+OQPs3Fl1ZIH+o9BNRmvHPjnRPbyNTf5FCiME
	JyXMXhRalocqNLaRnJPrr7Uq2MQlQ3SVfOtyjTBgXDC0jkLMUJ0Z3zkDjFvDJoaY
	GRYZHUEOusg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0251B4615;
	Wed,  4 May 2011 22:28:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC3024612; Wed,  4 May 2011
 22:28:34 -0400 (EDT)
In-Reply-To: <7v4o5afht7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 May 2011 11:21:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62C7906E-76BF-11E0-BE9B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172788>

Junio C Hamano <gitster@pobox.com> writes:

> So I think it would probably be a less-impact and useful solution to keep
> sysconfdir and add "sysconfdir = @sysconfdir@" to config.mak.in as well.
>
> Is Kacper's latest patch with an obvious one-liner to config.mak.in
> sufficient to achieve that?
>
>   From: Kacper Kornet <kornet@camk.edu.pl>
>   Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defin...
>   Date: Wed, 4 May 2011 16:29:21 +0200
>   Message-ID: <20110504142921.GE18585@camk.edu.pl>

In other words, this one on top of the above (which defaults sysconfdir
to /etc when $(prefix) is /usr and then sets git_etcdir to $(sysconfdir)).

-- >8 --
Subject: [PATCH] config.mak.in: allow "configure --sysconfdir=/else/where"

We do allow vanilla Makefile users to say make sysconfdir=/else/where
and config.mak can also be tweaked manually for the same effect. Give
the same configurablity to ./configure users as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 9614973..dd8f274 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -18,6 +18,7 @@ bindir = @bindir@
 gitexecdir = @libexecdir@/git-core
 datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates
+sysconfdir = @sysconfdir@
 
 mandir=@mandir@
 
-- 
1.7.5.1.242.g2ec223

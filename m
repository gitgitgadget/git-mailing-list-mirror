From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: indicate when a detached head is checked out for a branch
Date: Fri, 18 Jul 2014 15:18:38 -0700
Message-ID: <xmqqpph2l39d.fsf@gitster.dls.corp.google.com>
References: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
	<xmqqr41imuwk.fsf@gitster.dls.corp.google.com>
	<1405720477.13250.8.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:18:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8GUN-0008IF-Ih
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 00:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbaGRWSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 18:18:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63084 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754958AbaGRWSq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 18:18:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3132E28459;
	Fri, 18 Jul 2014 18:18:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QRqXaUwBvcBeoMs0Jkk66YQe+v0=; b=GG6DUg
	sm4l7eoFEZEztSNn2STlR1+qPfRzW//EAacufjFl9gmRl0Z6iEMCRZHUhU5rQ+jA
	+M+t0h9ZDASN4RWmOwdJ2bQFRckNMcHP9NippGcs2O8NxLZxtfPwb45b/3/SKRhP
	iDRaUikO4YxFyiycE0zmhjPxW4J7ynDmxm1q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rIb5d2wt3inC9i9HAp3vaItNIb6JqsI1
	OmKb/goJugtrrPGxs1Q6aT1XWHD5bIxR0vig1VDN82KmerrgNRBT187lMUsksRWU
	CGeTghQpiq5tPu/lZzzJPeFTHySMb9m2Wa0i3skJDySkbY56VmGYVts31ILu47QD
	xSAv7ctk74g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2821028457;
	Fri, 18 Jul 2014 18:18:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D0C42844B;
	Fri, 18 Jul 2014 18:18:40 -0400 (EDT)
In-Reply-To: <1405720477.13250.8.camel@spirit> (Dennis Kaarsemaker's message
	of "Fri, 18 Jul 2014 23:54:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 78A56942-0EC9-11E4-AC79-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253852>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> My use case for this is checking out the same branch (or commit, so
> already on a detached HEAD) in multiple different places to run
> independent actions (e.g. make test with different compiler options, or
> creating several different packages) and I would really appreciate it if
> that would keep working.

I do not have any problem if multiple working trees have the same
commit checked out on their own detached HEADs at all.  The "should
error out" was solely for the case where the user asked not to detach
but to obtain a state where a named branch is checked out.  In such
a case, the command should not turn it into a detached HEAD, with or
without a warning.

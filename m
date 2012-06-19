From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/4] version: add git_user_agent function
Date: Tue, 19 Jun 2012 20:40:04 +0200
Message-ID: <87pq8vrvqz.fsf@thomas.inf.ethz.ch>
References: <20120602184948.GA14269@sigill.intra.peff.net>
	<20120602190112.GB14369@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 20:40:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh3Ll-0001q5-RY
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab2FSSkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 14:40:10 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:58141 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414Ab2FSSkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:40:08 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 20:40:02 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 20:40:04 +0200
In-Reply-To: <20120602190112.GB14369@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 2 Jun 2012 15:01:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200225>

I'm terribly late to the party, seeing as this is already in next, but:

Jeff King <peff@peff.net> writes:

> This is basically a fancy way of saying "git/$GIT_VERSION",
> except that it is overridable at build-time and through the
> environment. Which means that people who don't want to
> advertise their git version (for privacy or security
> reasons) can tweak it.
...
> +GIT_USER_AGENT = git/$(GIT_VERSION)
...
> +GIT_USER_AGENT_SQ = $(subst ','\'',$(GIT_USER_AGENT))
> +GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
> +GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
> +BASIC_CFLAGS += -DGIT_USER_AGENT='$(GIT_USER_AGENT_CQ_SQ)'

Unless the user manually sets GIT_USER_AGENT, This forces a full rebuild
due to changed CFLAGS whenever the version changes.  Can you make it so
that only version.o needs to be rebuilt, as with the normal git version
string?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

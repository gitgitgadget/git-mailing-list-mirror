From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 02 Oct 2007 17:22:23 -0700
Message-ID: <7vr6kdhwsg.fsf@gitster.siamese.dyndns.org>
References: <20071002155800.GA6828@coredump.intra.peff.net>
	<200710021916.44388.andyparkins@gmail.com>
	<20071002191104.GA7901@coredump.intra.peff.net>
	<7vsl4tjo28.fsf@gitster.siamese.dyndns.org>
	<20071002204848.GA8284@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 02:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ics0e-0007ZD-13
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 02:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbXJCAWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 20:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbXJCAWc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 20:22:32 -0400
Received: from rune.pobox.com ([208.210.124.79]:59894 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbXJCAWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 20:22:31 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id D9D89140453;
	Tue,  2 Oct 2007 20:22:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 41A7C13FF33;
	Tue,  2 Oct 2007 20:22:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59760>

Jeff King <peff@peff.net> writes:

> Perhaps a better quest would be to eliminate all of those counts
> entirely with code that is obviously correct. I think it is much more
> readable to replace:
>
>   url = xmalloc(strlen(repo->base) + 64);
>   sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
>
> with something like:
>
>   strbuf_init(&url);
>   strbuf_addf(&url, "%s/objects/pack/pack-%s.idx", repo->base, hex);

Ugh, this typically calls snprintf() twice doesn't it?

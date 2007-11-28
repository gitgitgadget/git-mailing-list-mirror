From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 14:01:24 -0800
Message-ID: <7vd4tu3u8b.fsf@gitster.siamese.dyndns.org>
References: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org>
	<20071128194159.GA25977@midwinter.com>
	<20071128194919.GC11396@coredump.intra.peff.net>
	<C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:02:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUz7-0004v4-C8
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759444AbXK1WBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755672AbXK1WBd
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:01:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54699 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758701AbXK1WBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:01:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C7B4E2EF;
	Wed, 28 Nov 2007 17:01:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D4299ACD5;
	Wed, 28 Nov 2007 17:01:48 -0500 (EST)
In-Reply-To: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com> (Steven
	Grimm's message of "Wed, 28 Nov 2007 12:16:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66436>

Steven Grimm <koreth@midwinter.com> writes:

> Well, actually, I would still like opinions on one thing: What do
> people think of having git-push do a fetch if the remote side changes
> a ref to point to a revision that doesn't exist locally?

I do not like it at all.  git-push is about pushing what you did to the
other end; you may or may not want to refetch what other people
immediately on top of what you did, and this includes what the hook
script did in the repository you have pushed into.  If you want an
immediate refetch, you can script it so that you call push and then
fetch; the latter needs to be a separate connection to a different
service anyway.

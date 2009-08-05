From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is
 given
Date: Wed, 05 Aug 2009 14:01:44 -0700
Message-ID: <7vws5ix9dz.fsf@alter.siamese.dyndns.org>
References: <20090805201937.GB9004@coredump.intra.peff.net>
 <20090805202326.GC23226@coredump.intra.peff.net>
 <7vhbwm0zcs.fsf@alter.siamese.dyndns.org>
 <20090805204835.GA24539@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYncY-0001xV-T7
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbZHEVBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZHEVBz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:01:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZHEVBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:01:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E25D1E939;
	Wed,  5 Aug 2009 17:01:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 759E81E935; Wed,  5 Aug 2009
 17:01:46 -0400 (EDT)
In-Reply-To: <20090805204835.GA24539@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 5 Aug 2009 16\:48\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34919AD0-8203-11DE-8A01-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124982>

Jeff King <peff@peff.net> writes:

> I don't understand. Isn't that what "git push" _already_ does?

Sorry, it has been a while since I looked at print_push_status() the last
time.  You are right; without --verbose, we show interesting ref update
status, excluding the "already up to date" report.

What I meant was that I'd still want to see the non-verbose part of
print_push_status(), while suppressing the progress report.  That would
make mails coming from the cron job much more pleasant to read.

If you somehow can automatically squelch progress without -q for an
unattended invocation (e.g. cron jobs), then I wouldn't need to pass -q
and everything will be good.  But if I have to pass -q in order to squelch
progress, I do not want that same -q to automatically also mean "no status
output", which is what your 3/3 is about, if I am reading the patch
correctly.  That's all.

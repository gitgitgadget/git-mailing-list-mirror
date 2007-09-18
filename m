From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diffcore-rename performance mode
Date: Tue, 18 Sep 2007 01:58:17 -0700
Message-ID: <7vhclswdsm.fsf@gitster.siamese.dyndns.org>
References: <20070918082321.GA9883@coredump.intra.peff.net>
	<7vsl5cwe6p.fsf@gitster.siamese.dyndns.org>
	<20070918085413.GA11751@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYuZ-0002vv-BO
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbXIRI6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbXIRI6W
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:58:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbXIRI6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:58:21 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id ED95E1373C2;
	Tue, 18 Sep 2007 04:58:40 -0400 (EDT)
In-Reply-To: <20070918085413.GA11751@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 18 Sep 2007 04:54:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58555>

Jeff King <peff@peff.net> writes:

> I thought we were holding counts of hashes, in which case there _is_ no
> overflow.

The raw hashval (the fingerprint recorded in struct spanhash) is
further reduced and used as an index into spahash_top.data[].
So more than one hashval can try to sit in the same slot in
spanhash_top.data[] array.

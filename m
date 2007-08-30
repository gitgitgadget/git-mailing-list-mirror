From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplicate pathspecs from ls-files command line
Date: Wed, 29 Aug 2007 18:25:50 -0700
Message-ID: <7vr6llak4h.fsf@gitster.siamese.dyndns.org>
References: <20070829081122.GA604@piper.oerlikon.madduck.net>
	<20070829194410.GA11824@steel.home>
	<7v4piioyu1.fsf@gitster.siamese.dyndns.org>
	<20070829211519.GE11824@steel.home> <85tzqic9bf.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>,
	439992-quiet@bugs.debian.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 03:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQYna-00076t-73
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 03:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbXH3B0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 21:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757887AbXH3B0N
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 21:26:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbXH3B0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 21:26:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FC9512AD65;
	Wed, 29 Aug 2007 21:26:29 -0400 (EDT)
In-Reply-To: <85tzqic9bf.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	29 Aug 2007 23:36:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56993>

David Kastrup <dak@gnu.org> writes:

> Does anything speak against sorting the pathspecs?  That is an O(n log
> n) operation,

Not sorting is O(0) operation without losing cycles for the
normal case.  I think you can sort first in that error handling
path to avoid O(n^2) but sorting upfront to remove duplicates
for every case is unnecessary bloat that penalizes sane callers.

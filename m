From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Mon, 27 Aug 2007 01:48:21 -0700
Message-ID: <7v3ay5l5wq.fsf@gitster.siamese.dyndns.org>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaGq-0001vE-DH
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbXH0IsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbXH0IsZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:48:25 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbXH0IsY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:48:24 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BA101125027;
	Mon, 27 Aug 2007 04:48:44 -0400 (EDT)
In-Reply-To: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Sun, 26 Aug 2007 22:56:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56788>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Keeping the last used delta base object, if it would be dropped,
> supports creating smaller packs with shorter delta chains.

Instead of treating the "the last used one happened to be on the
horizon -- try not to drop it" special case, I wonder if it
makes sense to float the last used delta base object early in
the window _after_ it is used.  Wouldn't we keep more than one
very recently used delta base objects in the window that way?

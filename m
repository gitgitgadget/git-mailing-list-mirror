From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck segmentation fault
Date: Wed, 10 Dec 2008 22:42:40 -0800
Message-ID: <7v1vwfw6u7.fsf@gitster.siamese.dyndns.org>
References: <200811271814.06941.simon@lst.de>
 <200811272021.56108.simon@lst.de>
 <alpine.LFD.2.00.0811271449500.14328@xanadu.home>
 <200811280919.10685.simon@lst.de>
 <alpine.LFD.2.00.0812091408560.14328@xanadu.home>
 <20081210075338.GA7776@auto.tuwien.ac.at>
 <7vljunwidr.fsf@gitster.siamese.dyndns.org>
 <20081211062753.GA17683@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Thu Dec 11 07:44:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAfHU-0006kt-2S
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 07:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbYLKGmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 01:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbYLKGmu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 01:42:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYLKGmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 01:42:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D6ED71899B;
	Thu, 11 Dec 2008 01:42:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D78561899A; Thu,
 11 Dec 2008 01:42:41 -0500 (EST)
In-Reply-To: <20081211062753.GA17683@auto.tuwien.ac.at> (Martin Koegler's
 message of "Thu, 11 Dec 2008 07:27:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED01D514-C74E-11DD-ADA6-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102782>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> fsck_walk has been designed to call a function on all directly
> connected objected. There are callers, which expected this behaviour
> (eg. index-pack, mark_used in fsck).

Yes, that is where my "initially expected" comes from.  I was not
complaining or suggesting the behaviour to change.

I was fooled by the word *walk* in the name, which implies an
implementation of walking connectivity fully, with or without an ability
for the callback to tell the machinery when to or not to dig deeper.  It
wouldn't have been confusing if it were named "fsck_step()", which is what
the function is about: performing a single step of digging deeper.

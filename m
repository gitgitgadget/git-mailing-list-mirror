From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Sat, 07 Jun 2008 09:37:52 -0700
Message-ID: <7vy75hnqu7.fsf@gitster.siamese.dyndns.org>
References: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl>
 <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
 <7v8wxirwi1.fsf@gitster.siamese.dyndns.org>
 <DB158BDE-70D1-4779-9B03-A85C60EB2FA7@ai.rug.nl>
 <alpine.DEB.1.00.0806071612460.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 18:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K51RU-0000Hr-KX
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 18:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759473AbYFGQiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 12:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759450AbYFGQiH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 12:38:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758849AbYFGQiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 12:38:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 778574D65;
	Sat,  7 Jun 2008 12:38:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B41BF4D61; Sat,  7 Jun 2008 12:37:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806071612460.1783@racer> (Johannes
 Schindelin's message of "Sat, 7 Jun 2008 16:19:35 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18223306-34B0-11DD-BB6E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84215>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, I looked again, and indeed, you _copied_ it.  Instead of using the 
> functions mark_object() and get_object_mark() which are there only to be 
> used by you.
>
> So please fix.
>
>> >Even if that is the case, doesn't "(uint32_t *)deco->decoration - 
>> >(uint32_t *)NULL" mean the value range for deco->decoration is 
>> >one-fourth of U32?
>
> It is.  But since every object needs already at least 20 bytes, and we do 
> not even have the complete address space to put objects into, and we do 
> not plan to support 64-bit only repositories, I think we are fine.

Oh, I was not complaining about the one-fourthness.  I was wondering why
"(uint32_t *)", which makes it look like the type itself has very deep
meaning for this computation, was used, instead of "(char *)" or something
that makes it much clearer that what could be pointed at by the pointer
does not matter and you are only using them as fake integers.  If there is
such a deep meaning, it needs documented, and if there isn't then probably
the use of (uint32_t *) should also be fixed.

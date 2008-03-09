From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix git pull handling of the quiet option
Date: Sat, 08 Mar 2008 20:04:26 -0800
Message-ID: <7v8x0ssfud.fsf@gitster.siamese.dyndns.org>
References: <1205020356-6682-1-git-send-email-iusty@k1024.org>
 <1205020356-6682-3-git-send-email-iusty@k1024.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Iustin Pop <iusty@k1024.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 05:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYCnH-0007kk-Vz
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 05:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYCIEFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 23:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYCIEFC
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 23:05:02 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYCIEEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 23:04:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 803822835;
	Sat,  8 Mar 2008 23:04:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F2C652834; Sat,  8 Mar 2008 23:04:33 -0500 (EST)
In-Reply-To: <1205020356-6682-3-git-send-email-iusty@k1024.org> (Iustin Pop's
 message of "Sun, 9 Mar 2008 00:52:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76633>

Iustin Pop <iusty@k1024.org> writes:

> Although git pull has a documented quiet option,...

I think that is a documentation bug.  pull accepts all options for fetch
for the sole purpose of passing them intact to underlying fetch, and some
options to fetch does not even make much sense in the context of pull.

Also options to pull needs to come first; the options pull does not know
about is a signal for pull that the rest is for consumption of underlying
fetch.

If you want to teach --quiet to pull, however, your patch is the right
approach.  pull would eat --quiet and make a note for itself, and passes
that to underlying fetch (and perhaps merge).

You also need to sign-off your patch and add tests to make sure that other
people will not break your enhancement in the future.

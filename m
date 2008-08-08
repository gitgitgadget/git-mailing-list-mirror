From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to fix (and find) many git-* --check errors?
Date: Fri, 08 Aug 2008 12:27:18 -0700
Message-ID: <7viqubcnop.fsf@gitster.siamese.dyndns.org>
References: <489C40BC.8000008@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 21:28:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRXdh-0000jT-OL
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 21:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbYHHT10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 15:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbYHHT10
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 15:27:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbYHHT1Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 15:27:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6115050174;
	Fri,  8 Aug 2008 15:27:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 70CE450173; Fri,  8 Aug 2008 15:27:21 -0400 (EDT)
In-Reply-To: <489C40BC.8000008@sneakemail.com> (Peter Valdemar =?utf-8?Q?M?=
 =?utf-8?Q?=C3=B8rch's?= message of "Fri, 08 Aug 2008 14:49:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 074C1816-6580-11DD-A921-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91707>

"Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> writes:

> We have > 37000 white space "errors" in HEAD, mostly trailing
> whitespace, and I'm looking for a
>
> $ git diff --check | git??? --whitespace=3Dfix
>
> command.

Starting from a clean checkout, you could do something like this:

	$ git reset --hard
        $ rm .git/index
        $ git diff --binary -R HEAD >P.diff
        $ git apply --whitespace=3Dfix --cached <P.diff
	$ git commit -m "Fixed all whitespace gotchas"

P.diff contains essentially everything, and you are recreating everythi=
ng
from that patch.

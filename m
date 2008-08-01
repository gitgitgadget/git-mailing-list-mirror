From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 01 Aug 2008 15:14:15 -0700
Message-ID: <7vr698qt6w.fsf@gitster.siamese.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com>
 <200807311257.49108.litvinov2004@gmail.com>
 <20080731104529.GE7008@dpotapov.dyndns.org>
 <200808011023.32139.litvinov2004@gmail.com>
 <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
 <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
 <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com>
 <7vmyjwserv.fsf@gitster.siamese.dyndns.org>
 <20080801220932.GK7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2uF-0004OF-Lm
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbYHAWO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbYHAWO0
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:14:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYHAWO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 18:14:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EA6944831;
	Fri,  1 Aug 2008 18:14:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2F2444830; Fri,  1 Aug 2008 18:14:17 -0400 (EDT)
In-Reply-To: <20080801220932.GK7008@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Sat, 2 Aug 2008 02:09:32 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31B901EA-6017-11DD-8899-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91107>

Dmitry Potapov <dpotapov@gmail.com> writes:

> I have applied your patch and then corrected mine to use flags.
> See below.
>
> I wonder if something should be done about other places where index_xx
> functions are called. I have looked at them and all they use either 0 or
> 1 (boolean expression which will be evaluated to 0 or 1), so they should
> work as is, but I can correct them to use HASH_OBJECT_DO_CREATE instead
> of 1 if it helps with readability.

Even though the patch was not compile tested, I did check the existing
call sites are giving only 0 or 1, but I think converting these "please
write -- I give you 1" callers to pass the bitmask would be a sane thing
to do.

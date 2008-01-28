From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Mon, 28 Jan 2008 04:04:08 -0800
Message-ID: <7vd4rmtavb.fsf@gitster.siamese.dyndns.org>
References: <20080128003404.GA18276@lintop>
	<1201480650-19716-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801281159150.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	j.sixt@viscovery.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJSjR-0004ET-9o
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 13:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbYA1MEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 07:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYA1MEZ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 07:04:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbYA1MEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 07:04:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 253C023F1;
	Mon, 28 Jan 2008 07:04:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B27D23F0;
	Mon, 28 Jan 2008 07:04:15 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801281159150.23907@racer.site> (Johannes
	Schindelin's message of "Mon, 28 Jan 2008 11:59:50 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71881>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> ...
>> This only causes a problem when a path component has a length of
>> zero which can happen when the user provides an absolute path to
>> a file or directory in the root directory (i.e. "/", or "/foo"),
>> or if the input is malformed and contains a double-slash such
>> as "foo//boo".
>> 
>> Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
>
> I'll try to remember even 6 months from now that this was the "git clean 
> -n /" problem ;-)

Actually the quoted part of the message clearly tells that the
patch is touching the wrong code.  It should not blame the user
but the caller of the function that did not check such an input,
which is where the fix should be in.

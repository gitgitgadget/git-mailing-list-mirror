From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Work around curl-gnutls not liking to be reinitialized
Date: Fri, 08 Feb 2008 13:46:14 -0800
Message-ID: <7vlk5vi0k9.fsf@gitster.siamese.dyndns.org>
References: <20080208073456.GA17791@glandium.org>
	<1202501335-28205-1-git-send-email-mh@glandium.org>
	<20080208213148.GA2823@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNb3x-0004yT-Ab
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761113AbYBHVql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761007AbYBHVqj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:46:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760964AbYBHVqh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:46:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DDF7539C;
	Fri,  8 Feb 2008 16:46:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 805F45399;
	Fri,  8 Feb 2008 16:46:31 -0500 (EST)
In-Reply-To: <20080208213148.GA2823@glandium.org> (Mike Hommey's message of
	"Fri, 8 Feb 2008 22:31:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73154>

Mike Hommey <mh@glandium.org> writes:

>>  In the end, it was a bit of git's fault, but either curl or gnutls is the
>>  actual culprit. I've not looked into either code to find out who's
>>  responsible, but a very simplified testcase is as follows:
>> ...
>
> And the winner is... curl !
> The bug was introduced in this commit:
> http://cool.haxx.se/cvs.cgi/curl/lib/gtls.c.diff?r1=1.26&r2=1.27
> Note how gtls_inited is not set back to FALSE in cleanup.
>
> This ended up released in 7.16.3. I'm filing a bug.

Good detetive work.  Thanks.

I guess we need to ship with a known leak to work this around.
Sigh...

Perhaps we can convince cURL developers to switch to git while
we are at it? ;-)

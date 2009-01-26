From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (update)] make: By default, remove -pthread on Darwin (it
 is included by cstdlib).
Date: Mon, 26 Jan 2009 09:47:14 -0800
Message-ID: <7vr62q6jtp.fsf@gitster.siamese.dyndns.org>
References: <1232987160-5635-1-git-send-email-ted@tedpavlic.com>
 <1232987609-6229-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 18:50:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVar-0003qQ-CK
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZAZRrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbZAZRrX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:47:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbZAZRrX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:47:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 85BF195DCE;
	Mon, 26 Jan 2009 12:47:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B3E395DCC; Mon,
 26 Jan 2009 12:47:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 615F91B6-EBD1-11DD-9F5F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107241>

Ted Pavlic <ted@tedpavlic.com> writes:

> As discussed in
>
> http://lists.apple.com/archives/Unix-porting/2005/Mar/msg00019.html
>
> the Mac OS X C standard library is always thread safe and always
> includes the pthread library. So explicitly using -pthread causes an
> 'unrecognized option' compiler warning.
>
> This patch clears PTHREAD_LIBS by default. However, if
> FORCE_DARWIN_PTHREAD_LIBS is defined, then PTHREAD_LIBS will be set as
> before.

Why is this even configurable?  You explained pretty clearly that:

 - With -pthread, you get an nasty warning;
 - By default, we now do not use -pthread;
 - By adding FORCE_DARWIN_PTHREAD_LIBS, you can still compile with
   -pthread.

But the above leaves the reader wondering in what situation it may be
useful to use FORCE_* and for what purpose other than to get the nasty
warning back (which probably is not most users want to).

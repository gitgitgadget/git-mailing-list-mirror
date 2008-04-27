From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: fix --verify to error out when passed junk
 after a good rev
Date: Sat, 26 Apr 2008 23:21:26 -0700
Message-ID: <7v63u3izrt.fsf@gitster.siamese.dyndns.org>
References: <20080426151929.819ced3e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:22:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq0HN-0002nZ-EP
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbYD0GVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYD0GVm
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:21:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYD0GVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:21:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 153E81713;
	Sun, 27 Apr 2008 02:21:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3AC531712; Sun, 27 Apr 2008 02:21:34 -0400 (EDT)
In-Reply-To: <20080426151929.819ced3e.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat, 26 Apr 2008 15:19:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80419>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch something like:
>
> $ git rev-parse --verify <good-rev> <junk>
>
> worked whatever junk was as long as <good-rev> could be parsed
> correctly.
>
> This patch makes "git rev-parse --verify" error out when passed
> any junk after a good rev.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin-rev-parse.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> 	With this patch something like:
>
> 	$ git rev-parse --verify <good1> <good2>
>
> 	will still fail.

I think this should fail.

I've long thought that ideally giving anything but a single good rev to
"rev-parse --verify" should fail before spitting anything out.  This, like
other reponses to errorneous inputs, were what we considered of lower
priority in early days of git (think "before the end of 2005"), because we
had many other "better and more urgent" things to worry about.  I think we
have long passed that stage.

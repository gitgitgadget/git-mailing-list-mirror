From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] git-commit: Reformat log messages provided on commandline
Date: Wed, 09 May 2007 16:59:03 +0200
Message-ID: <vpqps5ajb60.fsf@bauges.imag.fr>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0705061851411.4015@racer.site>
	<vpqk5vlamav.fsf@bauges.imag.fr>
	<7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
	<20070509125225.GP4489@pasky.or.cz>
	<Pine.LNX.4.64.0705091513360.4167@racer.site>
	<20070509142426.GV4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 16:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlndS-00043h-CR
	for gcvg-git@gmane.org; Wed, 09 May 2007 16:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756971AbXEIO7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756553AbXEIO7P
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 10:59:15 -0400
Received: from imag.imag.fr ([129.88.30.1]:54028 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbXEIO7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 10:59:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l49Ex3lk016422
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 16:59:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hlnd9-0001zT-BO; Wed, 09 May 2007 16:59:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hlnd9-0001ch-8x; Wed, 09 May 2007 16:59:03 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20070509142426.GV4489@pasky.or.cz> (Petr Baudis's message of "Wed\, 9 May 2007 16\:24\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 09 May 2007 16:59:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46721>

Petr Baudis <pasky@suse.cz> writes:

> -	echo "$log_message"
> +	echo "$log_message" | fmt

I wouldn't do that for the first line of the message.

Someone typing

$ git commit -m "a very very very very very very very very very very very very long summary" \
             -m "a longer description of the above summary"

Probably doesn't want his first line to be broken (otherwise,
git-format-patch and other tools would be confused).

So, that would be more like

echo "$log_message" | (read first_line; echo "$first_line"; fmt)


Perhaps another option would be to provide, say, a -M option, doing

log_message="$log_message

$(echo $1 | fmt)"

to allow people to explicitely say whether they want reformatting. But
that's probably overkill.

-- 
Matthieu

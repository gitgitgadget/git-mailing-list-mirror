From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH] git-send-email: Don't set author_not_sender from Cc:
 lines
Date: Wed, 23 Aug 2006 11:14:19 +0200
Organization: Atmel Norway
Message-ID: <20060823111419.22d92f51@cad-250-152.norway.atmel.com>
References: <1156253919761-git-send-email-hskinnemoen@atmel.com>
	<7vd5asjkvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 11:14:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFooi-00038O-FX
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 11:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWHWJO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 05:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWHWJO2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 05:14:28 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:19177 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751463AbWHWJO1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 05:14:27 -0400
Received: from cad-250-152.norway.atmel.com (cad-250-152.norway.atmel.com [10.191.250.152])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id k7N9EJB1051585;
	Wed, 23 Aug 2006 11:14:19 +0200 (CEST)
	(envelope-from hskinnemoen@atmel.com)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5asjkvb.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25902>

On Tue, 22 Aug 2006 18:34:16 -0700
Junio C Hamano <junkio@cox.net> wrote:

> The patch looks wrong.  If your name is on CC: and you want to
> suppress sending to yourself what happens?

It will still send it to you, I guess. The documentation only mentions
what happens with From: lines, so I wasn't really sure what behaviour is
expected...

> How about doing something like this instead?

Yeah, that's probably better. I just tested it by sending a mail to
myself, and it doesn't append an extra From: line, so it solves the
problem as far as I'm concerned.

Haavard

> diff --git a/git-send-email.perl b/git-send-email.perl
> index a83c7e9..8adb6b9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -510,7 +510,7 @@ foreach my $t (@files) {
>  					if ($2 eq $from) {
>  						next if
> ($suppress_from); }
> -					else {
> +					elsif ($1 eq 'From') {
>  						$author_not_sender =
> $2; }
>  					printf("(mbox) Adding cc: %s
> from line '%s'\n",
> 

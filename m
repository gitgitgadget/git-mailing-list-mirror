From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] gitweb: Send XHTML as 'application/xhtml+xml' where possible
Date: Sun, 09 Jul 2006 12:18:12 +0100
Message-ID: <44B0E5F4.3000604@atoker.com>
References: <11524381182709-git-send-email-alp@atoker.com> <7vwtanm5eb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 13:18:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzXIw-0003sW-R1
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 13:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWGILSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 07:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWGILSU
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 07:18:20 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:35850 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1030452AbWGILST (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 07:18:19 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id 0442D164CCA;
	Sun,  9 Jul 2006 12:18:13 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtanm5eb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23545>

Junio C Hamano wrote:
>> It falls back to 'text/html' even if the user agent claims to support
>> 'application/xhtml+xml' by means of a glob in order to work around an
>> insidious Internet Explorer bug.
> 
> I do not care much about IE, but...

That makes the two of us. Still, it's probably worth not blocking out IE 
in case the need arises to check up on repositories from internet cafes 
when on holiday or the like.

>> +	my $content_type = ($cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ && $cgi->Accept('application/xhtml+xml') ne 0) ? 'application/xhtml+xml' : 'text/html';
> 
> 1. I would prefer something like this to be written with if-else,
>    not with a conditional expression;

Indeed, this line is a bit unwieldy. Will break it out.

> 2. The "by means of a glob" hack needs to be left as a comment
>    in the code to say why;

Good plan.

> 3. Did you really mean to say "ne 0"?

Well spotted. String comparison works, but != would be more sensible.

A revised patch is in the works.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Don't escape attributes in CGI.pm HTML methods
Date: Tue, 06 Mar 2007 17:40:28 -0800
Message-ID: <7vk5xtn84z.fsf@assigned-by-dhcp.cox.net>
References: <20070306093917.GA1761@coredump.intra.peff.net>
	<200703070137.07477.jnareb@gmail.com>
	<7vvehdnaib.fsf@assigned-by-dhcp.cox.net>
	<200703070221.25519.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Li Yang-r58472" <LeoLi@freescale.com>,
	"Jeff King" <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOl8t-0004is-6Y
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbXCGBkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbXCGBkb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:40:31 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36992 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161139AbXCGBka (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:40:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307014029.XZMQ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 20:40:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XdgU1W0171kojtg0000000; Tue, 06 Mar 2007 20:40:29 -0500
In-Reply-To: <200703070221.25519.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 7 Mar 2007 02:21:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41634>

Jakub Narebski <jnareb@gmail.com> writes:

> There is no need to escape HTML tag's attributes in CGI.pm
> HTML methods (like CGI::a()), because CGI.pm does attribute
> escaping automatically.
>
> Explanation:
>   $cgi->a({ ... -attribute => atribute_value }, tag_contents)
> is translated to
>   <a ... attribute="attribute_value">tag_contents</a>
> The rules for escaping attribute values (which are string contents) are
> different. For example you have to take care about escaping embedded '"'
> and "'" characters; CGI::a() does that for us automatically.
>
> CGI::a() cannot HTML escape tag contents automatically; we might want to
> write
>   <a href="URL">some <b>bold</b> text</a>
> for example. So we have to esc_html (or esc_path) if needed.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> In short: escape tag contents if needed, do not escape attrbure values.
>> 
>> I trust a patch from you will follow shortly?
>
> Here it is. I hope I found everything.
>
> Commit message is bit long, so you can cut it to first sentence only
> (or even only to title/subject).

Thanks.  I think your explanation in the log message has the
right amount of details and keeping it there would help people
who would want to later touch the code.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 01 Jun 2007 13:00:31 -0700
Message-ID: <7vbqfzzbq8.fsf@assigned-by-dhcp.cox.net>
References: <200704241705.19661.ismail@pardus.org.tr>
	<87zm3ju6tg.fsf@wine.dyndns.org>
	<7vr6ovzcgr.fsf@assigned-by-dhcp.cox.net>
	<200706012247.57273.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuDIf-0004gz-V4
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 22:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761651AbXFAUAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Jun 2007 16:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762206AbXFAUAf
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 16:00:35 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65026 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761651AbXFAUAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2007 16:00:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601200033.YLDO7952.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Jun 2007 16:00:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6L0Z1X00N1kojtg0000000; Fri, 01 Jun 2007 16:00:34 -0400
In-Reply-To: <200706012247.57273.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Fri, 1 Jun 2007 22:47:52 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48880>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> On Friday 01 June 2007 22:44:36 Junio C Hamano wrote:
>> Alexandre Julliard <julliard@winehq.org> writes:
>> > Sorry for the late nack, but it turns out that this patch breaks d=
iff
>> > output on the Wine server for files that are not utf-8.
>> >
>> > The cause is apparently that decode_utf8() returns undef for inval=
id
>> > sequences instead of substituting a replacement char like
>> > decode("utf8") does.
>>
>> Thanks for noticing.  Will revert.
>
> Why are reverting a correct bugfix? :( He's at most using outdated so=
ftware.=20
> *sigh*

I would assume that on top of a revert, with an additional

	return $str if is_utf8($str);

to to_utf8() you should be able to fix both installations that
has old or new Encode.pm?

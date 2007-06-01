From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 01 Jun 2007 15:45:31 +0200
Message-ID: <87zm3ju6tg.fsf@wine.dyndns.org>
References: <200704241705.19661.ismail@pardus.org.tr>
	<200705020012.13302.ismail@pardus.org.tr>
	<7v8xc85ill.fsf@assigned-by-dhcp.cox.net>
	<200705032222.37387.ismail@pardus.org.tr>
	<7vsladzp29.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 15:45:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu7Rw-0000Ln-4g
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 15:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066AbXFANpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 09:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757299AbXFANpm
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 09:45:42 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:57292 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066AbXFANpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 09:45:41 -0400
Received: from adsl-84-226-55-130.adslplus.ch ([84.226.55.130] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hu7Rd-0001bE-Pm; Fri, 01 Jun 2007 08:45:34 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 4E2D04F68A; Fri,  1 Jun 2007 15:45:31 +0200 (CEST)
In-Reply-To: <7vsladzp29.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 03 May 2007 12\:26\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48865>

Junio C Hamano <junkio@cox.net> writes:

> I would say that the patch is an improvement from the current
> code so it should hit 'master'; I was a bit busy lately and then
> am sick, and also we are post -rc1 freeze now and I was being
> cautious, just in case some nacks from more informed parties
> arrive late.

Sorry for the late nack, but it turns out that this patch breaks diff
output on the Wine server for files that are not utf-8.

The cause is apparently that decode_utf8() returns undef for invalid
sequences instead of substituting a replacement char like
decode("utf8") does.

That may be considered an Encode bug since we are running a fairly old
version (1.99, coming with Debian 3.1), but I'd rather not upgrade
perl on the server. Could the patch be reverted, or done differently?

-- 
Alexandre Julliard
julliard@winehq.org

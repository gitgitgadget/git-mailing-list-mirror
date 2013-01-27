From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 15:18:33 -0800
Message-ID: <7vip6icj06.fsf@alter.siamese.dyndns.org>
References: <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu> <20130127141329.GN7498@serenity.lan>
 <20130127145056.GP7498@serenity.lan>
 <7vzjzuv224.fsf@alter.siamese.dyndns.org>
 <20130127200401.GT7498@serenity.lan>
 <7vr4l6v11z.fsf@alter.siamese.dyndns.org>
 <20130127202106.GU7498@serenity.lan>
 <7va9ruuzsf.fsf@alter.siamese.dyndns.org>
 <7v622iuzea.fsf@alter.siamese.dyndns.org>
 <20130127224208.GV7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:18:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzbV3-00087F-WA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab3A0XSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:18:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43784 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755707Ab3A0XSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:18:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA88BFCE;
	Sun, 27 Jan 2013 18:18:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=frRS3wng6QARRNVfhDoOWEzkZTo=; b=JKnuSP
	GsSlNi1omDgxtqiBys0m0GhR0UHUq6U8lAdt96x5bPSzOus6/8b16bCN0ivgxCb5
	yBxmuCL+foq9t9J/nVOce25aFNj+ng1LxYBRAUOklcNuQFO7gF6aPh0OHiYbDwo/
	qxqN0m5HKhgEkCUMhdIpHz+UNbQ6qXqlF+bxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xsl3xvDZJVWdK1JeOvfzfKrNWLwL0nqz
	6eNPmTePIAWVoR1S9/MAVMbIPb94teh5dCK2V+/PmMpg6E4AO1l4nyHeidDEhcV6
	0jfG6Jy007/5FzOAlgwB7astVfutGCnUx28O0EngSkLSX2fJUSWQNvmd5mhiLxNV
	4LzdmHC6afI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30F84BFCD;
	Sun, 27 Jan 2013 18:18:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B762BBFCC; Sun, 27 Jan 2013
 18:18:34 -0500 (EST)
In-Reply-To: <20130127224208.GV7498@serenity.lan> (John Keeping's message of
 "Sun, 27 Jan 2013 22:42:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF446886-68D7-11E2-8918-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214750>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Jan 27, 2013 at 12:47:09PM -0800, Junio C Hamano wrote:
>> I remember that I earlier asked somewhere if we want to say "Python
>> 3.x that is older than 3.y is unsupported"
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/213920/focus=213926
>> 
>> but I was told that we will support all versions in 3.x series, IIRC.
>> 
>> Does this patch contradict with that?  If so I think we would need
>> to revisit the update to CodingGuidelines in that thread.
>
> Yes.  I'll send an update to that over the next couple of days.
>
> I think 3.1 and later is fine, when I said "Python 3.0 is unsupported"
> in the commit message below, I meant "unsupported by the Python
> developers".

Yeah, I knew what you meant.  I do not think it is so wrong to write
3.0 off as an early 0.x release of Python3 that was not yet usable
for that exact reason.

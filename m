From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 11:06:06 -0700
Message-ID: <7vwshygyy9.fsf@gitster.siamese.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org>
 <20080830180022.GA14552@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 30 20:07:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUr4-0001MY-J7
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbYH3SGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYH3SGQ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:06:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYH3SGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:06:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CFC865AF2C;
	Sat, 30 Aug 2008 14:06:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0F5F45AF20; Sat, 30 Aug 2008 14:06:07 -0400 (EDT)
In-Reply-To: <20080830180022.GA14552@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 30 Aug 2008 14:00:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 55538144-76BE-11DD-B64F-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94399>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 30, 2008 at 07:39:47PM +0200, Robert Schiele wrote:
>
>> git-add--interactive has one Perl command that was not yet present in
>> Perl 5.6.  Changing this single command makes it compatible again.
>
> Having read your other message, I know what it is about this command
> that does not work with Perl 5.6. But probably it would be good to
> mention "list form of three argument open with pipe".
>
>>  git-add--interactive.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> What about the similar uses in cvsimport, cvsserver, and gitweb? How
> about the scripts in contrib (a quick grep reveals some fast-import
> scripts, blameview, cidaemon, continuous, and hooks/update-paranoid.
>
> Most of those things are not as "core" as add--interactive, so I am not
> opposed to changing just this one spot and documenting "core can use
> 5.6, but these other things need 5.8".
>
>> -		open($fh, '-|', @_) or die;
>> +		open($fh, '-|', join(' ', @_)) or die;
>
> Won't this execute the command using the shell, which means that
> metacharacters need to be escaped? I didn't try, but I'm pretty sure
> this would break
>
>   git add -i "file with space"

I didn't try either but I think you are right.  And I agree we should say
we rely on 5.6 or newer.

I thought gitweb folks are targetting 5.6.1 as the minimum for unicode
support (Lea and Jakub Cc'ed)?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Mon, 10 Aug 2009 22:12:20 -0700
Message-ID: <7vmy67orwr.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908092153520.27553@iabervon.org>
 <200908101032.12835.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 07:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Majuv-0006x7-5B
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 07:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbZHKF1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 01:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbZHKF1P
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 01:27:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZHKF0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 01:26:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74A5C25C5D;
	Tue, 11 Aug 2009 01:12:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 60D2F25C5C; Tue, 11 Aug 2009
 01:12:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96857E06-8635-11DE-A7D6-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125513>

Johan Herland <johan@herland.net> writes:

> On Monday 10 August 2009, Daniel Barkalow wrote:
> ...
>> The only way I've been able to come up with to support this at all
>> usefully is to have a bunch of helper-specific options that specify what
>> the helper needs to know about the locations you consider to be part of
>> the project and an option that tells git that this remote uses the p4
>> helper. I'm not sure what makes sense for other helpers, but the case I
>> actually use needs something like what's in this patch.
>
> I'm somewhat agnostic on this issue. At the moment, I follow the P4 cues,
> and use a config like this:
>
>     [remote "foo"]
>         vcs = cvs
>         cvsRoot = ":pserver:user@cvs.server.example.com/var/cvs/cvsroot"
>         cvsModule = "bar"
>         ...
>
> But I could just as well use a config like this instead:
>
>     [remote "foo"]
>         url = "cvs::pserver:user@cvs.server.example.com/var/cvs/cvsroot#bar"
>         ...
>
> Either is fine with me, although I suspect users might find the
> current/first alternative easier to parse.

Ah, ok, that is a much better (rather, easier to understand for _me_)
example to illustrate what Daniel meant, and I can well imagine P4
counterpart of cvsRoot may resemble an URL even less than your cvsRoot
example does.

If the foreign system uses a single string as "the string to identify
location", like the latter (which is a good example, even though I do not
think a CVS folks write a reference to a module like you wrote), then I
think it makes sense to use that form as remote.$name.url.  But if naming
a location with a single simple string is an alien notion to the foreign
system, I agree with Daniel that we do not gain much by trying to shoehorn
them into a single remote.$name.url configuration.

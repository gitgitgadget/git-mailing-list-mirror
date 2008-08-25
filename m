From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support
Date: Mon, 25 Aug 2008 14:21:54 -0700
Message-ID: <7vk5e4g58t.fsf@gitster.siamese.dyndns.org>
References: <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
 <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <20080824235124.GA28248@coredump.intra.peff.net>
 <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
 <20080825020054.GP23800@genesis.frugalware.org>
 <7v1w0dkd5s.fsf@gitster.siamese.dyndns.org>
 <20080825125205.GB23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Karl Chen <quarl@cs.berkeley.edu>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjWp-000088-Kf
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYHYVWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbYHYVWF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:22:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYHYVWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 17:22:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0349A67E60;
	Mon, 25 Aug 2008 17:22:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6495A67E5E; Mon, 25 Aug 2008 17:21:56 -0400 (EDT)
In-Reply-To: <20080825125205.GB23800@genesis.frugalware.org> (Miklos Vajna's
 message of "Mon, 25 Aug 2008 14:52:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DBB639CE-72EB-11DD-8C3F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93681>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Sun, Aug 24, 2008 at 08:05:03PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> > Does this include removing of --work-tree as well?
>> >
>> > The git backend of Pootle (http://translate.sourceforge.net/wiki/) uses
>> > it.
>> 
>> Interesting.  Does it use it because it can (meaning, --work-tree is
>> supposed to work), or because --work-tree is the cleanest way to do what
>> it wants to do (if the feature worked properly, that is, which is not the
>> case)?
>
> It's like:
>
> The current working directory is like
> /usr/lib/python2.5/site-packages/Pootle. The git repository is under
> /some/other/path/outside/usr.
>
> Then Pootle has two possibilities:

The real question was about if/why that git repository _has to be_ outside
of /usr/lib/*/Pootle/.  Is that because --work-tree, if worked properly,
would have allowed it to be, or is that because for some external reason
you are not allowed to have .git under /usr/lib/*/Pootle/ directory?

If the latter, that shows the real requirement to keep supporting it as a
feature, and issues around it need to be fixed.  Otherwise, i.e. if it
does not require use of --work-tree but it uses it only because it could,
that gives us less incentive to keep --work-tree as a feature.

I haven't read the breakage and fix around diff in this thread yet, but I
will when I get home.

Thanks to both Nguyen and you for trying to salvage --work-tree support.

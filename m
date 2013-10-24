From: Jeff King <peff@peff.net>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 22:27:36 -0400
Message-ID: <20131024022736.GA24992@sigill.intra.peff.net>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
 <vpqbo2guff7.fsf@anie.imag.fr>
 <xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
 <87hac7hmrb.fsf@mcs.anl.gov>
 <xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
 <87zjpzg592.fsf@mcs.anl.gov>
 <vpqy55jogzr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jed Brown <jed@59A2.org>, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 24 04:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZAeT-0004Nu-JD
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 04:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab3JXC1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 22:27:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:54504 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753121Ab3JXC1j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 22:27:39 -0400
Received: (qmail 21071 invoked by uid 102); 24 Oct 2013 02:27:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Oct 2013 21:27:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Oct 2013 22:27:36 -0400
Content-Disposition: inline
In-Reply-To: <vpqy55jogzr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236563>

On Wed, Oct 23, 2013 at 10:43:36PM +0200, Matthieu Moy wrote:

> That may be an option. In the case of "git add -u", it was a bit more
> complicated, since a badly used "git add" somehow looses data (not very
> serious, you may only loos the index). So, saying after the fact "oh, by
> the way, I messed up the index" was not a very good transition plan.
> 
> In the case of "grep", I'm starting to get convinced that it's OK to do
> so, because the user can basically re-run grep with the right argument
> if needed.

For the same reason, is it insane to want a config option to switch the
default when no command-line option is given? These days I am mostly
working on reasonably-sized projects, and would generally prefer
full-tree grep. But in a past life, I worked on some large projects
where I would never touch anything outside of a particular subtree, and
I generally wanted a more limited grep (i.e., I would park my cwd in
/repo/subsystem1 rather than /repo and work from there, and hits in
/repo/subsystem2 were just useless noise).

That would also provide people who do not like the change of default an
escape hatch to keep the current behavior. And I do not think scripted
use will be inconvenienced; they will already have to use "." or ":/" to
be explicit (if they care) since the behavior is changing.

> The warning could be de-activable with an advice.* option.

Such a config option could also be used to shut up the warning. Though
if the behavior change is deemed non-intrusive enough to not merit a
deprecation period, I am not really sure it is worth having a noisy
warning.

-Peff

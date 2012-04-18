From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: organizing multiple repositories with dependencies
Date: Wed, 18 Apr 2012 14:09:24 +0200
Message-ID: <4F8EAEF4.8030706@web.de>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com> <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com> <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com> <nng1unmnksx.fsf@transit.us.cray.com> <CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: dag@cray.com, Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 14:09:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKTha-0003hW-NB
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 14:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab2DRMJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 08:09:33 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:32979 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab2DRMJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 08:09:31 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id 779FC7632F57
	for <git@vger.kernel.org>; Wed, 18 Apr 2012 14:09:25 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.175.87]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LrsC6-1S7i4A4302-013gcg; Wed, 18 Apr 2012 14:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
X-Provags-ID: V02:K0:gFlCBlbDYUPgC2tuBuO6LeoTyCQded//sAOFuHj1Aua
 M9rOvBj8kVaCsquUi5ZgfVAtW3VSx8T8ynK+y/iEJtX+uN7Zf/
 /+A8BE3QaQCnNBjpRrPpMDXoBBWGEtBiocORBkanl9x7UJ2A8F
 QKgM+pPQxSuFWaF2Ue5e+uiP/x0l7NQ/dDZGYkiZXaoMc0ca/Q
 +z11vy/tXqnIoLq5AUZpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195861>

Am 17.04.2012 23:43, schrieb Hilco Wijbenga:
> The main problem with the current submodule support is that there is
> so much manual work needed. It is too easy to forget a step. Moreover,
> it's not easy to determine *that* you forgot a step or which step you
> forgot.

Looks like you are talking about the submodule support how it was a
few years ago. Since 1.7.0 you cannot forget to commit changes in the
submodule anymore, and since 1.7.5 all referenced submodule commits
are fetched when you fetch the superproject. The only thing missing
(with some work done towards that in last years GSoc) is supporting
the pushing of submodule changes and the transparent update of
submodule content when the superproject is updated, both of which are
currently being worked on.

What else was bothering you so much you dumped submodules?

>> Of course, this is entirely driven by git-subtree's model of actually
>> incorporating subproject history into one big umbrella repository.
>> There is no separation between the subprojects and umbrella projects.
>> It's one giant history.  Therefore, push/pull to/from subprojects are
>> explicit operations.  That's probably not the best model for every
>> situation but I find it very nice.
> 
> I do not have enough (okay, any) experience with subtree to comment on
> that. The first part seems just what I want. I'm not sure about the
> explicit pushing/pulling part. That sounds too much like asking for
> the sort of problems that scared us away from submodules. Hopefully,
> I'm dead wrong. :-)

As I understand subtree the pushing and pulling of the subprojects
is needed pretty much at the same points in time it is needed when
using submodules (to share the subproject work between different
superprojects via their upstream). The difference is you import all
subproject changes into a single repo when using subtree, while they
stay separate when using submodules (and additionally you have to
record the updated subprojects in the superproject in an extra
commit there). Submodules enforce the distinction between submodules
and the superproject while subtree doesn't, which may or may not be
just what you want ;-)

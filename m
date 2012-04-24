From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 16:52:53 -0400
Message-ID: <201204242052.q3OKqrYT020792@no.baka.org>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com> <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com> <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com> <nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de> <nngbomh3uz0.fsf@transit.us.cray.com> <201204241759.q3OHxSbH017287@no.baka.org>
        <4F970C92.3030704@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: dag@cray.com, Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, greened@obbligato.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 22:54:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMmkl-0004ON-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 22:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab2DXUyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 16:54:22 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:43112 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756096Ab2DXUyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 16:54:21 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q3OKqsaW020732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Apr 2012 16:52:54 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q3OKqrYT020792;
	Tue, 24 Apr 2012 16:52:54 -0400
In-reply-to: <4F970C92.3030704@web.de>
Comments: In reply to a message from "Jens Lehmann <Jens.Lehmann@web.de>" dated "Tue, 24 Apr 2012 22:26:58 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196251>


In message <4F970C92.3030704@web.de>, Jens Lehmann writes:

    gitslave: This creates a federation of full fledged git repositories which
    are operated on by the gits commands together (where a git command would
    only operate on the superproject).
    The emphasis lies on the simultaneous operation of gits commands on all
    git repositories.
    It does not provide any coupling of the commits in the superproject and the
    slave repositories (but you can use tags to have that at some points in the
    history).

Well, gitslave is essentially a loop to run the listed git command in
each repository, so there are no atomic operations and you can get
partial success and partial failure, thus "simultaneous operation"
isn't a very good description.

Perhaps a better sentence would be, "The emphasis lies in the
simplicity and convenience of having gits commands run the same git
operation on all linked repositories, with output summarizing."

Just a FYI: partial success and partial failure in different
repositories isn't a major problem when using git.  However, in the
interest of full disclosure, two users racing to push could in theory
cause a broken project given specific combinations of some users
modifying different repositories than others with mutual dependencies
between them.  But in all of the years of using gitslave no-one has
ever had/reported such a problem.  If you can assuming any sort of
sane QA and deployment practice, this should be able to cause an
operational problem.

					-Seth Robertson

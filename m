From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7600: merge tag shoud create a merge commit
Date: Fri, 22 Mar 2013 11:05:36 -0400
Message-ID: <20130322150536.GE3083@sigill.intra.peff.net>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vr4j78p8a.fsf@alter.siamese.dyndns.org>
 <831c87ad325075b6049ef52c24477da2@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 16:06:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3Xu-00050U-EX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 16:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933715Ab3CVPFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 11:05:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35780 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192Ab3CVPFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 11:05:45 -0400
Received: (qmail 1430 invoked by uid 107); 22 Mar 2013 15:07:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 11:07:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 11:05:36 -0400
Content-Disposition: inline
In-Reply-To: <831c87ad325075b6049ef52c24477da2@meuh.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218812>

On Fri, Mar 22, 2013 at 03:56:15PM +0100, Yann Droneaud wrote:

> Le 22.03.2013 15:48, Junio C Hamano a =C3=A9crit=C2=A0:
> >>
> >>It's not in final shape: the line
> >>
> >>    EDITOR=3Dfalse test_must_fail git merge signed
> >
> >Because test_must_fail is a shell function, single-shot environment
> >assignment like this should not be used.
>=20
> It's used throughout the test. The test 'merge --no-edit tag should
> skip editor' is using it.

It's OK to do:

  SINGLE_SHOT=3Dfoo some_real_command

and it's OK to do:

  some_fun args

but it's not OK to do:

  SINGLE_SHOT=3Dfoo some_function args

Because some POSIX shells do not create a new environment for the
function (and SINGLE_SHOT will persist after the call, polluting the
environment).

> Before posting my half useful test, I used "EDITOR=3Dfalse
> test_must_fail set" in --verbose mode to find if EDITOR was correctly
> defined passed test_must_fail, and it was.

I do not think there is a shell that does not set it; it is only that
some shells do not _unset_ it.

-Peff

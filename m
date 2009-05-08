From: Jeff King <peff@peff.net>
Subject: Re: Tests in Cygwin
Date: Thu, 7 May 2009 22:00:37 -0400
Message-ID: <20090508020037.GA1264@coredump.intra.peff.net>
References: <83prfbhasp.fsf@kalahari.s2.org> <4A01E64C.7050703@SierraAtlantic.com> <7vvdoet13g.fsf@alter.siamese.dyndns.org> <4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Fri May 08 04:01:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2FPE-0000A5-1f
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 04:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbZEHCAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 22:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbZEHCAi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 22:00:38 -0400
Received: from peff.net ([208.65.91.99]:41473 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZEHCAh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 22:00:37 -0400
Received: (qmail 15624 invoked by uid 107); 8 May 2009 02:00:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 07 May 2009 22:00:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 07 May 2009 22:00:37 -0400
Content-Disposition: inline
In-Reply-To: <4A030277.2000708@SierraAtlantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118557>

On Thu, May 07, 2009 at 11:47:03AM -0400, Don Slutz wrote:

> Here is a change back to using spaces.  It also includes a change
> to test for the code working.  Squash on top.

Maybe it is just me, but I think

  test_expect_success SYMLINKS,SANITY 'some description' '
    the actual test
  '

is more readable than the space (since it keeps the number of single
quoted chunks on the line down). Which should be as simple as:

> -# prerequisites can be concatenated with '+'
> test_have_prereq () {
> -       save_IFS=$IFS
> -       IFS=+
> -       set -- $*
> -       IFS=$save_IFS
> -       for prerequisite
> +       for prerequisite in $(echo $*)
>        do
>                case $satisfied in
>                *" $prerequisite "*)

  +for prerequisite in $(echo "$1" | tr , ' ')

Just my bikeshedding two cents,

-Peff

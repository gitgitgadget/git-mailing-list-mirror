From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 06 Mar 2007 15:17:02 -0800
Message-ID: <7vzm6qm07l.fsf@assigned-by-dhcp.cox.net>
References: <20070306093917.GA1761@coredump.intra.peff.net>
	<989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
	<7vzm6qps51.fsf@assigned-by-dhcp.cox.net>
	<200703061423.18417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:17:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOiu5-0001DK-UL
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbXCFXRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Mar 2007 18:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbXCFXRG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:17:06 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41027 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030678AbXCFXRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2007 18:17:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306231703.CZBQ2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 18:17:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XbH21W0111kojtg0000000; Tue, 06 Mar 2007 18:17:03 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41616>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Speaking of -title, I see "sub git_project_list_body" does this:
>>=20
>> =C2=A0 =C2=A0 $cgi->a({ ... -title =3D> $pr->{'descr_long'}}, esc_ht=
ml($pr->{'descr'}));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> which seems inconsistent with the earlier quoted $fullname
>> handling (unless $pr->{'descr_long'} is already quoted and $pr->{'de=
scr'}
>> is not, which I find highly unlikely).
>
> CGI::a() subroutine automatically quotes properly _attribute_ values,
> but it does not (and it should not) quote _contents_ of a tag.
>
> So the above code is correct.

Sorry, you lost me...  I am wondering what you mean by
"automatically".  Do you mean 'always'?

And if that is the case, shouldn't we drop esc_html() around
$fullname here?

    ...  For example, many places esc_html()
    is used as the body of <a ...>$here</a> but some places it is
    used as

        $cgi->a({ ... -title =3D>esc_html($fullname) }, esc_path($dir))

as we do not have it around $pr->{'descr_long'} in the above?

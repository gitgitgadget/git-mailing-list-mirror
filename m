From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv3] git-fetch: Split fetch and merge logic
Date: Sat, 24 Feb 2007 01:30:19 -0800
Message-ID: <7vd53zzyvo.fsf@assigned-by-dhcp.cox.net>
References: <87wt29i7hg.fsf@gmail.com>
	<7vabz56vyq.fsf@assigned-by-dhcp.cox.net>
	<8aa486160702230242r4059811ewbc4cb5c6d33500df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 24 10:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKtEh-000272-69
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 10:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459AbXBXJaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Feb 2007 04:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933458AbXBXJaX
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 04:30:23 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35445 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933460AbXBXJaU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Feb 2007 04:30:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224093020.YTWI2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Feb 2007 04:30:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TMWK1W0091kojtg0000000; Sat, 24 Feb 2007 04:30:20 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40509>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On 2/23/07, Junio C Hamano <junkio@cox.net> wrote:
>
>> I am wondering if FETCH_FETCHED is purely for internal use by
>> git-fetch (it appears so), and if so if it is worth trying to do
>> without the temporary file, but that is a minor detail.
>
> Yes, it's purely internal. With "without the temporary file" you mean
> to put the content in a variable or removing at the end?

If a variable suffices that would be quite nice, but it is not a
big deal.  As the script does fair amount of computation in
subprocess, I suspect it may not be worth trying to use variable,
only to get rid of the temporary file.

>> I appreciate the cleverness of the intersection.  However, is
>> "echo -e" portable?  I think we have avoided it so far (we have
>> avoided even "echo -n" which is traditionally much more
>> available).
>
> printf '%s\n%s' "$merge_branches" "$fetch_branches"
>
> is OK?

Yes.  I think printf is what people who rewrote my "echo -n"
have done elsewhere.

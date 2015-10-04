From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 3/4] git-p4: Fix t9815 git-p4-submit-fail test case on
 OS X
Date: Sun, 4 Oct 2015 16:18:23 -0400
Message-ID: <20151004201823.GA8366@padd.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
 <1443981977-64604-4-git-send-email-larsxschneider@gmail.com>
 <xmqqegha1oj6.fsf@gitster.mtv.corp.google.com>
 <90C13A5C-AB19-4E5C-A317-15B3D182444D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 22:28:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zipt2-0005rV-Oh
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 22:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbbJDU14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 16:27:56 -0400
Received: from honk.padd.com ([162.221.205.100]:47911 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbbJDU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 16:27:56 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Oct 2015 16:27:55 EDT
Received: from arf.padd.com (unknown [50.111.75.71])
	by honk.padd.com (Postfix) with ESMTPSA id EEA654C003E;
	Sun,  4 Oct 2015 13:18:24 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5D4D123152; Sun,  4 Oct 2015 16:18:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <90C13A5C-AB19-4E5C-A317-15B3D182444D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279025>

larsxschneider@gmail.com wrote on Sun, 04 Oct 2015 11:44 -0700:
> 
> On 04 Oct 2015, at 11:23, Junio C Hamano <gitster@pobox.com> wrote:
> 
> > larsxschneider@gmail.com writes:
> > 
> >> +		if test_have_prereq CYGWIN; then
> >> +			: # NOOP
> >> +		elif test_have_prereq DARWIN; then
> >> +			stat -f %Sp text | egrep ^-r-- &&
> >> +			stat -f %Sp text+x | egrep ^-r-x
> >> +		else
> >> 			stat --format=%A text | egrep ^-r-- &&
> >> 			stat --format=%A text+x | egrep ^-r-x
> >> 		fi
> > 
> > Not a new problem but why do we need "stat" here?
> > 
> > Shouldn't "test -r", "! test -x", and their usual friends be
> > sufficient for the purpose of the test and are more portable?
> 
> Good question. The stat call was introduced with df9c545 by Pete Wyckoff.
> @Pete, @Luke: Are you aware of any particular reason for stat?

I think you could do this all with test. The key is to make
sure the files are readable, not writable, and either executable
or not. Cygwin and darwin oddities were not on my radar 3 years ago.

See also 4cea4d6 (git p4 test: use test_chmod for cygwin,
2013-01-26) for the description I wrote about what this test is
trying to verify.

		-- Pete

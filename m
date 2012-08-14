From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git diff vs git diff-files
Date: Tue, 14 Aug 2012 11:55:39 +0200
Message-ID: <87393pztk4.fsf@thomas.inf.ethz.ch>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	<87fw7qhm31.fsf@thomas.inf.ethz.ch>
	<CAF7PVPqyaZQtca0KfWHirBY2Dvdtn2RT-_mxR8x5uUNsfbHmdQ@mail.gmail.com>
	<87vcgl999v.fsf@thomas.inf.ethz.ch>
	<CAF7PVPq0Wjck+53G4=Ofz0drMdx9NtpfgzMFR4j=32N-ez2xBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Bernd Jendrissek <bernd.jendrissek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 11:56:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Dqz-0006qU-5X
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 11:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab2HNJzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 05:55:44 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:3365 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587Ab2HNJzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 05:55:42 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 11:55:37 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 11:55:40 +0200
In-Reply-To: <CAF7PVPq0Wjck+53G4=Ofz0drMdx9NtpfgzMFR4j=32N-ez2xBg@mail.gmail.com>
	(Bernd Jendrissek's message of "Tue, 14 Aug 2012 11:15:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203395>

Bernd Jendrissek <bernd.jendrissek@gmail.com> writes:

> On Tue, Aug 14, 2012 at 10:18 AM, Thomas Rast <trast@student.ethz.ch> wrote:
>> Can you try the following:
>>
>>   git ls-files --debug gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>>   cp .git/index .git/index.orig
>>   touch gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>>   # note, it is important that you run diff first
>>   git diff gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>>   git diff-files -p gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>>   git ls-files --debug gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>
> I'm can't tell what this was supposed to prove, but I think it's
> proven that I'm in the wrong mailing list, and that I should be taking
> this up with gnome-terminal. The Q1 part deletion line seems to be
> appearing (in the terminal) only after I've copy&pasted it into
> another terminal.
>
> Running the same commands in xterm (correctly) shows the Q1 part
> deletion line without having to copy & paste.

Fun stuff.  This will be very interesting to debug.  It's still
possible, though perhaps not extremely likely, that git is writing
garbage to the terminal and it just happens to work for xterm.

Whatever you do next, *please* post the *exact* file contents *and*
output in a format that does not suffer any transport damage, neither to
whitespace nor to binary data (such as terminal escapes).  Piping
through xxd comes to mind, perhaps by using

  GIT_PAGER=xxd git -p diff ....  >diff-hexdump

etc. to ensure that git takes the same code paths as when writing to
less.

Cut&paste from a terminal will at best give you exactly what the
terminal figures it is *currently displaying*, which is completely
different from what programs write to it.  At worst, it will also suffer
whitespace damage.  So pretty much everything you showed so far, except
for the raw data of one (why only one?!) side of the diff, is useless.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

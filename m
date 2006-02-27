From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: NT directory traversal speed on 25K files on Cygwin
Date: Mon, 27 Feb 2006 19:30:49 +0100
Organization: M38c
Message-ID: <20060227183049.GA13195@nospam.com>
References: <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <20060226231701.GA11961@nospam.com> <20060227011801.GB9264@trixie.casa.cgf.cx>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 19:31:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDn9i-0004hP-Qe
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWB0SbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWB0SbN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:31:13 -0500
Received: from post-24.mail.nl.demon.net ([194.159.73.194]:29137 "EHLO
	post-24.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751441AbWB0Sax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 13:30:53 -0500
Received: from wingding.demon.nl ([82.161.27.36]:50534)
	by post-24.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FDn90-00063d-G1; Mon, 27 Feb 2006 18:30:50 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FDn8z-0003pb-RN; Mon, 27 Feb 2006 19:30:49 +0100
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060227011801.GB9264@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16870>

On Sun, Feb 26, 2006 at 08:18:01PM -0500, Christopher Faylor wrote:
> On Mon, Feb 27, 2006 at 12:17:01AM +0100, Rutger Nijlunsing wrote:
> >On Sun, Feb 26, 2006 at 02:55:52PM -0500, Christopher Faylor wrote:
> >>On Thu, Feb 23, 2006 at 03:07:07PM +0100, Alex Riesen wrote:
> >>>filesystem is slow and locked down, and exec-attribute is NOT really
> >>>useful even on NTFS (it is somehow related to execute permission and
> >>>open files.  I still cannot figure out how exactly are they related).
> >>
> >>Again, it's not clear if you're talking about Windows or Cygwin but
> >>under Cygwin, in the default configuration, the exec attribute means
> >>the same thing to cygwin as it does to linux.
> >
> >I don't know about native Windows speed, but comparing NutCracker with
> >Cygwin on a simple 'find .  | wc -l' already gives a clue that looking
> >at Cygwin to benchmark NT file inspection IO will give a skewed
> >picture:
> >
> >##### NutCracker $ time find .  | wc -l
> >
> >real    0m 1.44s
> >user    0m 0.45s
> >sys     0m 0.98s
> >25794
> >
> >##### Cygwin $ time c:\\cygwin\\bin\\find .  | wc -l
> >
> >real    0m 6.72s
> >user    0m 1.09s
> >sys     0m 5.59s
> >25794
> >
> >##### CMD.EXE + DIR /S C:\PROJECT> c:\cygwin\bin\time cmd /c dir /s
> >>NUL 0.01user 0.01system 0:05.70elapsed 0%CPU (0avgtext+0avgdata
> >6320maxresident)k 0inputs+0outputs (395major+0minor)pagefaults 0swaps
> >
> >##### Cygwin 'find -ls' (NutCracker doesn't have a '-ls') C:\PROJECT>
> >c:\cygwin\bin\time c:\cygwin\bin\find -ls | wc -l 2.79user 7.81system
> >0:10.60elapsed 100%CPU (0avgtext+0avgdata 14480maxresident)k 25794
> 
> I'm lost.  What does this have to do with the exec attribute?
> 
> Or, were you just climbing aboard the "Cygwin sure is slow" bandwagon?

I tried to get on the bandwagon 'NT file IO magnitudes slower => git
magnitudes slower', but missed the parade a week ago. Then another
parade showed up, but I managed to delete most of it with a
misfortunate shift-something in mutt... And then even messed up in
keeping the wrong paragraph... *hmpf*

However, the point I was trying to make was that git might be sped up
by a magnitude (although not all of the magnitudes in comparison to
Linux) by looking at why the file IO is this slow: Windows' file IO is
_not_ the only reason. Using a different/new/better fitted interface
to Cygwin or Win32 for a specific git task might help, although I have
no clue what or how.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------

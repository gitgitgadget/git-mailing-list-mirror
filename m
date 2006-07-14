From: Christopher Faylor <me@cgf.cx>
Subject: Re: Error writing loose object on Cygwin
Date: Fri, 14 Jul 2006 01:24:10 -0400
Message-ID: <20060714052410.GA19680@trixie.casa.cgf.cx>
References: <20060712035746.GA7863@spearce.org> <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net> <20060713055127.GA15960@trixie.casa.cgf.cx> <20060714033435.GA1508@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 14 07:24:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1GA3-0005A1-Js
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 07:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWGNFYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 01:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWGNFYM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 01:24:12 -0400
Received: from pool-71-248-179-44.bstnma.fios.verizon.net ([71.248.179.44]:41353
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S964794AbWGNFYM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 01:24:12 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id B14CD13C021; Fri, 14 Jul 2006 01:24:10 -0400 (EDT)
To: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060714033435.GA1508@spearce.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23873>

On Thu, Jul 13, 2006 at 11:34:35PM -0400, Shawn Pearce wrote:
>Christopher Faylor <me@cgf.cx> wrote:
>> On Tue, Jul 11, 2006 at 09:15:38PM -0700, Junio C Hamano wrote:
>> >Shawn Pearce <spearce@spearce.org> writes:
>> >
>> >> Has anyone else seen this type of behavior before?  Any suggestions
>> >> on debugging this issue?
>> >
>> >I would suggest raising this (politely) to Cygwin people.
>> 
>> I lost the thread here but wasn't this referring to a samba mount?  If so,
>> it would be samba that's returning the wrong "errno".
>
>I thought about that but Windows 2000 talking to the same samba
>server issues back the correct errno.  Running the exact same Cygwin
>and GIT binaries (we've at least standardized on that).  So it
>seems weird that a samba server is issuing the correct error code
>to a Windows 2000 client but the wrong one to a Windows XP client.
>(In both cases the clients are accessing directories on the same
>filesystem on the UNIX server.)

It's entirely possible that samba is behaving differently with different
versions of windows.  OTOH, I believe that EACCES is the catch-all for
windows errors when translating into errnos so possibly it is an
uncaught error translation.

If you have the inclination and time, if you could run the session
under strace:  "strace -o strace.out git ...",d snip twenty or
thirty lines on each side of the place where the the errno translation
is happening, and send it to the cygwin list at cygwin at cygwin 
maybe something will be obvious.

Note that cygwin's strace is not anything like any other strace and
is quite a bit more wordy so, this file will be pretty large.  That's
why I ask for some careful editing before sending it to the mailing
list.  The errno number for EACCES on cygwin is 13.

cgf

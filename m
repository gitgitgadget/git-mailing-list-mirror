From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Tue, 28 Mar 2006 15:20:49 -0800
Message-ID: <7vbqvqjgvi.fsf@assigned-by-dhcp.cox.net>
References: <15693.1143575188@lotus.CS.Berkeley.EDU>
	<slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk>
	<Pine.LNX.4.64.0603281500280.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 01:21:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FONUc-0004Gf-Vy
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 01:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWC1XUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 18:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWC1XUw
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 18:20:52 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39146 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964801AbWC1XUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 18:20:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328232050.NWDV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 18:20:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603281500280.15714@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 28 Mar 2006 15:03:05 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18139>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 28 Mar 2006, Mark Wooding wrote:
>
>> Jason Riedy <ejr@EECS.Berkeley.EDU> wrote:
>> 
>> > P.S. For the whole finding-a-function-name business, some of 
>> > us are using git on fixed-format Fortran.  Every non-comment
>> > line begins with whitespace...  ;)  And in free format, many
>> > people don't add that first indentation within subroutines.
>> 
>> Urgh.  So, which regex library do people want to use? ;-)  (My vote's
>> for pcre.)
>
> I'd really just prefer to make the "-p" switch configurable, the way it 
> was before. No regexps, just the same rules as for GNU diff, perhaps with 
> the difference being that it would be on by default.

Strictly speaking, "No regexps" and "same rules as for GNU diff"
are mutually incompatible, since GNU diff -p defaults to
"^[[:alpha:]$_]" but the regexp is configurable.

My preference is to ignore FORTRAN, keep Mark's current rules,
perhaps with a way to turn it off if people really find it
annoying (I do not mind having it always on).

> Another possible approach is to say
>  - if the first line of the real diff matches the rules, do NOT add 
>    another line that matches the rule at the @@-line.
>
> since the simple @@-line rule really doesn't make sense for any file that 
> is "dense" (ie where most lines start with non-whitespace).

I think this is a good rule.  If "the first non-empty line" may
be even better; we do not want to see the name of previous
function for a huke like this:

	@@ -a,b +c,d @@

        int frotz(void)
        {
            ...

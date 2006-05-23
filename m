From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 01:24:38 -0700
Message-ID: <7vpsi55et5.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	<46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	<44720C66.6040304@gentoo.org>
	<46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	<Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	<20060522214128.GE16677@kiste.smurf.noris.de>
	<7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
	<46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
	<20060523065232.GA6180@coredump.intra.peff.net>
	<20060523070007.GC6180@coredump.intra.peff.net>
	<46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 10:25:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSCI-0000CJ-Ik
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWEWIYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWEWIYz
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:24:55 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21673 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932107AbWEWIYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 04:24:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523082454.NRTF18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 04:24:54 -0400
To: git@vger.kernel.org
In-Reply-To: <46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 23 May 2006 20:13:10 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20578>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Jeff,
>
> good stuff -- aiming at exactly the things that had been nagging me.
> Some minor notes on top of what junio's mentioned...
>
>> +    die "unable to open $f: $!" unless $! == POSIX::ENOENT;
>> +    return undef;
>
> Heh. Is that the return of the living dead?

Note the trailing "unless" there.

>> +sub update_index (\@\@) {
>> +       my $old = shift;
>> +       my $new = shift;
>
> Would it not make more sense to just pass them as plain parameters?

Meaning...?  Perl5 can pass only one flat array, so the above is
a standard way to pass two arrays.

>> +       print "Committed patch $patchset ($branch $commit_date)\n" if
>
> Given that we have that -- should we remember it and avoid re-reading
> the headref from disk? A %seenheads cache would save us 99.9% of the
> hassle.
>
> In related news, I've dealt with file reads from the socket being
> memorybound. Should merge ok.

Merged OK, and I think your last suggestion makes sense.  I'll
go to bed after pushing out Jeff's two patches and yours.

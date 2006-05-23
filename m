From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 13:25:55 -0700
Message-ID: <7vsln04hf0.fsf@assigned-by-dhcp.cox.net>
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
	<Pine.LNX.4.64.0605230948280.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605231232360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 22:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FidS4-0002ug-7K
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWEWUZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWEWUZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:25:57 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21461 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932126AbWEWUZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 16:25:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523202556.RWUL27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 16:25:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605231232360.5623@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 23 May 2006 12:36:37 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20631>

Linus Torvalds <torvalds@osdl.org> writes:

>> 	Committing initial tree 34bd3dcd4bfd79bad35ce3fb08b2e21108195db8
>> 	Server has gone away while fetching BUGS-TODO 1.1, retrying...
>...
> Martin, that problem seems to go away when I initialize $res to 0 in 
> _fetchfile. 
>
> I don't know perl, and maybe local variables are pre-initialized to empty. 

When a new file that is empty is created, sub _line would call
sub _fetchfile with $cnt == 0, and it can return $res which
is initialized to 'undef'.  That explains why sub file says
$self->_line() returned an undef and I think what you did is the
right fix.

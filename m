From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH]: remove extra-verbosity from git-clone (http)
Date: Mon, 19 Mar 2007 16:45:33 -0700
Message-ID: <7vslc0er1e.fsf@assigned-by-dhcp.cox.net>
References: <58d389c20702150910x24ec218bjdb9cb49ee03fd1df@mail.gmail.com>
	<20070319230436.GB12555@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fernando Herrera <fherrera@onirica.com>, git@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 00:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTRXm-0000Py-I0
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 00:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbXCSXpf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 19:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965337AbXCSXpf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 19:45:35 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47416 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965153AbXCSXpe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 19:45:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319234535.BKWM2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 19:45:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cnlZ1W00e1kojtg0000000; Mon, 19 Mar 2007 19:45:34 -0400
In-Reply-To: <20070319230436.GB12555@sequoia.sous-sol.org> (Chris Wright's
	message of "Mon, 19 Mar 2007 16:04:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42682>

Chris Wright <chrisw@sous-sol.org> writes:

> * Fernando Herrera (fherrera@onirica.com) wrote:
>> the attached patch removes the extra verbosity when cloning a http
>> repository. I noticed this after some git upgrade in fedora. Please,
>> consider applying it, getting tons of "got XXX", "walk XXX" lines by
>> default is a little bit annoying.
>> 
>> Salu2
>> 
>> PS: Thanks for this so great piece os software!
>> 
>> --- git-clone.sh.orig	2007-02-15 19:03:51.000000000 +0200
>> +++ git-clone.sh	2007-02-15 19:04:06.000000000 +0200
>> @@ -59,7 +59,7 @@
>>  		else
>>  			tname=$name
>>  		fi
>> -		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
>> +		git-http-fetch -a -w "$tname" "$name" "$1/" || exit 1
>>  	done <"$clone_tmp/refs"
>>  	rm -fr "$clone_tmp"
>>  	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
>
> Was there any problem with this patch from Fernando?  I don't care much
> either way (I simply never use http fetch myself ;-).  Just doing some
> old bugzilla cleanup and noticed this still was neither picked up nor
> replied to.  So, in case it just fell through the cracks...

I saw it.  The -v option used not to be there, but we added it
with an explicit purpose of not boring people fetching over http
connection (which used to be slow especially before packfiles
were introduced).  I do not care much either way, but I suspect
there actually are people who want to see that "assuring look"
of something happening.  I dunno.

I am certainly *not* opposed to have an explicit option or a
per-user configuration to make it not pass -v to http-fetch.  I
am just wondering if we want to change the default.  Especially
people new to git may wonder what is happening without _any_
feedback if we turned it off by default.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 17:55:48 -0800
Message-ID: <7v3bicupgb.fsf@assigned-by-dhcp.cox.net>
References: <43FB6C42.5000208@gorzow.mm.pl>
	<BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE>
	<Pine.LNX.4.64.0602211635450.30245@g5.osdl.org>
	<20060222011338.GL5000@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:55:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBjER-0007Vy-5t
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161287AbWBVBzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWBVBzw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:55:52 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56745 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932520AbWBVBzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:55:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222015406.DZZI20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 20:54:06 -0500
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20060222011338.GL5000@delft.aura.cs.cmu.edu> (Jan Harkes's
	message of "Tue, 21 Feb 2006 20:13:38 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16583>

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> On Tue, Feb 21, 2006 at 04:42:34PM -0800, Linus Torvalds wrote:
>> 
>> 	git pull git://git.kernel.org/....
>> 
>> and the automatic tag following kicks in, it will first have fetched the 
>> objects once, and then when it tries to fetch the tag objects, it will 
>> fetch the objects it already fetched _again_ (plus the tags), because it 
>> will do the same object pull, but the temporary branch (to be merged) will 
>> never have been written as a branch head.
>
> Isn't this easily avoided by fetching the tags first?

I do not think so.

Notice how the tag following code uses cat-file to determine if
the main fetch likely has slurped the object they point at.

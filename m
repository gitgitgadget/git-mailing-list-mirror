From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Tue, 30 May 2006 22:05:51 -0700
Message-ID: <7v64jm2380.fsf@assigned-by-dhcp.cox.net>
References: <20060529085738.GB29500@spearce.org>
	<7virnp8a30.fsf@assigned-by-dhcp.cox.net>
	<20060529094605.GB27194@spearce.org>
	<7vhd373o15.fsf@assigned-by-dhcp.cox.net>
	<20060531021808.GC21222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 07:06:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlIu6-0002BH-9E
	for gcvg-git@gmane.org; Wed, 31 May 2006 07:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWEaFFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 01:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWEaFFy
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 01:05:54 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52642 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751699AbWEaFFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 01:05:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531050552.XNQD24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 May 2006 01:05:52 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21057>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> If we supported multiple -m (presumably each becomes a single line?)
>> with internal fmt, I do not see how it would become less work.
>> 
>> 	$ git commit -w60 -m "This is my message." \
>>         	-m '' \
>>         	-m 'This is the body.  Etc....'
>> 
>> looks more typing to me, even without the second line to force
>> the empty line between the summary and the body.
>
> Actually I was thinking each -m would be its own paragraph so blank
> lines would split each -m and maybe the -w60 should be a config
> option in .git/config or .gitrc so it doesn't always need to be
> supplied on the command line.

Now that makes the distinction between the current:

	$ git commit -m 'This is my message.

	This is the body.  Etc....'

vs. the proposed multi-em:

	$ git commit -m 'This is my message.' \
        -m 'This is the body.  Etc....'

Presumably Etc.... will be an multiline argument to -m.  The
distinction is even more blurry to me than before.

Emacs users would just do "ESC q" and vi users would know how to
filter the file contents through fmt, so this seems to come from
aversion against invoking your $EDITOR.  I just do not see why.

Having said that, I do realize that the current behaviour of
accepting multiple -m without complaining and discarding all but
the last one silently is far worse than what is being proposed,
and I do not see downside to the multiple -m patch, so let's
apply that.  You can have your "fmt -w60" provided if it is made
into an option.

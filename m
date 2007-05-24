From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Thu, 24 May 2007 13:12:46 -0700
Message-ID: <7v8xbevv41.fsf@assigned-by-dhcp.cox.net>
References: <20070520181447.GA10638@ferdyx.org>
	<7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
	<20070521182052.GB4696@ferdyx.org>
	<7vd50qvwaz.fsf@assigned-by-dhcp.cox.net>
	<20070524195608.GA4714@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Thu May 24 22:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrJgJ-00061U-Dr
	for gcvg-git@gmane.org; Thu, 24 May 2007 22:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbXEXUMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbXEXUMt
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 16:12:49 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61570 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbXEXUMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 16:12:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524201249.HQDJ13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 16:12:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 38Cm1X00i1kojtg0000000; Thu, 24 May 2007 16:12:47 -0400
In-Reply-To: <20070524195608.GA4714@ferdyx.org> (Fernando J. Pereda's message
	of "Thu, 24 May 2007 21:56:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48302>

"Fernando J. Pereda" <ferdy@gentoo.org> writes:

>> > +static int split_maildir(const char *maildir, const char *dir,
>> > +	int nr_prec, int skip)
>> > +{
>> > +	char file[PATH_MAX];
>> > +	char curdir[PATH_MAX];
>> > +	char name[PATH_MAX];
>> >  	int ret = -1;
>> > +	struct path_list list = {NULL, 0, 0, 1};
>> >  
>> > +	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
>> > +	if (populate_maildir_list(&list, curdir) < 0)
>> > +		goto out;
>> >  
>> > +	int i;
>> 
>> Decl-after-statement.
>
> I did it because other parts of the file do it too. Do you want me to
> fix the rest of them?

My "gcc -Werror -Wall -Wdeclaration-after-statement" does not
seem to find any in the existing code, but if you found any
please fix that in a separate patch.

>> > @@ -186,9 +249,39 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
>> > ...
>> > +		if (ret < 0) {
>> > +			error("cannot split patches from %s", arg);
>> > +			return 1;
>> > +		}
>> > +		num += ret;
>> > +	}
>> > +
>> > +	printf("%d\n", num);
>> >  
>> > -	return ret == -1;
>> > +	return 0;
>> >  }
>> 
>> We do not signal error anymore from the command?
>
> If we reached that part of the code, there is no error to signal about.
> We signal error when either split_mbox or split_maildir fail by
> returning 1.

Ok, you are right.

Thanks.

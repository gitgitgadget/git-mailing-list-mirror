From: Junio C Hamano <junkio@cox.net>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 12:50:25 -0700
Message-ID: <7voe5gypvi.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<20051023183757.GS30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 21:52:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETls3-0005Uq-Qy
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 21:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVJWTu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVJWTu2
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 15:50:28 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:3031 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750706AbVJWTu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 15:50:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023195007.VASF4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 15:50:07 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051023183757.GS30889@pasky.or.cz> (Petr Baudis's message of
	"Sun, 23 Oct 2005 20:37:57 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10503>

Petr Baudis <pasky@suse.cz> writes:

>> diff --git a/Makefile b/Makefile
>> index 903c57c..87188ea 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -359,6 +362,9 @@ git-cherry-pick: git-revert
>>  %.o: %.S
>>  	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
>>  
>> +$(SERVERSIDE_PROGRAMS) : git-%$X : %.o srvside-ssh.o $(LIB_FILE)
>> +	$(CC) $(ALL_CFLAGS) -o $@ $(filter %o,$^) $(LIBS)
>> +
>>  git-%$X: %.o $(LIB_FILE)
>>  	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
>>  
>
> Why are you adding own compilation command, and why is it inconsistent
> with the git-%$X's one?

Although I'd prefer the simplicity of putting srvside-ssh.o in
LIB_OBJS, this is arguably defensible; it avoids relinking of
everything else merely because srvside-ssh.c is changed.

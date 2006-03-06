From: Rajkumar S <rajkumars@asianetindia.com>
Subject: Re: cvsimport woes
Date: Mon, 06 Mar 2006 22:22:09 +0530
Message-ID: <440C68B9.9030305@asianetindia.com>
References: <44094618.6070404@asianetindia.com> <46a038f90603060124h4ea1c3c6gaa5d8b52ed311230@mail.gmail.com> <46a038f90603060137o758ea7ch6c40652ad86a102a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Mar 06 17:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGIwU-0000d6-O9
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 17:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWCFQwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 11:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWCFQwP
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 11:52:15 -0500
Received: from smtp.asianetindia.com ([202.88.238.28]:6876 "EHLO
	smtp.asianetindia.com") by vger.kernel.org with ESMTP
	id S1751937AbWCFQwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 11:52:14 -0500
Received: (qmail 2158 invoked from network); 7 Mar 2006 04:17:16 -0000
Received: by simscan 1.1.0 ppid: 2154, pid: 2155, t: 0.7141s
         scanners:none
Received: from unknown (HELO [202.83.59.61]) ([202.83.59.61])
          (envelope-sender <rajkumars@asianetindia.com>)
          by smtp.asianetindia.com (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 7 Mar 2006 04:17:15 -0000
User-Agent: Thunderbird 1.4.1 (X11/20051006)
To: git@vger.kernel.org
In-Reply-To: <46a038f90603060137o758ea7ch6c40652ad86a102a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17299>

Martin Langhoff wrote:
> On 3/6/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> you don't seem to be making any silly mistake. Make sure you are using
>> a recent git, and a recent cvsps. Actually you want the _latest_ cvsps
>> (2.1 I think).
> 
> Scratch this bit, naturally. I wasn't 100% paying attention. Still,
> the rest of the answer should kinda/sorta make sense.

Thanks for your kind replies.

I was also talking to Matthias Urlichs (the author of cvsimport) What he 
says is that the first version is still checked out because
the import does not do the fast-forward/merge by itself.

I am wondering how can I do the fast-forward. I had a long chat in irc 
but did not find any solution to this particular issue. I tried git 
merge, but that does not work as the command needs more arguments. (I am 
a git newbie and git concepts are still bit fuzzy for me)

I would appreciate a lot if some one can point me in the right direction.

If you are not following this thread, the problem I am talking about is 
that when I do a cvsimport for a second time (ie do a git cvsimport; 
update the cvs; do a cvsimport again) the second updates are not visible 
in the current directory, though they are present in the git database.

You can use this script to reproduce this problem.

export CVSROOT=/home/raj/cvsroot
rm -rf cvsroot/ git/ src/ /home/raj/.cvsps
mkdir cvsroot  git src
cvs init
cd src/
echo "Line one" > file.txt
echo "Line one" > file1.txt
echo "Line one" > file2.txt
cvs import -m "Imported sources" src start realstart
cd ..
rm -rf src/
cvs co src
git cvsimport -v -k -u -m -d $CVSROOT -C git/  src
cd git
git status
cd ..
cd src/
echo "Line two" >> file.txt
echo "Line two" >> file1.txt
cvs commit -m "v2.0"
cd ..
git cvsimport -v -k -u -m -d $CVSROOT -C git/  src
cd git
git status
cd ..

Now the cvs version of file.txt and git version are different.

Thanks and regards,

raj

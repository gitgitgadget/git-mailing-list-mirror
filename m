From: John Griessen <john@ecosensory.com>
Subject: debugging git clone  via git-daemon     "cannot handle daemon internally"
Date: Tue, 04 Jan 2011 10:50:55 -0600
Message-ID: <4D234FEF.2030501@ecosensory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 17:51:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaA6B-00027O-0f
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 17:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab1ADQu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 11:50:58 -0500
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:64848 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab1ADQu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 11:50:57 -0500
X-Authority-Analysis: v=1.1 cv=UQuFHoD2CPQ248x8AXEbKhr4z9AaDqApxmEl3BhfZ64= c=1 sm=0 a=-4fNSqmjlTwA:10 a=8nJEP1OIZ-IA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:17 a=wyvzCOmcxTsvDdF3RvEA:9 a=UqYKIMB556daDv8AfiS6qaYjb9QA:4 a=wPNLvfGTeEIA:10 a=Kc5_tDKYYfWjy68_:21 a=7sJ3Y2wpAIuUVGti:21 a=hpnIzNeuzKcqG6phuHbX0Q==:117
X-Cloudmark-Score: 0
X-Originating-IP: 66.68.104.159
Received: from [66.68.104.159] ([66.68.104.159:54423] helo=[192.168.15.39])
	by hrndva-oedge02.mail.rr.com (envelope-from <john@ecosensory.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 01/09-00963-FEF432D4; Tue, 04 Jan 2011 16:50:55 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164501>

I have a server running debian  git-core, gitosis,  git version 1.7.2.3 and local git version 1.7.2.3.

I've uninstalled git-daemon-run from the server for testing simplicity.

The server is running this:
sudo /usr/lib/git-core/git-daemon --verbose --strict-paths --user=git --group=gitosis /srv/gitosis/repositories  &>git-daemon-err.log

when I try  cloning from my local machine I get these results:

john@toolbench:~/EEProjects/test$ git clone git://mail.cibolo.us/gitosis-admin.git
Cloning into gitosis-admin...
fatal: protocol error: bad line length character: fata



john@toolbench:~/EEProjects/test$ telnet mail.cibolo.us 9418
Trying 76.191.252.85...
Connected to mail.cibolo.us.
Escape character is '^]'.
fatal: cannot handle daemon internally
Connection closed by foreign host.


What does "cannot handle daemon internally" signify to you all?
The part where telnet connects is saying the firewall is open at 9418, so that's good.

What do you think about debian's package of gitosis?  It is working to push,
and clone with this command:
git clone gitosis@mail.cibolo.us:gitosis-admin.git
but not these:

john@toolbench:~/EEProjects/test$ git clone git://mail.cibolo.us/gitosis-admin.git
Cloning into gitosis-admin...
fatal: protocol error: bad line length character: fata
john@toolbench:~/EEProjects/test$ git clone git://mail.cibolo.us/srv/gitosis/repositories/gitosis-admin.git
Cloning into gitosis-admin...
fatal: protocol error: bad line length character: fata

it creates a gitosis user.
Should I install gitosis from source and have a git user only?

What can I simplify to debug this?

gitweb skips this by not using port 9418, so I will be setting that up in the meantime.

thanks,

John

-- 
Ecosensory   Austin TX

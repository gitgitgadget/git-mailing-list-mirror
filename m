From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 20:12:54 -0400
Message-ID: <A595C063-7F6E-49AD-A797-1133C731E7E3@mac.com>
References: <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Wed Jun 29 02:07:07 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnQ5u-0005Pd-Np
	for gcvmd-mercurial@gmane.org; Wed, 29 Jun 2005 02:06:23 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5T0DJGX001004;
	Tue, 28 Jun 2005 19:13:22 -0500
Received: from smtpout.mac.com (smtpout.mac.com [17.250.248.84])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5T0DHw2000992
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 19:13:17 -0500
Received: from mac.com (smtpin08-en2 [10.13.10.153])
	by smtpout.mac.com (Xserve/8.12.11/smtpout08/MantshX 4.0) with ESMTP id
	j5T0D1T7014951; Tue, 28 Jun 2005 17:13:01 -0700 (PDT)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin08/MantshX 4.0) with ESMTP id j5T0CtH5018496
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 28 Jun 2005 17:12:58 -0700 (PDT)
In-Reply-To: <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.730)
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

On Jun 28, 2005, at 17:54:14, Horst von Brand wrote:
> Andrew Thompson <andrewkt@aktzero.com> wrote:
>> I believe this works because the files stored in a binary format that
>> appends new changesets onto the end. Thus, truncating the new stuff
>> from the end effectively removes the commit.
>
> And is exactly the wrong way around. Even RCS stored the _last_  
> version and
> differences to earlier ones (you'll normally want the last one (or
> something near), and so occasionally having to reconstruct earlier  
> ones by
> going back isn't a big deal; having to build up the current version by
> starting from /dev/null and applying each and every patch that ever  
> touched
> the file each time is expensive given enough history, besides that any
> error in the file is guaranteed to destroy the current version, not
> (hopefully) just making old versions unavailable).  It also means that
> losing old history (what you'll want to do once in a while, e.g.  
> forget
> everything before 2.8) is simple: Chop off at the right point.

If we have versions A through A+N, Mercurial will create a new revlog  
file and
store a new full version when the total size of the changes between A  
and A+N
is greater than a certain amount, effectively ensuring that  
retrieving the
latest version of a file is O(size-of-file) instead of O(size-of- 
file*revisions).
This is the same speed as RCS for the tip, and significantly faster  
than RCS
for non-tip, which is crucial for merges.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
   -- C.A.R. Hoare

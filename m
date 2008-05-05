From: Geert Bosch <bosch@adacore.com>
Subject: Re: Excruciatingly slow git-svn imports
Date: Mon, 5 May 2008 00:29:35 -0400
Message-ID: <2B9E6C04-69F1-42BD-AE60-AFCE401E093E@adacore.com>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com> <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com> <20080429071122.GG24171@muzzle>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 05 06:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JssLJ-0000DN-VM
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 06:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbYEEE3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 00:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbYEEE3i
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 00:29:38 -0400
Received: from rock.gnat.com ([205.232.38.15]:58892 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYEEE3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 00:29:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id B1FC22A98A5;
	Mon,  5 May 2008 00:29:36 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Jv0iQPZmXUiH; Mon,  5 May 2008 00:29:36 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 3DC4E2A9878;
	Mon,  5 May 2008 00:29:36 -0400 (EDT)
In-Reply-To: <20080429071122.GG24171@muzzle>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81229>


On Apr 29, 2008, at 03:11, Eric Wong wrote:

>> I've found that git-svn gets slower as it runs. Try interrupting the
>> clone and running "git svn fetch" -- it should pick up where it left
>> off and will be MUCH faster if my experience is any indication.  
>> When I
>> clone the big svn repository at work I usually restart it every 1000
>> revisions or so and it finishes in a fraction of the time it takes if
>> I let it do everything in a single run.
>
> That's really strange to hear...  The git-svn process itself does not
> store much state other than the current revision and the log  
> information
> for the next 100 or so revisions it needs to import.
>
> Are you packing the repository?  Which SVN protocol are you using?   
> Does
> memory usage of git-svn stay stable throughout the run?

I found the same. After about 5 days (with maybe 10 break/restarts), I  
had
a converted repository with all 135K commits and a total size of just
under 1 GB. The last 100K commits took (much?) less than a day, almost  
all the
time was spend in the earlier ones. These commits seemed all to have  
thousands
of files, even though most were probably the same. I'm sure this  
repositor,
which covers 15 years of development of a multi-million line project,  
has
a lot of tags and it seemed that it just had to chew through many copies
of the complete set of files to find out that they're all the same.

It's great git-svn can be restarted so well and doesn't get confused by
uncleanly terminated runs. My final repository is fast and small.
I'm still struggling with how to properly synchronize branches, but that
probably is mostly a matter of user education.

Thanks all for these great tools.

   -Geert

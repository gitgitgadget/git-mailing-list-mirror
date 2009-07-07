From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Checking for fast-forward
Date: Tue, 07 Jul 2009 10:21:40 +0200
Message-ID: <4A530594.20100@drmicha.warpmail.net>
References: <ca4f67be0907060936v7bf7c44y4395717fff854fd4@mail.gmail.com> <20090706232614.32602ccc@schatten>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lee Griffiths <poddster@gmail.com>, git@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 10:22:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO5wF-0003NK-Vu
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 10:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbZGGIV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 04:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbZGGIV4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 04:21:56 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48663 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753700AbZGGIVz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 04:21:55 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 65DC63AF38C;
	Tue,  7 Jul 2009 04:21:58 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 07 Jul 2009 04:21:58 -0400
X-Sasl-enc: Hmd3mzDlLUDLw6RckMrJ6cfZsl/dULYOskzmS9J/uKbU 1246954918
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A173939C7;
	Tue,  7 Jul 2009 04:21:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090706232614.32602ccc@schatten>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122829>

Florian Mickler venit, vidit, dixit 06.07.2009 23:26:
> this is more of a git question, than smth special to msysgit. 
> 
> (git ml cc'd)
> 
> On Mon, 6 Jul 2009 17:36:54 +0100
> Lee Griffiths <poddster@gmail.com> wrote:
> 
>>
>> I have a script that checks for fast-forwarding by doing a git push
>> --dry-run. This strikes me as the wrong way to do it as it does _all_
>> of the stuff a git push would normally do i.e., packing and so on, and
>> I'm only really after the fast-forward check. Seeing as I already do a
>> git push at the end of the script (actualy two, as I do a --tags one
>> as well[1]), it seems like a big waste of time. Is there anyother way
>> to check and see if the git push would work? (I want the script to
>> avoid doing a git pull if possible).

No. (I infer your question is how to find out whether a push is a
fast-forward.)

If you don't know the state of the branch head in the remote repo you
simply cannot know whether the push will be a fast-forward.

If you know that your corresponding remote branch (say
remotes/origin/foo) is up-to-date with the destination branch (say foo)
in the remote repo (e.g., because you know you've fetched before and
nobody else is allowed to push there) then you can compare your branch
to be pushed (say foo) with your remote branch:

If $(git rev-list bar..remotes/origin/foo) is empty then the branch foo
in the remote repo can be fast-forwarded to bar.

Chhers,
Michael

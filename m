From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC][PATCH] Re: git-rm isn't the inverse action of git-add
Date: Mon, 09 Jul 2007 11:45:32 +0200
Message-ID: <vpqsl7xkj0j.fsf@bauges.imag.fr>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<vpq7ipittl2.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707022205210.4071@racer.site>
	<vpqoditkc23.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707031308170.4071@racer.site>
	<vpqir91hagz.fsf@bauges.imag.fr>
	<20070704200806.GA3991@efreet.light.src>
	<vpqd4z7q820.fsf@bauges.imag.fr> <vpqfy3yajbj.fsf_-_@bauges.imag.fr>
	<Pine.LNX.4.64.0707081855300.4248@racer.site>
	<vpq1wfi8wjl.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707082240510.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 11:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7pp2-00079E-TZ
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 11:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbXGIJqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 05:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbXGIJqV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 05:46:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:35814 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbXGIJqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 05:46:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l699jXoY013235
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Jul 2007 11:45:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I7poD-0005NY-1S; Mon, 09 Jul 2007 11:45:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I7poC-0004mQ-VD; Mon, 09 Jul 2007 11:45:32 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,  Jan Hudec <bulb@ucw.cz>, Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>
In-Reply-To: <Pine.LNX.4.64.0707082240510.4248@racer.site> (Johannes Schindelin's message of "Sun\, 8 Jul 2007 22\:49\:10 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 09 Jul 2007 11:45:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51974>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 8 Jul 2007, Matthieu Moy wrote:
>
>> I'm not sure whether this is really wrong. The things git should
>> really care about are the index and the repository itself, and the
>> proposed behavior is consistant regarding that (either remove all
>> files from the index, or remove none).
>
> Well, I think it is wrong for the same reason as it is wrong to apply the 
> changes to _any_ file when one would fail.  And since "git apply" shares 
> my understanding, I think "git rm" should, too.

OK, let's say I'm convinced ;-).

>> > I suspect that this case does never fail. 0 means success for 
>> > remove_file().  Not good.  You should at least have a way to ensure that 
>> > it removed the files from the working tree from a script.  Otherwise there 
>> > is not much point in returning a value to begin with.
>> 
>> I've changed it to have exit_status = 1 if git-rm aborted before
>> starting, and 2 if git-rm skiped some file removals (and of course, 0
>> if everything is done as expected).
>
> Oh, so you do not take the return value of this function to determine if 
> it has or has not done something with the files?  That's a bit confusing.

I did, but previously, I kept the code that "die()"s if the first call
to remove_file() "fails". In remove_file_maybe(), not removing a file
because it's not sure it's safe to delete it is not a failure, so I
had to put a "return 0;" here to avoid the fatal error. My first patch
had return status !=0 if we tried to remove the file, and it failed. I
changed that.

> I meant to complain about your OP, but this time it is even worse.  The 
> best way to guarantee that a patch gets lost in a thread is to move it _at 
> the end_ of a reply.

I had posted the patch for info, but I did expect this one to get
lost, since it's definitely not complete.

I'll post an updated patch with a testcase and an appropriate subject
line within a few days (I don't have time right now).

Thanks,

-- 
Matthieu

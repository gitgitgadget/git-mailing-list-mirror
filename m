From: Andreas Ericsson <ae@op5.se>
Subject: Re: Newbie experience with push over ssh
Date: Thu, 15 Feb 2007 16:35:29 +0100
Message-ID: <45D47DC1.6020401@op5.se>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>	<20070214142731.GA1478@moooo.ath.cx>	<45D33485.5020906@webdrake.net> <17875.14305.910866.273778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Joseph Wakeling <joseph.wakeling@webdrake.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 16:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHie6-0007Yw-IP
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 16:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbXBOPfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 10:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbXBOPfi
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 10:35:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36681 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbXBOPfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 10:35:37 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id D2A836BCD8; Thu, 15 Feb 2007 16:35:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2B6036BCC4; Thu, 15 Feb 2007 16:35:30 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <17875.14305.910866.273778@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39833>

Bill Lear wrote:
> On Wednesday, February 14, 2007 at 16:10:45 (+0000) Joseph Wakeling writes:
>> Matthias Lederhofer wrote:
>>> I don't think there is any way to 'clone to remote'.  You'd have to
>>> ssh to the other machine and clone from there, or you can just create
>>> an empty repository on the remote host and push the stuff into it.
>> I remember coming across the same issue as Matthieu and never got round
>> to solving it.  In my case the desire is to upload the code onto a
>> remote machine---in particular a cluster where I run simulations.  I
>> don't particularly need that remote code to be in a repo or otherwise,
>> since it's only there to be run, not edited.
>>
>> As far as I know I have no way of installing git on that machine.
>> Perhaps I could install it locally but I suspect the sysadmin would not
>> be supportive.
>>
>> So, is there a way of using git to upload my code to a machine without a
>> repo ready-prepared?
> 
> If you must ...
> 
> % cat ~/.gitconfig
> [alias]
> 	scp !scp
> 	rcp !rcp
> % git scp -rp . me@remotehost:/directory
>

:-)

Perhaps a better solution would be to do

git archive --format=tar --prefix=project/ | bzip2 -f9 | \
	ssh user@remote -C "cat > project.tar.bz2"

Then unpack and build as usual on the remote end. Works a treat and is
currently the gist of the only line in my "push-to-web" script (the rest
of it just extends the command to run to also unpack the tarball).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

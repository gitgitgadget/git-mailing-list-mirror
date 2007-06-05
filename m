From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: always export GIT_DIR if it is set
Date: Tue, 05 Jun 2007 13:39:57 -0700
Message-ID: <7v7iqib0f6.fsf@assigned-by-dhcp.cox.net>
References: <20070603144401.GA9518@moooo.ath.cx>
	<20070603144714.GD20061@moooo.ath.cx>
	<7vodjudei2.fsf@assigned-by-dhcp.cox.net>
	<20070605164957.GA12358@moooo.ath.cx>
	<Pine.LNX.4.64.0706051823140.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 22:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvfp3-0002VR-2M
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 22:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765380AbXFEUkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 16:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765479AbXFEUkA
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 16:40:00 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57113 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765380AbXFEUj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 16:39:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070605203958.TSHC14072.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 5 Jun 2007 16:39:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7wfy1X0011kojtg0000000; Tue, 05 Jun 2007 16:39:58 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49226>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 5 Jun 2007, Matthias Lederhofer wrote:
>
>> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> index 0c8a7df..f4cfbea 100644
>> --- a/git-filter-branch.sh
>> +++ b/git-filter-branch.sh
>> @@ -313,9 +313,12 @@ workdir="$(pwd)"
>>  
>>  case "$GIT_DIR" in
>>  /*)
>> +	export GIT_DIR
>> +	export GIT_WORK_TREE=.
>>  	;;
>
> Doesn't it strike somebody else as intrusive, if GIT_WORK_TREE has to 
> touch that many places?
>
> IMHO there should be a less intrusive, and possibly simpler, way to do it. 
> I am not at all interested in that feature, and I don't want to suffer 
> bugs from it either.

I suspect "bug" might be a bit too strong a word here, but this
definitely shows that work-tree series has a change of behaviour
that is subtle on the suface but with a huge impact.

It _might_ a bug for filter-branch to export GIT_DIR; sh-setup
deliberately chooses _not_ to export it.  I haven't really
thought through the issues, though...

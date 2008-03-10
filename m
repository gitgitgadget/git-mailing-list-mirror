From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remotes order in "git remote update"
Date: Sun, 09 Mar 2008 22:50:38 -0700
Message-ID: <7vbq5nm8k1.fsf@gitster.siamese.dyndns.org>
References: <2008-03-09-11-22-34+trackit+sam@rfc1149.net>
 <7vbq5op4gt.fsf@gitster.siamese.dyndns.org>
 <2008-03-09-12-21-35+trackit+sam@rfc1149.net>
 <alpine.LSU.1.00.0803092148480.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 06:51:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYav6-0006Ov-VB
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 06:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbYCJFuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 01:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYCJFuy
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 01:50:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbYCJFux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 01:50:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 328AF24F5;
	Mon, 10 Mar 2008 01:50:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6CDF124EC; Mon, 10 Mar 2008 01:50:46 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803092148480.3975@racer.site> (Johannes
 Schindelin's message of "Sun, 9 Mar 2008 21:50:04 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76696>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 9 Mar 2008, Samuel Tardieu wrote:
>
>> On  9/03, Junio C Hamano wrote:
>> 
>> | Samuel Tardieu <sam@rfc1149.net> writes:
>> | 
>> | > It looks like remote repositories are ordered alphabetically by their
>> | > local names when doing a "git remote update".
>> |
>> | I think the reimplementaiton in 'next' that will hopefully be in 1.5.5
>> | will keep the list of remotes in the order read from the config.
>> 
>> Indeed it does, thanks.
>
> Well, technically this is a regression.
>
> If you really want to order your remotes, why not add something like
>
> [remotes]
> 	default = my-first-remote my-second-remote [...]
>
> to the config?  That is what the (recently fixed in builtin-remote) remote 
> groups are for...

We never guaranteed there is any order the remotes are processed.  One
order is as good as another, and the only way that can give some guarantee
is with the remote groups.  So there is no regression and the suggestion
to use remote group is one good way.

We _might_ want to start guaranteeing some orders by documenting, but I do
not think it is necessary.  Does "git config" and "git remote" code even
guarantee the order the newly added ones are stored in the $GIT_DIR/config
file, and is it by design and specified in the documentation, or it is by
accident and happens to be the way the code is written?

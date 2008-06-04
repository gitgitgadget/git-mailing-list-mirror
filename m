From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Wed, 04 Jun 2008 11:02:47 -0700
Message-ID: <7v63spxem0.fsf@gitster.siamese.dyndns.org>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com>
 <20080604154523.GA25747@kroah.com>
 <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
 <m363spyta3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3xKw-0005Sf-QS
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbYFDSC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 14:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbYFDSC6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:02:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbYFDSC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 14:02:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4526E5E3E;
	Wed,  4 Jun 2008 14:02:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 60C175E3A; Wed,  4 Jun 2008 14:02:50 -0400 (EDT)
In-Reply-To: <m363spyta3.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 04 Jun 2008 11:00:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75A0C940-3260-11DD-B8C9-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83802>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Greg KH <greg@kroah.com> writes:
>> 
>>>> Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>>>> error: Unable to find fdcce40226d7d4273a08cc4ef84bb25755a710a4 under http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git
>>> ...
>>> It looks like git over http isn't following the link somehow to the main
>>> repo?
>> 
>> Yeah, see above.  www.kernel.org does not like to serve /home/ftp/pub/scm
>> path; it wants to serve it as /pub/scm/linux instead.
>> 
>> Your objects/info/alternates in 2.6.24.y points at /pub/scm/linux/kernel/git/torvalds/...
>> but in 2.6.25.y it has extra /home/ftp in front of it.
>> 
>> A quick fix is obviously to remove the extra prefix but it makes me wonder
>> how these two "stable" repositories were prepared differently.  Could this
>> be a regression in "git clone"?  Or perhaps you "clone -s"'s Linus's
>> repository slightly differently between them?
>
> Errr... isn't it the case for objects/info/http-alternates ?

You do not have to use that http specific hack.  On these machines, /pub
actually points at /home/ftp/pub with a symlink.

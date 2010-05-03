From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rev-parse vs. rev-list --no-walk
Date: Mon, 03 May 2010 17:50:19 +0200
Message-ID: <4BDEF0BB.6080009@drmicha.warpmail.net>
References: <4BDC7471.9030107@drmicha.warpmail.net>	 <7v1vdv4ccz.fsf@alter.siamese.dyndns.org> <t2z76718491005030822l469c720ag1466ecd2bad31f32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 17:50:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8xuw-0004AW-6R
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 17:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758781Ab0ECPuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 11:50:40 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58806 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752224Ab0ECPuj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 11:50:39 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 480A3F2817;
	Mon,  3 May 2010 11:50:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 03 May 2010 11:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gC9kDkeqjmWLo3zxX1+cvRX/uUM=; b=t/+63QcinhKawSCdzxchCSZe6U/CT+qx0ueAg0qk3hh7F2pe9d5MBkhcRzH99vtTwUfO+MkURXn6uByty2zosAh2fzmaF9aGCKVH1GOnwqpY67y68Nl0f23P8OQlfRN2BPh/0wBsN9RNSwP4mzzRhOpTfQlRpkRteuoe78trYHk=
X-Sasl-enc: 1+Uc3GUAs0ekQfhd6FH/e4SUXYy6OK4HDFUS94wpVLcF 1272901821
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EA6734A2F5B;
	Mon,  3 May 2010 11:50:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <t2z76718491005030822l469c720ag1466ecd2bad31f32@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146239>

Jay Soffian venit, vidit, dixit 03.05.2010 17:22:
> On Sat, May 1, 2010 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think one sane thing to do is to stop adding new rev-flags revision.c
>> supports to rev-parse (it already lags behind and nobody complained that
>> rev-parse doesn't understand --first-parent as a rev-flag), and keep its
>> use as "revision and non revision option sifter" only to support older
>> scripts written back in v1.0.0 days.  Its primary use these days is "turn
>> symbolic object names into 40-letter SHA-1", but "option sifter" aspect of
>> the command seems to have outlived its usefulness.
> 
> We tell scripters to be careful to use the plumbing and not the
> porcelain. From that standpoint, shouldn't we do our best to prevent
> the plumbing from falling into disrepair?

According to git(1), git rev-list is low-level, but git rev-parse is not!

>From a cursory look at current source it would be simple to discourage
use of rev-parse for revision flags (and, probably, as an option
sifter). There's no need to remove them (and break some outside
scripts). Junio suggested not to add any new ones to rev-parse. That
would make my RFD patch (--heads, --locals) smaller, and answers the
questions about solving the difference between rev-parse and rev-list
"-all" regarding HEAD. But maybe git-rev-parse(1) should change then, in
order not to encourage its use as option sifter. Everyone stops by this
man page when looking up revision syntax.

Michael

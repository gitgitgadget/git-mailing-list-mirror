From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Fix resource leaks in wrapper.c
Date: Tue, 27 Oct 2009 09:26:48 +0100
Message-ID: <4AE6AEC8.4040800@drmicha.warpmail.net>
References: <1256615635-4940-1-git-send-email-djszapi@archlinux.us> <4AE69DA7.6030704@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Laszlo Papp <djszapi2@gmail.com>, git@vger.kernel.org,
	Laszlo Papp <djszapi@archlinux.us>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 09:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2hOl-00087N-2N
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 09:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbZJ0I0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 04:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756600AbZJ0I0v
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 04:26:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43697 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756599AbZJ0I0t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 04:26:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 72B61BB213;
	Tue, 27 Oct 2009 04:26:52 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 27 Oct 2009 04:26:52 -0400
X-Sasl-enc: 0d3GjB2zZA8ZjP0j9Ce3ltkU6TgN/O+UeRBVC/DUollN 1256632011
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0D71928AC2E;
	Tue, 27 Oct 2009 04:26:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091027 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <4AE69DA7.6030704@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131315>

Johannes Sixt venit, vidit, dixit 27.10.2009 08:13:
> Laszlo Papp schrieb:
>> @@ -266,7 +266,7 @@ int odb_mkstemp(char *template, size_t limit, const char *pattern)
>>  	fd = mkstemp(template);
>>  	if (0 <= fd)
>>  		return fd;
>> -
>> +	close(fd);
> 
> Sorry, where is here a resource leak? You are "closing" something that was
> never opened because fd is less than zero.
> 
> Ditto for the other case.

I guess it's about silencing some challenged code analysis tool. I
recall that last time we had something like this we decided that coders
are smarter than tools... and also that clean up like this (for real
leaks) would be something for libgit.

Michael

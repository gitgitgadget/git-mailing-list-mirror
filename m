From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Running git-archive recursively over submodules
Date: Tue, 16 Feb 2010 11:49:48 +0100
Message-ID: <4B7A784C.1070405@drmicha.warpmail.net>
References: <201002152156.17132.trast@student.ethz.ch> <4B7A4B60.3090401@drmicha.warpmail.net> <201002161101.42493.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 16 11:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhL2P-0002oc-21
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0BPKwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:52:11 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42796 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556Ab0BPKwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 05:52:09 -0500
Received: from compute2.internal (compute2 [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1FAA8E13FB;
	Tue, 16 Feb 2010 05:52:06 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 16 Feb 2010 05:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vKQ16BzsTQVqrfOqYZ9fB3Aejvw=; b=gd5HELsN5SIaAofVc19R344mZS/rVWPrE5A0H/M4rcn0fwDPa33RNuYSAWIMSPuoaXXJXZPZicOidWPSGKGAqedRxIeV51OLSKV+IAEsrJucF1muzPy0XZ6ODY7v6nhdOKWvnsTK/bK6GSipU06ArUE8NayIL1dCbuGwqJ7hNBw=
X-Sasl-enc: oO5x4Eff3bcjIheeZHpjxApo0/E6RQseM3u+vPPgYflT 1266317525
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F2AC4ABB55;
	Tue, 16 Feb 2010 05:52:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100201 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <201002161101.42493.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140094>

Thomas Rast venit, vidit, dixit 16.02.2010 11:01:
> On Tuesday 16 February 2010 08:38:08 Michael J Gruber wrote:
>> Thomas Rast venit, vidit, dixit 15.02.2010 21:56:
>>> while git ls-files -s | grep -q ^160000; do
>>>     read_one_level
>>> done
>>
>> Am I blind, not seeing a recursion, or is there simply none? I reckon
>> you're reading the super project and one level of submodules into the
>> temporary index - which is fine for most purposes, of course. I would
>> say this is iterating over the submodules of the super project.
> 
> Well, the while condition reads "while there are submodule entries in
> my index".  The read_one_level function then replaces those submodules
> with their corresponding trees, which of course may again contain
> submodule entries.
> 

Gotcha, and the rm --cached in foreach makes sure that submodule entries
disappear from the index once their contents have been read into it, so
that the recursion stops when there's no deeper level. Clever.

Thanks for helping my for/while blindness (I guess I was thinking "for").

Cheers,
Michael

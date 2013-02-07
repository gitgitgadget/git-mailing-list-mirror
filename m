From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Thu, 07 Feb 2013 10:34:26 +0100
Message-ID: <51137522.3010005@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net> <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net> <20130206220644.GB27507@sigill.intra.peff.net> <51136E56.7060703@drmicha.warpmail.net> <20130207091116.GB15727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:34:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3NsZ-0001QA-R1
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab3BGJe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:34:28 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50150 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756327Ab3BGJe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 04:34:26 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9D2C2213B4;
	Thu,  7 Feb 2013 04:34:25 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 07 Feb 2013 04:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=2h7PZy0vrzd41hjDWUawxX
	zgfRM=; b=G2Cwm2peTz8j/J1aPYhimEIAMgJ5ZsqieVY7n8mMCD206eXVZa3Mns
	CyUJJmV1DFKGP5bXlSqF7eBEe6EKj8ThbcqzZ20iIf1nFHu7Wz+IFkTxaEGbpVWs
	BA26J0Bt5kWD7ngpNFJMFapwFJuXP8qwT3vt7jIbv2eiqEMXcXQd8=
X-Sasl-enc: h9OnVJnZjR+VeKRRmsz9OpLEscPnEE9UgNy3E5hWU0UI 1360229665
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 021554825F1;
	Thu,  7 Feb 2013 04:34:24 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130207091116.GB15727@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215684>

Jeff King venit, vidit, dixit 07.02.2013 10:11:
> On Thu, Feb 07, 2013 at 10:05:26AM +0100, Michael J Gruber wrote:
> 
>>> Would it be better if object_array_entry replaced its "mode" member with
>>> an object_context?
>>
>> Do all callers/users want to deal with object_context?
> 
> Wouldn't it just mean replacing "entry->mode" with "entry->oc.mode" at
> each user?

Yes, I meant at the time of creation, i.e. when someone has to create
and pass an o_a_e and maybe only knows a mode, and thus would have to
set the path to NULL or "".

>> I'm wondering why o_c has a mode at all, since it is mostly used in
>> conjunction with an object, isn't it?
> 
> Just as we record the path from the surrounding tree, we record the
> mode. It's that mode which gets put into the pending object list by the
> revision parser (see the very end of handle_revision_arg). Storing an
> object_context instead of the mode would be a strict superset of what we
> store now (right now we just throw the rest away).

Sure. But why does object_context have a mode member at all? Maybe it is
not alway used together with another struct which has the mode already,
then that's a reason.

Michael

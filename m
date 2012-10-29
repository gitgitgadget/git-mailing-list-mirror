From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] replace: parse revision argument for -d
Date: Mon, 29 Oct 2012 10:02:47 +0100
Message-ID: <508E4637.2060903@drmicha.warpmail.net>
References: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net> <20121029065836.GC5102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 10:03:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSlFP-0000MM-8R
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 10:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270Ab2J2JCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 05:02:51 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46594 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751938Ab2J2JCu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 05:02:50 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 486D1203A0;
	Mon, 29 Oct 2012 05:02:49 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 29 Oct 2012 05:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=56+R9dbB9BHPqXrlpEEiBz
	7IUe0=; b=Y6xA2zCs1c5IChZ2wxE2QrZJwa+dFBBhR+mJdKz2ChU8Oec7QlLaAa
	um3Z8mt55iLqzXw1OeTdtYI7EOwHNDzLCrtVUK3OAewLBZRlfEBkPLbf6UqQa7WG
	JKvY1rEQVOC8IVYBzYU+/umRAQjNpGc6cD/ljWDraTwPiwPzylSiw=
X-Sasl-enc: MHfUhjdPLnaF75PxY5mhDOfLdr4O/kM9rlSwQby8JgCg 1351501368
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B82F348266E;
	Mon, 29 Oct 2012 05:02:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <20121029065836.GC5102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208605>

Jeff King venit, vidit, dixit 29.10.2012 07:58:
> On Fri, Oct 26, 2012 at 03:33:27PM +0200, Michael J Gruber wrote:
> 
>>  	for (p = argv; *p; p++) {
>> -		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
>> +		q = *p;
>> +		if (get_sha1(q, sha1))
>> +			warning("Failed to resolve '%s' as a valid ref; taking it literally.", q);
>> +		else
>> +			q = sha1_to_hex(sha1);
> 
> Doesn't get_sha1 already handle this for 40-byte sha1s (and for anything
> else, it would not work anyway)?

What is "this"???

So far, "git replace -d <rev>" only accepts a full sha1, because it uses
it literally as a ref name "resf/replace/<rev>" without resolving anything.

The patch makes it so that <rev> gets resolved to a sha1 even if it is
abbreviated, and then it gets used.

Or do you mean the warning?

Michael

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case"
 but not with other regexp-related options?
Date: Wed, 22 Apr 2015 11:08:27 +0200
Message-ID: <5537650B.5050505@drmicha.warpmail.net>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>	<55311831.6010004@drmicha.warpmail.net>	<CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>	<5534BD87.8020709@drmicha.warpmail.net>	<xmqqbniin1cw.fsf@gitster.dls.corp.google.com>	<CA+55aFzdSgvYo11PHamkOVASz61RUq26+s0na0Zh2RRwsEkrMg@mail.gmail.com>	<xmqqtwwaljwb.fsf@gitster.dls.corp.google.com>	<55360D3D.3010201@drmicha.warpmail.net> <xmqqr3rdific.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 11:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykqe4-0007st-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 11:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbbDVJIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 05:08:32 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36775 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755813AbbDVJI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 05:08:29 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id E2BF92088A
	for <git@vger.kernel.org>; Wed, 22 Apr 2015 05:08:28 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 22 Apr 2015 05:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Hexj9kdu7IgVcShJb3IVLL3ASCA=; b=n4o6Oe
	aBlCqgUL8ZQbr3jnYTIr11BjdPTBAVLGjyyb8S3wiMjRLgiQ1nLUWYbk9LmfCpmE
	UzzH8bRMxyj75d1d35w55AySsix4F7pq7Ejv7CGnWrebaN0uV8KwYjN/f/kgP/D8
	2ReGalWpKu2ER6Y4jX9o5AFGM8YaooAZCzKZ0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Hexj9kdu7IgVcSh
	Jb3IVLL3ASCA=; b=tRaEpAU9a09TQxDHqzvIEfsHfKDMVdw8iKWtAwEf0+BFH7s
	Sxwhw/zRkMoZUTWyzxLERqMJJ9/cnCqYd+P1rFNfLUF6QRUW/i1qYPDHZ3lFuTHr
	0OoB46VRa2qXD10u6FFJ+B6Qq3qC4Na0vZ99EZ8vVGui1lu5/0MCw9nTDBVE=
X-Sasl-enc: PKzKBT9UrRa7QjK/OrPr9iSO7/UuFfobzl95brdaSXL6 1429693708
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 25D8EC00015;
	Wed, 22 Apr 2015 05:08:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqr3rdific.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267582>

Junio C Hamano venit, vidit, dixit 21.04.2015 18:59:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> We have engine-switching options and engine-modification options. The
>> latter are certainly good in the expression itself. Maybe even the
>> former, though I don't know how to switch away from fixed-strings in
>> that way...
> 
> I do not think mixing matching engines in a single request makes
> much sense. As the internal machinery is not even prepared to do
> that, even though it is prepared to apply engine-modifications ones
> to each grep term AFAIK, let's not go there.
> 

>From a user perspective, we mix engines already: fixed strings for -S,
regexp for the rest (by default). The user can switch one, but not the
other. And there are options that modify both engines at the same time.
That is the kind of confusion that (triggered OP's request and that) I
would like to resolve.

Michael

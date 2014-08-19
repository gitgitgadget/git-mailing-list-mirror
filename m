From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Tue, 19 Aug 2014 13:14:11 +0200
Message-ID: <53F33183.80802@raz.or.at>
References: <53EA8C3E.1080500@raz.or.at> <20140813015917.GA30756@google.com> <20140817083022.GJ23808@peff.net> <53F0A66A.9000909@raz.or.at> <20140817184252.GB2200@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	434599@bugs.debian.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 13:14:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJhNK-0004jg-4w
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 13:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbaHSLOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 07:14:20 -0400
Received: from mhub.domainplanet.at ([92.43.99.119]:39803 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaHSLOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 07:14:17 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id E3DEA9D338B;
	Tue, 19 Aug 2014 13:14:12 +0200 (CEST)
Received: from [10.0.0.88] (62-46-147-229.adsl.highway.telekom.at [62.46.147.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 9AE2EBFC1F;
	Tue, 19 Aug 2014 13:14:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140817184252.GB2200@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255454>

Am 2014-08-17 um 20:42 schrieb Jeff King:
> [...]
> 
>>> I'm not sure I understand this comment. Even if SSL is not in use,
>>> wouldn't we be passing a regular pipe to curl, which would break?
>>
>> Yeah, we can't do that, and thus would have to keep the handwritten IMAP
>> implementation just for the tunnel case (allowing to drop only the
>> OpenSSL specific stuff), see my other email:
>> http://www.mail-archive.com/git@vger.kernel.org/msg56791.html (the
>> relevant part is pretty far down at the bottom).
> 
> I'd really love it if we could make this work with tunnels and
> eventually get rid of the hand-written imap code entirely. I agree with
> Jonathan that we probably need to keep it around a bit for people on
> older curl, but dropping it is a good goal in the long run. That code
> was forked from the isync project, but mangled enough that we could not
> take bug fixes from upstream. As not many people use imap-send, I
> suspect it is largely unmaintained and the source of many lurking
> bugs[1]. Replacing it with curl's maintained implementation is probably
> a good step.

I'll work on this as soon as I find some time, but as that will include
changes to run-command.c (and possibly other files?), I'd like to cover
that in a commit of its own. Do you guys think the current patch [1] is
good enough for "official" submission already? If so, do I need some
sort of official review? Documentation/SubmittingPatches says I'm only
supposed to direct it to Junio after the list "reaches consensus", so
I'm wondering how to get there... :-)

Bernhard

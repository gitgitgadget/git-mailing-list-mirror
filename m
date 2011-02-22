From: Timur Tabi <timur@freescale.com>
Subject: Re: How do I make git-format-patch reject 8-bit encodings?
Date: Tue, 22 Feb 2011 08:49:03 -0600
Organization: Freescale
Message-ID: <4D63CCDF.50803@freescale.com>
References: <4D62E315.7040506@freescale.com> <7vbp24hqez.fsf@alter.siamese.dyndns.org> <4D6302E6.1070602@freescale.com> <20110222073330.GA8626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 15:49:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrtYA-0007U4-W3
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 15:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab1BVOtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 09:49:08 -0500
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:57431 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1BVOtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 09:49:07 -0500
Received: from mail87-tx2-R.bigfish.com (10.9.14.246) by
 TX2EHSOBE001.bigfish.com (10.9.40.21) with Microsoft SMTP Server id
 14.1.225.8; Tue, 22 Feb 2011 14:49:06 +0000
Received: from mail87-tx2 (localhost.localdomain [127.0.0.1])	by
 mail87-tx2-R.bigfish.com (Postfix) with ESMTP id 4616C6B8188;	Tue, 22 Feb
 2011 14:49:06 +0000 (UTC)
X-SpamScore: -6
X-BigFish: VS-6(zz98dNzz1202hzzz2dh2a8h637h668h61h)
X-Spam-TCS-SCL: 0:0
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:de01egw01.freescale.net;RD:de01egw01.freescale.net;EFVD:NLI
Received: from mail87-tx2 (localhost.localdomain [127.0.0.1]) by mail87-tx2
 (MessageSwitch) id 129838614689450_26931; Tue, 22 Feb 2011 14:49:06 +0000
 (UTC)
Received: from TX2EHSMHS009.bigfish.com (unknown [10.9.14.252])	by
 mail87-tx2.bigfish.com (Postfix) with ESMTP id 1320F13E0051;	Tue, 22 Feb 2011
 14:49:06 +0000 (UTC)
Received: from de01egw01.freescale.net (192.88.165.102) by
 TX2EHSMHS009.bigfish.com (10.9.99.109) with Microsoft SMTP Server (TLS) id
 14.1.225.8; Tue, 22 Feb 2011 14:49:05 +0000
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1MEn4mD003769;	Tue, 22 Feb 2011 07:49:04 -0700 (MST)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
 az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id p1MEn3gV029020;	Tue, 22
 Feb 2011 08:49:03 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101213 Fedora/2.0.11-1.fc13 SeaMonkey/2.0.11
In-Reply-To: <20110222073330.GA8626@sigill.intra.peff.net>
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167548>

Jeff King wrote:
> Can you provide an example of a message that is base64-encoded? I didn't
> think we base64-encoded anything in send-email (we do rfc2047-encode
> 8-bit header lines, but using quoted-printable). And looking through it,
> I don't see any code to do so.

I can forward to you the original email that is base64-encoded, but I cannot
reproduce the problem.  Even when I take that patch, apply it with git-am and
recreate it with git-format-patch, when I sent that recreate patch with
git-send-email, it is not base64 encoded.

> It's possible that I'm missing the code. Or that one of the underlying
> modules is doing it for us. Or it's possible that one of the SMTP
> servers in your route is doing it.

It is possible that our mail server is doing it.  We recently migrated to the
"Microsoft cloud" email service, and we've experienced all sorts of odd problems
with mailing patches.

> If you can send an example of original format-patch output that you fed
> to git-send-email, and the resulting mail that was delivered, then we
> can know more.

I don't know if I can still get the original patch that was encoded.

> I have a suspicion it is the last one (some MTA doing it), because git
> tends to generate messages with an 8bit transfer encoding. If we hit a
> server that doesn't advertise support for 8BIT SMTP extensions, I
> believe the sending MTA is required to encode (or bounce). That would
> also account for the inconsistency you noted. It depends on the
> recipient and the exact route of SMTP servers in the delivery.

Ah, this might be a clue.  I will do more research and get back to you.

-- 
Timur Tabi
Linux kernel developer at Freescale

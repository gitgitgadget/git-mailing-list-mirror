From: Enrique Tobis <Enrique.Tobis@twosigma.com>
Subject: RE: Commit 5841520b makes it impossible to connect to github from
 behind my company's firewall.
Date: Tue, 20 Oct 2015 17:06:37 +0000
Message-ID: <33632f538b4a406fb8f0e1eb2b016c43@EXMBNJE8.ad.twosigma.com>
References: <loom.20151020T131513-529@post.gmane.org>
	<vpq37x54vav.fsf@grenoble-inp.fr>
	<cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com>
 <xmqqr3kp8qqe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: 'Matthieu Moy' <Matthieu.Moy@grenoble-inp.fr>,
	Johan Laenen <johan.laenen+cygwin@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: 'Junio C Hamano' <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 19:12:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoaSE-0000md-7i
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 19:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbbJTRMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 13:12:01 -0400
Received: from mxl2.nje.dmz.twosigma.com ([208.77.214.146]:47152 "EHLO
	mxl2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbbJTRMA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2015 13:12:00 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2015 13:12:00 EDT
Received: by mxl2.nje.dmz.twosigma.com (Postfix, from userid 111)
	id 6247B600CB; Tue, 20 Oct 2015 17:06:39 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	mxl2.nje.dmz.twosigma.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40=-0.001 autolearn=no
	version=3.3.2
Received: from EXHTNJE1.ad.twosigma.com (exhtnje1.ad.twosigma.com [172.20.32.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mxl2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 62837600B1;
	Tue, 20 Oct 2015 17:06:38 +0000 (GMT)
Received: from EXMBNJE8.ad.twosigma.com (172.20.45.145) by
 EXHTNJE1.ad.twosigma.com (172.20.32.77) with Microsoft SMTP Server (TLS) id
 14.3.224.2; Tue, 20 Oct 2015 13:06:38 -0400
Received: from EXMBNJE8.ad.twosigma.com (172.20.45.145) by
 EXMBNJE8.ad.twosigma.com (172.20.45.145) with Microsoft SMTP Server (TLS) id
 15.0.1130.7; Tue, 20 Oct 2015 17:06:38 +0000
Received: from EXMBNJE8.ad.twosigma.com ([fe80::1882:851f:2745:9d60]) by
 EXMBNJE8.ad.twosigma.com ([fe80::1882:851f:2745:9d60%17]) with mapi id
 15.00.1130.005; Tue, 20 Oct 2015 17:06:38 +0000
Thread-Topic: Commit 5841520b makes it impossible to connect to github from
 behind my company's firewall.
Thread-Index: AQHRC1H1CwRD6HgpEESy5ILy46H0Yp50l+og
In-Reply-To: <xmqqr3kp8qqe.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279926>



From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C Hamano

> Enrique Tobis <Enrique.Tobis@twosigma.com> writes:

>> Hey!
>>
>> I'm really sorry to hear that.
>>
>> That change should enable more forms of authentication with your 
>> proxy, but it does cause libcurl to choose the one it finds most 
>> secure, according to the docs
>> (http://curl.haxx.se/libcurl/c/CURLOPT_HTTPAUTH.html) What kinds of 
>> authentication does your proxy use?

> Good line of thought.  The answer would reveal what non-working authentication form the proxy claims to support is chosen because libcurl considers  more secure than the one the user wants to use.
> I'd imagine that the next step after that would be to make the list of authentication forms configurable so that the user can say "hey my proxy claims to support this one but it does not work" to skip it?

> That sounds like a similar approach as what we did for SSL ciphers in f6f2a9e4 (http: add support for specifying an SSL cipher list,
2015-05-08) where some people had problems with certain cipher the server/client claimed to support when it was in fact broken.

> Thanks.

@Junio: I agree. From the post in the cygwin mailing list that Johan mentioned, the problem seems to be that the proxy supports NEGOTIATE, NTLM and Basic, and libcurl is choosing NEGOTIATE. That choice fails for that user.

There is something I don't understand, though. Johan must be configuring his proxy either a) through git config files; or b) through environment variables. Johan says his proxy uses NTLM authentication. If he is doing a), then my change should not have had any impact. We were already setting CURLOPT_PROXYAUTH to CURLAUTH_ANY in that case. If it's b), then his proxy couldn't have been using NTLM authentication. In the old code path, only _BASIC was available as an authentication mechanism. That default is what prompted me to make the change in the first place.

@Johan: how are you configuring your proxy? Git configuration or environment variables? Also, could you run GIT_CURL_VERBOSE=1 git pull and send the output. That should show the failing authentication method.

Thanks.

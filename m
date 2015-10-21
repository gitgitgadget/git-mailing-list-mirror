From: Enrique Tobis <Enrique.Tobis@twosigma.com>
Subject: RE: Commit 5841520b makes it impossible to connect to github from
 behind my company's firewall.
Date: Wed, 21 Oct 2015 18:45:43 +0000
Message-ID: <d3ad25596c1f40dd8adc41174028d05b@EXMBNJE8.ad.twosigma.com>
References: <loom.20151020T131513-529@post.gmane.org>
	<vpq37x54vav.fsf@grenoble-inp.fr>
	<cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com>
	<xmqqr3kp8qqe.fsf@gitster.mtv.corp.google.com>
	<33632f538b4a406fb8f0e1eb2b016c43@EXMBNJE8.ad.twosigma.com>
	<loom.20151021T091641-32@post.gmane.org>
 <xmqqh9lk5b42.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: 'Junio C Hamano' <gitster@pobox.com>,
	Johan Laenen <johan.laenen+cygwin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 20:46:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoyOj-0002SB-1e
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 20:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbbJUSps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 14:45:48 -0400
Received: from mxl1.aoa.dmz.twosigma.com ([208.77.215.145]:43408 "EHLO
	mxl1.aoa.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbbJUSpq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 14:45:46 -0400
Received: by mxl1.aoa.dmz.twosigma.com (Postfix, from userid 111)
	id 47B9B600B9; Wed, 21 Oct 2015 18:45:45 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	mxl1.aoa.dmz.twosigma.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50=0.8 autolearn=no
	version=3.3.2
Received: from EXHTNJE1.ad.twosigma.com (exhtnje1.ad.twosigma.com [172.20.32.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mxl1.aoa.dmz.twosigma.com (Postfix) with ESMTPS id 42CAC600B4;
	Wed, 21 Oct 2015 18:45:44 +0000 (GMT)
Received: from EXMBNJE8.ad.twosigma.com (172.20.45.145) by
 EXHTNJE1.ad.twosigma.com (172.20.32.77) with Microsoft SMTP Server (TLS) id
 14.3.224.2; Wed, 21 Oct 2015 14:45:44 -0400
Received: from EXMBNJE8.ad.twosigma.com (172.20.45.145) by
 EXMBNJE8.ad.twosigma.com (172.20.45.145) with Microsoft SMTP Server (TLS) id
 15.0.1130.7; Wed, 21 Oct 2015 18:45:43 +0000
Received: from EXMBNJE8.ad.twosigma.com ([fe80::1882:851f:2745:9d60]) by
 EXMBNJE8.ad.twosigma.com ([fe80::1882:851f:2745:9d60%17]) with mapi id
 15.00.1130.005; Wed, 21 Oct 2015 18:45:43 +0000
Thread-Topic: Commit 5841520b makes it impossible to connect to github from
 behind my company's firewall.
Thread-Index: AQHRDC5kCwRD6HgpEESy5ILy46H0Yp52RzDA
In-Reply-To: <xmqqh9lk5b42.fsf@gitster.mtv.corp.google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279998>

From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C Hamano

[administrivia: please do not cull people out of the Cc: list]

Johan Laenen <johan.laenen+cygwin@gmail.com> writes:

> Enrique Tobis <Enrique.Tobis <at> twosigma.com> writes:
>
>> There is something I don't understand, though. Johan must be 
>> configuring his proxy either a) through git config files; or b) 
>> through environment variables. Johan says his proxy uses NTLM 
>> authentication. If he is doing a), then my change should not have had 
>> any impact. We were already setting CURLOPT_PROXYAUTH to CURLAUTH_ANY 
>> in that case. If it's b), then his proxy couldn't have been using 
>> NTLM authentication. In the old code path, only _BASIC was available 
>> as an authentication mechanism.  That default is what prompted me to 
>> make the change in the first place.
>
> Interesting!
>
> I tried both git versions, the one with the revert of commit 5841520b 
> and the one without and both gave me the fatal error "Unknown SSL 
> protocol error in connection to github.com:443" when using the 
> ~/.gitconfig [https] and [http] proxy settings instead of using the https_proxy environment variable.

> OK, so the conclusion I draw here is that your NTLM setting is not working at all, you have been using Basic auth happily before that commit, and you have to either (1) get NTLM auth working, or (2) find a way to tell Git that your proxy appears to support NTLM but it is unusable and you need to use Basic.

> Even though you may be capable to do (1), other people in the same situation might not be, in which case we would also need a way to do (2).

> Am I reading the above correctly?

I draw almost the same conclusions. I agree that he seems to have been using Basic all along. Based on the verbose output Johan posted, I think libcurl is trying to do NEGOTIATE instead of NTLM, so that's what Johan would have to get working. I also agree that other people may need to do (2).

From: Wincent Colaiuta <win@wincent.com>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Tue, 5 Jan 2010 13:34:32 +0100
Message-ID: <AAABEE5B-0419-4344-86E2-7EB550CCFC01@wincent.com>
References: <36FEB8A0-968D-4B43-AEFB-9B0E227A1F88@wincent.com> <20100105041438.GB12574@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 13:49:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS8qL-0007E9-4M
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 13:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0AEMs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 07:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551Ab0AEMs4
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 07:48:56 -0500
Received: from outmail128144.authsmtp.com ([62.13.128.144]:50028 "EHLO
	outmail128144.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753374Ab0AEMsz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 07:48:55 -0500
X-Greylist: delayed 848 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2010 07:48:54 EST
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o05CYct2061029;
	Tue, 5 Jan 2010 12:34:38 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o05CYbJh051863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jan 2010 12:34:38 GMT
Received: from [192.168.1.2] (231.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.231])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o05CYXI7029280
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 5 Jan 2010 07:34:35 -0500
In-Reply-To: <20100105041438.GB12574@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: b077a98d-f9f6-11de-97bb-002264978518
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH ahsdDFNVdwdEHAkR AmQBWFBeU1U/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwVtcnVT fEYeVxh6cQYIcX1w bQgwXndcDU1yIVsr SxhSCGwHMTJ9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcXdQPz5w FgM/d3Uwd31AKThV ChkEMVJaTkcVEyV0 DTkYEigqEEsZDyEy NABuNlkbVEIWNEp4 WQAA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136188>

El 05/01/2010, a las 05:14, Jeff King escribi=F3:

>> - or, preferably, teach "git diff index" to recurse into directories
>> rather than expect a list of paths-of-blobs (possibly with a command
>> line switch to activate the behaviour if it were deemed a dangerous
>> default)
>
> Doesn't it already do this? If I say "git diff index subdir" it
> will limit the diff only to things inside subdir/.

[snip patch]

I tried out the patch and it obviously does avoid the "Argument list =20
too long" problem. At least for my usage patterns the superficial =20
differences in behavior that you note would not be a problem (I =20
usually want to limit things to a subdir, and seldom if ever pass in =20
things like '*.c').

> but note that the pathspecs given to ls-files and the path limiters
> given to diff are not quite the same. So "git add -i '*.c'" will
> currently find "subdir/foo.c", but would not with the above patch. Is
> that what you meant when you said "recurse into directories"?

In my relative ignorance of the finer details here, I meant that I =20
would want "diff-index" to give us the exact same set of blobs as we =20
get from "ls-files", so as to fix the error without modifying the user =
=20
visible behavior.

As I said, I personally wouldn't be impacted by the change in behavior =
=20
that your patch produces, but maybe others might.

Cheers,
Wincent

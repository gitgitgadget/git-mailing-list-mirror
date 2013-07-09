From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Diff colorizer confused by dos newlines
Date: Tue, 09 Jul 2013 19:35:54 -0400
Message-ID: <51DC9E5A.8000906@ubuntu.com>
References: <51DC5650.1070708@ubuntu.com> <20130709194132.GD5153@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 01:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwhRw-0007EZ-W3
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 01:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab3GIXf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 19:35:57 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:42914 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab3GIXf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 19:35:56 -0400
X-Authority-Analysis: v=2.0 cv=XpZ4yC59 c=1 sm=0 a=C56BoFkcj+OI1kjAe8jE5A==:17 a=MtVMNMWb1ewA:10 a=xFrwVLZJWjEA:10 a=vjRbQoN4iXQA:10 a=S1A5HrydsesA:10 a=IkcTkHD0fZMA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=_1V_7tvqi9AA:10 a=QfKxxUxMAAAA:8 a=qn_5sLevOWYL7jQNEF0A:9 a=QEXdDO2ut3YA:10 a=C56BoFkcj+OI1kjAe8jE5A==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 142.196.87.46
Received: from [142.196.87.46] ([142.196.87.46:57860] helo=[192.168.1.5])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 7E/6E-15971-A5E9CD15; Tue, 09 Jul 2013 23:35:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130709194132.GD5153@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230015>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Of course!  Thanks, now it completely makes sense.

On 07/09/2013 03:41 PM, Jeff King wrote:
> On Tue, Jul 09, 2013 at 02:28:32PM -0400, Phillip Susi wrote:
> 
>> When I try to look at a color diff of a file using dos newlines,
>> the output gets an odd sequence of ansi escapes and a stray
>> carriage return showing up only on the + lines, but not the -.
>> The normal looking - lines look like this:
>> 
>> \r\n ( from previous line ), ansi color escape, '-', whitespace,
>> text, terminating ansi escpae ( [m ), \r\n.
>> 
>> The broken + lines look like this:
>> 
>> \r\n ( from previous line ), ansi color sequence, '+',
>> terminating ansi escape ( [m ), whitespace, ansi color sequence,
>> text, terminating ansi escape, ansi color sequence, stray \r,
>> terminating ansi escape, \n.
> 
> That's intentional; the added lines go through the "whitespace
> checker" to help you identify potential whitespace problems (there
> is not much point showing them on lines going away, since you are
> getting rid of them).
> 
>> Any suggestions on how to resolve this?
> 
> Try:
> 
> git config core.whitespace cr-at-eol
> 
> See the description of "core.whitespace" in "git help config" for
> more details.
> 
> -Peff
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJR3J5IAAoJEJrBOlT6nu757gIIAMx+w7oCXZt66z57VhZi2yl0
PmL1HKGQ9+aqerwBtcOFvQL+b8s8o0nLUg3jkHWUFLdEtTIsLSlEwyJBhCzbWQQh
NzzuwtzGdoXWxj8lFf1PakLRpWg0IW0QJ6WuMltEZMvPvF4jyt3yCArS0StpZEG/
PhQoEsgg8XjgvP6KIpZDc/CoElKn0fyWf0HlLFwV+k+cCgQM+y7POnGdzGwKIM+O
U5QJxWZmNFuznJHxkd+YWIsAZuHS/eH4Tz97/Abl9z30k+/4eHvD/Hd47RCTLrC1
90IiBKp9vvPWJHA+6c1WTwiTnn54CpudKstB499aaMRsvXBzXHcdD+Tkb38imwI=
=WMkZ
-----END PGP SIGNATURE-----

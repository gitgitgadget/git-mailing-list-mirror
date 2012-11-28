From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] configure.ac: fix pthreads detection on Mac OS X
Date: Wed, 28 Nov 2012 12:38:16 +0100
Message-ID: <316765B5-705F-450D-8191-A29D5AC61E32@quendi.de>
References: <1354058931-88873-1-git-send-email-max@quendi.de> <7vlidmi65n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:38:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdfyR-0006u8-TN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 12:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab2K1LiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 06:38:24 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:60930 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754320Ab2K1LiX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 06:38:23 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Tdfy5-0001H6-1P; Wed, 28 Nov 2012 12:38:17 +0100
In-Reply-To: <7vlidmi65n.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354102703;de4e5414;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210728>


On 28.11.2012, at 07:38, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>> The configure script checks whether certain flags are required to use
>> pthreads. But it did not consider that *none* might be needed (as is the
>> case on Mac OS X). This lead to configure adding "-mt" to the list of
>> flags (which does nothing on OS X except producing a warning). This in
>> turn triggered a compiler warning on every single file.
>> 
>> To solve this, we now first check if pthreads work without extra flags.
>> This means the check is now order dependant, hence a comment is added
>> explaining this, and the reasons for it.
>> 
>> Note that it might be possible to write an order independent test, but
>> it does not seem worth the extra effort required for implementing and
>> testing such a solution, when this simple solution exists and works.
>> 
>> Signed-off-by: Max Horn <max@quendi.de>
>> ---
>> 
>> This is actually a revised version from my patch
>> "Change configure to check if pthreads are usable without any extra flags"
>> from July. I simply had forgotten all about it :-(.
> 
> Will queue,

OK

> but we would need wider testing to avoid "compiles well
> without an option but fails to link" issues similar to cea13a8
> (Improve test for pthreads flag, 2011-03-28) on other people's
> platforms (I know you tested on Mac OS X and over there it compiles
> and links well---I am worried about others).

Sure, understood. Though note that the test in question performs a compile & link test. So I have a hard time to see how this could break something. Then again, I dabbled in portable code long enough to never say never ;-).

BTW, is there such a thing as a build farm for git which automatically compiles and runs tests for pu / next / main, across a variety of platforms? Or does it all rely on devs test building everything regularly?


Cheers,
Max
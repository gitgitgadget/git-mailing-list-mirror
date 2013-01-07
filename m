From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/4] t0024, t5000: clear variable UNZIP, use GIT_UNZIP
 instead
Date: Mon, 07 Jan 2013 17:25:39 +0100
Message-ID: <50EAF703.7070806@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx> <50E9B8CD.2010209@lsrfire.ath.cx> <20130107051609.GB27909@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 17:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsFWi-000350-II
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 17:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab3AGQZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 11:25:51 -0500
Received: from india601.server4you.de ([85.25.151.105]:37170 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab3AGQZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 11:25:49 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id 8EC09B4;
	Mon,  7 Jan 2013 17:25:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130107051609.GB27909@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212901>

Am 07.01.2013 06:16, schrieb Jonathan Nieder:
> Ren=C3=A9 Scharfe wrote:
>
>> InfoZIP's unzip takes default parameters from the environment variab=
le
>> UNZIP.  Unset it in the test library and use GIT_UNZIP for specifyin=
g
>> alternate versions of the unzip command instead.
>>
>> t0024 wasn't even using variable for the actual extraction.  t5000
>> was, but when setting it to InfoZIP's unzip it would try to extract
>> from itself (because it treats the contents of $UNZIP as parameters)=
,
>> which failed of course.
>
> That would only happen if the UNZIP variable was already exported,
> right?

We don't want any parameters a user may have been specified influence=20
the test.  I'm not sure if someone actually sets that variable for that=
=20
purpose, though.

My main use case is running individual test scripts with an alternative=
=20
unzip binary, and with the patch this works as expected:

	$ cd t
	$ GIT_UNZIP=3D/usr/pkg/bin/unzip ./t5000-tar-tree.sh

> The patch makes sense and takes care of all uses of ${UNZIP} I can
> find, and it even makes the quoting consistent so a person can put
> their copy of unzip under "/Program Files".  For what it's worth,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!

Ren=C3=A9

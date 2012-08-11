From: Christoph Miebach <christoph.miebach@web.de>
Subject: Re: Localization: Timestamps get wrong if using different locales
Date: Sat, 11 Aug 2012 18:22:35 +0200
Message-ID: <502686CB.1070703@web.de>
References: <501E3828.40708@web.de> <7vmx292hi8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050406010409060002070407"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 18:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0ET2-0001iw-2Y
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab2HKQXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:23:00 -0400
Received: from mout.web.de ([212.227.15.4]:56111 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004Ab2HKQXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:23:00 -0400
Received: from [192.168.168.63] ([89.0.162.115]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MYw1v-1TDH8c08UF-00VR2R; Sat, 11 Aug 2012 18:22:41
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vmx292hi8.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:gJaQzZWRNmszKDjaQcRlI7Qez2VK9qF7qKDVSC3EwGV
 D1Jv5Nsntg7CtPF9HY7chNJzl/Ae2OAFTyC8OISOi6wEORtJfa
 lE82DLaQHUH2zhsezF7Sk4QkCnBXikiMsd8NU9N3ZQZ/byohfa
 7uVfPbIZdcG9OBUb0NGLCEorwGH2uzmSciSw49czfGDnafl1D0
 0mYjqB9lnfev29+RByHmLc3SBV8XHvdm4g1uHSuHcI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203288>

This is a multi-part message in MIME format.
--------------050406010409060002070407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

What I am doing is:
invoking a bash script that does the

git add ${i##$TXPATH/}/strings.xml

git commit --author="$AUTHOR" ${i##$TXPATH\/}/strings.xml -m "l10n: 
$LNAME update"

after a user confirmation.

IIUC setting LANGUAGE=en at the top of this script _did_ help.
So I run everything with german locale for reproducing this.

On 05.08.2012 22:47, Junio C Hamano wrote:
> Christoph Miebach <christoph.miebach@web.de> writes:
>
>> Running this commands locally (german locale) lead to some wrong dates
>> for the patches upstream.
>>
>> git format-patch -o patches origin
>
> What does "git show -s --pretty=fuller HEAD" give you at this point?
> This is to check what kind of timestamps are stored in the original
> commit objects.

See pretty_fuller.txt

> And what does "grep '^Date: ' patches/0001-*" show you at this point?
> This is to see if the problem is at the "format-patch" step.

See date_grep.txt

>> git send-email --compose --no-chain-reply-to --to some@address.com
>> --suppress-cc=author patches/0001-l10n-Turkish-update.patch
>
> And what does "grep '^Date: '" for the message that is received by
> recipients show at this step?  They cannot be
>
>>
>>
>> The local
>> Date: Sat, 4 Aug 2012
>> became
>>        Wed, 8 Dec 2004
>
> as these two do not even have times and zones.  It should read
> something like
>
>      Date: Sun, 05 Aug 2012 13:39:12 -0700
>
> or something.

It was a complete line. I just did not copy all of it, for I thought I 
already pointed out the problem.

The recipient uses en_CA.UTF-8 and guesses:
Date: 12-08-05 06:10 PM
it is Y-M-D, but git thinks it's M-Y-D

> Also "Date" on which message do you see your problem with?  The one
> that is created with --compose?  Or the one that was originally
> produced by format-patch and then sent?  Or both?

git log should show the translators name ($AUTHOR in the git commit line)

Sorry for the late (and probably still incomplete) reply. I can provide 
a complete example or send a patch to a dummy project if you prefer some 
time next week, I hope.

Regards

Christoph


--------------050406010409060002070407
Content-Type: text/plain; charset=UTF-8;
 name="pretty_fuller.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pretty_fuller.txt"

commit b6f59b4a61f1bd203bb0d449dabac7b16351e2e1
Author:     Christoph Miebach <christoph.miebach@web.de>
AuthorDate: Mon Aug 6 00:07:54 2012 +0200
Commit:     Christoph Miebach <christoph.miebach@web.de>
CommitDate: Mon Aug 6 00:07:54 2012 +0200

    l10n: German update

--------------050406010409060002070407
Content-Type: text/plain; charset=UTF-8;
 name="date_grep.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="date_grep.txt"

Date: Mon, 6 Aug 2012 00:07:54 +0200

--------------050406010409060002070407--

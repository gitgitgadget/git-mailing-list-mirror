From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Make 'git submodule update --force' always check out
 submodules.
Date: Wed, 25 Jul 2012 22:51:44 +0200
Message-ID: <50105C60.4050303@web.de>
References: <1343239412-26780-1-git-send-email-szager@google.com> <7vipdbbs0b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Stefan Zager <szager@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8ZG-0005Ej-DD
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 22:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab2GYUwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 16:52:04 -0400
Received: from mout.web.de ([212.227.15.4]:62365 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab2GYUvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 16:51:55 -0400
Received: from [192.168.178.48] ([91.3.177.222]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MNcIg-1SsSo12rko-006m66; Wed, 25 Jul 2012 22:51:52
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vipdbbs0b.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Oq6VvYtpyLcZr9klwnvXbI/kZL71iN0S3zTWOEWNDqC
 zn9Q1uzJMOhMtRKffFBHnjGvRDlEixoIb+CbaD6J11eh/Gz/Tj
 bcu1m9m9bADI2wSQSws155lJZF73nDcgmWLjRGFKoesVwDDtwS
 0rXGk2FmafXXervO8CP8s/kaO7fy1k1kCFGmlJlyspLTUoFlWQ
 BbL1GzpvlMjVZrslj6avg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202196>

Am 25.07.2012 20:44, schrieb Junio C Hamano:
> Stefan Zager <szager@google.com> writes:
> 
>> Currently, it will only do a checkout if the sha1 registered in the containing
>> repository doesn't match the HEAD of the submodule, regardless of whether the
>> submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
>> strong indicator that the state of the submodule is suspect, and should be reset
>> to HEAD.
>>
>> Signed-off-by: Stefan Zager <szager@google.com>
>> ---
> 
> Looks sensible (again -- see http://thread.gmane.org/gmane.comp.version-control.git/197532
> for the original discussion).  Can submodule folks Ack it?

I like it. Still I'd vote for amending the documentation like the
original thread proposed and would appreciate to have a test or two,
but apart from that I have no objections.

>>  git-submodule.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index dba4d39..621eff7 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -575,7 +575,7 @@ Maybe you want to use 'update --init'?")"
>>  			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
>>  		fi
>>  
>> -		if test "$subsha1" != "$sha1"
>> +		if test "$subsha1" != "$sha1" -o -n "$force"
>>  		then
>>  			subforce=$force
>>  			# If we don't already have a -f flag and the submodule has never been checked out
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

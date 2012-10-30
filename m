From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Teach rm to remove submodules when given with a trailing
 '/'
Date: Tue, 30 Oct 2012 22:28:23 +0100
Message-ID: <50904677.2020308@web.de>
References: <508DBF92.9090200@web.de> <508E2C05.9010109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:28:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJMa-0007CQ-LA
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab2J3V2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:28:32 -0400
Received: from mout.web.de ([212.227.17.11]:50887 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764Ab2J3V2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:28:31 -0400
Received: from [192.168.178.41] ([91.3.154.28]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Mdueb-1Tk2SL0fFN-00QAyu; Tue, 30 Oct 2012 22:28:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <508E2C05.9010109@viscovery.net>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:8vAcLmBq2h0zcvl+Di8RAUhsZC/r7Bh0WKYcmk3o/p8
 mSVw2g3ceAWHg2zXrWt52LSiQ7YM0X99ZnG9md8wGX2rDKxlot
 4ndkpYr9cug5uaurtlszll+1KMTo0yipanmvjnZbCaHbHXzaek
 DEk7yhip2ozedVIGfu1Zg7b5ewYdpufTG5ozpeQPSigD7CF+Fu
 EYiWZAmdlKsaDuxnvXDhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208743>

Am 29.10.2012 08:11, schrieb Johannes Sixt:
> Am 10/29/2012 0:28, schrieb Jens Lehmann:
>> +	/* Remove trailing '/' from directories to find submodules in the index */
>> +	for (i = 0; i < argc; i++) {
>> +		size_t pathlen = strlen(argv[i]);
>> +		if (pathlen && is_directory(argv[i]) && (argv[i][pathlen - 1] == '/'))
>> +			argv[i] = xmemdupz(argv[i], pathlen - 1);
>> +	}
>> +
>>  	pathspec = get_pathspec(prefix, argv);
>>  	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
> 
> That's wrong: Either move the check below get_pathspec() (which normalizes
> backslashes to forward-slashes on Windows) or use is_dir_sep().

Thanks for bringing this up.

> But isn't it somewhat dangerous to check pathspec for existance in the
> worktree without interpreting them? Think of magic pathspec syntax (that
> we do not have yet, but which may materialize sometime in the future).

I have to admit I'm not aware of magic pathspec syntax. Do you happen to
have any pointers where I could look at code doing similar things right?

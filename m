From: =?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1hbm4=?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: [PATCH 1/2] git svn dcommit: new option --interactive.
Date: Wed, 07 Sep 2011 22:02:36 +0200
Message-ID: <4E67CDDC.1020305@gmail.com>
References: <1315164113-26539-1-git-send-email-frederic.heitzmann@gmail.com> <1315164113-26539-2-git-send-email-frederic.heitzmann@gmail.com> <20110906202601.GA11668@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jaysoffian@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 22:03:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1OKy-0000rV-Im
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 22:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab1IGUDC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 16:03:02 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52762 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774Ab1IGUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 16:03:00 -0400
Received: by wyh22 with SMTP id 22so19003wyh.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=G44r0YGpgLa1LCibaNSlCYCdOFHyfarh2IsC+qtdqhk=;
        b=DmoufsWnLKQMaq/8QOgGpm5HBczLxdrEu/1lflYVm2IwxUGIvONTGhsaxjc17mNkpV
         om0TPwk9l+t3qkrvb2Msyu+3RKYTQtsln332fd0F3Kf9g9POVVU+7dXlZoSe/eD0nD5e
         zciFIV1oL5iWJzOlmGQhWQC7QkOt4N6t0K8/M=
Received: by 10.216.184.200 with SMTP id s50mr223081wem.36.1315425779205;
        Wed, 07 Sep 2011 13:02:59 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id ev5sm1710382wbb.11.2011.09.07.13.02.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Sep 2011 13:02:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
In-Reply-To: <20110906202601.GA11668@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180901>



Le 06/09/2011 22:26, Eric Wong a =C3=A9crit :
> Fr=C3=A9d=C3=A9ric Heitzmann<frederic.heitzmann@gmail.com>  wrote:
>> Allow the user to check the patch set before it is commited to SNV. =
It is then
>> possible to accept/discard one patch, accept all, or quit.
>>
>> This interactive mode is similar with 'git send email' behaviour. Ho=
wever,
>> 'git svn dcommit' returns as soon as one patch is discarded.
>>
>> Part of the code was taken from git-send-email.perl
>> Thanks-to: Eric Wong<normalperson@yhbt.net>  for the initial idea.
>> Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann<frederic.heitzmann@gmail=
=2Ecom>
> I agree with this feature, a few comments inline.
>
>>   I would have preferred not duplicating the code snippets taken fro=
m
>>   git-send-email ('ask' function, Term related code, ...) but I pref=
erred not
>>   to spoil Git.pm with it.
>>   Any comment on a better way to factor perl code would be appreciat=
ed.
> We should put this into Git.pm at some point.
> (Somebody should refactor git-svn.perl into separate files too... :x)
>
>>   Documentation/git-svn.txt |    8 +++++
>>   git-svn.perl              |   71 +++++++++++++++++++++++++++++++++=
+++++++++++-
>>   2 files changed, 78 insertions(+), 1 deletions(-)
> Tests and feature should be the same patch
>> +	return defined $default ? $default : undef
>> +		unless defined $term->IN and defined fileno($term->IN) and
>> +		       defined $term->OUT and defined fileno($term->OUT);
> Things to make life easier for (mainly) C programmers:
>
> * Use C-style "&&" and "||" for conditionals.  "and" and "or" are low=
er
>    precedence and better used for control flow (see perlop(1) manpage=
).
>
> * Also, use parentheses for defined(foo) to disambiguate multiple
>    conditions/statements.
>
My fault : I copied-pasted the 'ask' function from git-send-email.
Even if I rewrite it a litlle, it should not prevent anyone to mutalize=
=20
some code into Git.pm.
And, indeed, it will improve readability.

I wait a few days to see if anyone else has some comments and I send a=20
V2 patch serie.

Thanks for reviewing.

--
=46red

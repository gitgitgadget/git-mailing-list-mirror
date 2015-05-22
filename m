From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of post-rewrite
Date: Fri, 22 May 2015 16:52:26 +0200
Message-ID: <vpqd21soead.fsf@anie.imag.fr>
References: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
	<0000014d7bc3f7a5-332dd95f-907f-4f46-a5d6-6b9e5dc70b0a-000000@eu-west-1.amazonses.com>
	<xmqq1ti8heu9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 16:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvoJX-00022B-1x
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbbEVOwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:52:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37352 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756364AbbEVOwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:52:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4MEqPRv000744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 May 2015 16:52:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4MEqQca029982;
	Fri, 22 May 2015 16:52:26 +0200
In-Reply-To: <xmqq1ti8heu9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 May 2015 07:22:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 22 May 2015 16:52:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4MEqPRv000744
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432911146.815@fxlaV/mBtsoRsrVijMKK7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269726>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The 'exec' command is sending the current commit to stopped-sha, which is
>> supposed to contain the original commit (before rebase). As a result, if
>> an 'exec' command fails, the next 'git rebase --continue' will send the
>> current commit as <old-sha1> to the post-rewrite hook.
>>
>> The test currently fails with :
>>
>> --- expected.data       2015-05-21 17:55:29.000000000 +0000
>> +++ [...]post-rewrite.data      2015-05-21 17:55:29.000000000 +0000
>> @@ -1,2 +1,3 @@
>>  2362ae8e1b1b865e6161e6f0e165ffb974abf018 488028e9fac0b598b70cbeb594258a917e3f6fab
>> +488028e9fac0b598b70cbeb594258a917e3f6fab 488028e9fac0b598b70cbeb594258a917e3f6fab
>>  babc8a4c7470895886fc129f1a015c486d05a351 8edffcc4e69a4e696a1d4bab047df450caf99507
>
> Indent displayed material like the above a bit, please.

OK, will do.

> And please sign-off your patches.

Ah, I was testing submitGit, and forgot that send-email was usually
doing this for me.

>> +	cat >expected.data <<EOF &&
>> +$(git rev-parse C) $(git rev-parse HEAD^)
>> +$(git rev-parse D) $(git rev-parse HEAD)
>> +EOF
>
> By using a dash to start the here-document like this:
>
> 	cat >expect <<-\EOF &&
> 	$(git rev-parse C) $(git rev-parse HEAD^)
>         ...
>         EOF
>
> you can tab-indent the contents and the end marker at the same level
> to make it easier to read.

I usually do that but I just mimicked the surrounding code for
consistency. If you really prefer the <<-\EOF I can resend with an
additional "modernize style" patch before and this one properly
formatted.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

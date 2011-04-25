From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [PATCH] t/README: unify documentation of test function args
Date: Mon, 25 Apr 2011 20:30:22 +0200
Message-ID: <4DB5BDBE.308@debugon.org>
References: <4DB4010B.6080804@debugon.org> <7v62q2l3ft.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:30:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEQYM-0001uP-18
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 20:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702Ab1DYSa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 14:30:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64054 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203Ab1DYSa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 14:30:28 -0400
Received: from [192.168.2.111] (pD9E3BB0D.dip.t-dialin.net [217.227.187.13])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MVHmU-1QKU1f13EM-00YeIP; Mon, 25 Apr 2011 20:30:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7v62q2l3ft.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:ZNCVKIk0ayK+UMv/mF4FktaQaO8IaZehJX3n6qd4Nd4
 Tt25BkB0PZj96rZEs0B7CvvwrLzHrzCBCYlCVN2LbAqTGnXOay
 h7YRGPIImXt3n/aEogbX/2CzxfJaJnjlHvMy5bqMXkXdVCG62p
 0E357bfrxRzqo4db23ZI8Nr7uHqhVxOECtcZzG8NOP4pLHpqw4
 qFKrkMPV9+n2ZEsw3ZlcenRTUBVrlnbO0liyCvwTcE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172037>

[...] 
> Everything before this hunk looks sensible.
> 
>> @@ -503,18 +503,18 @@ library for your script to use.
>>  		test_expect_code 1 git merge "merge msg" B master
>>  	'
>>  
>> - - test_must_fail <git-command>
>> + - test_must_fail <command>
>> ...  
>> +   Run a command and ensure it fails in a controlled way.  Use this
>> +   instead of "! <command>".  When the command dies due to a segfault,
>> +   test_must_fail diagnoses it as an error; "! <command>" treats it as
>> +   just another expected failure, which would let such a bug go
>> +   unnoticed.
>>  
>> - - test_might_fail <git-command>
>> + - test_might_fail <command>
>>  
>>     Similar to test_must_fail, but tolerate success, too...
> 
> But the above two deliberately say "git-command" to clarify that these are
> special cases and meant to be used only to run a git command.  If we
> expect a failure from a command that is not "git", say "date", we would
> want to say "! date", not "test_must_fail date".
> 

Ah, okay. Is this true for test_expect_code too? It also has a git command
in the example, but it says <command>, not <git-command>:

 - test_expect_code <exit-code> <command>

   Run a command and ensure that it exits with the given exit code.
   For example:

	test_expect_success 'Merge with d/f conflicts' '
		test_expect_code 1 git merge "merge msg" B master
	'

>> @@ -530,7 +530,7 @@ library for your script to use.
>>     test_path_is_dir <dir> [<diagnosis>]
>>     test_path_is_missing <path> [<diagnosis>]
>>  
>> -   Check whether a file/directory exists or doesn't. <diagnosis> will
>> +   Check whether a file/directory exists or not. <diagnosis> will
> 
> Is the original really a grammo, or is this change just your personal
> taste?  If I were rewriting this, I would probably say something like:
> 
> 	- test_path_is_file <path> [<diagnosis>]
>           test_path_is_dir <path> [<diagnosis>]
>           test_path_is_missing <path> [<diagnosis>]
> 
> 	  Check if the named path is a file, if the named path is a
>           directory, or if the named path does not exist, respectively,
>           and fail otherwise, showing the <diagnosis> text.

Yes, it's just a matter of taste, but your rewrite is even better.

-Mathias

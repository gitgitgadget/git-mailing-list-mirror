From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/1] tests: Allow customization of how say_color() prints
Date: Mon, 17 Dec 2012 22:31:40 +0000
Message-ID: <50CF9D4C.9080706@ramsay1.demon.co.uk>
References: <50CCCB86.5080701@ramsay1.demon.co.uk> <7vobhuqzdc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkjIj-0003LA-FU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 23:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab2LQWgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 17:36:20 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:42722 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab2LQWgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 17:36:18 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 5D16BA0C084;
	Mon, 17 Dec 2012 22:36:17 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 8CE29A0C080;	Mon, 17 Dec 2012 22:36:16 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Mon, 17 Dec 2012 22:36:15 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <7vobhuqzdc.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211710>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index f50f834..9dcf3c1 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -202,6 +202,15 @@ do
>>  	esac
>>  done
>>  
>> +if test -z "$GIT_TEST_PRINT"
>> +then
>> +	GIT_TEST_PRINT="printf %s"
>> +fi
>> +if test -z "$GIT_TEST_PRINT_LN"
>> +then
>> +	GIT_TEST_PRINT_LN="printf %s\n"
>> +fi
>> +
>>  if test -n "$color"
>>  then
>>  	say_color () {
>> @@ -221,7 +230,7 @@ then
>>  			test -n "$quiet" && return;;
>>  		esac
>>  		shift
>> -		printf "%s" "$*"
>> +		$GIT_TEST_PRINT "$*"
>>  		tput sgr0
>>  		echo
>>  		)
>> @@ -230,7 +239,7 @@ else
>>  	say_color() {
>>  		test -z "$1" && test -n "$quiet" && return
>>  		shift
>> -		printf "%s\n" "$*"
>> +		$GIT_TEST_PRINT_LN "$*"
>>  	}
>>  fi
> 
> As you said, this is ugly and also unwieldy in that I do not see an
> easy way for a platform/builder to define something that needs to
> pass a parameter with $IFS in it in these two variables.

Yes, I spent 10 minutes trying to decide if I should send this patch
at all ... (ie how much public humiliation could I take :-D )

> Why does your printf die in the first place???

I really don't know. I'm not sure I will ever know. A couple of years
ago, when I was trying to debug the (harmless) "--color" spew, I found
(via google, etc) numerous accounts of similar problems, with various
workarounds for specific problems. One such account claimed that the
cause of the problem was an official "fix" from Microsoft (as part of
a service pack) which worked just fine on Windows Vista (and later) but
had this known side-effect on XP. Since it fixed the problem it was
intended to fix, even on XP, and the unfortunate "side-effect" on XP
should be quite rare, they decided to apply it on XP anyway. :(

Hmm, on reflection, it would probably be best if you just drop this patch.
I can keep it locally and apply it on top of any branch I want to test.
(Actually, it would be easier to simply revert commit 7bc0911d.)

Sorry for wasting your time.

ATB,
Ramsay Jones

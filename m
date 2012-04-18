From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] git-submodule.sh: Don't use $path variable in eval_gettext
 string
Date: Wed, 18 Apr 2012 21:06:04 +0100
Message-ID: <4F8F1EAC.5040704@ramsay1.demon.co.uk>
References: <4F8DAFDA.1020108@ramsay1.demon.co.uk> <4F8EA009.5080405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, bwalton@artsci.utoronto.ca,
	Johannes Sixt <j6t@kdbg.org>, avarab@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:07:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbAO-0004hn-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab2DRUHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:07:36 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:45756 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754892Ab2DRUHf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 16:07:35 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SKbA5-0003jd-oQ; Wed, 18 Apr 2012 20:07:34 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4F8EA009.5080405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195894>

Jens Lehmann wrote:
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
> 
> To me it makes sense to rename the problematic $path variable to
> get rid of this problem.

>>  git-submodule.sh |  161 +++++++++++++++++++++++++++---------------------------
>>  1 file changed, 82 insertions(+), 79 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 3d94a14..64a70d6 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -101,11 +101,12 @@ module_list()
>>  module_name()
>>  {
>>  	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
>> +	sm_path="$1"
>>  	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>>  	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
>>  		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
>>  	test -z "$name" &&
>> -	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
>> +	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$sm_path'")"
>>  	echo "$name"
>>  }
> 
> And as an extra this part fixes the bug that the die won't print the
> submodule path in case of an error as to do that it would have had
> to use $1 here ;-)

Yes, I noted that this was an independent fix when I first sent this to the
list (as an RFC) in the v1.7.8 rc time frame.

I had intended to either add a separate patch to fix this, or note it in the commit
message, but I obviously forgot.

[Junio, which alternative would you prefer?]

Thanks!

ATB,
Ramsay Jones

From: greened@obbligato.org
Subject: Re: [PATCH 2/7] contrib/subtree: Use %B for Split Subject/Body
Date: Tue, 15 Jan 2013 21:14:32 -0600
Message-ID: <87622xrf8n.fsf@waller.obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
	<1357646997-28675-3-git-send-email-greened@obbligato.org>
	<7vmwwjedei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:15:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvJTY-000169-1X
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 04:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab3APDPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 22:15:18 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:34793 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756660Ab3APDPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 22:15:17 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TvJbG-0003F5-BO; Tue, 15 Jan 2013 21:23:38 -0600
In-Reply-To: <7vmwwjedei.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 Jan 2013 10:29:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213720>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: Techlive Zheng <techlivezheng@gmail.com>
>>
>> Use %B to format the commit message and body to avoid an extra newline
>> if a commit only has a subject line.
>>
>> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
>>
>> Signed-off-by: David A. Greene <greened@obbligato.org>
>> ---
>
> This time (only), I'll try to fix them up at my end, but please
> check your toolchain, find out where the extra blank line between
> S-o-b: lines we see above come from, and fix that, so that I won't
> have to do so again.

Will do.

>>  contrib/subtree/git-subtree.sh     |    6 +++++-
>>  contrib/subtree/t/t7900-subtree.sh |   15 +++++++++++++++
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 920c664..5341b36 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -296,7 +296,11 @@ copy_commit()
>>  	# We're going to set some environment vars here, so
>>  	# do it in a subshell to get rid of them safely later
>>  	debug copy_commit "{$1}" "{$2}" "{$3}"
>> -	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
>> +	# Use %B rather than %s%n%n%b to handle the special case of a
>> +	# commit that only has a subject line.  We don't want to
>> +	# introduce a newline after the subject, causing generation of
>> +	# a new hash.
>> +	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
>
> The new format template is fine, but I do not think the comment
> should be there.  It does not give any useful information to people
> who are reading the end result of applying this patch and is useful
> only in the context of comparing the old and new templates, iow, it
> belongs to the commit log message.

I'll delete the comment.

                           -David

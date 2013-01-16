From: greened@obbligato.org
Subject: Re: [PATCH 4/7] contrib/subtree: Better Error Handling for add
Date: Tue, 15 Jan 2013 21:21:09 -0600
Message-ID: <87r4llq0d6.fsf@waller.obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
	<1357646997-28675-5-git-send-email-greened@obbligato.org>
	<7v7gnneco2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvJZp-0001zG-MO
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 04:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106Ab3APDVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 22:21:49 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:34935 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756860Ab3APDVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 22:21:49 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TvJha-0003Gh-Vn; Tue, 15 Jan 2013 21:30:11 -0600
In-Reply-To: <7v7gnneco2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 Jan 2013 10:45:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213723>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: "David A. Greene" <greened@obbligato.org>
>>
>> Check refspecs for validity before passing them on to other commands.
>> This lets us generate more helpful error messages.
>>
>> Signed-off-by: David A. Greene <greened@obbligato.org>
>> ---
>>  contrib/subtree/git-subtree.sh |   12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index cac0680..d53eaee 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -508,12 +508,18 @@ cmd_add()
>>  	ensure_clean
>>  	
>>  	if [ $# -eq 1 ]; then
>> -		"cmd_add_commit" "$@"
>> +	    git rev-parse -q --verify "$1^{commit}" >/dev/null ||
>> +            die "'$1' does not refer to a commit"
>
> Where do these uneven indentation come from?  Is it mimicking
> existing breakage in the script?

Huh.  I'm not sure how that happened.  I'll fix it if you haven't got to
it already.

                            -David

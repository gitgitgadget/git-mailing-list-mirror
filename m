From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] sha1_name.c: get_describe_name() by definition
 groks only commits
Date: Thu, 21 Jun 2012 12:57:19 -0700
Message-ID: <7v1ul8sajk.fsf@alter.siamese.dyndns.org>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
 <1340260532-11378-10-git-send-email-gitster@pobox.com>
 <CABPQNSZ246Y80WJN+u2OR8_3KWE_1=8F6WbTgVX-8wqyecGPkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 21 21:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShnVP-0002tp-IT
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 21:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759983Ab2FUT5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 15:57:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab2FUT5W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 15:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F02AE94F9;
	Thu, 21 Jun 2012 15:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MPfCuNCJ0cb6wHLiqIgl//GHwK4=; b=dcbdT3
	E2Yyr86pzMnISlVYujplpYQG9lStwWmZOHfz6M7VX7DJ1gqjCNIoU9i3vvnuhoXg
	l8LQwMkffHVxsSbDG5ru5OKui+rg+EVNAwSaV0kafdkBRRPzQYizCjPYjQuJVvWN
	gv0udzidqrrNB2nVOwW6E3yea3mUncpLPtj0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0WdLe8QJ1HJcW4bxhBdgDKl5SAShi17
	C8dsRxeavYaAqVRnr4l9wW9PQB/eJ0drLb0f1/8YfyujvywGMq4622ylSb8wsDnB
	FHSUJqdK7c08XOIdE3QVDoP6USgId/VBAd5t58BISniLhpIJ4S4sbaQF5ucYV9vh
	nDCHi3hTGtU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E732694F8;
	Thu, 21 Jun 2012 15:57:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77AF994F7; Thu, 21 Jun 2012
 15:57:21 -0400 (EDT)
In-Reply-To: <CABPQNSZ246Y80WJN+u2OR8_3KWE_1=8F6WbTgVX-8wqyecGPkg@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 21 Jun 2012 11:22:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 502A566E-BBDB-11E1-BC9F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200415>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Jun 21, 2012 at 8:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  sha1_name.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 58dbbe2..15e97eb 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -606,6 +606,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>>  static int get_describe_name(const char *name, int len, unsigned char *sha1)
>>  {
>>        const char *cp;
>> +       unsigned flags = GET_SHORT_QUIETLY | GET_SHORT_COMMIT_ONLY;
>>
>>        for (cp = name + len - 1; name + 2 <= cp; cp--) {
>>                char ch = *cp;
>> @@ -616,7 +617,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
>>                        if (ch == 'g' && cp[-1] == '-') {
>>                                cp++;
>>                                len -= cp - name;
>> -                               return get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
>> +                               return get_short_sha1(cp, len, sha1, flags);
>
> Is there a reason why you chose to put the definition in the
> root-scope of the function?

Mostly because it never changes inside the loop.  "unsigned const
flags" upfront might have even been a better option, though.

A less important reason is it would make the resulting file wider,
not narrower, than the original.

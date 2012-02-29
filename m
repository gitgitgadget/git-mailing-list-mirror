From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: Tilde spec - befuzzled
Date: Wed, 29 Feb 2012 11:13:22 -0800
Message-ID: <7v8vjltpv1.fsf_-_@alter.siamese.dyndns.org>
References: <4F4C995D.9000504@diamand.org> <4F4CA354.2070503@op5.se>
 <87zkc38a3v.fsf@thomas.inf.ethz.ch> <7vaa42zrw8.fsf@alter.siamese.dyndns.org>
 <4F4DF096.9050905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Luke Diamand <luke@diamand.org>,
	Git List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Feb 29 20:13:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2oxv-0002aP-OU
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 20:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031129Ab2B2TN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 14:13:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758031Ab2B2TNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 14:13:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F29C56CAB;
	Wed, 29 Feb 2012 14:13:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hj6+Si075h/9kZ2WRlN5aYhqK4M=; b=xdjOmd
	VQDEDzzmY3XbwMM5bS/CAwA9Bqyr9fOwvz1bM3fmk/PzK67v4/JN5ffVSWv4NTGy
	+Sqmy7936C9urLdBcGEgdk/pwFbgd5W8XH+IcK6wnlxPk2lw3cwjzTpCJmL31IxM
	B0OpN3XXa4orrR6n14L5tqQibg8mv3v8VyWZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AIx3//yK1hwYRHNepJUiJ1AevZ4wWb1A
	Z8I68kx1uSbVnr3aC7BeWaYmy6755X8ZDQaHQ+j/Ekrpy3oz0GaHldHexGpiQosL
	iTiOeoyOgZarkzHqFp//azEFGAz4M2vOFE+B/7SOJ2tLRR+CbVgWAhkLMAdxr6Uk
	wQAFuYSzcww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9CA76CAA;
	Wed, 29 Feb 2012 14:13:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B6286CA9; Wed, 29 Feb 2012
 14:13:24 -0500 (EST)
In-Reply-To: <4F4DF096.9050905@op5.se> (Andreas Ericsson's message of "Wed,
 29 Feb 2012 10:32:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 739AD392-6309-11E1-9063-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191845>

Andreas Ericsson <ae@op5.se> writes:

> On 02/28/2012 08:20 PM, Junio C Hamano wrote:
>> Thomas Rast<trast@inf.ethz.ch>  writes:
>> 
>>>>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>>>>> A suffix '{tilde}<n>' to a revision parameter means the commit
>>>>> object that is the<n>th generation grand-parent of the named
>>>>> commit object, following only the first parents.
>>>>>
>>>>> Hang on, *grand*-parents?
>>>>> ...
>>>
>>> Perhaps we should reword it as "n-th first-parent ancestor"?  Barring
>>> confusion about the position of the dashes, that leaves little room for
>>> error.
>> 
>> I think we could either go "easier to read but not precise"
>> 
>> 	... that is the<n>th generation (grand-)parent of ...
>
> (grand-)parent and ancestor are interchangeable while the parentheses
> remain, although the former looks a bit clumsier in text.

Ok, then something like this...

-- >8 --
Subject: Documentation: do not assume that n > 1 in <rev>~$n

We explained <rev>~<n> as <n>th generation grand-parent, but a reader got
confused by the "grand-" part when <n> is 1.

Reword it with "ancestor"; with the "generation" and "following only the
first parents" around there, what we try to describe should be clear
enough now.

Noticed-by: Luke Diamand <luke@diamand.org>
Helped-by: Thomas Rast <trast@inf.ethz.ch>
Helped-by: Andreas Ericsson <ae@op5.se>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/revisions.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index b290b61..1725661 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -101,7 +101,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 
 '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
   A suffix '{tilde}<n>' to a revision parameter means the commit
-  object that is the <n>th generation grand-parent of the named
+  object that is the <n>th generation ancestor of the named
   commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
   equivalent to '<rev>{caret}{caret}{caret}' which is equivalent to
   '<rev>{caret}1{caret}1{caret}1'.  See below for an illustration of

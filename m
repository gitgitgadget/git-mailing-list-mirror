From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Wed, 23 Nov 2011 10:59:31 -0800
Message-ID: <7vhb1ubr70.fsf@alter.siamese.dyndns.org>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
 <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
 <4ECB315F.4080701@alum.mit.edu> <7vwrasdp3t.fsf@alter.siamese.dyndns.org>
 <4ECCBB3D.7070204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Gerd Knops <gerti@bitart.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 23 19:59:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTI2m-0004is-DB
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 19:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696Ab1KWS7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 13:59:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab1KWS7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 13:59:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EBFF6E1F;
	Wed, 23 Nov 2011 13:59:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f/F02KXcFHMI0BRYSYQ5rJOOBJo=; b=Js7eTr
	CgcAwacGFGWBZ0iF53Vbsie6knPwC1BoVPt2uaJjATVINSxYxOd4naBpqRBf1oTO
	xZ3Um9GhUJu69uW3Rl+f8Suy6oHEs28fFZGSbYpQOMD1bYzN6WwJJoGRGGp3iBnF
	xoLXpLmB+dTDVXUyN4KpooRcNo/4a3DDMLp1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDy4aH6Z1HuUHR5HsJrwxbedHqlnHWeU
	o0kaKV4M9twsk0QvHprHHZ3xSGRN5WonNCwiH42OvytueunPoqcNiiCHgcApI7U6
	Ygcx7v6SsUYBMuNtUfMi8ZPmKROEwozKDW+m4Eakuw0FJYxsPcJEX9rKFJ2ZWKf+
	apGmx3It+XI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 168ED6E1D;
	Wed, 23 Nov 2011 13:59:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B5266E1C; Wed, 23 Nov 2011
 13:59:32 -0500 (EST)
In-Reply-To: <4ECCBB3D.7070204@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 23 Nov 2011 10:22:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 476819DE-1605-11E1-B204-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185864>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 11/22/2011 06:49 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> Currently git handles references names case-sensitively and allows
>>> multiple reference names that differ only in case.
>> 
>> We do the same for in-tree paths, by the way.  Ultimately, I think the
>> sane thing to do is to appeal to the user's common sense.  [...common
>> sense aka "if it hurts don't do it" omitted...]
>> 
>> I think refnames have exactly the same issue. In theory, you could have
>> "Master" and "master" branches, and nothing stops you from trying to do
>> so, but in practice, if it is not useful for you and your project, and
>> if it is equally fine to use some other name instead of "Master" for the
>> purpose of you and your project, then there is no strong reason for doing
>> so, unless you are trying to irritate users on case folding platforms.
>
> I agree.
>
> But git could nevertheless help users (1) by providing config settings
> or hook scripts or something that could be configured in a repository to
> prevent case-conflicts from entering the project history; (2) by
> emitting an error when such a conflict arises rather than getting so
> confused.

Yeah, and you didn't have to say "But"; we are in agreement (see my other
message in response to the same message from you).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Sun, 26 Sep 2010 23:04:56 -0700
Message-ID: <7vk4m73enr.fsf@alter.siamese.dyndns.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org>
 <1285202724-52474-1-git-send-email-kevin@sb.org>
 <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
 <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org>
 <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
 <F6C23FD9-37C4-4C20-83E7-26A1A2FC2275@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 08:05:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P06pz-0001an-9v
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 08:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202Ab0I0GFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 02:05:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab0I0GFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 02:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DAFD996B;
	Mon, 27 Sep 2010 02:05:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QKAeJIDKtqpPDpbgEjOwK7mTvQ4=; b=uJXWfy
	01MNzhFhVTcEJvP/oJsz2Je9EK6OHmPI9eFW/h5kVDeWsy2pCcdTJ+aBIRz7jShN
	FqhHUMOPR6IpD2P+l7EBzgUdZjIizP9605oDGVA9BIC0oZu5Vq1u1l1bGPbnR6Lt
	P1IWXxjzNDB5Ndye+Qj1ik1YY02jycrnycqjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m8qG2CUcITuCnT2L+M4F9Z+RZKCkQOKb
	Esp1LCUykD8HgxI+XSXPgt/EJN7WgMms56A1T2jC1kWXyKl5XSzxg9gqo7fGKmc6
	wkGZzgqxSJtDVNTO4VQhGhzzRORHFbMusuU/5YWdfh+B5h3ytoIycy3/+rRiWOUn
	fw9MfPMgqxU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0606D9968;
	Mon, 27 Sep 2010 02:05:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFF19D9967; Mon, 27 Sep
 2010 02:04:57 -0400 (EDT)
In-Reply-To: <F6C23FD9-37C4-4C20-83E7-26A1A2FC2275@sb.org> (Kevin Ballard's
 message of "Sun\, 26 Sep 2010 22\:34\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A3CDC82-C9FD-11DF-96AA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157303>

Kevin Ballard <kevin@sb.org> writes:

> On Sep 26, 2010, at 10:24 PM, Junio C Hamano wrote:
>
>> Kevin Ballard <kevin@sb.org> writes:
>> 
>>>> At the end-user level, this new option to merge-recursive has exactly the
>>>> same meaning as existing -M given to "diff" family; people would probably
>>>> want to see it made available as a synonym to "diff" family as well, no?
>>> 
>>> You mean so you can type `git diff --rename-score=50% foo`? A reasonable
>>> suggestion, but then what do we do with -B and -C? It doesn't make much
>>> sense to give a longer name to only one of the three options. This patch
>>> was concerned with simply exposing the functionality to the merge
>>> strategy and doesn't attempt to address the problem of providing long
>>> names for this trio of options.
>> 
>> I would call them --break-threshold and --copy-threshold respectively.
>> 
>> I have been happy without long option names when we originally had only
>> short names, but some people seem to be able to be more explicit, so...
>
> Fair enough. Expect that naming in the next iteration of the patch.
>
>> While we are at it, would it make sense to have "merge-recursive -M20" as
>> a shorthand as well?
>
> So it would be invoked like `git merge -s recursive -X M20 foo`? Looks a bit odd to me. I can add that if you think it's worthwhile though.

I agree it looks odd, too ;-)

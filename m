From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 11:11:39 -0800
Message-ID: <7vwqwtfzis.fsf@alter.siamese.dyndns.org>
References: <50C22B15.1030607@xiplink.com>
 <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:11:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th3L4-0002a2-2j
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 20:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab2LGTLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 14:11:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab2LGTLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 14:11:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8377C9FCF;
	Fri,  7 Dec 2012 14:11:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f2xvmpuxj6iBV6gvz2ayzw/UO7U=; b=jucyyE
	JCWc9Zjt4Fal7NLJi6jmfeKbHk2eVhg2HwOipNKGQzDiiNdm5kuCzyJ5A98VS79b
	A78F25B/i/B9lc82SCNZRXDDpyF5eGcYerVj4mgTG/dPm4PFSwQ3TqWL9/f2kcSj
	idEwxTpXsRjxV7refaw5E9BGk4fbXmB9p6tso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uVDs0IRMB1zpSb7i3jIcoidz8liO/cER
	MfQa/tcWXH+u2FQx91T72No1C7+Z8lmGWnglcvUOk7WXH5jemiCyKCKx9eFYaNel
	ImJL3zrcU0SocuCCnBvl4QlcFtP3ZI/sSDr+Zhm4C4FWs/h1+4QqbCLQq1mu2Is+
	L/SzxeZIgYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71D499FCE;
	Fri,  7 Dec 2012 14:11:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE86A9FC8; Fri,  7 Dec 2012
 14:11:40 -0500 (EST)
In-Reply-To: <50C22F72.6010701@xiplink.com> (Marc Branchaud's message of
 "Fri, 07 Dec 2012 13:03:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE6C75A0-40A1-11E2-8823-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211188>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-12-07 12:54 PM, Junio C Hamano wrote:
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>> 
>>> This is with git 1.8.0.1 on all the machines involved.
>>>
>>> One of our build machines is having trouble with "git submodule":
>>> ...
>>> Any ideas?
>> 
>> How and why is the IFS set differently only on one of your build
>> machines?
>
> It's not.  On all machines:
> 	$ set | grep IFS
> 	IFS=$' \t\n'
>
> As I said, if I isolate the module_list() function into another script it
> works fine, with the exact same environment that breaks in git-submodule.sh.
>
> Also, note that at the top of git-submodule there's
> 	. git-sh-setup
> which does
> 	unset IFS

Yeah, now it makes sense why you wrote "Weird" on the subject line.
What difference, if any, does the problematic box have compared to
your other healthy boxes?  It uses a different /bin/sh?

Just taking a shot in the dark...

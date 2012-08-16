From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 13:21:46 -0700
Message-ID: <7vobma1tb9.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <20120816194552.GA3167@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 16 22:21:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T26Zn-00044m-Ty
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 22:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461Ab2HPUVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 16:21:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030338Ab2HPUVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 16:21:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 819C4804B;
	Thu, 16 Aug 2012 16:21:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+h3wllhrGxowqGyB3HSnHg5A3QQ=; b=iZ02uG
	JeIvLRL7bW9ZcPDtjIzsV9i4HSlEcvaJs8qsO01WZDbJPQXuSp3C80wq7wKzo+YV
	BkWa/qwIlcUAT6Wb/x2MoyxByTLpMnnMze/SyYZhn02FTr0BRVwowomIMCuBSW0w
	v/wHLada+aNzgB7DhzzFOAN8Jo1ualU4IPTUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fw5wCcwZo1gBgjs0yIHp12gne1yAjXod
	RS6SpF/6vBWm7MM4sNTQJdK2D0KLgqDZ8YAOxwjfLMY6m/aX8m49RXqst9U9DDHc
	HGgPbtQzm9MidyZ8Uz5uKGEK3hjpANltyNTEuzGOtHSQUC1SZv/k78DAas9XXI7N
	l+66PqzFRIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 700A9804A;
	Thu, 16 Aug 2012 16:21:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C75938049; Thu, 16 Aug 2012
 16:21:47 -0400 (EDT)
In-Reply-To: <20120816194552.GA3167@suse.cz> (Miklos Vajna's message of "Thu,
 16 Aug 2012 21:45:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 014B77C2-E7E0-11E1-893B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@suse.cz> writes:

> On Thu, Aug 16, 2012 at 09:22:14AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> I am not sure if this is worth it, as it comes from a natural
>> "abbreviated options" support, i.e.
>> 
>> 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
>> 		rebase=true
>
> I sent the patch as a (newcomer) friend today asked if it's intentional
> that -r is undocumented in 'man git-pull'.

It is more intentional than it is by accident that we don't.

We would really think hard to avoid breaking when introducing new
options whose long name could begin with "v" or "q" to avoid
breaking "-v" and "-q" that are common across commands, but it is
entirely plausible that we want to add a new option whose name
begins with "re", and at that point, "-r" or "--re" stop being the
unique short form to trigger "git pull --rebase".

If somebody figures out "git pull --reba" or even "git pull -r"
works by accident _today_ and gets used to using it, that is fine,
but we do not want to guarantee the future.  We reserve the right to
introduce "git pull --repurpose" in a later version of Git, and make
"git pull --re" error out for ambiguity, breaking fingers of such
people who relied on "used to be but no longer" unique
abbreviations.

> ...
> I agree, however, we already document -q and --quiet, or -v and
> --verbose in the same manpage, so I think it would be consistent to have
> -r there as well.

See above.

Thanks.

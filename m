From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Tue, 24 Feb 2015 10:29:58 -0800
Message-ID: <xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>
References: <1424540906.15539.22.camel@scientia.net>
	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>
	<xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>
	<54EC98BD.7060100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 19:30:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQKFI-0004vd-JC
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 19:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbbBXSaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 13:30:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753263AbbBXSaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 13:30:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6718E3A0ED;
	Tue, 24 Feb 2015 13:30:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7u7AqFga0WPRr6xMO8iHBqXhexc=; b=qNwbbY
	HXpw4ePOyLY69S0G7SRT4ApKS4feBxiOs5v5GfGoDY6jPCSm6zlwbgs/7V/5V7df
	P9RGV4EXBj6F5KSH+GpLOd0SC7u41zpA8wE8nqg2y4VtlRBwS7Y/8TZ/qohoN6jp
	AJS14cUe4OSEqTwELoPpjRi39BXFrW42bEtXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ab/izW1LHm8wn8AKfH9r8pBZN7H0Pjyf
	MjLJsfl/9sIX7+jjNyp53XvHR4baGozE+b/xqQmIRi8opPLNJEw9AtviIfeVaReQ
	197M49MMtAcpzLHQcYdGrjVmsMzDp5qdrJIl9iEVEUJmhjmRBhcCfjUgT2Ya8sSr
	bO7L8CtqTEQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1333E3A0EC;
	Tue, 24 Feb 2015 13:30:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1D233A0EA;
	Tue, 24 Feb 2015 13:30:00 -0500 (EST)
In-Reply-To: <54EC98BD.7060100@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 24 Feb 2015 16:29:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 247E26B4-BC53-11E4-816B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264336>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Hmm, wouldn't it introduce a grave regression for users who
>> explicitly ask to clean crufty messages up (by setting their own
>> commit.cleanup configuration) if you unconditionally force
>> "--cleanup=verbatim" here?
>> 
>
> That's what I meant by possible side-effects below.
> ...
> But git cherry-pick without conflict should no re-cleanup the commit
> message either, should it?

Hmm, but if it does not, wouldn't that countermand the wish of the
user who explicitly asked to clean crufty messages up by setting
their own commit.cleanup configuration?

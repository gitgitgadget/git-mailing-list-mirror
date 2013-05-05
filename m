From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jn/config-ignore-inaccessible (Re: What's cooking in git.git (Apr 2013, #10; Mon, 29))
Date: Sat, 04 May 2013 20:55:39 -0700
Message-ID: <7vwqreull0.fsf@alter.siamese.dyndns.org>
References: <7vppxdgife.fsf@alter.siamese.dyndns.org>
	<87y5bvyw7j.fsf@hexa.v.cablecom.net>
	<20130504201414.GA2420@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 05 05:55:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYq3K-0004UT-Oa
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 05:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab3EEDzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 23:55:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab3EEDzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 23:55:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CBDFCB0;
	Sun,  5 May 2013 03:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r8A3nbfPkbqx+4+DWwwpj3p+Wvk=; b=Jqiz1V
	gdc7RjtgZbl8aNr1lYRljdyiLvUrTjKVZFdyCHaQiaeQTjfOnQV3WEkrFP5hxswA
	cdBmrl6pAiG0AKAFPQ/4JexMK74ugCXS9NJ1Tll5yMoS3wYi5QXfR8LuxXjBfWU9
	1otFxMxbKqt4T+zvN7/KtWl0viWINVEJ5H6Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9TibA6UGhdHyr4dDvManaO2Fs9mymIt
	k4yQUhu6aFKkhdwCmqL4GwPLdzbFY9shlTRDYNqK2PHNbFk1bcypsW8oMtZ1r8dq
	TCmDtr9pW/hafGLdrGMErJOdAQ6iZ43HYbn0Y4Mg2apTBA8v9IQ/vwR2e+KaSjeE
	IrtSudyBBPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF3CFFCAF;
	Sun,  5 May 2013 03:55:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42368FCAE;
	Sun,  5 May 2013 03:55:41 +0000 (UTC)
In-Reply-To: <20130504201414.GA2420@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 4 May 2013 13:14:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A783F7C0-B537-11E2-BC11-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223390>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>
>>> * jn/config-ignore-inaccessible (2013-04-15) 1 commit
>>>  - config: allow inaccessible configuration under $HOME
>>>
>>>  When $HOME is misconfigured to point at an unreadable directory, we
>>>  used to complain and die. This loosens the check.
>>>
>>>  I do not think we agreed that this is a good idea, though.
>>
>> As a data point: yesterday on IRC, two users complained that they each
>> had this problem.
>>
>>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3022
>>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3111
>
> I think the approach taken in the patch above is a good one.  If
> /etc/gitconfig contains important configuration, it is still not
> ignored, errors other than permissions reading ~/.gitconfig are
> still fatal, and permissions errors accessing ~/.gitconfig are no
> longer fatal because they are expected as something very common
> in normal setups.

OK.  Let's cook it in 'next' for a while and then decide what to do
post 1.8.3; I am perfectly fine with making it graduate to 'master'
immediately after 1.8.3 if everybody thinks this is a good idea.

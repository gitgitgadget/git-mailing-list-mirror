From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git add' option to non-interactively stage working tree changes
Date: Fri, 07 Jan 2011 12:44:24 -0800
Message-ID: <7vfwt45tqv.fsf@alter.siamese.dyndns.org>
References: <AANLkTimLKZnVn8Lr-E-8M8T5mXA55XabCT5rC+broeFJ@mail.gmail.com>
 <m2aajcbiei.fsf@igel.home>
 <AANLkTi=iwOGv3PzrRcVGDwwoTXmJ4CuC11vuYsjn4xxV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hrvoje =?utf-8?B?TmlrxaFpxIc=?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:45:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJBH-0000a5-FR
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab1AGUof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 15:44:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab1AGUoe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 15:44:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E78383D5F;
	Fri,  7 Jan 2011 15:45:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5w7c9wyKy/ZB
	0oh0dbjHVyXK160=; b=JouHgFiFRP28x3N4W7RlU3lQUVM/ksEdn24e0NR1kKdt
	jDjfNBuuDqTxA2cuPO9F6ieAIIBA+FTvqZji5JYk/5OIeBns7AXLwlHahvZ3lxhF
	+btd/HK+wfHCpkunKQshpmtsSHdZPs15S6w5RsQcJlPss48pofbZZQoiPscB1uY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HmQLa4
	MVv+pRnF1vCDugz1EF9Vrm7CB1vkuUgdj2Ip/vOdQy/48oDmiaXAY+HEfX9XsxUb
	YgXA1fkoFhaAzvQMAXkV84+7sHM1WjPaCl4LNX9PByOSiKyWhEMgtnQXaN4ZSN9I
	u6p7H3Jza0oSZ1iMrOowZKRyZMUr2Q7KuZYhY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4F4B3D5E;
	Fri,  7 Jan 2011 15:45:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E80D63D5D; Fri,  7 Jan 2011
 15:45:04 -0500 (EST)
In-Reply-To: <AANLkTi=iwOGv3PzrRcVGDwwoTXmJ4CuC11vuYsjn4xxV@mail.gmail.com>
 ("Hrvoje =?utf-8?B?TmlrxaFpxIciJ3M=?= message of "Fri\, 7 Jan 2011 21\:03\:21
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 033D089E-1A9F-11E0-8312-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164759>

Hrvoje Nik=C5=A1i=C4=87 <hniksic@gmail.com> writes:

> Thanks for the tip. I'll note that this is not exactly easy to
> discover, though, and it's quite some typing. Since git add -p and gi=
t
> add -i seem capable of determining the root themselves, maybe there
> should be a way to do the same for -u? Or even make it the default?

The general design principle when talking about an operation to build
towards the next commit is to limit the operation to the current workin=
g
directory when working from a subdirectory, so I would have to say that
what -p and -i do is wrong, but this is already a very well established
behaviour and there is no way to change the default (the same thing can=
 be
said for what -u does).

I think it might be Ok to introduce a --full-tree option to "git add" (=
and
"git grep"), though.  But introduction of corresponding configuration
variable to flip the default needs to be done carefully in steps across
major version boundaries as usual (i.e. first introduce --no-full-tree,
wait for 9 to 12 months to make sure scripts are updated, then start
honoring add.fullTree and grep.fullTree configuration variables).

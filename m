From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 5/7] submodule update: respect submodule.actionOnLabel
Date: Thu, 24 Mar 2016 14:14:12 -0700
Message-ID: <xmqq37rf8tp7.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-6-git-send-email-sbeller@google.com>
	<xmqq37rif870.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaEmDFDf+1BZV1C5ETswbXmAUYk_OMsZf_ka6tJ=pfwcQ@mail.gmail.com>
	<xmqqlh58bun7.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZCHv6z6zT2Q2MzMNXfGWcqk9uxsqQ-uEjAPw3h+cSjsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:14:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajCaD-0001To-9Z
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbcCXVOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:14:17 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751038AbcCXVOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:14:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA16F4E895;
	Thu, 24 Mar 2016 17:14:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gBe56fwn5c+jg/ROZTAhYNIdn0I=; b=iTfItS
	NlWu7RQ0H01DAzDJ5UpGf39YLZQpRlAKQp4onMqmjDDd89vEDrx1GtyB3VuPRfNb
	YDZN5pLOTq0BdFbpFOfRe3epTQOTLqA9aDp1pEzQf7OSkIQRWgOugv/6kM/kv+qV
	FCHTnwkeoN+e1QKFhKvH3UCqnjNWk+ZPnCqeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xC2Lz2QuuVbiiGJnUCndff5hywidmzg+
	Qk3YUoWMYxbKkhD7cMX/ruE8a3ySuC7TjbRcvQ0A0sNwmmXc7sb4vUnSexPpvRWF
	TbiMSWNvsDPtChwgIZp0bsFXaR3pXdzQmEawJCgDK55ajBV3RCe9YNljSfxsu2Q7
	unPE98M0dEw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1B334E894;
	Thu, 24 Mar 2016 17:14:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 492E24E893;
	Thu, 24 Mar 2016 17:14:14 -0400 (EDT)
In-Reply-To: <CAGZ79kZCHv6z6zT2Q2MzMNXfGWcqk9uxsqQ-uEjAPw3h+cSjsQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 24 Mar 2016 12:54:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C5E9B0C-F205-11E5-8C9C-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289801>

Stefan Beller <sbeller@google.com> writes:

> Maybe we can revive the term "group" and call it submodule.defaultGroup.
> The defaultGroup is defined by selection of names, paths and labels.

There are many ways to specify one or more of submodules:

 - By giving "pathspecs", you would choose submodules whose paths
   match them;

 - By giving one or more "names", you would choose the submodule
   with one of these names; or

 - By giving one or more "labels", you would choose submodules that
   have one of these labels.

It is perfectly fine to call the chosen set of submodules "group of
submodules".  It does not have any connotation on what is to be done
about the group, so that is probably the best word suggested so far
in the thread.

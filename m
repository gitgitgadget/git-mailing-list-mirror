From: Junio C Hamano <gitster@pobox.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Thu, 05 May 2016 14:41:43 -0700
Message-ID: <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
	<17E04501C9474282B87758C7998A1F5B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>, "Duy" <pclouds@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 05 23:41:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR1q-0003fN-Hk
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbcEEVlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:41:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756247AbcEEVlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3495918639;
	Thu,  5 May 2016 17:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cXyaSxlj8Dh+3VVK85adtYNqAfw=; b=p7JQ9F
	AzkQrg7V3WouHKOdGPM/B4byuthRXjQd2qMGnHcSKpnSsajGwn7Ljp2STWNdtBvK
	VPQCgC3T6I/qKImUju9LpydfoqIDYaMJY5eSaUJL10WPkGkf2vv+xMxBEFjDCodk
	dDGmxj5FkEA4JGvPha/uiMdgZG6BLkc0YoMw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ceMaEpmszuuhheGVMb8ft/6OA/ctrHlP
	OuGoo6ipEzMfsGLkLsdYaOzYdk8S3z/Bzf5Mpj57PUupnZk9ryGpP5tziT9IzRzZ
	ELC8uRkniM1ghTCz3ljC8D1Q3YFggWRgsUrptKnTsh+iPdEO9tQjY9nau/sYnYoo
	Wa1FgJZ7Mww=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1270D18637;
	Thu,  5 May 2016 17:41:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8782118632;
	Thu,  5 May 2016 17:41:44 -0400 (EDT)
In-Reply-To: <17E04501C9474282B87758C7998A1F5B@PhilipOakley> (Philip Oakley's
	message of "Thu, 5 May 2016 21:48:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2959585C-130A-11E6-BDD4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293685>

"Philip Oakley" <philipoakley@iee.org> writes:

>     int saved_namelen = saved_namelen; /* compiler workaround */
>
> Which then becomes an MSVC compile warning C4700: uninitialized local 
> variable.
>
> I'm wondering what was the compiler workaround being referred to? i.e. why 
> does it need that tweak? There's no mention of the reason in the commit 
> message.

That was a fairly well-known workaround for GCC that issues a false
warning that variable is used before initialized.  I thought we
stopped using it several years ago in new code after doing a bulk
sanitizing (I think the new recommended workaround was to initialise
such a variable to the nil value like '0' for integers).

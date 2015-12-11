From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] update-index: use enum for untracked cache options
Date: Fri, 11 Dec 2015 09:44:45 -0800
Message-ID: <xmqqio44g9rm.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
	<xmqq1tawlpqw.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3+gsHZuaBweP83or=rEh-LFnz6=ycBCeuhApxp0PzN1A@mail.gmail.com>
	<xmqqh9jqi1ky.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3AHMEZB+6Ajt8XSsecTp_PSxV_ZxFLbMAYgA3CDhPDng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 18:44:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7RkS-00031y-Nr
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 18:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbbLKRos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 12:44:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbbLKRor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 12:44:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42CC930905;
	Fri, 11 Dec 2015 12:44:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dhFQbs+fYVQScpCtTEviDOLdKd8=; b=dOhgPP
	gBJtZyNZebxoB3aZKq4cOgwzqbUj+iOMvKCrV5nGAnAVnP3SowaXLJfZ5UxXcxF1
	gUJ3pibd3dVqBGUe1G6r8PHpZWYBe/eeFshFBJv46z6oKG04t/tbKeFaP1Hux4el
	T6a0sHNRtMzH15LJx4vG509bOMhrK6t2srOWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfOA2n4ya304Mg8mQMz9M42R7AAQfqWI
	H0QwvQtZpS4Q9YQDJMU/i8E2qHZtyvuqWvQPtLEzBKBRMdzIXZOTDMhE7v1il0ER
	qZZq/Vvf0gNrQMrf4A0Z2L68SwLi6CT+oSQEowuRtbCVJFRdiPdZJN9s86vydJVv
	TE6M1t1Lynw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3919330904;
	Fri, 11 Dec 2015 12:44:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B01B30902;
	Fri, 11 Dec 2015 12:44:46 -0500 (EST)
In-Reply-To: <CAP8UFD3AHMEZB+6Ajt8XSsecTp_PSxV_ZxFLbMAYgA3CDhPDng@mail.gmail.com>
	(Christian Couder's message of "Fri, 11 Dec 2015 10:10:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE8810B4-A02E-11E5-A3AB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282264>

Christian Couder <christian.couder@gmail.com> writes:

>> As you know I am bad at bikeshedding; the only suggestion in the
>> above is to have common UC_ prefix ;-)  Don't take what follow UC_
>> as my suggestion.
>
> I am bad at finding names too, so I think what you wrote is pretty good.
>
> I thought about the following:
>
>      UC_UNDEF
>      UC_DISABLE
>      UC_ENABLE
>      UC_TEST
>      UC_FORCE
>
> but I am not sure it is much better.

I hated the DONTUSE/USE I listed, and I think DISABLE/ENABLE is much
much better.  I do prefer unspecified over undef, though.

Thanks.

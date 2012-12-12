From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] log: Add --use-mailmap option
Date: Wed, 12 Dec 2012 09:58:38 -0800
Message-ID: <7vd2yf5f01.fsf@alter.siamese.dyndns.org>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
 <1355264493-8298-6-git-send-email-apelisse@gmail.com>
 <CALWbr2xmRVS9m623yrxY88Ftaen_B8Tb2vd+VxhYV1ceAmbDSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Rich Midwinter <rich.midwinter@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:59:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiqaB-00026D-1U
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab2LLR6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:58:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab2LLR6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:58:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9712A206;
	Wed, 12 Dec 2012 12:58:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2B0fk04mTcerDtOvGEMwmVuTxPY=; b=FhZ9NJ
	ENVOQlFBZPcLN0vahfBnJcnsdL5n+JX2S0jvJxAEf50V0ttxem6iADxBgavf3JRU
	eJ4ZeVb7AVqu3fhgyhxaNDMnoJe6SUZcxbfVAMwQmp74zZEVDbwZjbcMauYNX68R
	F0I0Lqny/F6bmvVQpCzmPmbGuUACYj8+f6O20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i3No7/bYyB9+7hVFLif1Y3mNwJzSx5ni
	d9czNo7IxnJQDtEWAO8zLSLHAuXVqtn3ZN80aWY64Pt2QOwBpvJL+lC5h+ZXPzxW
	JLuofCtY9dRHcYcIptJ7iiXHmCOl+EYeW8CI0KZhZBS+ife5yJSMTZLCyKC3/D5G
	bl8zEFuR4rQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B805CA205;
	Wed, 12 Dec 2012 12:58:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37154A203; Wed, 12 Dec 2012
 12:58:40 -0500 (EST)
In-Reply-To: <CALWbr2xmRVS9m623yrxY88Ftaen_B8Tb2vd+VxhYV1ceAmbDSg@mail.gmail.com> (Antoine
 Pelisse's message of "Wed, 12 Dec 2012 12:58:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F6FA7E2-4485-11E2-BF5E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211375>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Tue, Dec 11, 2012 at 11:21 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> Add the --use-mailmap option to log commands. It allows
>> to display names from mailmap file when displaying logs,
>> whatever the format used.
>
> The question is which log commands actually ?
> Shouldn't we put the option in revision.c::handle_revision_opt instead ?

I was trying to avoid that to make it harder to trigger the
"feature" by mistake.  The rewriting with mailmap is for human
consumption and when we replay the history (e.g. format-patch used
as input for am or rebase), we should never be applying it.

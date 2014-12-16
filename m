From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 12:46:16 -0800
Message-ID: <xmqq7fxr9vc7.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-6-git-send-email-sbeller@google.com>
	<xmqqoar39y3l.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZnGKNTpRZndgG_CjAC9gqafGXoq8rFOWuHZkaqY_LK7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 21:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0z0h-0000Qy-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 21:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbaLPUqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 15:46:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbaLPUqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 15:46:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46E0D27DF3;
	Tue, 16 Dec 2014 15:46:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XaJQoi4T9OYuuVDaa/g41u972Vw=; b=aYatW+
	GXMyDJPVcAEjcxPZYLWst1cYk18MS/t3z+7AVcrgx4OIMqYe/CxbtBRsnV1o2CmG
	6APLz9XJf3wBP4/3+Co58eWOJtj6kgFlZ+647d6R8RnWBBN5Xkv+IYhUpNhHRl/5
	/nmt99XNUckCyvseNFrokg9mGbZ47FYSJmf2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=djkHr8KtFO2VAitNbVQoFtM9vXsp3bLu
	A84iKxFMboFt5GGU7+ETOiuRL7ZiccKx2PiMZN8ah3k/uHlvOcA4IvTDFdhidwNH
	jVF8+oatWCX2N/OJguvbQHQuYg4Wx7ptIZ1ggzQsETYt7VyRf4ciAD7tpNnVP+qH
	OK2leS1TsWM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AE3E27DF2;
	Tue, 16 Dec 2014 15:46:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B20E27DF1;
	Tue, 16 Dec 2014 15:46:19 -0500 (EST)
In-Reply-To: <CAGZ79kZnGKNTpRZndgG_CjAC9gqafGXoq8rFOWuHZkaqY_LK7w@mail.gmail.com>
	(Stefan Beller's message of "Tue, 16 Dec 2014 11:57:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 967A8BD4-8564-11E4-9239-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261470>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Dec 16, 2014 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>
>> Seeing that all callers of test_ref_upstream computes $2 as
>>
>>         git -C workbench rev-parse --verify <something>
>>
>
> Only in the first tests, where this should be the case after push.
> In the failure tests, we go with HEAD@{N} which needs to be computed
> inside the workbench repo.

Aren't we saying the same thing?  The suggested alternative is to do
the "git -C workbench rev-parse" bit inside the helper.

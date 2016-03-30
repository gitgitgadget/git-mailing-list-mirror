From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] pretty: expand tabs in indented logs to make things line up properly
Date: Wed, 30 Mar 2016 11:20:06 -0700
Message-ID: <xmqq7fgju8tl.fsf@gitster.mtv.corp.google.com>
References: <1458775426-2215-1-git-send-email-gitster@pobox.com>
	<1459293309-25195-1-git-send-email-gitster@pobox.com>
	<1459293309-25195-2-git-send-email-gitster@pobox.com>
	<CAPig+cTd_VRnikMzN7b2qfeG87M0v-4_qM42MkhOcRT54Wmv=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:20:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alKj8-0004Ez-2I
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbcC3SUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 14:20:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753201AbcC3SUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 14:20:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1F9150ED8;
	Wed, 30 Mar 2016 14:20:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pUFG46GDP+f6KtLcyL6zWqQIaD8=; b=VQsHOb
	9nksMJwDDbFWUKcBxbqcBo9DDSYR1wISeoAq7LL8wolCyZWsoQAOzgqrRiaztNs6
	NC0Sebi4tCspa8aKnUW05kL82aJdU3tMb14y+b1Bmo5PWsLmO9ST3M5LPd6/LvcN
	7CGzkeEdlAwz5tKqJuBHk5siEbrIsaqyxLF3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWISw0VsL6vZNzWEHxpP09/U49Lh69n/
	9JGH/lj0eQPwTkI3HrekBh9NrhBS4VRq4yl2EFWAGhIoePLrW3BxUVz+PwVwW8GU
	d3A+yAZtVHbOjGOS4nY5fDKpzQn7fIy3LCzKtRH6TwPF3ZJd79P3ngMIhmUQ15fl
	LZroS5Be1FI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98A8850ED7;
	Wed, 30 Mar 2016 14:20:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0818050ED6;
	Wed, 30 Mar 2016 14:20:07 -0400 (EDT)
In-Reply-To: <CAPig+cTd_VRnikMzN7b2qfeG87M0v-4_qM42MkhOcRT54Wmv=Q@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 29 Mar 2016 20:17:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08637F92-F6A4-11E5-8C2F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290335>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 29, 2016 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> A commit log message sometimes tries to line things up using tabs,
>> assuming fixed-width font with the standard 8-place tab settings.
>> Viewing such a commit however does not work well in "git log", as
>> we indent the lines by prefixing 4 spaces in front of them.
>> [...]
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
>> @@ -42,6 +42,12 @@ people using 80-column terminals.
>> +--expand-tabs::
>> +       Perform a tab expansion (replace each tab with enough number
>> +       of spaces to fill to the next display column that is
>
> Nit: "enough spaces" or "a sufficient number of spaces".

Thanks, will be part of a reroll (when it happens ;-).

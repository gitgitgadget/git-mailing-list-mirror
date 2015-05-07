From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/12] t7406: use "git pull" instead of "git pull --rebase"
Date: Thu, 07 May 2015 13:15:40 -0700
Message-ID: <xmqqpp6cnnyr.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-10-git-send-email-pyokagan@gmail.com>
	<xmqqfv78qp13.fsf@gitster.dls.corp.google.com>
	<CACRoPnQ3zYsv63pNUtasS6y2HnWMYqwssF=yFA3OHVvF2Yb5Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Peter Hutterer <peter.hutterer@who-t.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 22:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqSCx-00006G-JE
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 22:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbbEGUPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 16:15:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121AbbEGUPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 16:15:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B80BE4FB76;
	Thu,  7 May 2015 16:15:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cp3Mu8sCzCpBVHM93AuKnmP2yXE=; b=RX7aC/
	VCa8+jW9PPsPHiyyazWOY51NkcGywzfQhMvh6rC2yddW9roIX2fS/AKYzbxvFbLZ
	bXHS803VzlBsv9GlpfgMCTt0VG48rJHR7PRIs20i271oGOa52ql5MJsNwoiDO98O
	S3PMbns4AOywQ/ZCsHDhX/XLvWTrBlYlujjtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VE6RDbcY/yYf4lwrcNP21Gb8W4ZItUCC
	+sYym5ccW5cLfGOZ+Oad2niPDudcjY+yLGD1NdamQqpoz0Ukneb/YvIJUhgpVwHv
	0z4D+6ILGAGd4taPqwR02yDcdprZ7rhznnA7JSptJbfZ3uA3dttF4mfrwAvb/ZK3
	n7EjDeQLaEk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4EE24FB75;
	Thu,  7 May 2015 16:15:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 144224FB72;
	Thu,  7 May 2015 16:15:41 -0400 (EDT)
In-Reply-To: <CACRoPnQ3zYsv63pNUtasS6y2HnWMYqwssF=yFA3OHVvF2Yb5Sw@mail.gmail.com>
	(Paul Tan's message of "Fri, 8 May 2015 02:17:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D55B3D52-F4F5-11E4-A6AD-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268584>

Paul Tan <pyokagan@gmail.com> writes:

> Hi,
>
> On Fri, May 8, 2015 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Paul Tan <pyokagan@gmail.com> writes:
>> If 'git pull' gets broken, it will break this test _anyway_.
>
> You have a point, perhaps this should be changed to git-fetch + git-merge?
>
> Well my reasoning is that it's because git-pull --rebase requires more
> code to be implemented than git-pull. So I'm thinking that git-pull
> --rebase is more likely to break than git-pull.
>
>> Unless
>> the operating assumption is "it is OK to break 'git pull --rebase',
>> as long as we do not break 'git pull', while rewriting it", I am not
>> sure the value of the change in this patch.  We'd need to keep both
>> form working, no?
>
> Yes, ultimately the git-pull rewrite must re-implement everything, but
> if this test suite is affected by any git-pull (--rebase) breakage,
> then there will be lots of patch noise as this test suite's tests get
> disabled/re-enabled in the git-pull rewrite patches.
>
> But if the patch noise is okay, then I'm fine with dropping this patch
> and 07/12.

I am not sure what you mean by "patch noise".

I do not think touching this test which does not have anything to do
with "git pull" in your series is sensible at all, and you shouldn't
flip test_expect_success temporarily to _expect_failure, if that is
what you have in mind.

Just don't run unrelated tests while your series is in flux.

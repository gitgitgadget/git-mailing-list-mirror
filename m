From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Tue, 14 Jun 2016 00:21:56 +0200
Message-ID: <e48890a0-06cb-4ea7-d168-d1df1f4c2e37@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160607140148.23242-2-tom.russello@grenoble-inp.org>
 <xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
 <f34e3636-ce71-8352-259d-9f723d63e2a8@grenoble-inp.org>
 <xmqqvb1jmzly.fsf@gitster.mtv.corp.google.com>
 <3090c61c-533b-7119-f5e4-7d99e62f6da4@grenoble-inp.org>
 <vpqbn3ayk79.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, e@80x24.org, aaron@schrab.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:22:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCaFA-0004xQ-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbcFMWWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:22:00 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:40720 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161258AbcFMWV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:21:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C359125BE;
	Tue, 14 Jun 2016 00:21:57 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcX4E8ocX-XJ; Tue, 14 Jun 2016 00:21:57 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B2E4725A0;
	Tue, 14 Jun 2016 00:21:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id A8B302066;
	Tue, 14 Jun 2016 00:21:57 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ayl70lHpQww5; Tue, 14 Jun 2016 00:21:57 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 565872064;
	Tue, 14 Jun 2016 00:21:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <vpqbn3ayk79.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297253>

On 06/09/2016 08:01 AM, Matthieu Moy wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> On 06/08/2016 06:09 PM, Junio C Hamano wrote:
>>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>>
>>>> Actually we had issues when trying to refactor send-email's email
>>>> parsing loop [1]. Email addresses in output file `commandeline1` in
>>>> tests weren't sorted the same way as the reference file it was
>>>> compared to. E.g.:
>>>>
>>>>   !nobody@example.com!
>>>>   !author@example.com!
>>>>   !one@example.com!
>>>>   !two@example.com!
>>>
>>> And the reason why these addresses that are collected from the same
>>> input (i.e. command line, existing e-mail fields, footers, etc.) are
>>> shown in different order in your implementation is...?
>>
>> It's not shown in different order in our implementation, it's just a
>> leftover of my refactor attempt [1].
>
> I think the refactoring makes sense, but having this patch as PATCH 1/6
> in a series about --in-reply-to confuses reviewers: they would expect
> this patch to be useful to the others in the series.
>
> If you have "reply to a message in a file" ready without the
> refactoring, and a mostly ready refactoring, then I think it makes sense
> to have two patch series, the first being only "reply to a message in a
> file". If the refactoring itself is not ready, you may send a separate
> series "tests clean up" and explain on the cover-letter that it's, well,
> only a test clean up.

I think I will split the patch series into 3 smaller series:
- "quote-email" feature
- tests clean up
- send-email code cleanup (including send-email's output)

From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: aborted 'git fetch' leaves workspace unusable
Date: Thu, 02 Jan 2014 21:28:17 -0600
Message-ID: <85iou13fse.fsf@stephe-leake.org>
References: <32eeea08963ec4438f97ff9ef6553a75@stephe-leake.org>
	<xmqqbnzuqmqe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 03 04:28:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyvQz-0001Ee-Rs
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 04:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbaACD2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 22:28:25 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:29049 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751521AbaACD2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jan 2014 22:28:24 -0500
Received: from [75.87.81.6] ([75.87.81.6:51932] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 3D/E7-08839-55E26C25; Fri, 03 Jan 2014 03:28:21 +0000
In-Reply-To: <xmqqbnzuqmqe.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 02 Jan 2014 10:09:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239903>

Junio C Hamano <gitster@pobox.com> writes:

> stephen_leake@stephe-leake.org writes:
>
>> However, in this case, even running the fetch was a mistake; I would
>> have prefered that it leave FETCH_HEAD in its previous state.
>
> I think the clearing of leftover FETCH_HEAD is one of the early
> things "git fetch" does, unless "--append" is in effect.  I haven't
> looked at the code for a long time, but it may be possible to move
> the logic of doing so around so that this clearing is done as lazily
> as possible.
>
> I however suspect that such a change may have fallouts on other
> people who are writing tools like yours; they may be depending on
> seeing FETCH_HEAD cleared after a failed fetch, and be surprised to
> see a stale contents after they (attempt to) run "git fetch" in it.
>
> So it is not so clear if it is a good thing to change the behaviour
> of "git fetch" not to touch FETCH_HEAD upon a failure.

Ok; backwards compatibility is important.

Perhaps FETCH_HEAD could be copied to FETCH_HEAD_prev or some such, to
allow recovering in an error case?

-- 
-- Stephe

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR"
Date: Mon, 21 Dec 2015 10:31:28 -0800
Message-ID: <xmqqtwnbfybj.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
	<1450693372-6863-1-git-send-email-pclouds@gmail.com>
	<xmqqegefhftq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 19:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB5FE-0003G2-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 19:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbLUSbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2015 13:31:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751459AbbLUSbb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2015 13:31:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E8D4320BE;
	Mon, 21 Dec 2015 13:31:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hYReMqDFPAnb
	IXkyhot2KWlWWPs=; b=R7E58esYMY/rtrmTHo80PDOltJ1bAu9FJVIwEPRPpFD+
	drWiZr2BT7AnMxk2Zgc48DGnsYFPRcVCBMi6O5rnzMtqdPEoN2MDXuRdRlU2Wd4Q
	fhVBJb9WzUbOvIQAGCe10N3DkPCfUL/ncD0aVixVVrYBuyS0b7QfLSwL0cBo1fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gGCyM+
	s8411etwA+LG7Q6Ll0otEeryL2L00XqICfdKeu3/UKxO4SP9QEj0EFoO+3jfa4ul
	lbE5Du3viKw4NurCb7M4sXWVJVAGzBmVOu4zcOlCNX4/4SpLlIx30hpeOevjKLTf
	SyAfgxeC7d3yQ+8PyPQBcM75p2qe7CA1NKECc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 766EB320BD;
	Mon, 21 Dec 2015 13:31:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFA5A320BC;
	Mon, 21 Dec 2015 13:31:29 -0500 (EST)
In-Reply-To: <xmqqegefhftq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Dec 2015 09:28:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D83CE82-A811-11E5-A7B4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282808>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This commit has caused three regression reports so far. All of them =
are
>> about spawning git subprocesses, where the new presence of GIT_WORK_=
TREE
>> either changes command behaviour (git-init or git-clone), or how
>> repo/worktree is detected (from aliases), with or without $GIT_DIR.
>> The original bug will be re-fixed another way.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  On Thu, Dec 3, 2015 at 12:09 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>  > OK, when/if you decide that our first step should be a revert of
>>  > d95138e please send in a patch to do so with a brief write-up of =
a
>>  > follow-up plan.
>>
>>  Three reports to me are enough. And I obviously could not push the
>>  fix out fast enough. So if you want to revert it, here's the patch =
on
>>  maint.

Also, can you reference these three reports for future reference?

Thanks.

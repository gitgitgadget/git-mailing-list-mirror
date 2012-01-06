From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Fri, 06 Jan 2012 10:53:20 -0800
Message-ID: <7vboqgll27.fsf@alter.siamese.dyndns.org>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de>
 <7vsjjwvdyl.fsf@alter.siamese.dyndns.org> <4F037CBF.9010005@web.de>
 <7vhb0csa6w.fsf@alter.siamese.dyndns.org> <4F0629C6.9010908@web.de>
 <7vlipllmfh.fsf@alter.siamese.dyndns.org>
 <CABURp0rFOFfX7eu-v6ZK07iTfXwhOne60d70GkCdOvx0k8BZkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 19:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjEuv-0004rA-Fm
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 19:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab2AFSxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 13:53:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab2AFSxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 13:53:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CDF451DD;
	Fri,  6 Jan 2012 13:53:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oP8xEVRXuFOcSSZmuOUg+2jp1DA=; b=wp6bCF
	N8DuN9PzHuVqHXMsDTTGKrFMamt864u6vUo8a6iCudgWLnRRbvnQdrNDrZPyQJHk
	wCRr8u8x/99BB3C7hLg/10qlZ7ekvRqNbFpv/UPsGDWbbfdaiLqosEo+eVOYn1ok
	ZwdgMAA0+EadbsYeB62dE7PZwWVbbI6PF/ulc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e3K0jOgQ+gfcr8oDItFDcZ0CueeBPMRI
	Wg7Y7T2mICjvsNhQSym6g2ZvCe7UShVGqJ/Q82dPFa7UNpNrzbMfz8XWXUOo8Rav
	Xka5AWeWDQeyUz/U++6lWHifmxAEPclvZq/ob/YejapYfBb/m2XZ1bMVreqsCsnV
	ln+nzG7bq2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 245D751DB;
	Fri,  6 Jan 2012 13:53:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADC8451DA; Fri,  6 Jan 2012
 13:53:21 -0500 (EST)
In-Reply-To: <CABURp0rFOFfX7eu-v6ZK07iTfXwhOne60d70GkCdOvx0k8BZkQ@mail.gmail.com> (Phil
 Hord's message of "Fri, 6 Jan 2012 09:26:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B47E9B24-3897-11E1-812E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188038>

Phil Hord <phil.hord@gmail.com> writes:

> On Thu, Jan 5, 2012 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>> If not I'm fine with just setting core.worktree to a relative path in
>>> the git-submodule.sh script (like I did for the gitfile). And I'll look
>>> into teaching "git mv" about submodules right after that.
>>
>> ... teaching "git mv" may be a good move, I would think. I do think keeping
>> core.worktree pointing at the right directory is necessary, but I do not
>> see much point in making it a relative path, though.
>
> I do, in the case of submodules, as already discussed.

Of course you are right.

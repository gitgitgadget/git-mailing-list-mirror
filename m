From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Mon, 03 Jun 2013 10:40:09 -0700
Message-ID: <7va9n7gkjq.fsf@alter.siamese.dyndns.org>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
	<51AB86BB.3080203@lsrfire.ath.cx>
	<CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com>
	<51ABAA84.8090301@lsrfire.ath.cx>
	<CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
	<51ABD00C.7080503@lsrfire.ath.cx>
	<CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com>
	<51ABD99A.2030303@lsrfire.ath.cx>
	<CAMP44s2HotyK7hh0nFjCe+BBtu1pyqmkn6=yt9WV6UyhxjrXoQ@mail.gmail.com>
	<51ACBD68.4070506@lsrfire.ath.cx>
	<CAMP44s09s26Gyvqu___cQg2LsUnMrzZAa0pbUnGp85fDUEeapg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYjx-0003Hn-VB
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076Ab3FCRkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:40:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663Ab3FCRkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:40:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A94C224A13;
	Mon,  3 Jun 2013 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RxEaM90gstsVH/sEHk2BZ3mh09U=; b=vYjA7P
	HP4+bnkxkWAbvWdw0MEuuZI+qei4GvCaDbdysiUF3ynJdkZPAi92sW3ByaUyqu/p
	LjSw76wab3bWhYXHvVRainLoy7EtBBr3NzLV7PIoaoRTLDmBOrvYefmD2M7YV/Y5
	DY1X3WD8n1WicX1ZqNcRmlQb2j1FhJRlgGxa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WDWjw13bb0hhDtqnc9rNVzcyADPGjuLt
	G7X/W7oFAaONqPbzAcrHJqnqubkTamQC5gTfB+hzH9tVVx5sTmEbMcpaU90yeNmV
	vfwP5eIFDKBtwUQudBvyii7svbZ2VHAgpFEfNOb613IWFy0loZs6gde/VKURSYr3
	YTRFSIjewCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A011424A12;
	Mon,  3 Jun 2013 17:40:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27EDD24A0E;
	Mon,  3 Jun 2013 17:40:11 +0000 (UTC)
In-Reply-To: <CAMP44s09s26Gyvqu___cQg2LsUnMrzZAa0pbUnGp85fDUEeapg@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 3 Jun 2013 11:10:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3D956B6-CC74-11E2-B1B3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226247>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I don't see that, and I don't like adding a check that I don't expect to be
>> ever needed.
>
> It's called self-documenting code; by adding a check for the NULL
> pointer, we are stating that ce can be NULL, if we don't do that,
> people reading that code would need to figure that out themselves.

People following the codepath to unpack_nondirectories() already
have seen enough to know what src[] means and very well know what
NULL in it means.  The only people possibly confused are those who
do not know free(NULL) is safe, isn't it?

Honestly speaking, I do not want such people to be touching this
part of the system.

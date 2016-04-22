From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] format-patch: introduce --base=auto option
Date: Fri, 22 Apr 2016 14:54:16 -0700
Message-ID: <xmqqk2jpnwc7.fsf@gitster.mtv.corp.google.com>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
	<1461303756-25975-4-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 23:54:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj1v-0002dz-P9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbcDVVyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:54:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753102AbcDVVyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:54:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DD98163FB;
	Fri, 22 Apr 2016 17:54:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yZuWeC3CnDd+nlbSeQRUUD2MUB4=; b=xPEgTb
	zJ24H38WsmtFDJY1vAyNooMuHPSQOHXiXBXgP5vgmiE6cbgDT0qkRWGdETBH34eV
	w6oM0OlXVaU1achrysDc066DddumjYbEORNufB/s4QATY2ZZn0NRQC57uDd9+qcB
	6HBTX9A8J5kXg9MkDYPRSw8Kvl/2Lea4YI8X8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hKFk+LLbcmjWxBbXJCMKNZ3xQ+MIyvf0
	TjZD5NQmMAlwjh/+4IA3HBS6zuZwpuwRa4mY9jk+X5oroOZfWhxYcdsfMBHrSIH7
	JyJV+5YX28Ugw/Ny3dfHO1uTMJvooZGZ/7ahNXSlT/lMjFeYom8IpAP1sFT5+ftk
	XjMACjZZ8JM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E36163FA;
	Fri, 22 Apr 2016 17:54:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D1C7163F9;
	Fri, 22 Apr 2016 17:54:17 -0400 (EDT)
In-Reply-To: <1461303756-25975-4-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Fri, 22 Apr 2016 13:42:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2D983DE-08D4-11E6-AFEB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292274>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> +		if (upstream) {
> +			unsigned char sha1[20];
> +			if (get_sha1(upstream, sha1))
> +				die(_("Failed to resolve '%s' as a valid ref."), upstream);
> +			struct commit *commit = lookup_commit_or_die(sha1, "upstream base");
> +			struct commit_list *base_list = get_merge_bases_many(commit, total, list);

This introduces decl-after-statement.

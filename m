From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Mon, 06 Dec 2010 22:28:53 -0800
Message-ID: <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 07:29:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPr30-0004Nb-2w
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 07:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab0LGG3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 01:29:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab0LGG3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 01:29:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C1E4D30F6;
	Tue,  7 Dec 2010 01:29:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Qh2ThcnBQwmrHxj+5Ps7mqTlmM=; b=OsKS5B
	h4roLW/9w5tAFRD3V6Bn7aYbCg8j35hYEjekJ4MTUrPjt9W0YLSN/BvxbXAJ92mW
	5AktrRwETry4R731W66Y/VDItnXDh2nRc7y7odhWIVeqyeGbdwiKVeyOFd57/82Y
	ZSctdwd6wAdiKpV6WFTQIpOIFytEz6CwGzc0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oNKhiUPNv4dn1kfPT/K9m2sjBO4qE70L
	qO/ATnZBVXIXhmtRmW32Md+f+bwIgwwuxTiH9mIL8KgJoKygk68zqEaeLatnMC6D
	MzzqShpZpu3QbCmhmk4DCR5T8ETcBJ14qiwuvvd4b8dAceUNtJQtzUn6S2+ioXHJ
	8Fqii7tYo5A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B7FF30F5;
	Tue,  7 Dec 2010 01:29:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A349930F4; Tue,  7 Dec 2010
 01:29:16 -0500 (EST)
In-Reply-To: <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 7 Dec 2010 08\:18\:28 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5289E634-01CB-11E0-AABC-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163068>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Dec 7, 2010 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +#define BRANCH_DELETION_LOG "DELETED-REFS"
>> +
>
> Should this special log be mentioned in git-update-ref.txt or
> gitrepository-layout.txt?

Perhaps, but I wasn't sure if this patch itself is a good idea to begin
with.  Not the problem it tries to solve, but its approach.

For example, this cannot be shown with "reflog show" or "log -g" due to
the way these frontends locate the reflog file to read (the logic wants to
have an underlying ref).

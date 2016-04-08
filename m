From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: allow --no-patch to disable patch output
Date: Fri, 08 Apr 2016 11:30:15 -0700
Message-ID: <xmqqh9fcvtqg.fsf@gitster.mtv.corp.google.com>
References: <1460047599-9267-1-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cRNCwFmGW-Zo+osjceA6nb=6t3+rJ2uEbnyYxGfSWQ-Uw@mail.gmail.com>
	<CA+P7+xoUi5H19zOCAiiwQZ0-j8yNZS9-2DzgoMmLSVOrC8Nbpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:30:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aobAz-0005DZ-87
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 20:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743AbcDHSaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 14:30:20 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753725AbcDHSaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 14:30:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 633B452F25;
	Fri,  8 Apr 2016 14:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7vjN+UneWuE+fdgAwUFXcaLMAbU=; b=cKBAGo
	7y3RjqfeCuVI/FDntnv14MI0+zGsqXcFePbSRQshrxio8vJBCGhN1Zl7IOUIcAxH
	n6CScO97GyaZelf3MLE8FixmKEdeza7RfWUqYBPzYEfdLlir3+ksVcp53MgZSbGb
	9SqRn8gfRLPYRj5DPlZrH7fOf419Xn0l50uQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aq8TJaa+WW5gt4H8o3JIp/maGOiY1wwZ
	8az+MeQ6x/0ckd2W1fsx9tIB1MNVhMbrzMW0yuhmivFevTRp0P4u9vLp64CpqwG7
	cdx90NICaxQhucCq8vqqewM/ujBXvpPG+V4EPPtfGz1n0BvIOfbqhqcM1Ijna16B
	SxHDFAEbCow=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A69552F24;
	Fri,  8 Apr 2016 14:30:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD21952F23;
	Fri,  8 Apr 2016 14:30:16 -0400 (EDT)
In-Reply-To: <CA+P7+xoUi5H19zOCAiiwQZ0-j8yNZS9-2DzgoMmLSVOrC8Nbpw@mail.gmail.com>
	(Jacob Keller's message of "Fri, 8 Apr 2016 11:17:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0FBEEF0-FDB7-11E5-864C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291050>

Jacob Keller <jacob.keller@gmail.com> writes:

> So if I want to get the summary of a patch out of a commit without the
> actual diff what would you suggest?

"git log --stat"?

If you have a set of (discrete) commits, "git show --stat A B C"?

> Basically, I have a process where we have post processed code, and I
> want to be able to generate a "patch" that shows the diff only of the
> post-processed code, ie:

If you want to script and depend on the exact output, you cannot
depend on "log" or "show", so you would likely be doing "cat-file
commit" for log message part and "diff-tree" (with options like -p
and --stat) for the patch part, I guess.

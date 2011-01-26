From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git: patch does not apply
Date: Wed, 26 Jan 2011 09:43:35 -0800
Message-ID: <7vei7zlfw8.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=ujfX53PXsfQXKf+1d5WQP=zMtzhKG-PSzT2_s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 18:43:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi9PK-0004xA-Do
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 18:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab1AZRno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 12:43:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab1AZRnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 12:43:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 461873D01;
	Wed, 26 Jan 2011 12:44:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x9RcXBoWxapMI7ApGBJdPWmxNY0=; b=ivItBM
	o/RZNy1C3kQMskGNq0WQQydEGpi17WaOThx1RCRwi9FLNQXuHq+Aqz4xsXoUhPDH
	HimbYdg+FzTW04nlM3ko3v3jRWW8Mta48M9O4GqtLoz834XZDeaNAAAzt2uQGDC3
	QklXtJux4o4L4Zb6MmxvrpuS/DxE2k0X3q1MU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TrtDLy1fpEeWLJLqCghiCOWruHZwRXvf
	bxvgtUUHwT9VG7oWXaVOU8OgaCXR64/k/gtMiQWZZTJb0v58P6BEOTkE8Muhf7KQ
	6nSDRqz1BiifbsxOxbXcxiA7a2C/JX8Qsrbapk1Be3IInHvDjmh3KlY32TuuX2tm
	s5On1jIcumA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 258413D00;
	Wed, 26 Jan 2011 12:44:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D8FA3CFF; Wed, 26 Jan 2011
 12:44:25 -0500 (EST)
In-Reply-To: <AANLkTi=ujfX53PXsfQXKf+1d5WQP=zMtzhKG-PSzT2_s@mail.gmail.com>
 (Dmitri Pissarenko's message of "Wed\, 26 Jan 2011 13\:41\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECB2384A-2973-11E0-8CDB-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165525>

Dmitri Pissarenko <dmitri.pissarenko@gmail.com> writes:

> When I try to apply it, I get following message:
>
> $ git apply --check my_pcc_branch.patch
> warning: src/main/java/.../AbstractedPanel.java has type 100644, expected 100755

Whoever prepared the patch started off of the version of the file with
executable bit dropped, while you still have a version with executable
bit.  This is a warning and is not a cause for the patch not applying.

> error: patch failed: src/main/java/.../AbstractedPanel.java:13
> error: src/main/java/.../AbstractedPanel.java: patch does not apply

The tool looked at around line 13 of the APanel.java file because the
input, my_pcc_branch.patch, wanted to change things around there, but
couldn't find corresponding preimage.

> What does it mean?

That is what it means.

> How can I fix this problem?

Look at the patch (find lines that perhaps begin with "@@ -13,something"
after "diff --git a/...APanel.java b/...APanel.java" appears), look at the
APanel.java file at around line 13, and see how they differ.  Discern what
the patch wanted to do, and make a corresponding edit to ...APanel.java
file.

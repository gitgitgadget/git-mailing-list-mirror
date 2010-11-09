From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 02/10] test-lib: introduce test_line_count to measure
 files
Date: Tue, 09 Nov 2010 14:56:40 -0800
Message-ID: <7veiaukswn.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino> <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino> <20101031073350.GC11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 23:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFx7d-0008JK-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510Ab0KIW4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 17:56:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab0KIW4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 17:56:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A80B3472;
	Tue,  9 Nov 2010 17:56:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=odKkjbB3bsf7Bl4BWlXwuMzajHk=; b=PVXA0+g+NwAmuspst8uEeSA
	UpapM9+kRDeEsTwzJWvz/LeqDifRri/D+qdStf1ueugSyLdRrIyO2i1tnb0rX0R2
	011AdJAjBwQ9OHdyDvnI8eIh7H5F+pQkxJY8+AaQTkpOB6+dHxMaLYR4ofJ9afYW
	x6upsT5u13FhMW+wZ0QY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eaQAfkHJfGDDYM+MPpJp77qylVa3XMyg7ECbDGxvSNTooMi+9
	RasJU0CHPNNCXnTgCtkIUwA3JzHgfZWHTK/rrC02mxX29U+kHmgFSDUvyBHLamzJ
	qQERrAT0kH5Yz/1ho5KTVkHuPTFAt/8FvFKY9eFtccD5eUmtLQFOrbeqO8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF585346F;
	Tue,  9 Nov 2010 17:56:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 85A1D346E; Tue,  9 Nov 2010
 17:56:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A416362E-EC54-11DF-AA76-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161107>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Introduce a test_line_count function to help. If used like
>
> 	git ls-files -u B >output &&
> 	test_line_count -eq 3 output
>
> it will produce output like
>
> 	test_line_count: line count for output !-eq 3
> 	100644 b023018cabc396e7692c70bbf5784a93d3f738ab 2	hi.c
> 	100644 45b983be36b73c0788dc9cbcb76cbb80fc7bb057 3	hi.c
>
> on failure.

Sounds like a sane thing to do.

Especially because you wrote the implementation without surrounding dq
pair, the callers can say "test_line_count = $N $file" instead of -eq and
things will not break.  Nice.

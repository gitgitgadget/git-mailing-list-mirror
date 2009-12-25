From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] Report exec errors from run-command
Date: Thu, 24 Dec 2009 23:46:58 -0800
Message-ID: <7vhbrfebrh.fsf@alter.siamese.dyndns.org>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vr5qjecbb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 08:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO4tI-0005rK-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 08:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbZLYHrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 02:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZLYHrK
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 02:47:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbZLYHrH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 02:47:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 919DEA9E33;
	Fri, 25 Dec 2009 02:47:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iI+HiG2bL4CsWypzqMsmclf/1iU=; b=bTWU+w
	H0V8QUFJTuwNgaQxixrrz/gE57h4IlCsU0Q/nXzTb9fVkilLAew0wBdpYubGLi1k
	c5c1nIK2AS8vprPPZwuB27ztnPATwtpMEUbuurZOt3rs99LJ/6W7HbjWWLAzDrhU
	Vbvu1iOlbEJxf8PyiJBySFmTvkzZW3RH1KcKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mC3Y5BEYeoLQBWsZf+uYXB/wJrtepWy3
	3j4QN1iyfuyA7+2bcLabZdi+vukhhXADF9mdTZQQOTEsbIaQC80/PesatXUtIt+A
	1UhRfJDAwmMOehJLO1AgY9c6MduKQwpia/Q/+r//YM6ih/Ef4L4TTtbX28aLehld
	9FjAetrraT4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68B3DA9E32;
	Fri, 25 Dec 2009 02:47:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C309A9E31; Fri, 25 Dec 2009
 02:47:00 -0500 (EST)
In-Reply-To: <7vr5qjecbb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 24 Dec 2009 23\:35\:04 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B19FF982-F129-11DE-9F0C-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135667>

Junio C Hamano <gitster@pobox.com> writes:

> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
>
>> Previously run-command was unable to report errors happening in exec
>> call. Change it to pass errno from failed exec to errno value at
>> return.
>>
>> The errno value passing can be done by opening close-on-exec pipe and
>> piping the error code through in case of failure. In case of success,
>> close-on-exec closes the pipe on successful exec and parent process
>> gets end of file on read.
>
> Thanks; I think overall this is a good idea, even though I have no clue
> if WIN32 side wants a similar support.

By the way, at least it should be pretty straightforward to add a test or
two for [1/2] if not [2/2].

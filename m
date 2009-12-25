From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] Report exec errors from run-command
Date: Fri, 25 Dec 2009 00:40:11 -0800
Message-ID: <7vd423e9as.fsf@alter.siamese.dyndns.org>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vr5qjecbb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 25 09:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO5mD-0002kZ-Ft
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 09:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbZLYIkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 03:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZLYIkV
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 03:40:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbZLYIkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 03:40:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D498DAA032;
	Fri, 25 Dec 2009 03:40:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bEC+pG8zXZYdr6vsJ4bTlpbZXVs=; b=tqXLjT
	RbpScuVeVZPux7fU/Pa2pb5DN5VYqO9oXpoq3H4viHSgevMwV5eSIOLiwT22w9X7
	qMXcj9uNkRK6SHLTYsqeBT8K7YVdZuIqMd4tKL9zPaYxu0hthjGxuSBTI/xqet2w
	0j6RoUx2+/vrRfyWvllZTUdy7uB/3lo7KggcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sgGbirPhFxmyqefqIEWH0pzaykGy2AzO
	9gSpxUVH6ymRymJ9qtuvn0OMNjQRdXjSct1qtCyUE4Ok1E3IUNfwqW7bSGtBcddc
	jvFJJ4lAKBJRv5PLFzxoxT1tIgHuo6zWTN44ICHBO+BuQ+4iouZwT5GoC6ASGSk3
	Kp2nrb+8hgA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1F5CAA031;
	Fri, 25 Dec 2009 03:40:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DA868AA02A; Fri, 25 Dec 2009
 03:40:12 -0500 (EST)
In-Reply-To: <7vr5qjecbb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 24 Dec 2009 23\:35\:04 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FCC14AC-F131-11DE-AC95-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135668>

Junio C Hamano <gitster@pobox.com> writes:

>  - At first reading, the "while (close(fd) < 0 && errno != EBADF);"
>    pattern was a bit of eyesore.  It might be worth factoring that out to
>    a small static helper function that a smart compiler would
>    automatically inline (or mark it as a static inline).

This also is a minor style thing, but we prefer your

>>+		while(close(report_pipe[1]) < 0 && errno != EBADF);

formatted like this:

	while (foobar)
        	; /* noop */

to

 (1) have SP after syntactic keyword like while/if/switch to differentiate
     from function calls; and 

 (2) make the no-op stand out for a bit more visibility.

 

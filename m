From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/19] completion: use bash builtins to search for
 repository
Date: Wed, 09 May 2012 12:52:49 -0700
Message-ID: <7v62c5rv1q.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-11-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 21:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSCwT-0001s2-SU
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760920Ab2EITwx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 15:52:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab2EITww convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 15:52:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF2718C12;
	Wed,  9 May 2012 15:52:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HayeTCtp8kAA
	iHYjWwzTM2rQNSE=; b=E2wv71x72z/U2rw5YpIS1M8LeurcLRYG86EfO6l4jfvi
	fHomMweKqnDnKoxOfsCPNypV1k6CJxjWy9Xfmi6XzzqfLnl13vveBTeVW29Fouku
	UA0FBEj0kwnBUxGYorL51KbVw159jLMvy4s8oU5mm4RN2tI9PrfiwuXFRM2/wHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j0E7Z9
	alvN2d6Osyo7b3ym7AnxQvVNCprjOE7Dn8TwqPgszixEALJ02y420+1fYgFv2bWZ
	J2X9GzQC2ACkczvN/kbfqMKElEtnX1csiquN5H7KVybnLy7sUaT+M0pr76BPq676
	IjgaUppnVYVbH+k7Fqbeep6BCBk12g4p5kXcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6C988C10;
	Wed,  9 May 2012 15:52:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38C4E8C0F; Wed,  9 May 2012
 15:52:51 -0400 (EDT)
In-Reply-To: <1336524290-30023-11-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F510D34-9A10-11E1-AB41-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197499>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> ..., this
> search is not that thorough either, as it doesn't check whether the
> found '.git' directory or the directory pointed to by a gitfile is a
> valid '.git' repository.
> ...
> Of course, stat()ing in C is much faster than in bash, so there is a
> point when bash builtins will be slower than '$(git rev-parse
> --git-dir)' despite all the fork()s+exec() overhead.

I'd feel safer if this new logic were an opt-in feature, at least in th=
e
beginning, with these pros-and-cons summarized near the beginning of th=
e
file to let the users choose if they want to use "exactly matches the
command the prompt script is trying to help" version (i.e. rev-parse) v=
s
"matches most of the time and faster under these conditions" version
(i.e. the new logic).

Thanks.

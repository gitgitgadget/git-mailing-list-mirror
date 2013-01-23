From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 09:04:48 -0800
Message-ID: <7vwqv3hlu7.fsf@alter.siamese.dyndns.org>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
 <7v622nj0ys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:05:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty3lA-00079X-S0
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 18:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab3AWREv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 12:04:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756245Ab3AWREv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 12:04:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2B16B024;
	Wed, 23 Jan 2013 12:04:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BpZfIhR0xQsB3TUV8JX1SGxpWV0=; b=g3gHg2
	wxntDNaDGX/XE3EjEaUcGoaK2B4xJJL2Itsefvccgv/WkCqipQrOMus/GPAAeNwr
	Uo8D62bijdCYbXE9YqMbKq6cUZlMTBKTWDGlasfg4ajiDJqHNQELaHZkUnpPLADI
	AH/3FvrUB20FBWN5kz7D5UYLFqBvdaDwGyaKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mtr3ghz1pzXBElGETdCK8DQ+cSFUJF8j
	hwSjCb2tIMdSHb6/FKwSu21ll3Lh6Y2HtDXPntbiI9Put+eAT3PJg+er3nEk9J8K
	7dMXIf1saM/m0dsMHRXZfNWB2Ol21wY9NGGEZWkJro6qBDTHicfpSv45qtAZWPWt
	jzDv4DUkNck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6FAFB022;
	Wed, 23 Jan 2013 12:04:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3701EB021; Wed, 23 Jan 2013
 12:04:50 -0500 (EST)
In-Reply-To: <7v622nj0ys.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Jan 2013 08:52:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF8E5414-657E-11E2-9D1A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214336>

Junio C Hamano <gitster@pobox.com> writes:

> But I still do not think this loop is correct.  In a repository that
> has a working tree, you would learn that directory $D has $D/.git in
> it, feed $D to handle_repo(), and then descend into $D/.git/objects/,
> $D/.git/refs, and other random directories to see if you can find
> other repositories....

Ahh, no, you don't.

I still think calling is_git_directory() on $D + "/.git" would be a
better implementation, though.

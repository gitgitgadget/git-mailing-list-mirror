From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] write_idx_file should use an unsigned nr_objects
 parameter
Date: Fri, 01 Apr 2011 11:28:27 -0700
Message-ID: <7vtyehg71w.fsf@alter.siamese.dyndns.org>
References: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 20:28:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5j5Q-0006pO-G4
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 20:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab1DAS2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 14:28:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1DAS2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 14:28:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4C964A1C;
	Fri,  1 Apr 2011 14:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yy4D7LIAR544498dGEwrodT03iE=; b=oBSW3y
	xVw3C/G8Zk5ZFxyGa5tDryr3CJFKawklHAjKRc8Vu4s/JCufWG5YTSAJXNJdHHy7
	veYJwE1OyuY7vX7CXqq8bEyyfOypVdOph017Se9BAchDULoiFJqNxRrzYDjUd/NI
	opQsJGjNEIxO4SazrWaIXsy0A1kjT+FW7WZbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btXtfcX7zc1YE4n0Img2xrmoNf0Qoyd5
	S6su71Ps3UYRl9DlFcJDDrjYNsXhCrhaO1m0YM9MIkEHHkjvMd+5M6sfkAx78pNc
	sxdYnh5/gVa0jR8Zerqp34mXh67ul3v/T4jV0crlJ5UV29oO8AhcUzGzCbAahkYg
	4iuE7RpEC6c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8DC7B4A1A;
	Fri,  1 Apr 2011 14:30:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 973724A15; Fri,  1 Apr 2011
 14:30:20 -0400 (EDT)
In-Reply-To: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Wed, 30 Mar 2011 20:24:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B5870B8-5C8E-11E0-A859-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170601>

Dan McGee <dpmcgee@gmail.com> writes:

> This follows the precedent set in the pack-objects code and being
> adjusted for in index-pack and unpack-objects.

Eh, why?  The use of a fixed-width type in the existing code is mostly to
make sure that the on-disk result will fit within the on-disk field.  The
variables like iteration counter "i" we use in write_idx_file() need to be
at least as wide but there is no reason to forbid the compiler from using
the natural interger type as long as it is more suiable on the platform,
no?

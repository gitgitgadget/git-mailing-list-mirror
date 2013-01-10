From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] reset: don't allow "git reset -- $pathspec" in
 bare repo
Date: Thu, 10 Jan 2013 10:04:17 -0800
Message-ID: <7vvcb429um.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-5-git-send-email-martinvonz@gmail.com>
 <7vtxqq5f0g.fsf@alter.siamese.dyndns.org>
 <CANiSa6gK+RqovV+NKWgV57hz-p_O085HN7WCg9qvQAD-Ynpfjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 19:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtMUc-0002wZ-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 19:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab3AJSEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 13:04:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab3AJSET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 13:04:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31BDDA35D;
	Thu, 10 Jan 2013 13:04:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NmLEOIM0eeZhMZbaJtR+Ubh7tR0=; b=yCZYJb
	VYNwjYYEDdfuRIH/lRIaE+LmLo0N6RpL82LRKybiRHbd7Px/PMUk8w0EZCD4chok
	ylqDfHnf123wkE2VE+DuoE0b9MBuq5KhWkUN5AZw5/3oC9npFf2umPGYf6ZjSCu3
	9eT5V9B6x0NQxNB9AS7/Q8F4zJHxAXnrIVsTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=otfxAKbpJvVC1qUPG/QMGI729o5EcPL/
	PW+QsQXYKZmvOBvHTL5pLJFv5j7D4Ii7IqB/sflruebFXsHgm1mglAQIR+W3Do46
	gtBhZtpF8867c+TkmJiwtUzFV6ctE66PPwnY92b074x5JfGe5iapzBTB+fIcpFFr
	VlbONJCX4Ec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26AEFA35C;
	Thu, 10 Jan 2013 13:04:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9916FA35B; Thu, 10 Jan 2013
 13:04:18 -0500 (EST)
In-Reply-To: <CANiSa6gK+RqovV+NKWgV57hz-p_O085HN7WCg9qvQAD-Ynpfjw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Thu, 10 Jan 2013 00:24:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 271E3C26-5B50-11E2-A6B6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213146>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

>     ... Fix by moving
>     the branching point after the check.

OK, that is what I missed.  We have an existing check for mixed
reset, which was originally meant to handle case without any
pathspec but can use the same error condition (i.e. type is mixed
and repository is bare) and error message (i.e. no mixed reset in
a bare repository).  "reset with pathspec" was done before that
check kicked in.

Thanks for clarification (and sorry for the noise).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule deinit: clarify work tree removal message
Date: Tue, 16 Apr 2013 22:16:11 -0700
Message-ID: <7vppxthh44.fsf@alter.siamese.dyndns.org>
References: <5112C6F6.4030607@web.de>
 <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com>
 <7v1ubk8u6o.fsf@alter.siamese.dyndns.org> <51477EFF.2010505@web.de>
 <7v7gl4mabf.fsf@alter.siamese.dyndns.org> <5159D9A8.30901@web.de>
 <CABURp0rkeYc7K0COhc1+96Q2Ox2TaNRpMSmQYOiwBpgPJbsafA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 07:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USKjD-0003gB-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 07:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab3DQFQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 01:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756994Ab3DQFQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 01:16:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DF5BE75D;
	Wed, 17 Apr 2013 05:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4a3u2LvDWdK+LOfIEkVeJ9Whkk=; b=CeGpRG
	wYVUoQxaMcIxKEiKLcg+KjmPhVEjE7+VvyYmOyuT693qzyEyYrDX72uuM1UAoqvJ
	Y4/HMMNRo4sscUHAvA1LzwsQe59rx76euGbooTI551J4l4TcVIVgYzLplj04zIRG
	hbbzINWmc0ceYHM4sOA2W4vXnDMlKJusl0LB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LaDT2cDeCsVuyz/9S/b0lsUsOW6q6hlr
	bo6sshtPn7qGOZFMO20f0s8oCOXDHFA24pz/1O/rzMIMm1bYpy3lJEsdCqri2vtj
	pjp+zQ19u2i0AY6n1Qy3eOYhLz0fCY9PNFcH9qxZipQGgLQjBK0QNV43gEvoSC1c
	T3+RPvN5uQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D8A1E758;
	Wed, 17 Apr 2013 05:16:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CCA6E752; Wed, 17 Apr 2013
 05:16:13 +0000 (UTC)
In-Reply-To: <CABURp0rkeYc7K0COhc1+96Q2Ox2TaNRpMSmQYOiwBpgPJbsafA@mail.gmail.com> (Phil
 Hord's message of "Tue, 16 Apr 2013 09:32:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC540CB4-A71D-11E2-8673-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221506>

Phil Hord <phil.hord@gmail.com> writes:

> On Mon, Apr 1, 2013 at 3:02 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Okay, so here is the patch for that. If someone could point out
>> a portable and efficient way to check if a directory is already
>> empty I would be happy to use that to silence the "Cleaned
>> directory" message currently printed also when deinit is run on
>> an already empty directory.
>
>    isemptydir() {
>         test -d "$(find $1 -maxdepth 0 -empty)"
>    }

Hrm, -maxdepth and -empty are not even in POSIX.  Folks on GNU
platforms and BSDs (I checked NetBSD 6 and OpenBSD 5.2) should be
fine, but it makes other platforms unhappy.

What is this check used for?  To avoid running "rmdir" on non-empty
ones?  Saying "cleaning foo/" (or "cleaned foo/") when foo/ is
already empty is not a crime; not omitting an empty one may actually
be a better behaviour from the point of view of repeatability and
uniformity.

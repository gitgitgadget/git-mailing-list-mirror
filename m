From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 01 Nov 2011 09:45:01 -0700
Message-ID: <7vy5vzn65u.fsf@alter.siamese.dyndns.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
 <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1110311908240.1930@bonsai2>
 <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 01 17:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLHSa-0002Ne-EP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 17:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab1KAQpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 12:45:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720Ab1KAQpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 12:45:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FD8347ED;
	Tue,  1 Nov 2011 12:45:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aYF7+VvJYjdkSp74WddMeqRd9p8=; b=gvOfIK
	BARw+Q9JAoK2qsDR65zlUoTuIWon5b+IIZEFcNgF9+d2RJdZaSkVM4p8CohBfssd
	n82W8Q02xUH+QsTf5Uk+t7uskhw5tvUQkeLdifJFv4kpitv2h51/pzsIS1XDJLje
	XZS446HGN6L5XND3CU570/vn1gxK4WttzTRoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTlLQUcShS7EDVllQivGakyVB/aWzQtt
	hxzDymJhr6sxs8PetAoP/r2Fe1qgAMItjkwhJ2bDjZPKMWi+Nl28EFOCo98pf2Uz
	e3ll9F9mTjuP6kFzl9G0Rwp0wyMmkBOecwSgnGb4+AcKpIkG2qN1L2rHzkRK+m+y
	chzuiszjLQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63AC247EC;
	Tue,  1 Nov 2011 12:45:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D08B947E8; Tue,  1 Nov 2011
 12:45:02 -0400 (EDT)
In-Reply-To: <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 1 Nov 2011 12:56:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D85AEC6E-04A8-11E1-9E59-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184575>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> This is a slip-up in my patch 0f77dea, but I don't quite understand
> why this didn't cause any troubles until now... I guess the MSVC parts
> of Makefile are somehow more dependent on LIB_H or something...
>
> Junio, is it too late to squash in a fix-up? If it is, I can send a
> fixup-patch instead...

I can queue this for v1.7.8-rc1 if you want, as it is a fix whether or not
we define MSVC or not while building.

-- >8 --
From: Erik Faye-Lund <kusmabite@gmail.com>
Date: Tue, 1 Nov 2011 12:56:21 +0100
Subject: [PATCH] mingw: poll.h is no longer in sys/

Earlier we moved this header file in the code but forgot to
update the Makefile that refers to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4c09b35..ee34eab 100644
--- a/Makefile
+++ b/Makefile
@@ -515,7 +515,7 @@ LIB_H += compat/mingw.h
 LIB_H += compat/obstack.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
-LIB_H += compat/win32/sys/poll.h
+LIB_H += compat/win32/poll.h
 LIB_H += compat/win32/dirent.h
 LIB_H += connected.h
 LIB_H += csum-file.h
-- 
1.7.8.rc0.88.g45c5be

> Anyway, with that fix in place, it still breaks here:
> ...
> Again, this seems to be related to the poll-emulation... I see that
> these things are guarded by an "#if(_WIN32_WINNT >= 0x0600)" in
> <winsock2.h>, which means it's supported for Windows Vista and
> above... We still support Windows XP, so it seems someone has set this
> too high :)
> ...
> And THEN it compiles fine from 'devel'.
>
> So there's some more work left to be done. Unfortunately, I don't have
> time to polish these changes for at least a week, so unless someone
> volunteers it'll take some time...

It seems, from your description, that msvc update series has some way to
go and it probably is better to be cooked by Windows-savvy folks for
another cycle. Which would mean that your upload-archive series is still
good to go as long as it works for non-MSVC/mingw people, right?

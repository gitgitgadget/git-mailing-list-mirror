From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 09 Jul 2014 14:57:36 -0700
Message-ID: <xmqqion69ovj.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BD7A36.2030300@kdbg.org>
	<xmqqr41u9w27.fsf@gitster.dls.corp.google.com>
	<20140709195619.GA17454@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:57:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zs4-0001za-UG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbaGIV5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:57:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63226 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbaGIV5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:57:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 816EF2876B;
	Wed,  9 Jul 2014 17:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rn/Cfzu/8T+2O2qliBFGpvQlzg=; b=oGpGt+
	ik6/dxqqVM929t5mm+eBQSyVY4Pn3LjWVAVRH1+QmtNtAOvH7RTlD9WskHMe2beZ
	WQjf/k280WeAU0GcDn62k/WwjpHNK7EMz/iERqY2ntbdogCE1/ddJuusZtKrEMJ5
	ZD8Hs4pmn+ospcS8n3lMX4n1O95x4K7mUmwdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o/Ya2ngezJmScjmtYMh5GcvhZticmkY9
	0g/misjw9WIGIekb7j81EwQ6rS1GzcarAB82TsgpQlyUu4AaFt0wPYdmFzy/W8Bh
	IWVCPL+fy6m79nSuBJFY+X+F1KkW5HtVdCVnrnbD3N6/ofGg5Hy2u/EZ9ajAqB6F
	YJwUT+vNQ6E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 779952876A;
	Wed,  9 Jul 2014 17:57:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC57E28763;
	Wed,  9 Jul 2014 17:57:22 -0400 (EDT)
In-Reply-To: <20140709195619.GA17454@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 9 Jul 2014 19:56:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 019BBF5C-07B4-11E4-92DC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253159>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> > Am 08.07.2014 21:34, schrieb Jens Lehmann:
>> >>> And Msysgit complains 
>> >>> error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/submodule_update_repo/.git/modules/sub1/config.lock failed: Function not implemented
>> >> 
>> >> I'm not sure what this is about, seems to happen during the "cp -R" of
>> >> the repo under .git/modules into the submodule.
>> >
>> > No. It happens because fchmod() is not implemented in our Windows port.
>> >
>> > Please see my band-aid patch at
>> > http://thread.gmane.org/gmane.comp.version-control.git/248154/focus=20266
>> > The sub-thread ended inconclusive.
>> 
>> We need to start somewhere, and a no-op fchmod() in your patch may
>> be as a good place to start as anything.  At least we would then
>> keep the old behaviour without introducing any new failure.
>
> Right, this likely makes the most sense for single-user systems or
> systesm without a *nix-like permission system.
>
>> An alternative might be to use chmod() after we are done writing to
>> the config.lock in order to avoid the use of fchmod() altogether,
>> which I think can replace the existing two callsites of fchmod().
>> That approach might be a more expedient, but may turn out to be
>> undesirable in the longer term.
>
> In that case, we would need to open with mode=0600 to avoid a window
> where the file may be world-readable with any data in it.

Yes, of course.

To elaborate what I was alluding to at the end of the message you
are responding to a bit more, if we were to move this "grab perms
from existing file (if there is any) and propagate to the new one"
into the lockfile API, 

 - in hold_lock_file_for_update(), we would record the permission of
   the original file, if any, to a new field in "struct lock_file";
 - open with 0600 or tighter in lock_file(), and

 - either before closing the file use fchmod() or after closing and
   moving the file use chmod() to propagate the permission.

If the original did not exist, we would pass 0666 to open as before
in lock_file() and do not bother chmod/fchmod at the end.

Or something like that, perhaps.

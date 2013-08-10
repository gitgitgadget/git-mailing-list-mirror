From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 09 Aug 2013 22:18:32 -0700
Message-ID: <7vioze2kev.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	<7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
	<7vmwoq304o.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Q2x9uz5Ajr=BgVjSjO88XD5UYzVSEqgMeK5_YAYSa5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 07:19:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V81Zu-00043u-8a
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 07:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab3HJFSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 01:18:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab3HJFSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 01:18:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 104E830503;
	Sat, 10 Aug 2013 05:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cq5mPzKaXMuL8WSE92HO8T8iAd8=; b=XtfoW0
	4u1Mbz3WP4fBCyFygF8EpVSG7lACKWWkai2M1y7gBjlMHJJSEOvethRNARlEk7Gm
	Ql13Pma9lJXCgnv6CdoHu4tYotQLEUJoJ1rGzrgkDSVRNnFOIpDa9q1lwKSJlVCB
	RQU0ms3tV0O0MULRXEoK9hnI/43NJERl7c7+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhRKh3DIY5vM0c3sHOGg7XsiwYhK5iA8
	ABUNutEhqvZaLmLhJyhz+JfpjQslXNF3TydHNVPgCAVDt5xRyScQ/Dc8nEBDwIH2
	PnrMsCfuSTM6qRCyYPMp07YvEzpRyUcZTQCJY5p6/l5oPRTVh7zVmybgRyHbi+vu
	svr1bQSmtMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06DC430502;
	Sat, 10 Aug 2013 05:18:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 625FD30501;
	Sat, 10 Aug 2013 05:18:34 +0000 (UTC)
In-Reply-To: <CAMP44s1Q2x9uz5Ajr=BgVjSjO88XD5UYzVSEqgMeK5_YAYSa5A@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 9 Aug 2013 18:43:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DCD50C8-017C-11E3-911B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232062>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Hmph, do you mean the third example of this?
>>
>>         $ python
>>         >>> import os
>>         >>> os.path.expanduser("~/repo")
>>         '/home/junio/repo'
>>         >>> os.path.expanduser("~junio/repo")
>>         '/home/junio/repo'
>>         >>> os.path.expanduser("~felipe/repo")
>>         '~felipe/repo'
>>
>> which will give "~felipe/repo" that is _not_ an absolute repository
>> because no such user exists on this box?
>>
>> It is true that in that case fix_path() will not return early and
>> will throw a bogus path at "git config", but if the "~whom" does not
>> resolve to an existing home directory of a user, I am not sure what
>> we can do better than what Antoine's patch does.
>
> I was thinking something like this:
>
> if url.scheme != 'file' or os.path.isabs(url.path) or url.path[0] == '~':
>   return

That did cross my mind.

I know ~/ and ~who/ are expanded on UNIXy systems, and I read in
Python documentation that Python on Windows treats ~/ and ~who/ the
same way as on UNIXy systems, so the "begins with ~" test would work
on both systems.  But it is probably a better design to outsource
that knowledge to os.path.expanduser(), with the emphasis on "os."
part of that function.  That way, we do not even have to care about
such potential platform specifics, which is a big plus.  The only
possible difference that approach makes is the above example of
naming a non-existent ~user, but that will not work anyway, so...

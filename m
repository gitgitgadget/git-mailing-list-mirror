From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Thu, 12 Feb 2015 11:48:26 -0800
Message-ID: <xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
References: <54DBEAA5.6000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:48:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzkY-0004gV-5u
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbbBLTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 14:48:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751483AbbBLTs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:48:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FDC2376FA;
	Thu, 12 Feb 2015 14:48:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X+JZEfg/3alYlZZnmI983vjRfKA=; b=MOgUOM
	ZWKFDtkbRbka4QqxYIT6TTm/tDVCEv9/+4qhzPQnifqwcIDi9xJ9LoMTl7UBh2K3
	QPIupAQ/pJRFtasZwe51/Ui4bovr2LLl1yYS+OsL67e8slZPQCVCO4UA8T8qw8QS
	wXFskf/IN03rqXjaideWuD2PwIUw7DE62XHCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VdDHqJqFG1Dp466FQyFCKskKA7PteNT6
	Na9TozbHz9V9dLGtMHBpQD2eg+Md3lEAeObftTuzcBgyCkcdshv2XNZ4fVR7xNcE
	MG24TY4+hQyHKzcEEtoF4Egi+tTuDEtlZQuLwA7gem0LTE+lNzAm1dPoe0PNEgg9
	lDnxNcc3DKA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65F72376F9;
	Thu, 12 Feb 2015 14:48:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB7C0376F8;
	Thu, 12 Feb 2015 14:48:27 -0500 (EST)
In-Reply-To: <54DBEAA5.6000205@gmail.com> (Karsten Blees's message of "Thu, 12
	Feb 2015 00:49:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D29017A-B2F0-11E4-B243-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263756>

Karsten Blees <karsten.blees@gmail.com> writes:

> This patch series was inspired by the problem that Git does not
> detect changed file content if st_size, st_mtime and st_ctime
> are unchanged. This was apparently caused by VSS2Git resetting
> mtime to a value in the past. [1]
>
> I believe (or rather hope) that all involved in the discussion
> agree that Git cannot reasonably be expected to detect changed
> file content if file time(s) are reset on purpose.
>
> However, some users have expressed concerns that 'same size and
> mtime' [2] may theoretically happen by chance in daily operation.

Hmph.

Haven't we already accepted that it is not just "may theoretically
happen" and had counter-measures in racy-git detection machinery
for quite some time?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/5] t4205, t6006: Add failing tests for the case when i18n.logOutputEncoding is set
Date: Wed, 21 May 2014 11:11:47 -0700
Message-ID: <xmqqwqdfovbw.fsf@gitster.dls.corp.google.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com>
	<cover.1400678003.git.Alex.Crezoff@gmail.com>
	<12b22fd98d687b0484d7d5e5f122d770ca56908d.1400678003.git.Alex.Crezoff@gmail.com>
	<537CC869.1020104@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <alex.crezoff@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed May 21 20:11:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnAze-0002N1-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 20:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaEUSLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2014 14:11:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57812 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaEUSLy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2014 14:11:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1292A17C56;
	Wed, 21 May 2014 14:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BGFbHhcc2QxK
	ewx4F5gAlScem8M=; b=DByO3IEF7uHEYYJlY7VyMROWyHEAFMxqTSUITb7oaxb+
	Cs24p2mrRB+cwBgPM4keivmhzw2E0NkqgwRmzAvRFQk8SOAe2mQqt94Ti7fVTule
	vgMQo5nqJKRAU6tMCiOMW/7cARPGvBkzb5m884D/IpusCVRNJvEYNOg6KU14ZbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AiOqYs
	o+XBSOKpepMtWTOBErVaqoM1q/+09pdY8j//HcqEl5ESsNT7buZIPppk4FiuFNjy
	I5YOQUXLnn8+KQOAVfQnd3rYRLxtGxxQRJlqMGgLqxz1sol0RVULoyNdz+bpysi9
	ftiYX8MEKWxFKJoBH8wYeNXudL6eCtYBsLhnY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 072D817C55;
	Wed, 21 May 2014 14:11:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28C6717C3F;
	Wed, 21 May 2014 14:11:49 -0400 (EDT)
In-Reply-To: <537CC869.1020104@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Wed, 21 May 2014 16:38:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6097D2C4-E113-11E3-BFC1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249818>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 21/05/14 14:20, Alexey Shumkin wrote:
>> Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
>> length with an appropriate padding. This works for non-ASCII texts w=
hen
>> i18n.logOutputEncoding is UTF-8 only (independently of a printed com=
mit
>> message encoding) but does not work when i18n.logOutputEncoding is N=
OT
>> UTF-8.
>>=20
>> There were no breakages as far as were no tests for the case
>> when both a commit message and logOutputEncoding are not UTF-8.
>>=20
>> Add failing tests for that which will be fixed in the next patch.
>>=20
>> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
>> Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
>> Reviewed-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>
> Hmm, I didn't really review these patches. I simply noted a problem
> on my system and provided you with an extended bug-report and
> assisted you in fixing it up. So, if it even warrants a mention in
> the commit message, then 'Helped-by:' would be nearer the mark.

I had the same impression.  The same for Duy's.

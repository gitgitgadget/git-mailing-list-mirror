From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [LHF] making t5000 "tar xf" tests more lenient
Date: Sat, 05 Jan 2013 12:11:39 -0800
Message-ID: <7vsj6fpeys.fsf@alter.siamese.dyndns.org>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E8722B.8010408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 05 21:12:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tra66-00059k-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 21:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab3AEULn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 15:11:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755843Ab3AEULm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2013 15:11:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30EC3BD01;
	Sat,  5 Jan 2013 15:11:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WaOHwfQtZEQ9
	Qw51oYC0DPsJQzw=; b=ea7QgwaKl8GpNU61LcH6C2TvmKMoxdhP9h8OjvtH8sDe
	fNbYsAU0AHadO4Ovwl2NaQSo5ZTvWlffIoMSOPaviWGV057PdN0BpiaWah0i28OI
	pGRLijfDO7GrNR6qXdGITW7S0sjz/yGA6GmaL9suYr2i6+GzjpKFZ0kUTQ+GHiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ufDR4H
	a+H1gjFIZGMVxQplCq9rsimNDefV5ZJOqz12J1LV0SHytiSn5A/OxA1jQkXguaod
	rmHX7z8XmUgTP+7RHUAcwT/Ql8TEu6oVApDEoizsMypH5mNRT9/PZB2bFlQGv5M3
	jna/YL8celCdy4+PJQLKngJViAfNlBI0Z8990=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20735BD00;
	Sat,  5 Jan 2013 15:11:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9750CBCFF; Sat,  5 Jan 2013
 15:11:40 -0500 (EST)
In-Reply-To: <50E8722B.8010408@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 05 Jan 2013 19:34:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E09153C-5774-11E2-97B1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212710>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Anyway, I don't think the pax headers are to blame here.

Hmph, I am reasonably sure I saw a test that created an archive from
a commit (hence with pax header), asked platform tar to either list
the contents or actually extracted to the filesystem, and tried to
ensure nothing but the paths in the repository existed in the
archive.  When the platform tar implementation treated the pax
header as an extra file, such a test sees something not in the
repository and fails.

This was on (and I am still on) NetBSD 6.0 not 6.0.1, by the way.

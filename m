From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 12:04:22 -0700
Message-ID: <xmqqpps7xoax.fsf@gitster.dls.corp.google.com>
References: <5236FBEA.80909@gmx.de>
	<CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
	<vpqvc1z6eoo.fsf@anie.imag.fr>
	<CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
	<CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com>
	<xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
	<1496b663-6b6c-45a2-95d1-cbe634b0d160@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 21:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM0Zi-0002jg-AT
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab3IQTE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 15:04:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703Ab3IQTEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 15:04:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DF4C42E7C;
	Tue, 17 Sep 2013 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Ev4fXC0mBzYNbvBwtgf7pOCLvY=; b=sIwGlX
	cPi5RaKQKlsKEASKLJw02Jqa0wBF7zRYGTGA085+mOxFMTAcYYBtHU0+RWSkTrp2
	m4KpWIqgBdp9qG3Zzc2zi86ArzSafT28nPQDL3XI3Rm98sQMLKjfoJ3D+q4sdEH7
	7zzSD6Vkjo7L0heLDoqZTGpojnrKjDfC1p+eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZasQO9crxAIAbJ05bbAnCDjP3FcDdtGS
	UcvTH8kTp/ULSz58n2cOuOKSblsNMI3eajflev0pburf6MKFlFuRePJNdaLskBch
	p9uJwdRh9+oRRJPUey7p43XcZkW8Mx4eDT8TVw7TxlFI6gqf74oqSAz46oihVyZy
	ZXwUxqpV+k0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AB0442E7B;
	Tue, 17 Sep 2013 19:04:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47F8342E75;
	Tue, 17 Sep 2013 19:04:24 +0000 (UTC)
In-Reply-To: <1496b663-6b6c-45a2-95d1-cbe634b0d160@email.android.com> (Piotr
	Krukowiecki's message of "Tue, 17 Sep 2013 20:12:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F79529E2-1FCB-11E3-A40B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234902>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

>  What about simply iterating over options in order in which they
>  are specified and the last option that matches specifies the
>  result?

But isn't it very inconsistent from the way normal pathspec works?
"git log -- A B" and "git log -- B A" would give the same result.

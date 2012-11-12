From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/15] fast-export: avoid importing blob marks
Date: Mon, 12 Nov 2012 09:44:36 -0800
Message-ID: <7vbof2k96j.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-2-git-send-email-felipe.contreras@gmail.com>
 <509FD425.5030702@web.de> <20121111163827.GA11408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:44:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy45-0005ws-91
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab2KLRok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:44:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab2KLRoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:44:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D804F9522;
	Mon, 12 Nov 2012 12:44:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+TvBjReQq1aHuNUthWW+uT3AkyU=; b=G6vkffoMuH/G54lzrAgu
	TnPiVnijOM6U2/L8+lV0V1mcKzWzMBPucw+C9chbPLFbWXVZz2Qhd5FSAU1Nm/uv
	gnIwdnXDaabXdRUh/D1rcaNfd4BHdOXLPsDhZ6bLytloxPNaLw9jpamF67KoZJYu
	hY3+VL9npB0kE8BAVt3H2mA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eo5BJbu4ps5PC5d+NqBPksgpH80OiMNxCloJMvmkcteHyI
	Sp/ca0VVkpF6roCogo9gzATAaO/SPr8oMWrV6gu8ydO0Gg3DACTxO68YcjoYbO+h
	8uaaRfWMbZrtQnqq+db8uDszvkOka/A/o38ZvzYnoamM3MW1WY/GcV3x00Avs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2E309521;
	Mon, 12 Nov 2012 12:44:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C7A69520; Mon, 12 Nov 2012
 12:44:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1328E06-2CF0-11E2-9BF2-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209499>

Jeff King <peff@peff.net> writes:

>> Major issue:  "echo -n" is still not portable.
>> 
>> Could we simply use
>> 
>> touch  marks-cur  &&
>> touch marks-new
>
> Yes, "echo -n" is definitely not portable.  Our preferred way of
> creating an empty file is just ">file".

Yes.

And it is misleading to use "touch" in this case; unless you are
updating the timestamp of an existing file while preserving the
contents of it, please don't use the command.

Thanks.

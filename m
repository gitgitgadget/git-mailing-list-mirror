From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Tue, 20 Nov 2012 14:43:13 -0800
Message-ID: <7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:43:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TawXT-0005Z3-B9
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 23:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab2KTWnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 17:43:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137Ab2KTWnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 17:43:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DDC09258;
	Tue, 20 Nov 2012 17:43:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JkQTnOjLnhlMIeD+HaByT4s48Bw=; b=rYcrQR
	PLdbABnhZa/U7FHUzQj8iBUSsOnQ8IPts8EPGENey709AnyTpeiA4HacmmcLWd3Q
	oxYiF1Bn13PMge2UErT/VgYfvOdPiUsGvw/uuPxMZUJIHoZzZ0oCIObvpAtND1dk
	QCMI2dPdVr85H/lFioiV3pATAO+Fhp2PbPCpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wDdydwpdTahXBppMnUnC/RxtGSdLlk7y
	xgNrZSkg79OK3MLw26ZXRSKKkZStvjRsgQJ65uUi5DUpoF9mtbVtqrKQLKwd8p27
	pGsBqyCcRfqwsN8oXwxNk29e176O4r5kfrxca9QbensMjw5O+XS4lL01skpCIcn5
	i7wgSeuMzHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 179FE9257;
	Tue, 20 Nov 2012 17:43:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 855B99256; Tue, 20 Nov 2012
 17:43:14 -0500 (EST)
In-Reply-To: <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 12 Nov 2012 17:28:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB739BB6-3363-11E2-AFC2-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210120>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Of course, transport-helper shouldn't even be specifying the negative
> (^) refs, but that's another story.

Hrm, I am not sure I understand what you mean by this.

How should it be telling the fast-export up to what commit the
receiving end should already have the history for (hence they do not
need to be sent)?  Or are you advocating to re-send the entire
history down to the root commit every time?

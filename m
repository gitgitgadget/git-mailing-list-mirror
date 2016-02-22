From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] notes: read copied notes with strbuf_getline()
Date: Mon, 22 Feb 2016 11:27:49 -0800
Message-ID: <xmqq60xg7dfu.fsf@gitster.mtv.corp.google.com>
References: <56CA5DBB.8040006@moritzneeb.de> <56CA6160.7010908@moritzneeb.de>
	<CAPig+cReRiwHBJiatWJ=Gc+k+dtcMhdwFn4K57yHAjE3d_fzwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Moritz Neeb <lists@moritzneeb.de>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 20:28:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXw9F-0000wQ-Km
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 20:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcBVT1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 14:27:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752204AbcBVT1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 14:27:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BB6747994;
	Mon, 22 Feb 2016 14:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=igxl0VzJkCd3x9Tqnlc4NiF36sI=; b=kQKzXP
	KoRpFV1tX7iPaoU8tg2x95n7WBP61H9gQj7oFIzJYzHUD9REw8Z7sjTh3goTxgR9
	99JU3p7t5BS6cGpLpsIyZPnNk5PIcyYswmdtohliYP0D7ufp9184zkRP4Gb57Ugs
	NQu3EYd2eK5H6tdMSE9oPo2R4S24oYRj4RXSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gxMqDlNJ0fG3WeO4wV2YAzcC7bx+2kym
	iUZ9nQFbvnmnTaPFR5NIcrn/cgC8FJ68QBmEqls5EouTNuoqTIyw2mfNSVxWZInU
	AwT5afyMHZ35ZcMTz9+UnFnPTHv+bK+K12Q+vN/J9ZnaJqgaRZKE1+hqpL9prMKB
	8qhpu6ylXgI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1215847993;
	Mon, 22 Feb 2016 14:27:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5FCB147992;
	Mon, 22 Feb 2016 14:27:50 -0500 (EST)
In-Reply-To: <CAPig+cReRiwHBJiatWJ=Gc+k+dtcMhdwFn4K57yHAjE3d_fzwQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 21 Feb 2016 21:41:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C75D8E0-D99A-11E5-A6ED-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286946>

Eric Sunshine <sunshine@sunshineco.com> writes:

> A deeper issue not touched upon by the commit message (but which
> should be) is that that strbuf_split() leaves the "terminator" (space,
> in this case) on the component strings, and that is why split[0] must
> be rtrim'd. Rather than dropping only one of the rtrim's, a cleaner
> approach might be to convert the code to use string_list_split() which
> doesn't have the "odd" behavior of leaving the terminator on the split
> strings, in which case both rtrim's could be retired.
> This, of course,
> would be done as a separate preparatory patch.

Yeah, this is a good point to raise.

Thanks.

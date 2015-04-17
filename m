From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file: freshen existing objects
Date: Fri, 17 Apr 2015 08:50:59 -0700
Message-ID: <xmqqlhhqhhy4.fsf@gitster.dls.corp.google.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
	<20150417140315.GA13506@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Saasen <ssaasen@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 18:09:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj8pT-0006Eb-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 18:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbbDQQJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 12:09:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932402AbbDQQJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 12:09:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5116949B33;
	Fri, 17 Apr 2015 12:09:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k++PEZL//1WDXTRpyg7rPfONi1c=; b=MQVS/C
	J0MQuSii8MiHX29g3Mpt8CeN/Zmu+c2t6FR8wc7I3EMwN1Q7chyRDPYABi92UetD
	8YV1EFAlXssx9OUai6Ynr85AOmv9O2k3vd0agSEzCxSUqnrdkNNWLNONXH9C+7hL
	DwwDUmFQ/uWsdpI8vasX8kSGqonapuHduhsL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdRIXtTGcKVBIBMUakKoGp5/P3wPoMmk
	RBFKjlrEf5GDn99/OLDgOVW/W9IJWFy+gKbhw0X1xkWVXfeWXUIib3YiImIs0CZp
	WXdC/ZPYgMXEtwFbSiaifzI+6pXsE7N5TH1DmWZhK0GrjEPSWxthsk3qDcJTR1Zw
	Q7gUSp5Vzqw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AAF049B32;
	Fri, 17 Apr 2015 12:09:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED0EC49406;
	Fri, 17 Apr 2015 11:51:00 -0400 (EDT)
In-Reply-To: <20150417140315.GA13506@peff.net> (Jeff King's message of "Fri,
	17 Apr 2015 10:03:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8BC78F42-E519-11E4-B042-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267364>

Jeff King <peff@peff.net> writes:

> If it's not a problem, I'd love to see timings for your case with just
> the first patch, and then with both.

Thanks for two quick progress patches.

> You may also be interested in:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/266370
>
> which addresses another performance problem related to the
> freshen/recent code in v2.2.

That, too.

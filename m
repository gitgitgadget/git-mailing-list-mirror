From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 13:24:42 -0700
Message-ID: <7vd31d3iwl.fsf@alter.siamese.dyndns.org>
References: <20120917173531.GB1179@sigill.intra.peff.net>
 <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net>
 <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
 <20120917182957.GF1179@sigill.intra.peff.net>
 <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
 <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com>
 <505CCA55.6030609@gmail.com> <20120921204907.GA22977@sigill.intra.peff.net>
 <505DB73E.2020108@gmail.com> <20120922174741.GA6722@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 22:24:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFWFx-0004Ew-TU
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 22:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2IVUYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 16:24:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab2IVUYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 16:24:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B96458498;
	Sat, 22 Sep 2012 16:24:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MVyrpT9DFhc9eQptPS+xrAyHzT4=; b=XXui6n
	08l/ldvpaziTyewRSvSXe4ht5sUQtw4x+e9QylQ15RKR5Ut8evcw3on58/FjIIZg
	q4YhGIz24Mw1ajU1U6LUjh1UBjq0JEF3meTS5XeSBwdSA3O3mAjBSroOCreQ1uu9
	ZH/qPK5VADvUSI/ziul6Zu/a//hvpadPCNQRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x5lq1aVf47qBCoyJlY76GfhKm+zBkHCL
	JKq/nDijA2UZLDCVb4PbqADQgSaYDdlMWubWATCQX2Nn2SvjWRxNa176+UdPkrnF
	OsPxO/cX5qsVnpaBvUHj/Zd3hfqU8aJ+5jqFag2aUzdCM6wT27WSAb1WEmzXXFaf
	peYViSGyw2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71B08497;
	Sat, 22 Sep 2012 16:24:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C9ED8496; Sat, 22 Sep 2012
 16:24:43 -0400 (EDT)
In-Reply-To: <20120922174741.GA6722@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 22 Sep 2012 13:47:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B9F9E32-04F3-11E2-A7F3-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206213>

Jeff King <peff@peff.net> writes:

> On Sat, Sep 22, 2012 at 03:03:58PM +0200, Stefano Lattarini wrote:
>
>> On 09/21/2012 10:49 PM, Jeff King wrote:
>> >
>> > Oh. It sounds like setting $SHELL to zsh is really the problem, then. If
>> > it is not Bourne-compatible when called as "zsh", then it really should
>> > be called in a way that turns on compatibility mode (bash will do this
>> > when called as "sh", but you can also do it with "bash --posix").
>> >
>> AFAIK, if Zsh is called as "sh", it too will run in Bourne compatibility
>> mode; not sure how to force this compatibility from the command line though
>> (albeit I'd guess there is some way to do so).
>> [...]
>
> Thanks for digging. I think this case, though, is that we were simply
> using the wrong variable ($SHELL instead of $SHELL_PATH). Your
> workarounds would help if somebody put zsh into $SHELL_PATH, but
> fundamentally that is not a sane thing to be doing, so I think we can
> just consider doing so user error and not bother working around it.

Yeah, 100% agreed with your assessment, including the part thanking
Stefano.

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 09:03:53 -0700
Message-ID: <xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	<1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	<xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
	<20140713173356.GA8406@sigill.intra.peff.net>
	<20140713183629.GA19293@sigill.intra.peff.net>
	<xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
	<1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>,
	"sunshine\@sunshineco.com" <sunshine@sunshineco.com>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:04:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X75D6-0005qh-BX
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 18:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbaGOQEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 12:04:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64883 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbaGOQEC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 12:04:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D95BA28F02;
	Tue, 15 Jul 2014 12:03:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ruj9+UgqmQY78AU0PI+62Yzb7MA=; b=kITFF+
	lhrneuleEXdSQ2T+fl9OuOxSwQgC3ip4gtXlFEF9kRrcaKgPO2v7sstCh7Hb+inu
	jnQnH+xERVyWzfjCaFO1wPfSDLeKAlrYyXmcDIgAhotbcNXNKBX4xAEKuq6Wx/Wq
	755LMc07BjhhORS+Paa6RM6na0EOXmz/uS9nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ArkUKTgpLEPwRICNftxL2rB/iSxIKXJv
	sIVU0ZcugfrCB433zZ8uiXsI3xKV2742fxcfRBGx8o5IDkq4l53AdHwwBDJFaBkR
	0U6fn+ufJ1HRpvvBFVuziN4/qvIEEvnET9Y6hqp8XQwL/VdF0CEP4RguQGWv8IlM
	2IfdtZmLzCE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCE0328F01;
	Tue, 15 Jul 2014 12:03:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B26D128EFA;
	Tue, 15 Jul 2014 12:03:37 -0400 (EDT)
In-Reply-To: <1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Tue, 15 Jul 2014 14:52:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 94D22110-0C39-11E4-8344-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253568>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> On Mon, 2014-07-14 at 10:17 -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Sun, Jul 13, 2014 at 01:33:56PM -0400, Jeff King wrote:
>> >
>> >> I realize that I am reinventing the error-reporting wheel on a sleepy
>> >> Sunday afternoon without having thought about it much, so there is
>> >> probably some gotcha or case that makes this ugly, or perhaps it just
>> >> ends up verbose in practice. But one can dream.
>> >
>> > Just for fun...
>> 
>> Yes, that is fun.
>> 
>> I actually think your "In 'version:pefname' and 'wersion:refname',
>> we want be able to report 'pefname' and 'wersion' are misspelled,
>> and returning -1 or enum would not cut it" is a good argument.  The
>> callee wants to have flexibility on _what_ to report, just as the
>> caller wants to have flexibility on _how_.  In this particular code
>> path, I think the former far outweighs the latter, and my suggestion
>> I called "silly" might not be so silly but may have struck the right
>> balance.  I dunno.
>> 
>> If you absolutely need to have both, you would need something like
>> your approach, of course, but I am not sure if it is worth it.
>> 
>> I am not sure how well this meshes with i18n (I know the "for fun"
>> does not even attempt to, but if we tried to, I suspect it may
>> become even uglier).  We would also need to override both error and
>> warning routines and have the reporter tag the errors in these two
>> categories, no?
>
> Do we want to go this way?

I do not speak for Peff, but I personally think this is just a "fun"
demonstration, nothing more, and my gut feeling is that it would
make things unnecessary complex without much real gain to pursue it
further.

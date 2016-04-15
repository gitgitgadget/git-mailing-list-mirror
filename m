From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Fri, 15 Apr 2016 10:31:39 -0700
Message-ID: <xmqqwpnybwxw.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
	<CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
	<CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
	<20160415095139.GA3985@lanh>
	<CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
	<20160415165208.GA17928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:31:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7as-0000Lu-Np
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbcDORbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 13:31:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751851AbcDORbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 13:31:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F3C713AF4;
	Fri, 15 Apr 2016 13:31:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UjAQcThT1qbk40IIUoTOii9ILRA=; b=vNct5h
	HRtVjCk7ZDOFreIHvKTPf4lAigjsVkUSf8/eci8Me6sOf0kZe0+VZuzfaFUI8uup
	4crLFoKDEJxZhXtHcDlCT3jE09HFRYv+7GXm8iCsdJriPfsGgfsQG6nAWiqFXIUg
	dKioDoPtjFjhoAARNnu46OpXaUvrkSZNpEl7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DqY6e0noTaFVSraPrW1Vxd1t2Hh9EXQq
	qgzcoQ1HvNIioIMIRRwUZ7Y0SUfbWrT6uE640sIZ6eaZ1PCAey76fvqn5GxZ14Jn
	6g70s9+JfkKoTwaVOphhB4CtsKVQcgVC7AhMCoz9Xm2KwQmnH2/32qJ4rskLaHS5
	cjBUfkHefnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 579E913AF3;
	Fri, 15 Apr 2016 13:31:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A57F413AF1;
	Fri, 15 Apr 2016 13:31:40 -0400 (EDT)
In-Reply-To: <20160415165208.GA17928@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Apr 2016 12:52:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA1D8FBC-032F-11E6-9A19-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291626>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 15, 2016 at 01:18:46PM +0200, Christian Couder wrote:
>
>> On Fri, Apr 15, 2016 at 11:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > On Fri, Apr 15, 2016 at 12:04:49AM +0200, Christian Couder wrote:
>> >>
>> >> There is a draft of an article about the first part of the Contributor
>> >> Summit in the draft of the next Git Rev News edition:
>> >>
>> >> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md
>> >
>> > Thanks. I read the sentence "This made people mention potential
>> > problems with parallelizing git checkout" and wondered what these
>> > problems were.
>> 
>> It may have been Michael or Peff (CC'ed) saying that it could break
>> some builds as the timestamps on the files might not always be ordered
>> in the same way.
>
> I don't think it was me. I'm also not sure how it would break a build.

Yup, "will break a build" is a crazy-talk that I'd be surprised if
you said something silly like that ;-)

Last time I checked, I think the accesses to attributes from the
convert.c thing was one of the things that are cumbersome to make
safe in multi-threaded world.

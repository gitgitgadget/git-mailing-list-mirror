From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Thu, 02 Apr 2015 07:45:54 -0700
Message-ID: <xmqqmw2qlhb1.fsf@gitster.dls.corp.google.com>
References: <20150302092136.GA30278@lanh>
	<1425685087-21633-1-git-send-email-sbeller@google.com>
	<xmqqr3t1vefz.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
	<xmqqr3szql9r.fsf@gitster.dls.corp.google.com>
	<xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
	<CACsJy8Cj97NrvuAXjqRbd52ivaHZ_oqy+k-3_LeRSe2Jy6U33Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 16:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdgNj-00077e-Qi
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 16:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbbDBOp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 10:45:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752725AbbDBOp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 10:45:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DFD342FC1;
	Thu,  2 Apr 2015 10:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LFhLIXjjjm2k4WstFjRxFMeHmLg=; b=ZalGEF
	zGhirsXFOl/YuGa2vWULfuVXNlf00xSKdk4Rwq7aj+XzsiPLFCg1dDGGssqACPUl
	qmJQn+/q/tf19GDzDTs18CiM/En6aQ6YMrd+JYo04Ep4o+RwnJctmhRRuRkjEDQZ
	/1xgCKLxNygd9Ca49wp6yHZnr8MMGpDqQXQkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sMAHzVwltsmulHKInWj8FxH2zn2hL3A1
	igXcXDC5EU9zaTSFNNq1+Yf3pqI0su2sNmoKL3nRpEZwVFSpAKbXrXEY9hdie6WJ
	ixB1IqcKRRed+VbpdJ+4i+yRudkiLNZfzlNc7ssa3KOThxBJabr2rvkxoQD2DxrD
	OYnqpve8LdQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 656D742FC0;
	Thu,  2 Apr 2015 10:45:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C096942FBF;
	Thu,  2 Apr 2015 10:45:55 -0400 (EDT)
In-Reply-To: <CACsJy8Cj97NrvuAXjqRbd52ivaHZ_oqy+k-3_LeRSe2Jy6U33Q@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 2 Apr 2015 19:37:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7E7CBBC-D946-11E4-A84A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266641>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Apr 1, 2015 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> This is a follow-up on $gmane/264553, which is a continuation of
>> $gmane/264000, but instead of giving two required readings to
>> readers, I'll start with reproduction of the two, and add a few more
>> things the current protocol lacks that I would want to see in the
>> updated protocol.
>
> I think the important thing to get v2 started is making sure we do not
> need v3 to get rid of any of these limitations. In other words v2
> should be extensible enough to implement them later.

Yes.

>>    ...
>
> I don't have an answer to this one. So the reaction is,...
> "broken" (in pratice, not in theory), don't touch it. I know I'm
> burying my head in the sand..
>    ...
> Introducing the ref exchange in push-pack could be done in an
> extension too, I think.

Thanks, but you do not have to "solve" these sample issues here.  As
you said above, your primary goal at this stage is to make sure v2
is extensible to cover future needs, and in order to do so, you need
to make sure "what's lacking" list is fairly complete.  You are not
helping from that point of view.

I'd like to see a new protocol that lets us overcome the limitations
(did I miss others? I am sure people can help here) sometime this
year.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Thu, 04 Sep 2014 09:51:35 -0700
Message-ID: <xmqqtx4nuy5k.fsf@gitster.dls.corp.google.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
	<CACsJy8C_=aNX9LT2V_zhw++tC22C5SDfwbpTS=juONMxwcV9pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 18:51:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPaG7-0004Xj-CV
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 18:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbaIDQvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 12:51:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64959 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaIDQvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 12:51:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27E9637422;
	Thu,  4 Sep 2014 12:51:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g91ITBVEx7Ax6X/GzyOVsH91C4U=; b=QvOQnQ
	Fd910oIXIfK/lJ3WvSpWBpVLmD3QEpHgKxu574Q4DSSB2bS4Tu7FuZoRRzStDewO
	lvXK9+C88U0A2FbrNw3KEkGWx9KeR7Z31coyLX2NaZDC4BITirTpb8mR5htwbNoh
	xb+JTtkGYVH3pEVPmuhv3zZF8aMwxPHqLgSGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BX23xZHR4Mg75SvGbZIlopBr5q/Ha0fo
	jZB1SZjzJ8PmUIWbl+o503xhZgrZ/J1+xca/4jaUl45YMSaG2HkXj1hc7QKsGBvZ
	SZHtAahnKRdz1vyFB8VJn3ygPgdfoSBGiAKolCR8c7O2bIuvMr4Z5k0sbQLjbAy4
	75SS2zsSZaY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B99D37421;
	Thu,  4 Sep 2014 12:51:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 878E737420;
	Thu,  4 Sep 2014 12:51:37 -0400 (EDT)
In-Reply-To: <CACsJy8C_=aNX9LT2V_zhw++tC22C5SDfwbpTS=juONMxwcV9pA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 4 Sep 2014 20:46:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC659A4E-3453-11E4-970E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256450>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Sep 3, 2014 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/multiple-work-trees (2014-07-29) 39 commits
>>
>>  Reroll posted, but haven't picked up yet.  How would this interact
>>  with rr/transaction series which is pretty much all about the refs?
>
> Haven't checked out that topic yet. But ref changes in
> multiple-work-trees are to make sure ref path construction goess
> through git_path(), and some cleaning up after strbuf_git_path() is
> introduced. So basically textual conflicts only.

Up to the point that is queued on 'pu', the other topic(s) still
keep the assumption that all refs are files in $GIT_DIR/refs/, and I
think I managed the textual conflicts correctly in 'pu' before.

But starting from $gmane/255476 the assumption gradually gets lifted
and eventually we may have refs and reflogs expressed in a different
backend, without these files that represent the refs at all.

I am not yet sure how this "I have $GIR_DIR/ but that is not a real
one but borrows most of the stuff from elsewhere" meshes with that
new world.

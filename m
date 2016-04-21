From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 08:37:32 -0700
Message-ID: <xmqqk2jrt1kz.fsf@gitster.mtv.corp.google.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-5-git-send-email-pclouds@gmail.com>
	<CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
	<CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
	<CACsJy8ATaYx0Fk-7HK9Rz_o687hxCLuOJYJ6DkBd4Xk8sP+byw@mail.gmail.com>
	<CAPig+cQkT8vb-OVdS_ALVuDii9njY6BN2FhkXt=CavAfyeO2Fg@mail.gmail.com>
	<20160421151355.GA6200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Reto =?utf-8?Q?Hab?= =?utf-8?Q?l=C3=BCtzel?= 
	<rethab.ch@gmail.com>, Mike Rappazzo <rappazzo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 17:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atGfl-00069f-2C
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 17:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcDUPhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 11:37:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbcDUPhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 11:37:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E1EC13111;
	Thu, 21 Apr 2016 11:37:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iahwJBez4LbTOsyR6GRiiTLCRTY=; b=rqZrfd
	2Y65jg0lPoSGizFjvzpbumyHrRVnxtz9NdZ+8uUtWcYzbh6R1oczZ8J6gEXwjywW
	3k063vXgU71lzEh5GSO6wESBrig5iHdB7TMQWQ7hkZRperml6gbqjWR9+P3n79O8
	7WsDIPAM5qX9fuWp1e5LEO5Zqq+4fYBFI8UAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BDqkn7kkUb0rbkCusmJaGl+JU6mX/F/B
	KlNVk+6v7F+wVeMRMTGN3lGvsrukfSoibO3ziqPOZUz4zE2Zw23x4K6t0NvDI+jZ
	Y2L94FeJU+0l8fh1Ht/wN9cJwCHiSaxgu5c36nInx8hnFAncHpBIZ5n45BaC+6E5
	3ov2P8WdsuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8643113110;
	Thu, 21 Apr 2016 11:37:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDDE21310F;
	Thu, 21 Apr 2016 11:37:33 -0400 (EDT)
In-Reply-To: <20160421151355.GA6200@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 21 Apr 2016 11:13:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F79A8AB8-07D6-11E6-A04B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292114>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 21, 2016 at 10:23:09AM -0400, Eric Sunshine wrote:
>
>> > While we're at it, how about renaming it to pathcmp (and its friend
>> > strncmp_icase to pathncmp)?
>> 
>> Yes, that seems like a good idea. For anyone familiar with
>> strcasecmp() or stricmp(), having "icase" in the name makes it seem as
>> though it's unconditionally case-insensitive, so dropping it from the
>> name would likely be beneficial.
>
> Seconded (thirded?). I have been caught by this confusion in the past,
> too.

I agree that strcmp_icase() gives a false impression that it always
ignores case differences, but a new name that does not at all hint
that it may do icase comparison as necessary will catch me by an
opposite confusion in the future.

I have not yet formed a firm opinion if pathcmp() conveys enough
hint.

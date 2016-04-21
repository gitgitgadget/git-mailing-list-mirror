From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 08:42:54 -0700
Message-ID: <xmqqfuuft1c1.fsf@gitster.mtv.corp.google.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-5-git-send-email-pclouds@gmail.com>
	<CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
	<CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
	<CACsJy8ATaYx0Fk-7HK9Rz_o687hxCLuOJYJ6DkBd4Xk8sP+byw@mail.gmail.com>
	<CAPig+cQkT8vb-OVdS_ALVuDii9njY6BN2FhkXt=CavAfyeO2Fg@mail.gmail.com>
	<20160421151355.GA6200@sigill.intra.peff.net>
	<xmqqk2jrt1kz.fsf@gitster.mtv.corp.google.com>
	<20160421154058.GA9525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Reto =?utf-8?Q?Hab?= =?utf-8?Q?l=C3=BCtzel?= 
	<rethab.ch@gmail.com>, Mike Rappazzo <rappazzo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 17:43:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atGl3-0001fU-NX
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 17:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbcDUPnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 11:43:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752751AbcDUPm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 11:42:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BE04131D0;
	Thu, 21 Apr 2016 11:42:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S9P0ZmNbMB7SPBuzzg5xGhfqKZw=; b=eiiiCq
	Mf6GOEpO8GcWyQiEpXz5yMGBry9ryaJ4GB127gThnPrHmTPrhFTu8q+jsmhiMNmv
	ccpxN9lLZU9dBae9NqRBaMeHkxCTgEIB6IDwWd4y7MNRFp58pwbSOQ7Ain3POfZV
	WbO+6oVyszr8rbgDHlmjr8Hz5EUR1aohGiPic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iipSL4LZlb0pSY3V6ILqfXLs3bJRlxeK
	3vXW39qUShagQPi9Lemlb779TNrYpYF8M1BoD/9K3ql0fav5/nKq2wYtnYeLhG2c
	Cm91UCOPdoMlY+CKInkbQbsdggvs4bORyg5aUM8OhIYf/JXv+uxCnaRdUAAJTngZ
	9vT+rGQLO4A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63CC5131CF;
	Thu, 21 Apr 2016 11:42:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B77F6131CE;
	Thu, 21 Apr 2016 11:42:55 -0400 (EDT)
In-Reply-To: <20160421154058.GA9525@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 21 Apr 2016 11:40:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B76ECEEE-07D7-11E6-8245-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292117>

Jeff King <peff@peff.net> writes:

> To me, the benefit is that you don't have to care about ignore_case. You
> have asked to compare two paths, and any system-appropriate magic should
> be applied. That may be icase, or it may be weird unicode normalization.
>
> I think the key thing missing is that this is only about _filesystem_
> paths. You would not want to use it for tree-to-tree pathname
> comparisons. So maybe "fspath" or something would be more descriptive.

Yup, I would be very happy with "fs" in the name.

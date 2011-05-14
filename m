From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Submodules: Don't parse .gitmodules when it
 contains, merge conflicts
Date: Sat, 14 May 2011 10:56:41 -0700
Message-ID: <7vfwoh5fom.fsf@alter.siamese.dyndns.org>
References: <4DCEACF8.50503@web.de> <4DCEAD52.60707@web.de>
 <BANLkTinvkxDYqNs3Pv0CniGtAHm5dJf0wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 19:57:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLJ5z-0000sk-7s
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 19:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab1ENR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 13:56:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab1ENR4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 13:56:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E7A258BD;
	Sat, 14 May 2011 13:58:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXTGFOY6mz9qwrOKqZIxdmzh8lU=; b=VB1d16
	PEM//B0yJEZ5AA7hrfQHzHPGt3lClH02zdAoaUMMWpavnsURWXEAou+1el2L8QvP
	nmhkpDWJf/VkA2UR85+9d/qRN5E/DMXqcaLm6sfFMHIwErFjpE2/MLVRlGJwuBL8
	vxU6qcuFR83NZnPbdPVct4ukEaMfM4yHprjto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vic56h9TyPRFES/29ZKWLLiWju7Y/b/6
	cPHgib+6/ePUhzumkmc4ltFZemiPWFNJuaPVAfXcj9tgCew1ZZLE7U38DwT5/SeR
	lJ8aPD3vQdZO0g7hdcKMGDsIOphw54tKtKDMEk6gBP2rVS006nFQhN20OjmWK6bR
	wd1zavZwy9M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1538758BC;
	Sat, 14 May 2011 13:58:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B9B9A58BB; Sat, 14 May 2011
 13:58:49 -0400 (EDT)
In-Reply-To: <BANLkTinvkxDYqNs3Pv0CniGtAHm5dJf0wg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 14 May 2011 23:59:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D57744A6-7E53-11E0-9B63-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173599>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, May 14, 2011 at 11:26 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Commands like "git status", "git diff" and "git fetch" would fail when the
>> .gitmodules file contained merge conflicts because ...
>
> Side note. .gitattributes and .gitignore likely suffer the same.
> Perhaps the unmerged check in this patch can be generalized for reuse.

I am somewhat skeptical about that statement.  These files are designed to
be one-entry-per-line so that useful information in the non-conflicted
parts in a conflicted file (which should be majority) can still be used.
Only the .gitmodules is an oddball.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to ~/.config/git"
Date: Mon, 14 Mar 2016 13:33:26 -0700
Message-ID: <xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
	<CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:33:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZBM-0003xC-DD
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 21:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbcCNUdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 16:33:31 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755917AbcCNUda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 16:33:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0AF54C0F3;
	Mon, 14 Mar 2016 16:33:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pyyzvlgLWcHT
	U4TC2YxVdpx2Cew=; b=s5CeBbaM+Z3mMKmoH42U0WmU9/59YM806WuW8FK2IUnO
	Sfw3KYpZC7hXOgZrtgqRVe+1Jb6Eo2+eFqs5+zxjF9EBMsh4DIiFuSEMxPSvM7XJ
	sA2dlMQ3+1+uD6iw1R+8qCbVn98X/0Tx88L9O3MFMaIy73QWzc5rE2UgiU8f58w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YVbDoa
	1s4wwM+a0BKIcTCnp3Vpbb3OkyHJZ64qd9LFKyefPQ+2gAxT6pLVd65JZ/Km8N3a
	PhnyuL3Lvb/02iOr26gaPBvQDYq8341iDbOJiofDghv2WaSsIEc/xajp457h+oD1
	egqM5G7ORAOO2ScmlDDKxbk5GgV7AYy2wFl1E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D85324C0F1;
	Mon, 14 Mar 2016 16:33:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1AD2A4C0F0;
	Mon, 14 Mar 2016 16:33:28 -0400 (EDT)
In-Reply-To: <CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Tue, 15 Mar 2016 03:53:52
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 023245C2-EA24-11E5-BF18-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288808>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

> After reading the
> [spec](https://specifications.freedesktop.org/basedir-spec/basedir-sp=
ec-0.7.html)
> more carefully, I think that $XDG_RUNTIME_DIR may be a better choice =
than
> the above two. For ~/.git-credential-cache/socket is a unix socket an=
d should
> be used only runtime.

Nice.

> Of course I could check the existence of `~/.git-credential-cache` an=
d
> `$XDG_CONFIG_HOME/git/credential-cache` to decide where to put
> the socket,

I think that is the most sensible.  They are directories that are
expected to be persistent, aren't they?

You sound like you think it is better to check the location of the
existing socket, but I am having a hard time understanding and/or
guessing why you might think so, especially when you already know
that the socket itself may not be persistent.  Puzzled...

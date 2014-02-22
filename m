From: David Kastrup <dak@gnu.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Sat, 22 Feb 2014 07:20:28 +0100
Message-ID: <87fvnbhdn7.fsf@fencepost.gnu.org>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8DnjQyzY2ym7=fAQzThuhMuFzGLuKc35JJXn5FfB7r4Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:49:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8HI-0003Yw-JN
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaBVItk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 03:49:40 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:40777 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbaBVItj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 03:49:39 -0500
Received: from localhost ([127.0.0.1]:39818 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WH8HD-0003o3-8T; Sat, 22 Feb 2014 03:49:39 -0500
Received: by lola (Postfix, from userid 1000)
	id BB956E04F5; Sat, 22 Feb 2014 07:20:28 +0100 (CET)
In-Reply-To: <CACsJy8DnjQyzY2ym7=fAQzThuhMuFzGLuKc35JJXn5FfB7r4Gg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 22 Feb 2014 07:36:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242510>

Duy Nguyen <pclouds@gmail.com> writes:

> OK with git://git.savannah.gnu.org/emacs.git we have
>
>  - a 209MB pack with --aggressive
>  - 1.3GB with --depth=50
>  - 1.3GB with --window=4000 --depth=32
>  - 1.3GB with --depth=20
>  - 821MB with --depth=250 for commits --before=2.years.ago, --depth=50
> for the rest
>
> So I don't think we should go with your following patch because the
> size explosion is just too much no matter how faster it could be. An
> immediate action could be just make --depth=250 configurable and let
> people deal with it. A better option is something like "3 repack
> steps" you described where we pack deep depth first, mark .keep, pack
> shallower depth and combine them all into one.
>
> I'm not really happy with --depth=250 producing 209MB while
> --depth=250 --before=2.year.ago a 800MB pack. It looks wrong (or maybe
> I did something wrong)

That does look strange: Emacs has a history of more than 30 years.  But
the Git mirror is quite younger.  Maybe one needs to make sure to use
the author date rather than the commit date here?

-- 
David Kastrup

From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed <paths>
Date: Sun, 15 Aug 2010 20:51:03 +0000
Message-ID: <AANLkTik+yGn_0PR9uO2_EsZgQPW187P4qmZx4fJSbAWO@mail.gmail.com>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
	<20100814210505.GA2372@burratino>
	<7vvd7chcj4.fsf@alter.siamese.dyndns.org>
	<87tymwzjbk.fsf@catnip.gol.com>
	<AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
	<7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Ralf Ebert <info@ralfebert.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 22:51:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkkAi-0004Ew-Kf
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 22:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891Ab0HOUvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 16:51:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39757 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab0HOUvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 16:51:04 -0400
Received: by iwn7 with SMTP id 7so957410iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RbkWwLkyUkY/wfcy+sFEofNUBVyl8X90pTrUxUlLj2A=;
        b=IO1yBK7elGtUHiCxmEdHXvl7kbDYfu8uZPWY2VNc650moIDJ7CWeh/sLRJftBR8jOl
         kaYkHIcP5+ag6U3rGypyMzqzb4Rsk4UkkE90V4LjBerv1KZu165tDYWRDGUyDDIvhkq0
         6mSyHdspGhuuMEh2VpzXzWXdc+xpk51dpK4jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lX0Uo/2RpKbZgnlAtMLiw+bwLSCpFqMbW5MMfDFGAD7JqkZuovBeV70LzM8g78XT1a
         HqfXN23DWWAvSq+jUZxAemPvZBcZsVwvsN/26M8SXuWzndITUQxb0TilM+zlX52i6zR2
         BBFDsrP7hiBMbEr0MuRh7+ZmnaZnmk/vnTFqE=
Received: by 10.231.177.25 with SMTP id bg25mr4532918ibb.154.1281905463325;
 Sun, 15 Aug 2010 13:51:03 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 13:51:03 -0700 (PDT)
In-Reply-To: <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153620>

On Sun, Aug 15, 2010 at 18:36, Junio C Hamano <gitster@pobox.com> wrote=
:

> What if we:
>
> =C2=A0- change "reset --hard [<commit>] -- <pathspec>" to internally =
run the
> =C2=A0 moral equivalent "checkout" without complaining;
>
> =C2=A0- change "reset --mixed [<commit>] -- <pathspec>" to do the sam=
e thing as
> =C2=A0 it has always done without complaining; and
>
> =C2=A0- make sure "reset --soft [<commit>] -- <pathspec>" barfs loudl=
y.
>
> Do people see major downside?

Generally I'd like to see Git move towards have a more internally
consistent UI and less warts.

Doing what you suggest would make git-reset(1) more internally
consistent, while duplicating the git-checkout functionality.

So it's a question of whether git-reset should do all reset-y things
without complaining, even when that infringes on git-checkout's
domain.

I don't know which should be picked, but it's something to
consider.

One thing I'd like to see is some documentation showing how we'd like
Git to act if we didn't have to worry about backwards compatibility. I
sometimes see little warts like mixing of cached/index/stage, but I
haven't seen any plan for these sort of things. Are we planning to
change some of these things in the future? If so when, and what should
be changed?

It's hard to say whether a UI change like this makes sense without the
bigger picture.

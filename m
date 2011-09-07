From: Joel Kaasinen <joel@zenrobotics.com>
Subject: Re: [BUG] git bisect start fails when stale bisect data is left behind
Date: Wed, 7 Sep 2011 09:28:16 +0300
Message-ID: <CAC6WLetO-KKkHmPHJ64rt6+BMbhUHUtNfxF3GK4obMUAuE9XXQ@mail.gmail.com>
References: <CAC6WLetwT9UvBY_=Nf38hhkyU1mhmdWHWqscf3ebba1WRGS1LQ@mail.gmail.com>
	<CAP8UFD1h059dOyjszcP-qFauyho78c0RHBMQsGOPFgzZtp+7vg@mail.gmail.com>
	<7vehztaan4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 08:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1BhW-00035U-2X
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 08:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab1IGGd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 02:33:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32857 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab1IGGd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 02:33:27 -0400
Received: by ywf7 with SMTP id 7so4673109ywf.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 23:33:27 -0700 (PDT)
Received: by 10.43.133.70 with SMTP id hx6mr857556icc.134.1315376896384; Tue,
 06 Sep 2011 23:28:16 -0700 (PDT)
Received: by 10.231.133.131 with HTTP; Tue, 6 Sep 2011 23:28:16 -0700 (PDT)
In-Reply-To: <7vehztaan4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180855>

On Tue, Sep 6, 2011 at 19:38, Junio C Hamano <gitster@pobox.com> wrote:
> I do not necessarily think this is a bug to begin with --- the user h=
ad a
> bad state, and bisect stopped without doing further damage.

Oh, actually my git-bisect man page says:

"""
   Bisect reset
       After a bisect session, to clean up the bisection state and retu=
rn to
       the original HEAD, issue the following command:

           $ git bisect reset

       By default, this will return your tree to the commit that was ch=
ecked
       out before git bisect start. (A new git bisect start will also d=
o that,
       as it cleans up the old bisection state.)
"""

The parenthetical sentence seems to imply that a bisect start cleans
out the old state. The problem is that the cleaning fails when the
state is bad. (Try e.g. "git bisect start; git bisect start a b" where
a and b are valid refs.)

It's pretty much the same to me how this gets resolved. I'm fine with
a more verbose error message from bisect start.

=96J

From: Luc Pionchon <pionchon.luc@gmail.com>
Subject: Re: [PATCH] pretty: add '*' modifier to add LF after non-empty
Date: Fri, 24 Feb 2012 12:58:58 +0200
Message-ID: <CAEYyJDyE88w2R5duQgm21w50OkU+J4qbs00=TfV=FvXPyUWaVA@mail.gmail.com>
References: <1330002637-9347-1-git-send-email-pionchon.luc@gmail.com> <7v7gzd498r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 11:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ssL-0007bg-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 11:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab2BXK7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 05:59:41 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48638 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653Ab2BXK7k convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 05:59:40 -0500
Received: by lagu2 with SMTP id u2so2652635lag.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 02:59:38 -0800 (PST)
Received-SPF: pass (google.com: domain of pionchon.luc@gmail.com designates 10.112.99.231 as permitted sender) client-ip=10.112.99.231;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pionchon.luc@gmail.com designates 10.112.99.231 as permitted sender) smtp.mail=pionchon.luc@gmail.com; dkim=pass header.i=pionchon.luc@gmail.com
Received: from mr.google.com ([10.112.99.231])
        by 10.112.99.231 with SMTP id et7mr663656lbb.57.1330081178549 (num_hops = 1);
        Fri, 24 Feb 2012 02:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UcPMUd4bhD2WEsoJjEnB4WpIA/3+yYPvvWJpr8fbFls=;
        b=RKItVCLFnaCv56eyxd196T75fZvTODHY74KgUGYy0Dz1FC+dYsTsNMqST5/nLzpSKj
         mI1IbvZTad+OSYZvQVCvbaJmhkACJdkYpysdVuHoJbYa2GKpvBpYOCRpRiD0T/ys9ZMv
         bgloQCanc+/6tSLsSndCLdkPOrnpzd2nrm3mM=
Received: by 10.112.99.231 with SMTP id et7mr554799lbb.57.1330081178479; Fri,
 24 Feb 2012 02:59:38 -0800 (PST)
Received: by 10.152.21.165 with HTTP; Fri, 24 Feb 2012 02:58:58 -0800 (PST)
In-Reply-To: <7v7gzd498r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191428>

On Thu, Feb 23, 2012 at 21:53, Junio C Hamano <gitster@pobox.com> wrote=
:
>
> Luc Pionchon <pionchon.luc@gmail.com> writes:
>
> > Add the '*' modifier, similar to the '+' modifier,
> > to add a line-feed after a non-empty placeholder.
>
> Hrm, I thought I designed the plus and minus fairly carefully so that
> nobody needs to add this later.
>
> Wouldn't it be sufficient to write
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Foo%n%-d
>
>
> that says "We usually have LF after Foo, and write %d after that, but=
 we
> might not have anything interesting in %d at all, in which case we do=
n't
> add that %n"?

What I want is a LF after the non empty, rather than before.
It seems to me that %n%-d is equivalent to %+d,
or did I miss something?

See the 3 examples below, with %n%-d, %+d and %*d

$ ./git log -5 --graph --pretty=3Dformat:"%C(yellow bold)%n%-d %C(reset=
)%s"
*
|\=C2=A0=C2=A0 (HEAD, origin/master, origin/HEAD, master) Sync with 1.7=
=2E9.2
| *
| |=C2=A0 (v1.7.9.2, origin/maint) Git 1.7.9.2
| *=C2=A0 completion: use tabs for indentation
| *=C2=A0 completion: remove stale "to submit patches" documentation
* |=C2=A0 git-p4: the option to specify 'host' is -H, not -h

$ ./git log -5 --graph --pretty=3Dformat:"%C(yellow bold)%+d %C(reset)%=
s"
*
|\   (HEAD, origin/master, origin/HEAD, master) Sync with 1.7.9.2
| *
| |  (v1.7.9.2, origin/maint) Git 1.7.9.2
| *  completion: use tabs for indentation
| *  completion: remove stale "to submit patches" documentation
* |  git-p4: the option to specify 'host' is -H, not -h

$ ./git log -5 --graph --pretty=3Dformat:"%C(yellow bold)%*d %C(reset)%=
s"
*=C2=A0=C2=A0=C2=A0 (HEAD, origin/master, origin/HEAD, master)
|\=C2=A0=C2=A0 Sync with 1.7.9.2
| *=C2=A0 (v1.7.9.2, origin/maint)
| |=C2=A0 Git 1.7.9.2
| *=C2=A0 completion: use tabs for indentation
| *=C2=A0 completion: remove stale "to submit patches" documentation
* |=C2=A0 git-p4: the option to specify 'host' is -H, not -h


Also as a side note, I noticed that color is lost after new lines.

>
> > +test_expect_success 'add LF after non-empty (1) (empty)' '
> > + =C2=A0 =C2=A0 git show -s --pretty=3Dformat:"%*d%s%nfoo%n" HEAD^^=
 >actual &&
>
> Shouldn't this be equivalent to "%n%-d%s%nfoo%n", which in turn is co=
vered
> by one of the previous tests (del LF before empty)?

I think the later is equivalent to %+d%s%nfoo%n, am I wrong?

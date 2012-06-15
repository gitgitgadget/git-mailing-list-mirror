From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCHv2] git bisect old/new
Date: Fri, 15 Jun 2012 16:20:51 -0400
Message-ID: <CABURp0qGUvjtOBp8vQ4LqWsWp-5oi+-2GwVq-edQbUnKzXHR-A@mail.gmail.com>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <7vr4tkhys5.fsf@alter.siamese.dyndns.org> <20120613200606.Horde.QkenYnwdC4BP2NaOTf8gvnA@webmail.minatec.grenoble-inp.fr>
 <CAP8UFD2LBKXuey2w_-0Zy9Thi1DWCgekjCL3RULmHWVK5DXCog@mail.gmail.com> <7vlijper0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	duperrav@minatec.inpg.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Peff <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:21:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfd1B-0002U6-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab2FOUVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 16:21:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35473 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277Ab2FOUVM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 16:21:12 -0400
Received: by yhmm54 with SMTP id m54so2830235yhm.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Vk6vX66LV/RhUmHANI3rf9sKEn1Hr4TW8bTwu8E0rhw=;
        b=qCo+xM1d7m8TwCSPPzyBV93+kBphNySfooWzD1CH4t2QyL47BlgI5kpnMCZCiLauUQ
         OwlKP5ZY5x6s+UR0fbHweiKbvxWPxNSkMKysCrlL6sqo28SyTsmKKIcbWECkeR4N0uG4
         /2b1QFc2RlFIEZ6gyH4Wi0Dv/Vdk10VfcScIdsnmRTwi1atUQ7m86jdizhc+2LvO2vDr
         7hyOo5bBXqqg4fT4HDRXqtOXxQV3LW4A7TwNiXXA9TlVFVAvA5/CjMo+b2IoxuFlq92O
         EnrP6K8EJEo1kPxcWSegZSeyXR6cZ5UPcMEnzC1Lnyme03OlTT+sflsrTkeyQAs/arnG
         I1eA==
Received: by 10.236.153.4 with SMTP id e4mr9409824yhk.89.1339791671677; Fri,
 15 Jun 2012 13:21:11 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 15 Jun 2012 13:20:51 -0700 (PDT)
In-Reply-To: <7vlijper0e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200091>

On Thu, Jun 14, 2012 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Peff said:
> >
> > -------
> > Hmm. I think this is not quite as nice, but it is way simpler. It m=
ay be
> > worth trying for a bit to see how people like it. If they don't, th=
e
> > cost of failure is that we have to maintain "old/new" forever, even
> > after we implement a yes/no reversible scheme. But maintaining the
> > old/new mapping from yes/no would not be any harder than the good/b=
ad
> > mapping, which we would need to do anyway.
> >
> > So it sounds like a reasonable first step.
> > -------
>
> The above is a very reasonable stand. =A0But I do not think it leads
> to the following at all.
>
> > So I'd rather have a file with a generic name like "BISECT_TERMS", =
but
> > it may contain just one line like for example "new/old".
>
> That is forcing an unnecessary complexity, when we do not even know
> if we need anything more than old/new. =A0We can start simple and the
> result may be sufficient and in which case we can stop there.
>
> In fact, Peff's advice you quoted is against doing what you just
> said, which is to do more than we know that we need right now.
>
> If we end up needing arbitrary pair of words, then at that point we
> may add a mechanism that records the pair of words in use, be they
> <yes/no>, or <frotz/xyzzy>. =A0And when that happens, <new/old> will
> continue to be supported for free--there is no extra work to support
> <new/old> in addition to the work needed to support <good/bad> and
> <arbitrary1/arbitrary2> that we need to support anyway.

Except that most of the work to support <arbitrary1/arbitrary2> is
already being done in this patch to add <new/old>, but it will need
re-doing or un-doing to move to arbitrary terms.  Supporting arbitrary
terms today would save work (the re-doing and the un-doring), if we
went that way in the future.

But perhaps we won't.

Phil

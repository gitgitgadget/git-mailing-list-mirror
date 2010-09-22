From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv2 4/4] t7500: add tests of commit --squash
Date: Wed, 22 Sep 2010 11:59:29 -0600
Message-ID: <AANLkTinajr6DvYeyiK79xESYqg0kegUN1s8LxEqGoUc+@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
 <1285100703-49087-5-git-send-email-patnotz@gmail.com> <AANLkTinTA23Xf2AFLW+tzeLq1AWUhBBuca63qs_foXtr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 20:00:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTbp-0001kG-5i
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 19:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab0IVR7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 13:59:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53445 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0IVR7u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 13:59:50 -0400
Received: by fxm12 with SMTP id 12so215627fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lHjokumrXfYaJ1KKZmKX4f/nflf+iY/YZfcCS7hp8FU=;
        b=wjn/b4b5oqi4v66F9Rt2bmCkCC4TxEp1MDXvdCyYNZNqTHNOV2VCAV5+S95f79WnR3
         RMpUQP0yKfn7r6QHz+CH8sBYS25TNvpFLXmeA7/j4pdaZmoXXAgRu4PfLhuYVFO+4xZM
         2aErEeGlU8ZMkP0vxdF3TNgBYq44ZG/V6iwfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CiVALAJhTvj3xKA6JS2n9wvY+lwUhJNibCzmCaSVyTVwsb5YHxPLEpKPClCcfAncUY
         rPZom2Vg2o3kmYMxqkP0wEC3zbYuBYVAbBeXtcPoEqHxJNvQIAbV9PEOic2FuhQW/Bhm
         mj62k1YUlW53QWmdcji/szalwdjWWyG9FxbFw=
Received: by 10.239.168.68 with SMTP id j4mr35055hbe.115.1285178389307; Wed,
 22 Sep 2010 10:59:49 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 22 Sep 2010 10:59:29 -0700 (PDT)
In-Reply-To: <AANLkTinTA23Xf2AFLW+tzeLq1AWUhBBuca63qs_foXtr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156813>

On Tue, Sep 21, 2010 at 2:36 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Sep 21, 2010 at 20:25, Pat Notz <patnotz@gmail.com> wrote:
>
> > +cat >editor <<\EOF
> > +#!/bin/sh
> > +sed -e "s/intermediate/edited/g" <"$1" >"$1-"
> > +mv "$1-" "$1"
> > +EOF
> > +chmod 755 editor
> > +
> > +test_expect_success 'commit --squash works with -c' '
> > + =A0 =A0 =A0 commit_for_rebase_autosquash_setup &&
> > + =A0 =A0 =A0 EDITOR=3D./editor git commit --squash HEAD~1 -c HEAD =
&&
> > + =A0 =A0 =A0 commit_msg_is "squash! target message subject lineedi=
ted commit"
> > +'
>
> Why not put the editor in t/t7500/ and use test_set_editor() like the
> other tests?

The real reason is that I'm new enough that I wasn't aware of this
pattern.  I saw what was done in t7501-commit.sh and followed along.
I missed the use of test_set_editor() right there in t7500-commit.sh.
Doh!

I can certainly do that if it's preferred.  I must say, though, that I
find it odd to put test inputs in a separate file in a separate
directory from where the test transforms those into expected outputs.
To see what the test is doing you have to load both files and trace
through it.

Still, I'd be happy to change do this if that's the preferred way.

From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2 4/4] t7500: add tests of commit --squash
Date: Tue, 21 Sep 2010 20:36:21 +0000
Message-ID: <AANLkTinTA23Xf2AFLW+tzeLq1AWUhBBuca63qs_foXtr@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
	<1285100703-49087-5-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 22:36:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9Zu-0006eI-TQ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab0IUUge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 16:36:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39821 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab0IUUgd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 16:36:33 -0400
Received: by gwj17 with SMTP id 17so1771268gwj.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5DKEGo6npCdw3zWdCEThaP3YWLeT4df+nBvksEXri9E=;
        b=tN7QIP0fKAocXV16x3ybCsmMMz+sUWhPgm9EZGoha3GfLLAym8Kytqkk+S0O/bRTgd
         Yhd3PemsxTMyO13m/6Jjd27bsNcVfSLBk5sfxjuOnFBh0Ae3KxHTFaoz3DqlIBStCtRs
         4WgmidB6VpoEAG/kjtgiKTUS+4u4ip0U1Yms8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WZxCVmWdiPOlAAmPi22ZH2hwExKx8KbAJzSpUrIszxq9B4H4du0qlS5nWOSRJ8Vz6N
         8cQPDGAENd76lNcQOGNSN5mriwdhW5cu93dkwunsg+aD2FXM24ctcEyCUCSOtLZv301t
         9HihQPCQI0HUQduhoYwASL0lk9PhbplMvEJA0=
Received: by 10.90.65.15 with SMTP id n15mr3485768aga.196.1285101381319; Tue,
 21 Sep 2010 13:36:21 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 21 Sep 2010 13:36:21 -0700 (PDT)
In-Reply-To: <1285100703-49087-5-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156756>

On Tue, Sep 21, 2010 at 20:25, Pat Notz <patnotz@gmail.com> wrote:

> +cat >editor <<\EOF
> +#!/bin/sh
> +sed -e "s/intermediate/edited/g" <"$1" >"$1-"
> +mv "$1-" "$1"
> +EOF
> +chmod 755 editor
> +
> +test_expect_success 'commit --squash works with -c' '
> + =C2=A0 =C2=A0 =C2=A0 commit_for_rebase_autosquash_setup &&
> + =C2=A0 =C2=A0 =C2=A0 EDITOR=3D./editor git commit --squash HEAD~1 -=
c HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 commit_msg_is "squash! target message subject =
lineedited commit"
> +'

Why not put the editor in t/t7500/ and use test_set_editor() like the
other tests?

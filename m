From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/7] revert: free opts.revs to do a bit of cleanup
Date: Tue, 22 May 2012 10:44:59 +0530
Message-ID: <CALkWK0=1a_LvQ=zhdAEt91j1sMsgp6J=_CyeNFOkB95dw15pnQ@mail.gmail.com>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org> <20120521145610.1911.57879.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 22 07:15:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWhRO-0005YK-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab2EVFPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 01:15:22 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44379 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab2EVFPU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 01:15:20 -0400
Received: by wibhj8 with SMTP id hj8so3031182wib.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 22:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dNuCu8BQjSlS7ag4RfSv5tpxALJJoyAXOIyKD8lY9LA=;
        b=EwyzMecsM5hPC4/ClFCNXvaBCYsN6q82RMREeE+IXURA8Bisi97bubvNaNrBKaXZDi
         r9wKUEebV4dzinwSxDkg2AMCskS5S1IWJPoYCzf01mDylSaWzvv1brXcRUdEQ77Zlo1Q
         ZH6biuGP4UJLU6jP/xWHW+7z1EbqKvX8tfCDoPZTp6y0xoGpJWqlHs2cZb0/tPgfqWuh
         hosCPGctpFmVPw2l/Kv2rMC4iPgYVo6YyaE53Gb19bwPZbruGiAsolTI5gcmzn3uWKf7
         OUIm2aHSnuttOwbwtO15o2Hs1/jqrFTc7M232ipQ37XregxH1vszpvb34yV5G/QcgDbx
         uVTA==
Received: by 10.180.102.36 with SMTP id fl4mr24008999wib.2.1337663719619; Mon,
 21 May 2012 22:15:19 -0700 (PDT)
Received: by 10.216.68.10 with HTTP; Mon, 21 May 2012 22:14:59 -0700 (PDT)
In-Reply-To: <20120521145610.1911.57879.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198175>

Hi Christian,

Christian Couder wrote:
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 82d1bf8..5f82a84 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -217,6 +217,7 @@ int cmd_revert(int argc, const char **argv, const=
 char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config(git_default_config, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0parse_args(argc, argv, &opts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D sequencer_pick_revisions(&opts);
> + =C2=A0 =C2=A0 =C2=A0 free(opts.revs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("revert =
failed"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;
> @@ -232,6 +233,7 @@ int cmd_cherry_pick(int argc, const char **argv, =
const char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git_config(git_default_config, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0parse_args(argc, argv, &opts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D sequencer_pick_revisions(&opts);
> + =C2=A0 =C2=A0 =C2=A0 free(opts.revs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("cherry-=
pick failed"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;

Technically, memory is allocated to both opts->revs and opts->xopts in
parse_args().  Why not free both?

Ram

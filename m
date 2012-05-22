From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/7] revert: free opts.revs to do a bit of cleanup
Date: Tue, 22 May 2012 22:03:10 +0200 (CEST)
Message-ID: <20120522.220310.2276783773227531713.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
	<20120521145610.1911.57879.chriscool@tuxfamily.org>
	<CALkWK0=1a_LvQ=zhdAEt91j1sMsgp6J=_CyeNFOkB95dw15pnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com,
	nbowler@elliptictech.com
To: artagnon@gmail.com
X-From: git-owner@vger.kernel.org Tue May 22 22:03:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvIn-0005aL-50
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab2EVUDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 16:03:20 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:35774 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab2EVUDT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 16:03:19 -0400
Received: from localhost (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1527BA61DE;
	Tue, 22 May 2012 22:03:11 +0200 (CEST)
In-Reply-To: <CALkWK0=1a_LvQ=zhdAEt91j1sMsgp6J=_CyeNFOkB95dw15pnQ@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198235>

Hi Ram,

=46rom: Ramkumar Ramachandra <artagnon@gmail.com>
> Hi Christian,
>=20
> Christian Couder wrote:
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index 82d1bf8..5f82a84 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -217,6 +217,7 @@ int cmd_revert(int argc, const char **argv, cons=
t char *prefix)
>> =A0 =A0 =A0 =A0git_config(git_default_config, NULL);
>> =A0 =A0 =A0 =A0parse_args(argc, argv, &opts);
>> =A0 =A0 =A0 =A0res =3D sequencer_pick_revisions(&opts);
>> + =A0 =A0 =A0 free(opts.revs);
>> =A0 =A0 =A0 =A0if (res < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("revert failed"));
>> =A0 =A0 =A0 =A0return res;
>> @@ -232,6 +233,7 @@ int cmd_cherry_pick(int argc, const char **argv,=
 const char *prefix)
>> =A0 =A0 =A0 =A0git_config(git_default_config, NULL);
>> =A0 =A0 =A0 =A0parse_args(argc, argv, &opts);
>> =A0 =A0 =A0 =A0res =3D sequencer_pick_revisions(&opts);
>> + =A0 =A0 =A0 free(opts.revs);
>> =A0 =A0 =A0 =A0if (res < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("cherry-pick failed"));
>> =A0 =A0 =A0 =A0return res;
>=20
> Technically, memory is allocated to both opts->revs and opts->xopts i=
n
> parse_args().  Why not free both?

I didn't see any leak with opts->xopts but I will have a look.

Thanks,
Christian.

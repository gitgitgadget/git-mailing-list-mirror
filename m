From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach 'git remote' that the config var branch.*.rebase
 can be 'interactive'
Date: Wed, 13 Jan 2016 13:03:57 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131302340.2964@virtualbox>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de> <vpq7fjdyfvu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Paul Tan <pyokagan@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKE6-0005LA-GR
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbcAMMIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:08:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:50122 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932144AbcAMMIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:08:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MaJPk-1adBUA2wIK-00Jus0; Wed, 13 Jan 2016 13:08:10
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <vpq7fjdyfvu.fsf@anie.imag.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Z8ms0kAa+GqCTBw+EnEvEeD3MXd1QyQCRlnHTvUboKCrLGeVb8x
 t0AhSvMhoFNSXMOznjpQzoPTY3Ky7zwRlsHidVF1UoPExmDtWw0WNk3TnJ9KM5QFzl9fXa5
 RGKRx1+fT2EUJcoDNmFUqzJpQvPiAP7g7+w3oPEKQ7xrR7OlpSb2hszK0UsdmgQhA7XXt9X
 vQ7Fn5q9BT9MPTq/bnVuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+nWaFNJxj10=:q+wnklYyOvAgaQx4CMvMGj
 J7kUm5bGIPakA+k1/DJOLOvIDgJoPf2Lym1AtZBnAXGFEYfzIfUOntTCt9Cwx7OmybRKn0e/u
 NRFM+UbK6pApPAsmbg0l7WqGC3g8ne8O4O+DfF8jv1Fub1CfaAcUBNpohaTZsA+EAt4rncMVc
 Btm9m3JfpoQpqBWGqIKHtZ0VnTyKuqFgsa9nHikCGAsFF71RLXWDIiCjkAhzgOSwPdMR7Fnev
 lF9OSwxHQVbvsFZwTIcJFpB08Ghw+7Um6fjtmEPIsTC6f6/apDg5syDPaPhu9nZWew1aoJUk/
 UhgkhoJVmHA1CKNjgtiEighWn//gb8cT3wcHq94+6ZM2eerkypUIOEMUn03aZR5BH2CFPAleS
 u69j2GV1lcxu5wvkBgvtgIfQXsbNDJpNTEaICuo/jN4Sz1J9bFC99FXkCRb/nxRrQENyEn5wp
 s2QWRGa1Xdw+8a8DA2Q5GNMHN2rdA8vreOXyVtajMsW4sRH6Vpn+jcDz+w3NZyFHkTQEvbufh
 hxnvBhHaoepuhT8rHmZvu8dMaj3Vq+ws244psvNQNdbkMpX6PjeL2fMUnqA0kwHWbn6EI/TtD
 qRR5IA2gwTHT5+TPz5AHVo5ALyxxBVrwpNmXE/mcE1KCXOOntPB1eg5dDxziAy2BgMC5z7bGF
 u10vwtj07n7Haq9WoL9BoQGBxUgnHgLDHI7dD98oJq1AUUL5vslQjgf7ikz3QX/EJrl+1w1Y5
 lnoV99MiRMPd2EoNnUl3qHS/K4mULvEWcgXbum/sPw7gHbJnB6yLoSGz2u/wkmguVjxvLMUy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283902>

Hi Matthieu,

On Wed, 13 Jan 2016, Matthieu Moy wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 6694cf2..0af8300 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> >  static struct string_list branch_list;
> > @@ -312,6 +312,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> >  				info->rebase = v;
> >  			else if (!strcmp(value, "preserve"))
> >  				info->rebase = 1;
> > +			else if (!strcmp(value, "interactive"))
> > +				info->rebase = INTERACTIVE_REBASE;
> 
> What happens if one has branch.*.rebase=interactive, and wants to make
> an exception? Does
> 
>   git pull --rebase=true
> 
> cancel the 'interactive' part?

It is the same situation as before (just substitute a
branch.*.rebase=preserve setting): yes, the config is parsed first, then
the command line, so the command line wins.

> I guess it is, but if so I think it should be tested and documented.

Is this really necessary, given that the behavior has not changed from
before?

Ciao,
Dscho

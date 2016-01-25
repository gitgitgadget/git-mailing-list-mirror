From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/19] mingw: let's use gettext with MSYS2
Date: Mon, 25 Jan 2016 17:16:48 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251714380.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <7162dcb55e6a317cba840ef1176d09d99fc37f6b.1453650173.git.johannes.schindelin@gmx.de> <xmqqio2ibfkn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 17:17:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNjp5-0001Vo-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 17:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbcAYQQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 11:16:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:58394 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932761AbcAYQQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 11:16:54 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LtZcC-1ZwLbB27im-010u59; Mon, 25 Jan 2016 17:16:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqio2ibfkn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:sD0UYJXfWrZwDK4rxrCHiGrapRQrH85xeJ9ETsa7ykkpB0Axatz
 bEcwoEgFRbUb/N4VUuIUQJk3jm7juqFbbaBT9Mk8Lyc/v+A2Dz0t+HAjhPWUoOzaI2O66Eg
 CnMp1u6lJHS6Jfu817hZr4IWcBR+wki26cO8aPUSchdyhUk517L4spGtAy4rO4shqLqS+48
 Jtv8BonsjYryuCF5dP45w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ERcqfsi165U=:sEvOd29ZUQ4q+NGUEzu21f
 nwvp5K+qz6rYkBXD5EqwiUiQFFjBplZ4bPAN6qqb42B5Be7DBaAL793es5v5IwV3FFxO0QD59
 3TzAMJu0q9j1al4GRh+2ABtm9eOmvUi3poeOUOca9wC/fk/Zd4GmONxtaKvVQTU8zEEV0XzbA
 ejFRskakBGsZwZxsuT3EQ6J3ZdIDGkLwQjE/hlpCsPzKN4YO67qsxtk5V3r37IM88K4qgRhxA
 +px0yY8a0uyX3e4Eqw8zWI+ULF6ShioMU8HoY+JosvGd84Y0E5eZwuBu1KeCSrUB6Q+btuAnY
 lh+zAYqCsVNkP6P7m7O5/ZPlr19Kwn1Y3TFv1ofG+oPsDZUcSVa3CgBrCgVHn8pgbufsvZ9w4
 QNzlKdviTVW1UZmxFy1xjVl4mBfgQiPzPSnTGvjPROKNhCN8BNmjja4ktlGAEcQ3DFiZ3Q5WY
 gf/kwufpIKwul4CdSRIn/sqAqFqMRp7OoIkSGGyUfit9tUHdC98WTAYaDWmk4JlC3dZvYQ93K
 ppY7pbraSYYjzzZFr1aJvwOljoR8J8v64JiwLJJgRaAcG9g5yNqfXaM1xzZrmI3bsViKlWlHw
 PnQfOGMl7ORmIkoUsALB32NQGnP2pMQ3VgWykO7SVhYEY1Q2piD9Gu8Qe6ypVfcvqNVw2WYYP
 nHT2FkB7By4+mhWlJKQJKEc8hoVdx6GuG0dm6bXX3ZGiQ6ncM+xsLFQMpZHcAzgoNA0ZcWtd4
 N+cOdCrbEZs+qL3a40KoBofujyFScK2GT+DdjB7qsd+aIRHsR7XVA670pyxswth5IkFpUtZ8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284737>

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This solves two problems:
> >
> > - we now have proper localisation even on Windows
> >
> > - we sidestep the infamous "BUG: your vsnprintf is broken (returned -1)"
> >   message when running "git init" (which otherwise prevents the entire
> >   test suite from running)
> 
> It is unclear to me how gettext is related to use of vsnprintf().

Including libintl.h overrides vsnprintf() with the libintl_vsnprintf()
drop-in replacement that does return the expected value.

I updated the commit message (will be part of v2):

	https://github.com/dscho/git/commit/4473801e

Ciao,
Dscho

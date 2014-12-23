From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to
 warnings
Date: Tue, 23 Dec 2014 19:23:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231922120.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de> <xmqqoarbidv7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
 <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info> <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
 <xmqqlhlz6zti.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231051320.21312@s15462909.onlinehome-server.info> <xmqqr3vq49w5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231723480.21312@s15462909.onlinehome-server.info>
 <xmqq61d24724.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231828050.21312@s15462909.onlinehome-server.info> <CAPc5daWBL89KpYqONNyvJ-t8K1P-nMJVAU1bLWkqzHGdb2q-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:23:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3U7E-0000y7-60
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbaLWSXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:23:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:57457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbaLWSXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:23:23 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MMjgF-1XyFiK35LD-008dni;
 Tue, 23 Dec 2014 19:23:19 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPc5daWBL89KpYqONNyvJ-t8K1P-nMJVAU1bLWkqzHGdb2q-gA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:6S+QDr06LNLzwgfQRATuJOe0IiIBD2+WpY2DCgF/xDaIsN5Anat
 kaaAD0Vu7JBA/wOTGQFC4rCeF6f0vg6lADdfD6g4ZGXGwBNqrFGyhljwKueZdlBlPDo+n6S
 61lwl5yaXbOk6UC8FqD/lEW/H8Vv5iefYLW9Fa6KZq9YiiWCt9gNZhKVyCdBQR4HK/VfCjh
 BtINXGyJl58ItAdRAKiOg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261758>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> On Tue, Dec 23, 2014 at 9:28 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > And *still*, this is *just* a global table with defaults. I would *still*
> >> > need to copy-on-write when the first customization of the severity level
> >> > takes place because I cannot allow the global defaults to be modified by
> >> > one caller (that would defeat the whole purpose of having per-caller
> >> > settings bundled in the fsck_options struct).
> >
> > There is no alloc. Right now, the initialization reads:
> >
> >         struct fsck_options options = strict ?
> >                 FSCK_OPTIONS_STRICT : FSCK_OPTIONS_DEFAULT;
> 
> Then it is just the matter of having
> 
>    fsck_options_init(&options);
>    if (strict)
>     options.some_field = make_it_strict;
> 
> as the first few statements, no?
> 
> I am not sure why it is so difficult....

It is not difficult. But I try to avoid complexity when I can. Since you
asked specifically, I will introduce it, though. Hopefully still this year
(I'll not be available for a while starting tomorrow).

Ciao,
Dscho

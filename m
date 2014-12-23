From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to
 warnings
Date: Tue, 23 Dec 2014 18:28:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231828050.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de> <xmqqoarbidv7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
 <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info> <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
 <xmqqlhlz6zti.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231051320.21312@s15462909.onlinehome-server.info> <xmqqr3vq49w5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231723480.21312@s15462909.onlinehome-server.info>
 <xmqq61d24724.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:29:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3TGd-0000qx-Ei
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbaLWR3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:29:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:55286 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbaLWR3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:29:01 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MU0pN-1YTd6G47Yf-00Qgk6;
 Tue, 23 Dec 2014 18:28:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq61d24724.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:TtNhKUfgBIDMlZkGBEpHgQOvEFa7kKd48kHmN/SqSR98Enj/mKO
 ssgoPHP3UHkrH5ZjrpEF0KhZSVgdQIWitymbL3UbP6CswC9fLUx2KJfZDG1JjpHEdc2HOsG
 XmeEExgtspJCefZtmwY3CxIoH1FRMGFcUnT1gBAz6wrLmfKnfapIYPCiK5enwiPY55ytCme
 O34y/cOydpLlbraUxVYxg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261746>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > And *still*, this is *just* a global table with defaults. I would *still*
> > need to copy-on-write when the first customization of the severity level
> > takes place because I cannot allow the global defaults to be modified by
> > one caller (that would defeat the whole purpose of having per-caller
> > settings bundled in the fsck_options struct).
> 
> If you allocate a per-invocation fsck_options struct, then the
> initialization the default with code is dead easy---you can just do
> it immediately after you x[cm]alloc()---no?

There is no alloc. Right now, the initialization reads:

	struct fsck_options options = strict ?
		FSCK_OPTIONS_STRICT : FSCK_OPTIONS_DEFAULT;

Ciao,
Dscho

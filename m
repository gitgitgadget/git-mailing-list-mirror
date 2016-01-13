From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Always release pack files before calling gc --auto
Date: Wed, 13 Jan 2016 19:52:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131951040.2964@virtualbox>
References: <cover.1452705584.git.johannes.schindelin@gmx.de> <20160113175237.GA13139@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:52:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQX9-00075p-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933096AbcAMSwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:52:31 -0500
Received: from mout.gmx.net ([212.227.17.22]:61270 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933042AbcAMSwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:52:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlpJU-1Zk5hv1OLI-00ZLjS; Wed, 13 Jan 2016 19:52:07
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160113175237.GA13139@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1pEwYSctLg9d4T4WFgvXYDu3d3S3cNb1ZvGII5xep6f5gkmx/iv
 yCRUS5hH9KgPuGMQA+JggWteEsq0E+5fjAmKuxyB/JNiPmLOFAH5SAnnnBbgF9+qY/zexKy
 870FVFq1yGzQMBrqStkZ+DfA60ADceysg/VcJ5tqlhujp71TN8lRTAJUsEP3XU/LPPOE06U
 LVr+clICTTj+UEMfmL8Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HqN2TQdmWHQ=:Jt0FQsqUFaLSOnR0na0aQ5
 c3PEp0of07t5oUXA02v8XxuG7Mi1wf6rE55D6TQ+9BOXrD8+Blv2v3QRtVY5mAzWO/lvly4F9
 +Lb6AiGPVhahh1wdmr2jmsMziQojDyFiILqwQckj/n2oLJ1PzoqM9qvlC/0Yc4QL/7O6k/zqF
 67U4ig7iWzksP+NdnbzdhJ3tAvzgy7q7Pb5ye1gJKO5kYMnElHQplXbkkcNDvYa5VNd/l10a/
 pAHFoEetgNvs38zL0lO+nVn3gkNpzEqSWX5TMbwApoHWwYRyQjx5RSthdBEvtX12Fj6jXhOmZ
 YEUPs7mlnSqtx7ZySAxrY2+xv4qOdoJiX1GY7tH55no4OS+U7wAafueoHA556HZZ0xBnuZujm
 df2KM3sj5wANJYGMPx0LtkPUlBZtLNPMuMTY6ydEvI52Pzj5IOHjujloMiz+ZKuVIcoTuEmkh
 YKesneR/kP7ELOwk6RKTjOq1pWygk4bzUEtgIlBqrGH0+Ay+Gi9Rk8g4pH+6r3imba5iDBQiP
 P5HaKbM8JkN00R/8O9SDRfeBzhTMroWJA644QyjOX6JOjZNpyAhaRbNCSgleWsNRcV6C5P6tW
 iLYUwJRM/psAtmnQla3SwV1s0oBozy0+0RUg1V9wRSjyjCXV/FIijHAihe6OScvaZWEEqNuh/
 Qi5m9ZUFeZuvkbOd0nNFsIZGmVX3Pke8x8i1yrNEYKFgA9hMG4j1M5+p6xRI9fukrMT2DvvoE
 CKZ8ikloKulICKs9WTohhkzbGIPyBxUOJ+SCzkTq/kdfpKY1jol2kqmgv/CRZaIBIJZZEkBT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283967>

Hi Peff,

On Wed, 13 Jan 2016, Jeff King wrote:

> On Wed, Jan 13, 2016 at 06:20:02PM +0100, Johannes Schindelin wrote:
> 
> > These patches are companions to 786b150 (clone --dissociate: avoid
> > locking pack files, 2015-10-06), triggered by a bug report to the Git
> > for Windows project.
> > 
> > Johannes Schindelin (4):
> >   fetch: release pack files before garbage-collecting
> >   am: release pack files before garbage-collecting
> >   merge: release pack files before garbage-collecting
> >   receive-pack: release pack files before garbage-collecting
> 
> [...]
>
> I think all of the cases here are fine, for two reasons:
> 
>   1. The new closing is right before the program would exit anyway, so
>      there's no interesting work left to do (and obviously that's where
>      we generally want to call "gc --auto", too)

This is actually what I checked, but of course I managed to forget to
mention it in the cover letter :-(

Thanks for verifying, and for spelling it out.
Dscho

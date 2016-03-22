From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 17:49:18 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603221748360.4690@virtualbox>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com> <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com> <alpine.DEB.2.20.1603221552100.4690@virtualbox>
 <xmqqh9fyjy9w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 17:49:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPUr-0006Vi-VC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 17:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbcCVQt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 12:49:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:53514 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbcCVQt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 12:49:29 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGip3-1aUsq117TN-00DVkx; Tue, 22 Mar 2016 17:49:20
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqh9fyjy9w.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Fd4pb1udEImhYFU0l2IDdxyx53QbxyDrEe4vhN8uqj0icdt1Zwe
 jVlnkAWY70lxuNtSGgLUrl2Dkd/8SZ42AAn/4WtHbys0Uqv0Ne/XjtfXTOcTc2AUDa5TTZz
 b2kqfUpA2My4xeOaykREUXnQ/4TwyrCmLHZGcK+9rYwGOK2M4Hbh5rP9ji4hKTR5MLV4sny
 W+ExAdmAtM2+FF2UG8l8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fd5gZixCfek=:AAWDpo3YcUV2r4bijjKqN6
 +MeGpTwT1vttqU6U/guWPQIAvEDwYrGRxQo3ZgTxM8lBbPqtJjWMSTO2z+gt+L6bxSggChaIA
 8oleYWAhXCnJthiAQ14BliWb1LSo7i1vyP7SIQNLWWbuF2x5diBWdA5cC7ZAYelSeb4s6WF96
 pmT8FgYk4nC2ZYy87qf4ooTYU/4e1HhCTDhbWuid5OOHPhgAWyJs1OnB5tV9+b6QMIH8/KJLr
 Dk93Q+Ef2LvCZU8Ggifq5EqrSZe3INV39wXxtT802REk2TlL/eaenbS+fql64FMVA5sdzqfJa
 Qrm92q9mmAxaWXZaxuU2CIx9+IIBFrZsyrzoaLA2dvrnRX2hqmOXwEgRilGwFBPnlRhcSTzMM
 k1R7bocdKAXUf5ndITgSb9dwjJ59VEVLwT39LP/sKBSNLVK+Q28qRpc7tYBgMt2eBLkzklrkd
 oYPTaOScSzi5ViiLkbYkMHs/g7klo1tIdz8KyJqYnfS8awOVvRs4w1mZPpOevF6Z/bB038nRO
 a4a1qhrGGHGekt9reucM0iZQo4BeEwoHCTiZmDwxCMfAbWrzk7lL2GnB9Z74jp11HvCwYS4XT
 //b173NB4b3bl7RmtIMQZTZ43Xumn68Tl75ZTL+J4LsMyu2fZrA9sb9iku19u0dahBQ8gVX6B
 iRMqMVaBMRDInxICj5B4IEBjTTc0k5Iaw7X68iFJAbyKmcvhptyZkxyABwwRSVQDvnOyXqzE0
 jc18DzN4ccoDn2TTolIpxcKiqXv+vOVV7HTKfV3OBURxA0GwOxjxLawkovoD4kcRjOQH2/5H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289515>

Hi Junio,

On Tue, 22 Mar 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  	struct option options[] = {
> >>  		OPT_BOOL(0, "next-all", &next_all,
> >>  			 N_("perform 'git bisect next'")),
> >>  		OPT_BOOL(0, "no-checkout", &no_checkout,
> >>  			 N_("update BISECT_HEAD instead of checking out the current commit")),
> >> +		OPT_STRING(0, "check-term-format", &term, N_("term"),
> >> +			 N_("check the format of the ref")),
> >
> > Hmm. The existing code suggests to use OPT_BOOL instead.
> > ...
> > The existing convention is to make the first argument *not* a value of the
> > "option", i.e. `--check-term-format "$TERM_BAD"` without an equal sign.
> 
> I think it is preferrable to keep using OPT_BOOL() for this new one
> if we are incrementally building on top of existing code.
> 
> But if the convention is that the option is to specify what opration
> is invoked, using OPT_CMDMODE() to implement all of them would be a
> worthwhile cleanup to consider at some point.

Good point, I keep forgetting that OPT_CMDMODE() was introduced
specifically for subcommands.

Ciao,
Dscho

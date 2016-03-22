From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 16:11:33 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603221610370.4690@virtualbox>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com> <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com> <alpine.DEB.2.20.1603221552100.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 16:11:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiNy9-00034W-1w
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 16:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbcCVPLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 11:11:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:57300 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbcCVPLg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 11:11:36 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MKIEQ-1ak2eu0J30-001evk; Tue, 22 Mar 2016 16:11:34
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1603221552100.4690@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:A/GH0Y51mi1QMbwvzFImUkNXBDv++euDt1NF57h48IT/FGwLTTk
 7dtJo1MQSmSMhhmVwQ33KUu2M4Euq2Np6koHhOptZ7X684CLRXHPwmfku/SAJ/Ks8DhdO5r
 gB1ntsCqTGXKh7tBDsqyLZsdoUcw8G76WpQ8cIBXpylJNaCJSun1BekoVUZFFhzvBYvO16C
 S2KmGqv/1S36KaS7kZelw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oQ7BvzX5XDE=:ra21ceGrlXZd6trRaIahal
 WXO/RFSM7M4Ry05TNTAE3y12U9aMKenOiIBb1EYhqHUNwQQ3/WMgC75uoSJ9unM1jDfF3mmLV
 BelnAu75b6R3038uXzbdiw1HU7Pf6dgzcCY0yQw2rKXmFTAqaHBjXjQ2aJmnZBAxuZ/XgYIBI
 i3NfykeApM8MPgDaQY+spxWfAIFREq8zKBO1DGswp61uQIbOogB++KVsSyhd1aluYEg3YzcjE
 kFaJPYd9ST/cJho2GacUKw78tg8Tn9XNz3aKbNFwT6KrfeNgUPCXIGhLxJUq3RyKjAZeidQrK
 ZSusoMSCzJKaBCuKNpFL/CSthdCmGJYuMVafrhNjrtgOQDCKhCsuVD/YHqF9+evUd4EkPM1f+
 4uUov8pDnU4vJ8yV7JNeKe4uU9U5Q2aK4MTb/QqIEuW3Ud/tcnQ7jOJcFWvjiwPCBhHBenRCJ
 KA0UiEeFYPZckCtODuIs50bqSwfY67kCdN/7iBxU6N225X/Y3F0UdwhiHL4mxQVeKevLn2ZIC
 EAJ5OJ7Wtcapj2w86vroTeuQ2MdK9iJ3zv0GAT779Wo/KIhCk7z11eIHMpCaP2Hq6LiRwz8Md
 uqotRfD18Ma7KR9K62w1RZqgFjEQLzKpozEmQM4CBfJBk6ntExi2VPXRokTgWz7ykE0OLaYVO
 ugXhiIpq7tFWqlJ2qm2FnCRIwqatYApJQsoEs9AXcl/BtD+72UK4xRf87TJI5AWfCX/UTITz8
 TopkKDoWij6cLEhp3bqRHTDYYSBSkZViFT4gaMMn6JCBQi6zOKwKavYnjjRcRqt4WbNEXEEI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289508>

Hi,

On Tue, 22 Mar 2016, Johannes Schindelin wrote:

> On Tue, 22 Mar 2016, Pranit Bauva wrote:
> 
> > +	if (!strcmp(term, "bad") || !strcmp(term, "new"))
> > +		if(strcmp(revision, "bad"))
> > +			die("can't change the meaning of term '%s'", term);
> > +
> > +	if (!strcmp(term, "good") || !strcmp(term, "old"))
> > +		if (strcmp(revision, "good"))
> > +			die("can't change the meaning of term '%s'", term);
> 
> These two can be combined. Actually, these *four* can easily be combined:
> 
> 	if ((one_of(term, "bad", "new", NULL) && strcmp(orig, "bad")) ||
> 	    (one_of(term, "good", "old", NULL) && strcmp(orig, "good")))
> 		die("can't change the meaning of term '%s'", term);

Completely forgot to mention: This conversion skipped the comment

	# In theory, nothing prevents swapping
	# completely good and bad, but this situation
	# could be confusing and hasn't been tested
	# enough. Forbid it for now.

Let's port that comment over, too?

Ciao,
Johannes

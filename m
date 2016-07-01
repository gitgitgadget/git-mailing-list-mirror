Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B8E2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 13:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbcGANtn (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 09:49:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:51690 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbcGANtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 09:49:31 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MOwY7-1bDBe12zTj-006Miq; Fri, 01 Jul 2016 15:48:34
 +0200
Date:	Fri, 1 Jul 2016 15:48:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 5/9] merge-recursive: avoid returning a wholesale
 struct
In-Reply-To: <xmqqr3bf3fvr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011542210.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <c33e9cdb1ec6cbebcc3124a62b7b9d52b92cf6c9.1467199553.git.johannes.schindelin@gmx.de> <xmqqr3bf3fvr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6ciCWZAVVgBSk/gys+YtMkv1cANjfs6oZnzaj9ZG1njnsiSbg0T
 UezZjuty7yIT6IJp+pIb5wFuo/syyJstUIo0xTyTd3orQ6bZpZNCP8idpL9jcZydXf8RbPS
 GUtIz/WfOT9L2LfwIrzuuZF2m9uF9FhcqImWxRaF1nGx9ncx68FCJq16sQnv8Q7kvisJYEt
 XxzaemBE9vLdwvoBHbgjA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:RhhqxDqPpD8=:lGSiuA9awXfAnauQZXSozi
 5Nvf8sBorvBB3MC2XpKeu/RBsf8RV5hMjZx3ag562e5aLyZC2qAmE1eiCW+qEZJGvNvcnFD/X
 7EZgTkVqUTw1QLrUZ/5LUAk2SUDLKQiVIKrXjxvJ93pCUs+YJNAGYNaAWpjQaeh3WhkHN0XzT
 +6RsBpAPXUPJt2noR/SVnPo5QvAawGqwfzG8A12KDc6amE9ShiuEXM4GFs9GX8V73bgGAyX/3
 Va2FXAnFUwhBfoXUQaLXvDzx4LPHMI/ceIgafVbmtx6oTpsOueFgWtLwqDg2nyk5aRBZ+E3sz
 jGFIhEbRVNC2XmDE1FOIhODH2L8+Qnog26kVfmyCSOFmyO67oJCxOOiiNCbNr3+8Ewo5NadAX
 pY4XgzNsNM2Cn7k7rlwoVZrTzyVePhGKIxLvSehut2F69YznUfIBCO0rPNpuF/Dsj0gx6j9HY
 X4IbHlbfq4vzHT4l+t+EbaFHUu8LA1gvMkcGnq7ZhW3McmrFX3Vc/G9k/XAaebI3QL9PXG+f9
 PUJ/DuXNkir04meQAYuu+85NvMphToCZCmgtk9+z2odYbArG0WjSVw7+R60dtviz6JjdDZpY9
 x8FYrLwPX+bgXGTGz0+bG4kGXdeM5xQx6E48rNM6BiI5+r0mL3zC+wFf7o2iSC+t+FA7iySN/
 ygp8Sd3CxjYCavwGQbQbmgi7Ymr1cX+xpG5aOfeo8Nr2PLr3tLDaOhdnFlSsyzP2g06Cq5tQN
 Vb1sZAaW1qf0n1G2maK4VBX1zD6dbUwbhaUthwWnxR8wUcbIwJ2EDOGKWVr3tZjD6iefaQlXv
 B7H2TRM
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > It is technically allowed, as per C89, for functions' return type to
> > be complete structs (i.e. *not* just pointers to structs), but it is
> > bad practice.
> 
> Not necessarily.

Okay, I fixed it.

> > This is a very late attempt to contain the damage done by this developer
> > in 6d297f8 (Status update on merge-recursive in C, 2006-07-08) which
> > introduced such a return type.
> >
> > It will also help the current effort to libify merge-recursive.c, as
> > it will allow us to return proper error codes later.
> 
> But this part of the motivation does make sense.  Having to pass an
> extra int &error_code field, only because the return value is
> already used for something else, is a lot more weird.

While I still think it is inelegant to return a whole struct
(understanding the machine code aspects of it), I toned it down to say
that we just do not use that construct in Git's source code. And I kept
the paragraph that you found more convincing, of course.

Ciao,
Dscho

P.S.: If it is not too much of a problem, may I ask you to simply delete
remainders of my patches when replying and not commenting on them? I just
deleted 226 lines after verifying that you really did not respond to any
part of it in the unhelpful Alpine client (which I still use because it
*still* fits much better with my workflow than anything else, by a lot).
Again, not a big deal if it would make your life more painful.

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Sat, 12 Mar 2011 22:14:04 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1103122159300.15442@debian>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian> <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com> <alpine.DEB.2.00.1102161122350.14950@debian>
 <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com> <alpine.DEB.2.00.1103120930250.15442@debian> <AANLkTikrYbY6r5hYnhWCB1GVKbPgounxdvAGeejsUKoC@mail.gmail.com> <alpine.DEB.2.00.1103122005490.15442@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 04:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyblC-0007Sc-5y
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 04:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab1CMDOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 22:14:11 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48511 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238Ab1CMDOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 22:14:08 -0500
Received: by vxi39 with SMTP id 39so3574481vxi.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 19:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=C6at2X2n9ndsS5/UCajho5qu01mVjwcceZ6WbXw9UTU=;
        b=HniuA6RqKNxFd39bCghF1rvrIZwukh+FWEC657eJNKT10CFIrQXeUI1jeZtHm6IiRd
         pl54fbaim8j0KyyefPeJmj7GIqJfbu5/McBRvCXAUCDhp7gVJctuA7ib8FhceJ9wSnVK
         9Qrmi2jdNx4wz+sinLCyNhp410KfaXAtAOP4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=LImkVGnTAy0+2mHJ2rzfp5k+DcUiWG3c6bBEA9kpnyhU2wLgJ//QxLVonGI24mhxGE
         EKNjlk+j9LRfybJ32FZPfT2mdt/aEv4m93bBckjsuxX5+Jtdr7Vlf1+i/FME/XFGEtBo
         17Vd0rc/WT60tPNwQPY+mThJioIuZ6g2up4BY=
Received: by 10.52.90.109 with SMTP id bv13mr10638617vdb.237.1299986047687;
        Sat, 12 Mar 2011 19:14:07 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id b6sm1957155vci.0.2011.03.12.19.14.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Mar 2011 19:14:06 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1103122005490.15442@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168958>

On Sat, 12 Mar 2011, Martin von Zweigbergk wrote:

> On Sun, 13 Mar 2011, Santi B?jar wrote:
> 
> > Could you test also variants of the exponential strategy?
> 
> I guess I could :-). Will see if I get time for that later today.

So here are the updated figures for the force-updated history
(pu-like):

                 u@{10}     u@{100}    u@{1000}
manual         0m0.535s    0m1.164s    0m1.415s
linear         0m1.245s   0m37.367s   5m10.068s
merge-base    0m14.490s   0m15.409s   0m15.508s
exp(1,2)       0m1.056s    0m6.175s   0m27.221s
exp(10,10)     0m1.950s   0m20.031s   0m18.215s
exp(7,7)       0m1.310s    0m6.851s   0m16.757s

and for the non-force-updated history (master-like):

                 u@{10}     u@{100}    u@{1000}
manual         0m0.885s    0m6.126s   0m52.248s
linear         0m1.349s   0m39.688s   5m28.753s
merge-base     0m1.160s    0m1.699s    0m1.901s
exp(1,2)       0m0.769s    0m4.342s    0m7.360s
exp(10,10)     0m0.700s    0m2.535s    0m3.110s
exp(7,7)       0m0.653s    0m2.332s    0m3.506s


exp(10,10) is worst possible for the test cases I picked, since the
wanted reflog entry is always the first one in an interval, so almost
10 times as many entries as necessary are considered. I therefore also
tried with exp(7,7) to get more fair figures.


/Martin

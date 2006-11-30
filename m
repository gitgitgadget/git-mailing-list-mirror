X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 22:16:29 +0100
Organization: At home
Message-ID: <eknhjr$nce$1@sea.gmane.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se> <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org> <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home> <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org> <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home> <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 30 Nov 2006 21:15:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32799>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GptFQ-0005Aj-9K for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936456AbWK3VPH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006 16:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936455AbWK3VPH
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:15:07 -0500
Received: from main.gmane.org ([80.91.229.2]:48103 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936456AbWK3VPF (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:15:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GptFB-00057f-BX for git@vger.kernel.org; Thu, 30 Nov 2006 22:14:57 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 22:14:57 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 22:14:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> The _original_ "git add" was literally just this one-liner:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0#!/bin/sh
> =A0=A0=A0=A0=A0=A0=A0=A0git-update-index --add -- "$@"
>=20
> which actually was better in this respect (it updated the content), b=
ut=20
> that didn't do sub-directories, so this is arguable a bug introduced =
by=20
> commit 37539fbd:=20
>=20
> =A0 =A0 [PATCH] Improved "git add"
>=20
> =A0 =A0 This fixes everybodys favourite complaint about "git add", na=
mely that it
> =A0 =A0 doesn't take directories.
>=20
> which started using=20
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git-ls-files --others -z -- "$@"
>=20
> together with the exclude files to generate the list of files to add.=
 At=20
> that point, we lost files that already existed (since "--others" spec=
ifies=20
> just files we don't know about).

So should we use then

        git-ls-files --cached --others -z -- "$@"

in git-add?

I'm very much for having git-add, -rm, -mv and -resolved as porcelain
wrappers around git update-index, so there would be even less events
when you have to use this plumbish command directly.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


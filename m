X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 18:50:19 +0100
Message-ID: <200611041850.20136.Josef.Weidendorfer@gmx.de>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <200611031815.49553.Josef.Weidendorfer@gmx.de> <7vk62bxvtx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 4 Nov 2006 17:02:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <7vk62bxvtx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30930>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgOu2-0007Lr-MW for gcvg-git@gmane.org; Sat, 04 Nov
 2006 18:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965551AbWKDRBv convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006 12:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965552AbWKDRBv
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 12:01:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:60875 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S965551AbWKDRBv convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 12:01:51 -0500
Received: (qmail invoked by alias); 04 Nov 2006 17:01:49 -0000
Received: from p5496B6C7.dip0.t-ipconnect.de (EHLO noname) [84.150.182.199]
 by mail.gmx.net (mp019) with SMTP; 04 Nov 2006 18:01:49 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Saturday 04 November 2006 13:03, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
>=20
> > On Friday 03 November 2006 10:46, Karl Hasselstr=F6m wrote:
> >> Hmm. How about changing the meaning of "remote" slightly? Like thi=
s:
> >
> > That's not good, as it changes existing config meaning.
> >...
> > Other option: Introduce "fetchonly" line which ignores the original
> > fetch lines in the remote section.
> >
> >        [remote."gitster"]
> >                url =3D gitster.example.com:/home/junio/git.git/
> >                fetch =3D heads/master:remotes/gitster/master
> >                fetch =3D heads/next:remotes/gitster/next
> >        [branch."master"]
> >                remote =3D gitster
> >                fetchonly =3D heads/master:remotes/gitster/master
> >                merge =3D remotes/gitster/master
>=20
> That is a regression in that now I need to fetch twice (in the
> above example, in reality four).

Hmm. You do not need to use it.
However, there are use cases for this.

=46or example, I am mostly interested in what's new on the
next and master branch in the git repository. There is no need for me
to always fetch pu or maint.

So I can use (I am behind a firewall):

[remote "origin"]
        url =3D http://www.kernel.org/pub/scm/git/git.git
        fetch =3D master:origin
        fetch =3D maint:maint
        fetch =3D next:next
        fetch =3D todo:todo
        fetch =3D +pu:pu

[branch "master"]
        remote =3D origin
        fetchonly =3D master:origin
	fetchonly =3D next:next
        merge =3D origin

and get master and next with a "git fetch" when on master, and
"git fetch origin" would fetch all branches.


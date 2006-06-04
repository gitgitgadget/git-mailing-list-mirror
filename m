From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 12:33:34 +0200
Message-ID: <e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	 <7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
	 <7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 12:33:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmpvN-0002h9-NQ
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 12:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWFDKdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 06:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWFDKdf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 06:33:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:11170 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932190AbWFDKde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 06:33:34 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1144377wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 03:33:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jdf24YYOPn0VfLJRIUpqrXXuOSyczr55GgEH/XcNxATJwn20oLg09koxSWV5g6I/8PpTTpYk8IBVElJqf5dyC33TGkx8nMmg8xqi0vb1nw684uYlPMRiUQQajNxIF5goCwidQDeev6ohUCVolssBqdtZ+X9IzJPWUmqxOM/7RUs=
Received: by 10.64.151.8 with SMTP id y8mr2809251qbd;
        Sun, 04 Jun 2006 03:33:34 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sun, 4 Jun 2006 03:33:34 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21261>

On 6/4/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > In a less corner case, just to better explaing my idea, consider this:
> >
> >          a---b---d---e---f---g---h
> >          t1   \ /              t3
> >             ---c
> >                t2
> >
> > Where our sha1 is still "e", in this case
> >
> > git-rev-list  --topo-order <e>  ^a  ^c   ^g
> >
> > gives, as last revision in output list, "f"
> > Then parentOf(<f>) is <g> and our looked for tag is t3
>
> Sorry, in the example time flows from left to right.  If you
> exclude g then you are excluding everything that is reachable
> from g so you would not see "f".
>
From today git:

tag list is:

v1.3.3 1b9bc5a7b7434d771726011613a00cb202bd9f44
v1.3.2 7abd7117ec57b8c3c2a469db62c7811fdac5c655
v1.3.1 7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
v1.3.0 4baff50551545e2b6825973ec37bcaf03edb95fe

selected sha is ccb365047a1081455b767867f0887e7b4334f9d8
(Allow "git repack" users to specify repacking window/depth)

$ git-rev-list --topo-order ccb365047a1081455b767867f0887e7b4334f9d8
^1b9bc5a7b7434d771726011613a00cb202bd9f44
^7abd7117ec57b8c3c2a469db62c7811fdac5c655
^7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
^4baff50551545e2b6825973ec37bcaf03edb95fe

ccb365047a1081455b767867f0887e7b4334f9d8
85e6326cc3e7c272566c60a39741f84391830d49
4262c1b0c38613a8c5ae729bd4d3f18f0df3ec44
24735cfc500feb2a8dba9f140080ab3476363d28
caef71a5354ca162cc5a6914a7a643efbc9ae28a
34e98ea56414adc5a582e6368e8ec9c109dbee48
3a624b346db02a07b0317743b362d1a15c6c3c18
965f803c323bb72a9dedbbc8f7ba00bbadb6cf58
b073f26b256cded6252bafd34982eb6f69d2a4b6
a4d34e2db5565e6b75f79f9d3938aa9151e72e44
eab144ac49c18d981261c2d0ba964d6380d9f1da
9153983310a169a340bd1023dccafd80b70b05bc
db89665fbf86d4e0166b2f252a939ed8bf6782fe
78fff6ebbafe2d23464a2b059104954bfe8732c7
cb8f64b4e3f263c113b7a2f156af74b810e969ff
d4ed9793fd981ea5a35ebaa8e337446bb29f6d55
b2934926dd7455de61577c1dfdf4c12d224e7ae0
ba1d45051e050cbcf68ccccacea86a4b6ecde731
5b84f4d87a1bd58c7540e9ea82ee3673ecddbad5
7594c4b2d7cc81f806453402aefe1bf71ae6dd53
6b9c58f4669b3832ed2830f0cb1a307ea6bc6063
8c1f0b44c59530dea8007a9f5b69d0fac6aea3b1
8e8f998739db6526fe890fabc88c866759bc2ac3
cd2bdc5309461034e5cc58e1d3e87535ed9e093b

Parent of cd2bdc5309461034e5cc58e1d3e87535ed9e093b is

4baff50551545e2b6825973ec37bcaf03edb95fe

aka tag v1.3.0

Am I missing something?

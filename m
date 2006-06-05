From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Mon, 5 Jun 2006 13:54:35 +0200
Message-ID: <e5bfff550606050454l32a8a3b1kffa40fcc4d018778@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	 <7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
	 <7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
	 <7v3belcicq.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040657p5c1a3dceq3eef254ab64f0e3a@mail.gmail.com>
	 <7vhd305dk9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 13:54:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnDfL-0006nq-Hm
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 13:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWFELyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 07:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWFELyg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 07:54:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:19654 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751015AbWFELyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 07:54:36 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1428814wri
        for <git@vger.kernel.org>; Mon, 05 Jun 2006 04:54:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EQeRtFyIK+WbE8qDeTn8RW9LCZ0YoMLnVDdrBwz7yy4tIR4Si6H1NSB6bky8/8hQNZtNB9DWH8nL1E+2LHwojUcD0MTyGvFyCLkOAAHbEIcx9zEX3ZEtrx7EGwUvflud+MadbLC9zGXVWw+WyEYEhTfTa859h2dsROofXqzY3QI=
Received: by 10.64.76.8 with SMTP id y8mr3319763qba;
        Mon, 05 Jun 2006 04:54:35 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Mon, 5 Jun 2006 04:54:35 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhd305dk9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21315>

On 6/5/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> I think your "start from positive ones, traverse one by one and
> stop traversal that hits the negative one" logic requires the
> negative one to be directly on the traversal paths starting from
> positive ones to have _any_ effect.  We often ask "what's the
> ones that are still not merged to the master from the side
> branch" while dealing with topic branches:
>
>          c-------d---e master         time flows from
>         /       /                     left to right
>  --a---b---x---y---z side
>
> and the way to ask that question is "rev-list master..side"
> (which is "rev-list side ^master").  It should list z and not
> show y nor x nor b nor a.
>
> In order for it to be able to notice that y should not be
> listed, it needs to perform traversals from negative ones as
> well in order to learn that y is reachable from master.
>

Thanks for your clear explanation. Now I see much better what's the deal.

>
> I think one useful thing we can do is to generalize what
> "describe", "nave-rev", and "merge-base" do to have a command
> that takes a committish X and a set of other committish T1..Tn,
> and examines if Ti (1<=i<=n) is reachable from X and if X is
> reachable from Ti (1<=i<=n), and give a short-hand to specify
> the set of T for common patterns like --heads --tags and --all.
>

I don't know if this is enough for our original problem to find previous tag.

Our problem is indeed not only to find previous tags, but _nearest_
previous, so I think we have to think to a generalization that takes
in account also a kind of 'metric' among tags because the only
reachability seems to fall short in finding the nearset one.

But definitely I need to think more about this ;-)

   Marco

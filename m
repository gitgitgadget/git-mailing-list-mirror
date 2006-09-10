From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 20:32:13 +0200
Message-ID: <e5bfff550609101132x7e7ed336xa394b6220ab3643@mail.gmail.com>
References: <e5bfff550609092214t4f8e195eib28e302f4d284aa@mail.gmail.com>
	 <20060910152122.31694.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org, jonsmirl@gmail.com,
	paulus@samba.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Sep 10 20:32:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMU6V-0003OL-HF
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 20:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWIJScP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 14:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWIJScP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 14:32:15 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:55864 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932402AbWIJScO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 14:32:14 -0400
Received: by py-out-1112.google.com with SMTP id n25so1827511pyg
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 11:32:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oQiJE5JzTIyCJ8gOm13Plmz8RNf+1S0Qbo6+p/WOeioeSSjy3taEl84ev4stqp0r0xlhzAWso2H90CXHXI2LOHwDGMuCm0QTxT5995O1mxn5IxhuFQUPtSEb0dCcRXiCScCBckl6dJ+q3LmUmyFM6WSd50aE9oWCXod8s6LHux8=
Received: by 10.35.123.2 with SMTP id a2mr7229459pyn;
        Sun, 10 Sep 2006 11:32:13 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sun, 10 Sep 2006 11:32:12 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060910152122.31694.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26805>

>
> But can we stop designing git-rev-list output formats until we've figured
> out if and how to implement it in the visualizer?  Or, more to the point,
> visualizers plural.  That's the hard part.  Then we can see what sort
> of git-rev-list output would be most convenient.
>

Regarding qgit we have two cases:

-arrive of fixup set for out of order commits _not_ currently
displayed on the screen
This is by far the most common case expecially for big archives. In
this case the fix speed depends on how far are the fixed commits from
the last loaded commit (it's an insertion in a vector). In any case
far more quick then redrawing the graph. No flickering side effect
here. Implementation is easy.

-arrive of fixup set for out of order commits currently displayed on the screen
Here implementation _could_ be more difficult, but given the very low
statistic of this case (a rare case among rare cases) we could accept
the brutal approach of reset the complete graph, *but not the loaded
revisions data*, and redraw the graph. With this approach
implementation is almost as easy as before but flickering is involved.

I agree with you that we should have fixup information as soon as
git-rev-list discovers out of order commits.

   Marco

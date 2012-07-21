From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to
 remote-helper.
Date: Sat, 21 Jul 2012 10:58:15 -0500
Message-ID: <20120721155814.GD19860@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <2448876.O3MA5kWbuX@flobuntu>
 <20120721144834.GB19860@burratino>
 <3246520.u1PcGtbf0N@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, msysgit@googlegroups.com
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:58:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssc4c-0002NJ-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab2GUP6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:58:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62374 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab2GUP6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:58:24 -0400
Received: by obbuo13 with SMTP id uo13so6567289obb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LYzg1KX5HWWm0mHZvXOj94f+qG1mprDjYWTq3BPXPIM=;
        b=zLN5omyg5e+iosqbjHDOyGdYGZVcyLgoS7EIm4KNdeflwHSq0ACARpe2xjeqzebu8+
         GRBe40fL0k6UHWL1YMckMy70xEO0OH36Ke6xRIVhv49086hham5Eh2qcsxo+JYhsbG3b
         GBvtAGUDrnNyRW42yYvJcgYFJ4fCbR5eugHoY2JhVESe+mjlV+rrzRoauuo2QbHUPiC5
         SjzfIWmckp4iTMTJ992uN1gxk1RB1iJ8i2bfr7wM/NwLFoU5Dajd6oAxO2h4WOpyhGai
         fswL4CIg/93K8lXmKrh8JEntcWdxRgrZje8C+VblLJmp0kKnr0TBi+SOjaNs5PR3G79t
         OQgA==
Received: by 10.50.47.168 with SMTP id e8mr1418143ign.3.1342886303454;
        Sat, 21 Jul 2012 08:58:23 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k6sm1651004igz.9.2012.07.21.08.58.22
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:58:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3246520.u1PcGtbf0N@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201822>

(adding msysgit list to cc for a Windows question)
Hi,

(regarding bidirectional communication between git and fast-import for
remote helpers)
Florian Achleitner wrote:

> People didn't like pipe variant (prexec_cb not being compatible to windows' 
> process creation model), so I learned about fifos and implemented a (basic) fifo 
> variant. *shrug*

Is this meant as a summary of [1]?  Hannes wrote:

| The second problem is more severe and is at the lowest level of our
| infrastructure: We set up our child processes so that they know only about
| file descriptors other than 0,1,2 to the child process. Even if the first
| problem were solved, the child process does not receive sufficient
| information to know that there are open file descriptors other than 0,1,2.
| There is a facility to pass along this information from the parent to the
| child, but we simply do not implement it.

It sounds to me like the pipe model would work fine on Windows, and it
would just require some porting work (out of scope for this summer of
code project).  Am I misunderstanding?

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/199216

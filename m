From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Fri, 9 Dec 2005 11:59:21 +0100
Message-ID: <81b0412b0512090259l5f06f6d6n5416e271af36d6a1@mail.gmail.com>
References: <20051208202555.GA3046@steel.home>
	 <7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
	 <20051208210251.GB19423@steel.home>
	 <7v7jafcmev.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512082336i674932bapd631d559e80cad79@mail.gmail.com>
	 <7vlkyu7l05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 12:00:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkfyI-0000Ay-SD
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 11:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVLIK7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 05:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVLIK7X
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 05:59:23 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:12831 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751310AbVLIK7X convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 05:59:23 -0500
Received: by nproxy.gmail.com with SMTP id n28so271319nfc
        for <git@vger.kernel.org>; Fri, 09 Dec 2005 02:59:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z78acXCH+FcoQscaTH/nXT/m8JLdiNAuBCE8chcd7K887pQQoyljliQRzSmyQ+B9aT5PWrCpKEEuuIubgEQziQ1AltpuJMpSgqk4dP7l5Bnhi5a2GLt9Ghw9UHhGaoBJ/Uff1SgKBbnVRA2nIRz2UKz48n2Q/Hv4i8xpO5BSDhw=
Received: by 10.48.254.13 with SMTP id b13mr398508nfi;
        Fri, 09 Dec 2005 02:59:21 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Fri, 9 Dec 2005 02:59:21 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkyu7l05.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13422>

On 12/9/05, Junio C Hamano <junkio@cox.net> wrote:
> > An accident? Like a filesystem not supporting executable permission?
> > What is the reason to report success from the test run in that conditions?
>
> Let's be reasonable.  I was hoping to hear from you a real-world
> breakage case that I overlooked due to my lack of access to
> platforms you may have access to. I am not interested in a
> theoretical failure case discussion very much.  If your
> filesystem does not support executables, why do you expect
> things to run from the freshly built directory to begin with?

In my case it was the freshly build directory where a chmod 0666 * was
done. This directory wont rebuild (the dates are correct), and the
tests run, as if nothing happened.
I actually noticed only after a half an hour, that I wasn't running
the executables I expected.

> Linkage error of git-init-db (or git wrapper) may leave the file
> created but leave that in unexecutable form, which could be a
> valid concern, but that would signal an error to the make during
> the build stage, and "test" target depends on "all" target.
>
> And please do not start arguing that you can cd to 't' directory
> after such a build failure and manually say "make".  You can do
> that without even running make at the top level and cause the
> same failure.  I consider both of them pilot errors.

Yes, but they are not obvious. It is also not obvious what to do,
because everything seams alright.

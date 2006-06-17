X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Fri, 16 Jun 2006 22:26:38 -0700
Message-ID: <7vk67gbbe9.fsf@assigned-by-dhcp.cox.net>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	<8aa486160606150426q19b0a661s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 17 Jun 2006 05:26:58 +0000 (UTC)
Cc: git@vger.kernel.org, "Yakov Lerner" <iler.ml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8aa486160606150426q19b0a661s@mail.gmail.com> (sbejar@gmail.com's
	message of "Thu, 15 Jun 2006 13:26:27 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1FrTKh-0005cu-4h for gcvg-git@gmane.org; Sat, 17 Jun
 2006 07:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751550AbWFQF0k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 17 Jun 2006
 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWFQF0k
 (ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 01:26:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:19334 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1751550AbWFQF0k
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 01:26:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127]) by
 fed1rmmtao04.cox.net (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with
 ESMTP id
 <20060617052639.IKQF15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
 Sat, 17 Jun 2006 01:26:39 -0400
To: Santi <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

Santi <sbejar@gmail.com> writes:

> Wed, 14 Jun 2006 22:26 +0300, Yakov Lerner <iler.ml@gmail.com>:
>> Many times, I mistakenly used 'make prefix=... install' where prefix value
>> was different from prefix value during build. This resulted in broken
>> install. This patch adds auto-detection of $prefix change to the Makefile.
>> This results in correct install whenever prefix is changed.
>
> I do this each time I install packages from source. I keep them with
> "stow" and the usual sequence is:
>
> make prefix=/home/santi/usr
> make install prefix=/home/santi/usr/stow/git
> cd /home/santi/usr/stow/
> stow -v git
>
> so with this auto-detection I'll compile some programs twice.

I do not know what "stow" is about, but if it is to allow you to
run make-install to install things in somewhere else, examine
the result, and then move the result to the real location
(implying that you should be able to nuke the "somewhere else"
after you have done so), with the patch, the above sequence
would install the binaries pointing at a wrong directory,
because the second compilation would make them point at the
temporary installation directory ~/usr/stow/git, not the final
location ~/usr/.



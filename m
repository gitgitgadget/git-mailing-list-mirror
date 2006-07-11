From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: Revisiting large binary files issue.
Date: Tue, 11 Jul 2006 08:20:31 +0200
Message-ID: <slrneb6gpf.gu9.Peter.B.Baumann@xp.machine.xx>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com> <7v7j2l833o.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 11 16:31:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0JGU-0003ve-V6
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 16:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWGKObA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 10:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWGKObA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 10:31:00 -0400
Received: from main.gmane.org ([80.91.229.2]:10409 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750844AbWGKOa7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 10:30:59 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G0JFT-0003eN-Of
	for git@vger.kernel.org; Tue, 11 Jul 2006 16:30:03 +0200
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 16:30:03 +0200
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 16:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23713>

On 2006-07-10, Junio C Hamano <junkio@cox.net> wrote:
> Carl Baldwin <cnb@fc.hp.com> writes:
>
>> First, I would like to be able to set the packing window to 0 for all of
>> the git commands.  It would be nice if I could set this in a
>> per-repository config file so that any push/fetch operation would honor
>> this window.  Is there currently a way to do this?
>
> Should not be hard to add.
>
>> Second, I would like to not pay the penalty to inflate and then deflate
>> the objects into the pack when I use a window of 0.  How hard would this
>> be?  I am a capable programmer and wouldn't mind getting my hands dirty
>> in the code to implement this if someone could point me in the right
>> direction.
>
> The problem is that unpacked objects have the single line header
> (type followed by its inflated size in decimal) which starts the
> deflated stream, while in-pack representation of non-delta does
> not.
>
> There was an attempt to help doing this, but I haven't pursued it.
>
> 	http://article.gmane.org/gmane.comp.version-control.git/17368
>
>

Wouldn't it make more sense to convert the unpacked object reprasentation
to the one which is used in the pack files?

This would make it really easy to just copy the object in the non-delta
case to the pack and avoid the inflate/deflate calls.

Peter Baumann

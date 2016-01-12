From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 11:26:24 -0500
Message-ID: <jwvr3hmwz1n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160112153239.GA8041@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 17:26:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ1mL-0001Iv-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 17:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbcALQ0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 11:26:37 -0500
Received: from plane.gmane.org ([80.91.229.3]:41629 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbcALQ0h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 11:26:37 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aJ1mF-0001Fj-CQ
	for git@vger.kernel.org; Tue, 12 Jan 2016 17:26:35 +0100
Received: from 184-175-3-20.dsl.teksavvy.com ([184.175.3.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 17:26:35 +0100
Received: from monnier by 184-175-3-20.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 17:26:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 184-175-3-20.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:LWwV2lNbmdNjIsTTbm3UbgVNlUM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283826>

>> I currently work around the problem by adding a dummy empty branch, but
>> being able to use the revision 00000000 as a known reference to an empty
>> tree would come in really handy, and since it's already used at various
>> places in Git (post-receive hook and "git show" output, at least), it
>> would seem like a natural extension.

> The empty tree also has a name:
>
>   $ git hash-object -t tree /dev/null
>   4b825dc642cb6eb9a060e54bf8d69288fbee4904

Yay!

   git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904..d59cfff346c3e210adc26501f8cebf8da5ab2e7d

seems to give me the expected diff.
Thanks!

> And hopefully that explains why "000000" does not necessarily make a
> good placeholder for "the empty thing". There are multiple empty things,
> and it is not clear what:

>   git diff 0000000 1234abcd

> means. Is 0000000 a tree? A blob?

Well, Git is the one who uses 000000 to refer to an empty thing, but
indeed it seems like it does inconsistently: it's sometimes used as the
"empty blob" and sometimes as an "empty tree".


        Stefan

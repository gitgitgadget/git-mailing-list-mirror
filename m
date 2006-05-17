From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Wed, 17 May 2006 13:20:09 -0600
Message-ID: <m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 21:21:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRZm-0002xx-GV
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWEQTUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWEQTUr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:20:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63634 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750983AbWEQTUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:20:46 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4HJKAKX026787;
	Wed, 17 May 2006 13:20:10 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4HJK9T7026786;
	Wed, 17 May 2006 13:20:09 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsln8cwn6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 17 May 2006 11:51:41 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20228>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Importing a quilt patch series into git is not very difficult
>> but parsing the patch descriptions and all of the other
>> minutia take a bit of effort to get right, so this automates it.
>>
>> Since git and quilt complement each other it makes sense
>> to make it easy to go back and forth between the two.
>>
>> If a patch is encountered that it cannot derive the author
>> from the user is asked.
>
> What's the expected workflow for you to work on a 1300 patch
> series you get from Andrew in the next installment to deal with
> 88 unattributed patches?  Answer the question 88 times and make
> sure you get the answers right every time?  Or abort and
> hand-edit them to help mailinfo to notice the correct
> attribution and re-run?

For the internal consumption case it isn't a big deal.  I
can specify --author with something bogus and it works. 

There are a few tweaks that can be made to git-mailinfo to
make it better at parsing information out of patches.  I
cut the list down to about 49 that way.  I had it all of the
way down to 1.  But then I realized that the first Singed-off-by
really doesn't accurately reflect the author.  I suspect a
few of my other teaks are equally suspicious.

> I know I am guilty of suggesting "going interactive", but I have
> a feeling that having an optional file that maps patch-name to
> author might be easier to work with.  If the old patches are
> recycled in the updated -mm set, you probably can reuse the
> mapping for them, adding entries for newly introduced "unnamed"
> patches as needed.

Short of getting the script where it has a sane restart in the
middle mode going interactive and asking questions makes a lot
of sense.  Especially with smaller trees.

For Andrews tree before I play anymore with technical solutions I
need to talk to Andrew and see if we can improve the situation
upstream.  Possibly with a quilt-audit script that finds problem
patches.

Eric

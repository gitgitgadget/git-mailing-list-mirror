From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in
 	the case of conflicts.
Date: Wed, 31 Mar 2010 13:39:24 +0200
Message-ID: <4BB3346C.7070700@viscovery.net>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>	 <4BB2F7A0.6020702@viscovery.net> <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 13:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwwGk-00070L-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 13:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0CaLj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 07:39:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42214 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755484Ab0CaLj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 07:39:28 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NwwGb-0000W8-9r; Wed, 31 Mar 2010 13:39:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 084151660F;
	Wed, 31 Mar 2010 13:39:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143662>

Am 3/31/2010 13:12, schrieb Jon Seymour:
>> I looked at the result, but it does not convince me. In my case, I have a
>> large file that has many changes between the "maint" and "master"
>> branches. Whenever there are conflicts after merging "maint" to "master",
>> I see all these changes, and really they *are* uninteresting.
>>
> 
> I think you may have missed the point of my patch.
> 
> The successfully merged lines may be uninteresting from the point of
> deciding what I should *do* but they
> are highly relevant to the question of what I really, really should *not* do.

How would you decide that if you cannot read the information that is
presented to you?

Can you tell without thinking for 10 seconds which of these two changes is
lost if you choose "Use local version"?

@@@ ... @@@
  x
 +foo
  y
@@@ ... @@@
  a
- bar
  b

Oh, it's easy for the conflicted part of the diff, which you'll see
elsewhere as well:

@@@ ... @@@
  r
++<<<<<<< HEAD
 +foo
++=======
+ bar
++>>>>>>> some-branch
  s

Do not forget that in a case (like mine) where the non-condensed diff is
actually huge, the conflict markers would no exactly be easy to find in
the diff.

> If there are 100 successfully merged lines from each side of the merge
> but only 2 conflicting lines, should I
> 
> a) pick the remote branch
> b) pick the local branch
> c) manually edit the conflicting line (or use a merge tool)
> 
> The point of my patch it to make it much more likely that you will pick c).

And I was saying almost the same, namely that it should not only be "much
more likely" to pick c, but to *always* pick c (by making it the only
option available).

> In the current state, the GUI doesn't make it clear that either a) or
> b) is almost certainly a huge mistake.

And therefore I suggest to disable these options.

> Now, you could disable Use Remote and Use Local for all but the very
> simplest cases - but you don't need it for these
> cases. Hell, ed would do for these.

Which are those very simplest cases that you are referring to? If you mean
modify/delete conflicts, then I indeed would like to keep the options for
them.

That said, your earlier patch that presented the diff against HEAD was not
bad after all.

-- Hannes

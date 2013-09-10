From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Tue, 10 Sep 2013 13:04:18 +0200
Message-ID: <vpqtxhtey4t.fsf@anie.imag.fr>
References: <vpq4n9tghk5.fsf@anie.imag.fr> <522EEC28.6020405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 13:04:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJLkB-0002JT-Vr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 13:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab3IJLEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 07:04:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45564 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab3IJLEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 07:04:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8AB4H4w014873
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Sep 2013 13:04:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJLk2-0002Zp-Jr; Tue, 10 Sep 2013 13:04:18 +0200
In-Reply-To: <522EEC28.6020405@gmail.com> (Chris Packham's message of "Tue, 10
	Sep 2013 21:53:44 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 10 Sep 2013 13:04:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8AB4H4w014873
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379415859.05549@rWrJbH2f8h0KpgqYyvTf2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234431>

Chris Packham <judge.packham@gmail.com> writes:

> On 10/09/13 21:19, Matthieu Moy wrote:
>> Hi,
>> 
>> I just noticed that the template COMMIT_EDITMSG was containing status
>> hints, and that they were not particularty helpfull _during_ a commit. I
>> think it would be sensible to ignore advice.statusHints and disable
>> hints unconditionally when writting to COMMIT_EDITMSG.
>> 
>> Any objection?
>> 
>
> I did recently find them useful/reassuring when I was committing a
> merge. But I wouldn't consider that a strong objection.

Just to make sure we're talking about the same thing: when commiting a
merge, the template currently looks like:

  Merge branch 'master' of /tmp/git
  
  Conflicts:
  	foo.txt
  #
  # It looks like you may be committing a merge.
  # If this is not correct, please remove the file
  #	.git/MERGE_HEAD
  # and try again.
  
  
  # Please enter the commit message for your changes. Lines starting
  # with '#' will be ignored, and an empty message aborts the commit.
  # On branch master
  # Your branch and 'origin/master' have diverged,
  # and have 3 and 1 different commit each, respectively.
  #   (use "git pull" to merge the remote branch into yours)
  #
  # All conflicts fixed but you are still merging.
  #   (use "git commit" to conclude merge)
  #
  # Changes to be committed:
  #
  #	modified:   foo.txt
  #

What I'd like to remove are the parts between parenthesis :

  (use "git commit" to conclude merge)
  (use "git pull" to merge the remote branch into yours)

The first part (It looks like [...]) would remain, of course.

Actually, even the "All conflicts fixed but you are still merging." part
is not really accurate when the commit is already started.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

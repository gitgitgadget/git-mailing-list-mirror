From: "David Euresti" <davi@euresti.com>
Subject: Re: Problem with merge when renaming
Date: Tue, 18 Sep 2007 15:42:39 -0700
Message-ID: <95b3d0af0709181542s43cd55c1xb0e653be4c030dab@mail.gmail.com>
References: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com>
	 <7v7imnvca0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlmO-0007yi-Di
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649AbXIRWmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758086AbXIRWmo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:42:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:24889 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057AbXIRWmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:42:43 -0400
Received: by wr-out-0506.google.com with SMTP id 36so11204wra
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=BfU65JHyfRGqqO2ae2CU3eDA3o11sqEkw3ELgF2ru78=;
        b=N0yYStTWUdik+RdTj5jc5rS9BGACjBQvFPp1EHL2eH+5uXGuwQnjVvaxLV8UuAT6zL77cbpyzB88aQahWZUuwdvqJBYrARBF9deobzq7QRc5G9UZmAcQ5MifnNKTA5I0UhJkt1cTn9caYklXVyh5Nh59IBlFcT7tdBsI71ONoGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rJouX0uQAxr6H4INvKqhyVxjRpTtcSJQqMPHQ+YcoPnehn6iCVyyP6+K686Xd1E+USaJ9FemTUlXB2bZTJtbT7lvsrSssGr5Fw5ImnU9DD9vmwsjtVN/q+rPq80YxJsQmIzduOe3PF5t7vjnceXT+JnXrQ9EF1Vnpthom59WqIo=
Received: by 10.142.240.9 with SMTP id n9mr156893wfh.1190155359759;
        Tue, 18 Sep 2007 15:42:39 -0700 (PDT)
Received: by 10.143.167.13 with HTTP; Tue, 18 Sep 2007 15:42:39 -0700 (PDT)
In-Reply-To: <7v7imnvca0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: cd0a2475b1319832
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58652>

1) git version 1.5.2.5 and 1.5.3.1.139.g9346b

2)
$ git-merge -s resolve branch-a
$ git-merge -s resolve branch-b
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Trying simple merge.
Simple merge failed, trying Automatic merge.
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   bar.txt
#       new file:   foo.txt
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       unmerged:   dir/foo
#       unmerged:   dir/foo/foo.bin
#       modified:   dir/foo/foo.bin
#

But if I do it in the other order I get this:
$ git-merge -s resolve branch-b
$ git-merge -s resolve branch-a
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Trying simple merge.
Simple merge failed, trying Automatic merge.
Removing dir/foo
Adding dir/foo/foo.bin
ERROR: untracked dir/foo/foo.bin is overwritten by the merge.
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.

deuresti@deuresti-lnx /tmp/scm-rename-test/git-repo
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    dir/foo
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       unmerged:   dir/foo/foo.bin
#

Thanks,
David
On 9/18/07, Junio C Hamano <gitster@pobox.com> wrote:
> "David Euresti" <evelio@gmail.com> writes:
>
> > I think I found a problem when you move a file into a directory of the
> > same name.  Here's what I did.
>
> Two questions.
>
>  (1) git --version?
>
>  (2) if you do "git merge -s resolve" instead of just "git
>      merge", do you see a difference?
>

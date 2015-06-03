From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 03 Jun 2015 21:26:49 +0200
Message-ID: <556F54F9.2050202@web.de>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net> <loom.20150603T114527-151@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 21:28:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0EJb-0006ad-LM
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbbFCT1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 15:27:00 -0400
Received: from mout.web.de ([212.227.17.11]:62759 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbbFCT06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 15:26:58 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M8Qtq-1ZLjP32dgQ-00vwHF; Wed, 03 Jun 2015 21:26:55
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <loom.20150603T114527-151@post.gmane.org>
X-Provags-ID: V03:K0:R1ZZlxrGUr/44vAv/6tTdc/+CbrioBvn6iNqv7thADMnNI7EK+9
 c8o8mzgjAEgB6szcas+6Fvx1hgbxQUTOmCXCH2kHuPemz4xN0V+yJ/6zEaYO+92uK7Cm2t0
 yyAy7Uhy22+zd18KBDK8/ykNG1+uh3ZCy1t4oIlsQC9I0NGCd5DBJUGTrBTbTyiDAJPKP1q
 ay5jSwqBJMQZH3wCUMayw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270728>

On 2015-06-03 11.55, Ed Avis wrote:
> Jeff King <peff <at> peff.net> writes:
> 
>> I would say the more "usual" way to use checkout like this
>> is to give specific paths. I.e., run "git status", say "oh, I need to
>> restore the contents of 'foo', but not 'bar'", and run "git checkout
>> foo". That works regardless of the type of change to "foo" and "bar".
> 
> That seems fine - a specific file is named and you clearly want to alter
> the contents of that file.  By analogy, 'rm foo' will silently delete it,
> but if you specify a directory to delete recursively you need the -r flag.
> OK, it's not a perfect analogy because the purpose of rm is to delete data
> and nothing else ;-).
> 
> If my personal experience is anything to go by, newcomers may fall into the
> habit of running 'git checkout .' to restore missing files.  In the old days
> I would often delete a file and then run 'cvs update' or 'svn update' to
> restore it.  That would fetch a fresh copy from the repository, and while
> it might do some kind of diff/patch operation on modified files, it would
> not simply throw away local changes.
> 
> 'git checkout .' seems like the analogous command, but it has much sharper
> edges.  I still think it should be safer by default, but if you decide
> against that then perhaps you need to create some way to restore missing
> files and not overwrite others.  'git checkout --no-overwrite'?  Then it
> could even be added to .gitconfig as the default for those who like it.
> 
> I have to say that as a newcomer to git I do not like the idea of creating
> a special undo log for git.  It would just be yet another concept to learn
> and another thing to add to the list of 'where is git hiding my data this
> time?'.  And the time when it would be useful - after some bungled operation
> that lost data - is just the time when the user is already confused and
> adding another semi-hidden stash of objects to the mix would befuddle them
> further.  If there is to be a backup made of local changes that get lost,
> and I agree it is a good idea, then it should be something stupid and
> completely obvious, such as saving the old file as 'foo.before_checkout.1'.
> 
This is what my Git says:

git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   A
        deleted:    B

(So it should be somewhat self-documenting)


I try to avoid things like "git reset --hard", and "git checkout .",
and often use "git stash" instead.

It may be that there is a chance to improve the documentation.

Just for curiosity:
From where did you got the information to run "git checkout ." ?

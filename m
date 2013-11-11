From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 1/7] remote-hg: don't decode UTF-8 paths into Unicode
 objects
Date: Mon, 11 Nov 2013 13:30:48 -0500
Message-ID: <52812258.1060109@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com> <1384142712-2936-2-git-send-email-rhansen@bbn.com> <5280b9d87f92c_6841541e786f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 19:30:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwGF-0004Xj-3o
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab3KKSaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:30:52 -0500
Received: from smtp.bbn.com ([128.33.1.81]:33428 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301Ab3KKSau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:30:50 -0500
Received: from socket.bbn.com ([192.1.120.102]:44789)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfwG8-000OLk-TK; Mon, 11 Nov 2013 13:30:48 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 96DF93FEF1
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5280b9d87f92c_6841541e786f@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237627>

On 2013-11-11 06:04, Felipe Contreras wrote:
> Richard Hansen wrote:
>> The internal mercurial API expects ordinary 8-bit string objects, not
>> Unicode string objects.  With this change, the test-hg.sh unit tests
>> pass again.
> 
> This makes sense to me, but the tests are already passing for me. How are they
> failing for you?

$ hg --version | head -n 1
Mercurial Distributed SCM (version 2.2.2)
$ cd ~/git/t
$ ../contrib/remote-helpers/test-hg.sh --verbose --immediate
...
Traceback (most recent call last):
  File "~/git/contrib/remote-helpers/git-remote-hg", line 1246, in <module>
    sys.exit(main(sys.argv))
  File "~/git/contrib/remote-helpers/git-remote-hg", line 1230, in main
    do_export(parser)
  File "~/git/contrib/remote-helpers/git-remote-hg", line 1031, in do_export
    parse_commit(parser)
  File "~/git/contrib/remote-helpers/git-remote-hg", line 822, in
parse_commit
    node = hghex(repo.commitctx(ctx))
  File "/usr/lib/python2.7/dist-packages/mercurial/localrepo.py", line
1270, in commitctx
    p2.manifestnode(), (new, drop))
  File "/usr/lib/python2.7/dist-packages/mercurial/manifest.py", line
197, in add
    cachedelta = (self.rev(p1), addlistdelta(addlist, delta))
  File "/usr/lib/python2.7/dist-packages/mercurial/manifest.py", line
124, in addlistdelta
    addlist[start:end] = array.array('c', content)
TypeError: array item must be char
not ok 4 - update bookmark

I can put the above in the commit message if people would like it there.

-Richard

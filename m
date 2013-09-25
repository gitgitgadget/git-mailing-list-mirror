From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Tue, 24 Sep 2013 22:13:43 -0500
Message-ID: <87y56lsie0.fsf@gmail.com>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
	<CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 05:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOfY8-0006oL-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 05:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab3IYDN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 23:13:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:35863 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab3IYDNz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 23:13:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VOfY0-0006jn-SQ
	for git@vger.kernel.org; Wed, 25 Sep 2013 05:13:52 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 05:13:52 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 05:13:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:s39tUvyWfSWiPhGs9PV3vEGUq94=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235330>

David Aguilar <davvid@gmail.com> writes:

> On Tue, Sep 24, 2013 at 2:07 PM, Jona Christopher Sahnwaldt
> <jc@sahnwaldt.de> wrote:
>> Hi,
>>
>> maybe this has already been reported, but I didn't find it in the mail archive.
>>
>> If I understand correctly, after I clone a repo, I should be able to
>> switch to branch foo just by running
>>
>> git checkout foo
>>
>> This doesn't seem to work if a folder called "foo" exists in the root
>> of the repo.
>
> git checkout foo --
>
> The double-dash at the end disambiguates between refs and paths.
>
> You can use that trick on any command that accepts refspec (branches,
> tags, etc) and pathspec (path patterns).

I was going to reply with similar advice, but I actually tried it on the
example repo and it didn't work. Apparently it doesn't interoperate
properly with the functionality that guesses when you're trying to check
out a remote branch and creates an equivalently named local branch.

    [2] fs@erdos /tmp $ git clone https://github.com/dbpedia/extraction-framework.git
    Cloning into 'extraction-framework'...
    remote: Counting objects: 33513, done.
    remote: Compressing objects: 100% (6633/6633), done.
    remote: Total 33513 (delta 19000), reused 32922 (delta 18436)
    Receiving objects: 100% (33513/33513), 23.48 MiB | 747.00 KiB/s, done.
    Resolving deltas: 100% (19000/19000), done.
    Checking connectivity... done
    [2] fs@erdos /tmp $ cd extraction-framework/
    [2] fs@erdos /tmp/extraction-framework $ git checkout live-dev --
    fatal: invalid reference: live-dev
    [2] fs@erdos /tmp/extraction-framework $ git checkout live-dev
    Branch live-dev set up to track remote branch live-dev from origin.
    Switched to a new branch 'live-dev'
    [2] fs@erdos /tmp/extraction-framework $ git checkout master
    Switched to branch 'master'
    [2] fs@erdos /tmp/extraction-framework $ git checkout wiktionary
    [2] fs@erdos /tmp/extraction-framework $ git branch
      live-dev
    * master
    [2] fs@erdos /tmp/extraction-framework $ git checkout wiktionary --
    fatal: invalid reference: wiktionary

-Keshav

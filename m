From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] merge: allow using --no-ff and --ff-only at the same
 time
Date: Mon, 01 Jul 2013 16:52:29 +0200
Message-ID: <51D197AD.1070502@alum.mit.edu>
References: <20130701070143.GB17269@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 01 16:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtfT4-0004qw-0u
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 16:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab3GAOwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 10:52:34 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51503 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753130Ab3GAOwd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jul 2013 10:52:33 -0400
X-AuditID: 12074411-b7f296d000001209-77-51d197b06f5d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F0.F5.04617.0B791D15; Mon,  1 Jul 2013 10:52:32 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r61EqTdD009904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Jul 2013 10:52:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130701070143.GB17269@suse.cz>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqLth+sVAgy+7RS26rnQzWTT0XmG2
	2DllPrMDs8fFS8oeZxYcYff4vEkugDmK2yYpsaQsODM9T98ugTuj51B0wWOligtXVjI2MD6V
	6mLk5JAQMJFoXfWVDcIWk7hwbz2QzcUhJHCZUeLh+ivsEM5VJolVTztYQKp4BbQlet+3gdks
	AqoS295dZgSx2QR0JRb1NDN1MXJwiAqESVz5rQpRLihxcuYTsHIRASWJbxP3s4PYzALWEite
	HwYrFxYIkPi6KxAkLCSgI/F362xmkDAn0MQ1i+VBTGYBdYn184QgGuUltr+dwzyBUWAWkvmz
	EKpmIalawMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkYAV3MM44KXeI
	UYCDUYmHd8H0C4FCrIllxZW5hxglOZiURHkvT7kYKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	96Y3UI43JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMF7eBpQo2BRanpq
	RVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoPuOLgREKkuIB2rsApJ23uCAxFygK0XqK0Zhj
	8tkt7xk5DvwAkkIsefl5qVLivEtBSgVASjNK8+AWwVLVK0ZxoL+FeTeBVPEA0xzcvFdAq5iA
	VvG2ngNZVZKIkJJqYJTqcN2wp+ZevsHZie0MrirC14469GW9Pfpp8U2m88IFz1XVpxW9F9eU
	tuHT8C+9H/Jmsup6Dc3iTYcfzVA0/9Ah3yHxfH98ieMCxulyXyXWbdFT/5Fccy7n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229300>

On 07/01/2013 09:01 AM, Miklos Vajna wrote:
> 1347483 (Teach 'git merge' and 'git pull' the option --ff-only,
> 2009-10-29) says this is not allowed, as they contradict each other.
> 
> However, --ff-only is about asserting the input of the merge, and
> --no-ff is about instructing merge to always create a merge commit, i.e.
> it makes sense to use these options together in some workflow, e.g. when
> branches are integrated by rebasing then merging, and the maintainer
> wants to be sure the branch is rebased.

That is one interpretation of what these options should mean, and I
agree that it is one way of reading the manpage (which says

--ff-only::
	Refuse to merge and exit with a non-zero status unless the
	current `HEAD` is already up-to-date or the merge can be
	resolved as a fast-forward.

).  However, I don't think that the manpage unambiguously demands this
interpretation, and that (more importantly) most users would be very
surprised if --ff-only and --no-ff were not opposites.

How does it hurt?  If I have configuration value merge.ff set to "only"
and run "git merge --no-ff" and then I merge a branch that *cannot* be
fast forwarded, the logic of your patch would require the merge to be
rejected, no?  But I think it is more plausible to expect that the
command line option takes precedence.

Hmmph.  I just tested and found out that (before your patch) a "--no-ff"
command-line option does *not* override a "git config merge.ff only" but
rather that the combination provokes the error that you are trying to
remove,

    fatal: You cannot combine --no-ff with --ff-only.

I find *that* surprising; usually command-line options override
configuration file settings.  OK, it's time for some more exhaustive
testing:

   situation      merge.ff  option      result
   -------------------------------------------------------------------
1  ff possible    false     --ff        works (ff)
2  ff impossible  false     --ff        works (non-ff)
3  ff possible    false     --ff-only   error "cannot combine options"
4  ff impossible  false     --ff-only   error "cannot combine options"
5  ff possible    false     --no-ff     works (non-ff)
6  ff impossible  false     --no-ff     works (non-ff)
7  ff possible    only      --ff        works (ff)
8  ff impossible  only      --ff        error "not possible to ff"
9  ff possible    only      --ff-only   works (ff)
10 ff impossible  only      --ff-only   error "not possible to ff"
11 ff possible    only      --no-ff     error "cannot combine options"
12 ff impossible  only      --no-ff     error "cannot combine options"

>From line 1 we see that "--ff" overrides "merge.ff=false".

>From lines 3 and 4 we see that "--ff-only" cannot be combined with
"merge.ff=false".

>From line 8 we see that "merge.ff=only" has its effect despite "--ff",
which would normally allow a non-ff merge.

>From lines 11 and 12 we see that "--no-ff" cannot be combined with
"merge.ff=only".

I find this inconsistent.  I think it would be more consistent to have
exactly three states,

* merge.ff unset == --ff == "do ff if possible, otherwise non-ff"

* merge.ff=false == --no-ff == "always create merge commit"

* merge.ff=only == --ff-only == "do ff if possible, otherwise fail"

and for the command-line option to always take precedence over the
config file option.

Moreover, isn't it the usual practice for later command-line options to
take precedence over earlier ones?  It is the case for at least one command:

    $ git log --oneline --no-walk --no-decorate --decorate
    cf71d9b (HEAD, master) 2
    $ git log --oneline --no-walk --decorate --no-decorate
    cf71d9b 2

So I think that command invocations with more than one of {"--ff",
"--no-ff", "--ff-only"} should respect the last option listed rather
than complaining about "cannot combine options".

If I find the time (unlikely) I might submit a patch to implement these
expectations.


In my opinion, your use case shouldn't be supported by the command
because (1) it is confusing, (2) it is not very common, and (3) it is
easy to work around:

    if git merge-base --is-ancestor HEAD $branch
    then
        git merge --no-ff $branch
    else
        echo "fatal: Not possible to fast-forward, aborting."
        exit 1
    fi

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

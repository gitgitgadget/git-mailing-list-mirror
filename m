From: David Kastrup <dak@gnu.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 16:59:24 +0200
Message-ID: <86lkahwqsz.fsf@lola.quinscape.zz>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
	<20071005142140.GK19879@artemis.corp>
	<20071005142507.GL19879@artemis.corp>
	<20071005143014.GA18176@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 17:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdoxN-0001Dm-1j
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbXJEPTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 11:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbXJEPTD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:19:03 -0400
Received: from main.gmane.org ([80.91.229.2]:40397 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbXJEPTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 11:19:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Idoks-0001AO-DH
	for git@vger.kernel.org; Fri, 05 Oct 2007 15:06:18 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 15:06:18 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 15:06:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:ck7rgjSPd77m8UfK/7p+nsJsg7I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60092>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Oct 05, 2007 at 04:25:07PM +0200, Pierre Habouzit <madcoder@debian.org> wrote:
>> The option parser takes argc, argv, an array of struct option
>> and a usage string.  Each of the struct option elements in the array
>> describes a valid option, its type and a pointer to the location where the
>> value is written.  The entry point is parse_options(), which scans through
>> the given argv, and matches each option there against the list of valid
>> options.  During the scan, argv is rewritten to only contain the
>> non-option command line arguments and the number of these is returned.
>> 
>> Aggregation of single switches is allowed:
>>   -rC0 is the same as -r -C 0 (supposing that -C wants an arg).
>
> I like options aggregation, but I'm not sure aggregating option arguments
> is a good idea... I can't even think of an application that does it.

I think most allow this for the last option in a row.  Tar is somewhat
more perverse with its non-option command string:

tar xfzbv filename.tgz 40

uses filename.tgz as the option argument for "f" and 40 for "b".

Note that while tar accepts options instead of the initial command
string,

tar -xfzbv filename.tgz 40

will _not_ work, while

tar -xffilename.tgz -z -b40 -v

presumably would (have no time to test this right now).


-- 
David Kastrup

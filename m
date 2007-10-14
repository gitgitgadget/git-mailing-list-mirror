From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] [BUG FIXED 2] git-add (-a|-u)  and -n support
Date: Sun, 14 Oct 2007 18:00:44 -0400
Message-ID: <D44B7811-5A0F-4A31-9DB3-6D2BF645E543@MIT.EDU>
References: <E1DCA1D1-1ED3-498A-A919-9EBAF3BA0870@mit.edu> <0458D1DA-6261-4DA6-91B0-739F4D35AADF@mit.edu> <E857D120-787F-460B-A167-4B5F4BD2C3B5@mit.edu> <vpq3awd25hs.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 00:01:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhBWU-0002X9-DG
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759929AbXJNWBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759803AbXJNWBM
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:01:12 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:51147 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754126AbXJNWBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 18:01:11 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9EM0oVx028046;
	Sun, 14 Oct 2007 18:00:50 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9EM0jw7026400
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 14 Oct 2007 18:00:50 -0400 (EDT)
In-Reply-To: <vpq3awd25hs.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60910>

Thanks for the reply!

On 14 Oct 2007, at 9:25:03 AM, Matthieu Moy wrote:

> Michael Witten <mfwitten@MIT.EDU> writes:
>
>> Subject: [PATCH] git-add now understands two kinds of update:
>>
>>  	-u: update as before
>>  	-a: update all as in a true 'git commit -a'
>
> I don't find the option set very intuitive. I'd prefer
>
>   - git add -u . => update the current directory as before
>   - git add -u   => update all files from the root.
>
> But your solution has the advantage of being backward compatible, so,
> no strong opinion here.

Here's compromise that is backwards compatible. For both git-add
and git-commit:
	
	-a dir [dir2 ...] => all changes in the given dirs.
	-a                => all changes from the root.

Then we can just leave -u in place for now, and mark it as deprecated.

In any case, the goal is to make the intuition solid between
git-commit and git-add.


> (side note: also, while you're here, it would be nice to have a single
> command to do "git add .; git add -u", i.e add all unknown files,
> update all existing files, and actally remove all deleted files. In
> one word, synchronize the index with the working tree completely.
> Perhaps "-a" would be a good name for that, not sure)

We can couple the above with -f to do this.


>>  builtin-add.c |   69 +++++++++++++++++++++++++++++++++++++
>> +-------------------
>
> Your patch is whitespace-damaged. I don't know how to fix that for
> Apple Mail, but git-send-email can help.

I see that now; Apple's trying to be smart about blank lines, it  
would seem.

>> static const char builtin_add_usage[] =
>>  "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--]
>> <filepattern>...";
>
> You should document -a here, and in Documentation/git-add.txt if you
> introduce it.

Let's get -a/-u squared away first.

Thanks again,
Michael Witten

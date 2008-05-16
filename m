From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git-svn goes into infinite loop rebuilding rev_map
Date: Fri, 16 May 2008 14:02:20 -0400
Message-ID: <4aca3dc20805161102y2de0d95cif8a6b643abf722e8@mail.gmail.com>
References: <4aca3dc20805161015l28d1e4a2u318c1bc23bb5b925@mail.gmail.com>
	 <4E00E139-E354-4336-8290-51CD1B55017A@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, normalperson@yhbt.net
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri May 16 20:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx4H7-0007v7-Gj
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 20:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYEPSCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbYEPSCZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 14:02:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:47105 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYEPSCY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 14:02:24 -0400
Received: by wx-out-0506.google.com with SMTP id h29so772461wxd.4
        for <git@vger.kernel.org>; Fri, 16 May 2008 11:02:23 -0700 (PDT)
Received: by 10.90.71.16 with SMTP id t16mr5318351aga.94.1210960940753;
        Fri, 16 May 2008 11:02:20 -0700 (PDT)
Received: by 10.90.49.12 with HTTP; Fri, 16 May 2008 11:02:20 -0700 (PDT)
In-Reply-To: <4E00E139-E354-4336-8290-51CD1B55017A@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82313>

On Fri, May 16, 2008 at 1:48 PM, Kevin Ballard <kevin@sb.org> wrote:
> On May 16, 2008, at 1:15 PM, Daniel Berlin wrote:
>
>> Starting last night, for no particularly obvious reason, git-svn fetch
>> (or git-svn rebase or any command that does naything interesting) on
>> gcc.gnu.org's repo causes git-svn to do the following:
>>
>> -bash-3.00$ git-svn fetch
>> Rebuilding .git/svn/trunk/.rev_map.138bc75d-0d04-0410-961f-82ee72b054a4
>> ...
>> Done rebuilding
>> .git/svn/trunk/.rev_map.138bc75d-0d04-0410-961f-82ee72b054a4
>> Rebuilding .git/svn/trunk/.rev_map.138bc75d-0d04-0410-961f-82ee72b054a4
>> ...
>> <repeat forever>
>>
>>
>> I checked the obvious things. There is no permissions problem, strace
>> doesn't show the writes failing, etc.
>> git-fsck shows nothing as being obviously wrong.
>
> Are you sure? I just glanced at the code, and it avoids rebuilding i the map
> file exists and is not empty.
Absolutely positive.

You can see the strace at http://www.dberlin.org/git.strace.bz2
Note there are no eperms or anything of the sort.


>
>> This just suddenly started happening with no obvious reason (we fire
>> off git-svn fetch and rebase on the repo when cvs commits happen).
>>
>> git-log shows the last processed rev was:
>>
>> commit e66b310fb9a3ddc7ed5143db3c468711c8a36d08
>> Author: uros <uros@138bc75d-0d04-0410-961f-82ee72b054a4>
>> Date:   Thu May 15 14:38:23 2008 +0000
>>
>>       * config/i386/sse.md (*vec_concatv2sf_sse4_1): Add "m" constraint
>>       to alternative 4 of operand 2.
>>
>>
>>   git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@135364
>> 138bc75d-0d04-0410-961f-82ee72b054a4
>>
>>
>> I'm happy to provide anything i can to get the problem fixed, but not
>> being a git expert, i have no idea what is up here.
>
> What version of git do you have? And you might want to CC Eric Wong
> <normalperson@yhbt.net> on this.
>
It was 1.5.5
After we noticed this problem, i tried updating it to the absolute
latest from the repo as of this morning (didn't help).
So it is now 1.5.5.1.308.g1fbb5


> -Kevin Ballard
>
> --
> Kevin Ballard
> http://kevin.sb.org
> kevin@sb.org
> http://www.tildesoft.com
>
>
>

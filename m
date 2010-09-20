From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Mon, 20 Sep 2010 03:31:41 +0200
Message-ID: <4C96B97D.6030209@gmail.com>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de> <201009192030.21659.robin.rosenberg@dewire.com> <201009192203.o8JM39PE011067@no.baka.org>        <4C9698C5.70607@gmail.com> <201009192354.o8JNsVLs018778@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 03:31:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxVEW-0003VW-3B
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 03:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0ITBbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 21:31:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42093 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab0ITBbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 21:31:45 -0400
Received: by wyf22 with SMTP id 22so3860639wyf.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 18:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=F0LCysnsEUS9XKU+79h7KHGfngKoH1w8YGHyqbCPzZU=;
        b=cRZwS8pRlneFDZ7V0f+gT/MVhW5Bai7rO9uX6zZw0XbpI5CNM7zIJ2Nb1+tfi5/wTk
         f9aqud5RM8jbGou5YvS0X5ffNblHec2EvcbB+oDBQ8rUaDA7jIpjvd8PIsa02O27eaVj
         BIhjzKl0t33jsIjp5iNy47bzvoEuw/D/qQnw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=Q4NW5m0/pAncft6hFcHp/Ks4A9l2hYkDLk6p9hwxQ6NRxyYAewxOOk2fWPDhE8oBv+
         l7dEI879LuF8EQWnXEtLWhv08/rMI5S0lj30qb8HLJUsvnhpwHrietbkVNu2vybn1AE/
         s16UWXTx0iXueIRWNeTnXkneiaYALy/aWYvNE=
Received: by 10.216.93.10 with SMTP id k10mr3730723wef.38.1284946304164;
        Sun, 19 Sep 2010 18:31:44 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-83-50.multimo.pl [89.174.83.50])
        by mx.google.com with ESMTPS id e56sm4757908wer.22.2010.09.19.18.31.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 18:31:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <201009192354.o8JNsVLs018778@no.baka.org>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156543>

On 09/20/10 01:54, Seth Robertson wrote:
> In message <4C9698C5.70607@gmail.com>, Artur Skawina writes:
> 
> On 09/20/10 00:03, Seth Robertson wrote:
>>>>>>                A---B---C topic
>>>>>>               /         \
>>>>>>          D---E---F---G---H---I---J---K---L---M---N master
>>>>>>                                   \         /
>>>>>>                                    O---P---Q another-topic
>>>
>>>>> No, that's not what I need either.  After thinking about it more, I
>>>>> think what I want is "of all merges in the ancestry path from B to
>>>>> master, show only those whose first parent can't reach B."  The result
>>>>> is the list of all merges that were involved in bringing B to master.
>>>
>>>
>>>> This would work, and i don't see a way to optimize it in git-speak,
>>>> given that you don't want to see any extra trailing merges. [...]
>>>
>>> The provided command actually doesn't work for me for all cases.  It
>>> works for the simple case of "B", but does not work for "F", because F
>>> saw merge H & M.  I think we need --not --first-parent, except that
>>
>> Well, F was never on a separate branch, so the command returning ""
>> is arguably the right thing.
> 
> I'd like a command that would tell me the right branch something was
> on whether it was on master or topic or whatever.  If instead of
> "master" the branch was named "supertopic" and master commit AA had
> child D would that make a difference?

Like i said, "arguably". In theory, no, there is no difference. In
practice, some branches will be more long-lived than others -- and
certain conventions will apply. Hence, i think that answer /is/ the
right one, in context -- that script was specifically looking for
info on /another/ branch.

>>> doesn't actually work in this case either.  However, if we get the
>>> full --first-parent rev-list and look for our commit, that works.
>>> This is incredibly painful, though.
>>> ----------------------------------------------------------------------
>>> #!/bin/sh
>>> TARGET=`git rev-list -n 1 $1`
>>> git branch -a --contains $1 | sed 's/^\** *//' | grep -v ' -> ' |
>>> while read br; do
>>>  if git rev-list --first-parent $br | grep -q "$TARGET"; then
>>>   echo $br
>>>  fi
>>> done
>>> ----------------------------------------------------------------------
> 
>> And it does not work if you no longer have the branches around...
> 
> If something doesn't have a name I am not very interested in it (for
> my purposes, your milage may vary).  Presumably the other code could be
> combined with my inner loop.
> 
>> But even if you kept all the old refs, this would return
>> "another-topic"+"master", which is hardly the right answer.
> 
> I'm not sure how you can figure out when a branch was first created.
> We might "know" that master is older than the others, but if this
> commit was on another-topic and supertopic we cannot use that
> intuition..
> 
> Returning all possible branch names at least gives the user somewhere
> to start and does not give them ones which are obviously insane.

If you want to find out on which branch a change was committed and
"master" is right for 'F', then the "another-topic" part of that
answer is problematic -- every commit on that branch is a descendant
of 'F", and so is everything in between $common_base ('J') and master.
If you /don't/ treat master as special (ie don't treat the first
parent as special) what is then the difference vs a simple
"git branch -a --contains F"?
IOW, why would the right answer for 'F' be both 'master' and
'another-topic', but for 'B' - just 'topic'?

artur

From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Mon, 4 Aug 2014 22:51:52 +0100
Organization: OPDS
Message-ID: <F97E9146985F4449A937B9C5CCA1D7F5@PhilipOakley>
References: <1406994383-5076-1-git-send-email-philipoakley@iee.org><1406994383-5076-2-git-send-email-philipoakley@iee.org> <xmqq38dctcmz.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 23:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEQAh-0006Nw-W1
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 23:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaHDVv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 17:51:56 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:46387 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855AbaHDVvz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 17:51:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkUoAOv+31MCYJ75PGdsb2JhbABbgw1jAUWHL4EEy0sFAQIBAQyBCRcFAQEBATg2g34FAQEEAQgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIKQy0B5BGj0w1gwGBHAWKVYQigmaiVjwv
X-IPAS-Result: AkUoAOv+31MCYJ75PGdsb2JhbABbgw1jAUWHL4EEy0sFAQIBAQyBCRcFAQEBATg2g34FAQEEAQgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIKQy0B5BGj0w1gwGBHAWKVYQigmaiVjwv
X-IronPort-AV: E=Sophos;i="5.01,800,1400022000"; 
   d="scan'208";a="710971779"
Received: from host-2-96-158-249.as13285.net (HELO PhilipOakley) ([2.96.158.249])
  by out1.ip01ir2.opaltelecom.net with SMTP; 04 Aug 2014 22:51:53 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254787>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Historically (5 Nov 2005 v0.99.9-46-g28ffb89) the git-format-patch 
>> used
>> 'origin' as the upstream branch name. That name is now used as the 
>> nominal
>> name for the upstream remote.
>>
>> While 'origin' would be DWIMmed (do what I mean) to be that remote's
>> primary branch, do not assume the reader is ready for such magic.
>
> Good thinking.
>
>> Likewise, do not use 'origin/master' which may not be up to date with 
>> the
>> remote, nor reflect the reader's master branch. The patch series 
>> should be
>> relative to the reader's view of 'git show-branch HEAD master'.
>
> This however is backwards, no?  The history on 'origin/master' may
> not be up-to-date in the sense that if you run 'git fetch' you might
> get more, but it absolutely is up-to-date in the sense that it shows
> what the origin has to the best of your repository's current
> knowledge.

I still think that the user/reader shouldn't be creating patches based 
on wherever someone else had got to, rather it should just be patches 
from their own feature branch. However the rest of your argument still 
stands with regard to accidental/unexpected conflicts with other 
upstream work, and the reader should ensure they are already up to 
date - maybe it needs a comment line to state that.

>
> Compared to that, what the user's local 'master' has is much less
> relevant.  For one thing, if a more recent commit that is on the
> remote repository is missing on 'origin/master' because you haven't
> fetched recently, by definition that commit will not be on your
> 'master' either, so you have the same staleness issue to the exact
> degree.  Even worse, when you are developing a topic to upstream, it
> is a good practice to merge your topic to your own 'master' to check
> it with the wider project codebase that is more recent than where
> your topic earlier forked from, and it makes little sense to tell
> 'exclude what I have on my master' to format-patch when extracting
> changes to upstream out of such a topic.  You send what the other
> side has, not what you do not have on your local 'master' branch.
>
>> Use the more modern 'master' as the reference branch name.
>
> There is nothing 'modern' in 'master'.

Noted.

>
> I think the original description was written before we switched to
> the separate remote layout.  What is in 'refs/remote/origin/master'
> these days was stored and updated at 'refs/heads/origin' and no
> other branch from the remote repository was tracked back then.  The
> changes to be upstreamed are output by grabbing what are not in
> 'origin', whose modern equivalent is 'origin/master'.
>
> In short, if your patch were s|origin|origin/master|, instead of
> s|origin|master|, that would be an adjustment to the more modern
> world that is still faithful to the intent of the original.

I think we would need to clarify that (the intent) for the reader. I'll 
see what I can do. (suggestion below)

>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/git-format-patch.txt | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-format-patch.txt 
>> b/Documentation/git-format-patch.txt
>> index c0fd470..b0f041f 100644
>> --- a/Documentation/git-format-patch.txt
>> +++ b/Documentation/git-format-patch.txt
>> @@ -523,25 +523,25 @@ $ git format-patch -k --stdout R1..R2 | git 
>> am -3 -k
>>  ------------
>>
>>  * Extract all commits which are in the current branch but not in the
>> -origin branch:
>> +master branch:
>>  +
>>  ------------
>> -$ git format-patch origin
>> +$ git format-patch master
>>  ------------
>>  +
>>  For each commit a separate file is created in the current directory.

Perhaps insert "Note: Your 'master' should be up to date with respect to 
'origin/master' before creating and sending patches upstream to avoid 
unexpected conflicts." ?

>>
>> -* Extract all commits that lead to 'origin' since the inception of 
>> the
>> +* Extract all commits that lead to 'master' since the inception of 
>> the
>>  project:
>>  +
>>  ------------
>> -$ git format-patch --root origin
>> +$ git format-patch --root master
>>  ------------
>>
>>  * The same as the previous one:
>>  +
>>  ------------
>> -$ git format-patch -M -B origin
>> +$ git format-patch -M -B master
>>  ------------
>>  +
>>  Additionally, it detects and handles renames and complete rewrites
> --
Philip 

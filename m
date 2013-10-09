From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed, 09 Oct 2013 12:46:47 +0200
Message-ID: <52553417.2090903@viscovery.net>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com> <CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com> <CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com> <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Giarrusso <p.giarrusso@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 12:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTrIA-00057R-By
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 12:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab3JIKqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 06:46:54 -0400
Received: from so.liwest.at ([212.33.55.16]:48640 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab3JIKqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 06:46:54 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VTrI0-0005pR-BQ; Wed, 09 Oct 2013 12:46:48 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 17E9916613;
	Wed,  9 Oct 2013 12:46:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235806>

Am 10/9/2013 12:32, schrieb Paolo Giarrusso:
> On Wed, Oct 9, 2013 at 12:20 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
>> On Wed, Oct 9, 2013 at 11:57 AM, Paolo G. Giarrusso
>> <p.giarrusso@gmail.com> wrote:
>>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>>> index 7d7af03..ebfb78f 100755
>>> --- a/contrib/subtree/git-subtree.sh
>>> +++ b/contrib/subtree/git-subtree.sh
>>> @@ -592,7 +592,9 @@ cmd_split()
>>>         eval "$grl" |
>>>         while read rev parents; do
>>>                 revcount=$(($revcount + 1))
>>> -               say -n "$revcount/$revmax ($createcount)
>>> "
>>> +               if [ -z "$quiet" ]; then
>>> +                       printf "%s" "$revcount/$revmax ($createcount)
>>> " >&2
> 
> An additional note for reviewers and appliers: the original and the
> patched codeboth embed a literal ^M,
>...
> whether the code should use some
> escape sequence instead.

As you are using printf, you can easily do:

			printf '%s\r' "..."

without using ^M.

-- Hannes

From: =?UTF-8?Q?Wojciech_Przyby=C5=82?= <przybylwojciech@gmail.com>
Subject: Re: Potential bug in git client
Date: Wed, 11 Jun 2014 12:09:06 +0100
Message-ID: <CAKY5LXzYNZbmFaQMP91=nV=gyEtNDz9fpL6wZt7TWkq_jbnNZg@mail.gmail.com>
References: <CAKY5LXywixV3dWcCcVPTvyFrScJjLd8eoVs=RA1VRcrzUgtThQ@mail.gmail.com>
	<5398359B.6060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 13:09:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WugP3-00043r-7F
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 13:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbaFKLJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2014 07:09:08 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:44557 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbaFKLJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 07:09:07 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so4941630qac.35
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 04:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hYMlXPAINul+UcSVQLCNEbKUqp9SODi7s6EXvOdyNc4=;
        b=naxmwbo1VNw+pOSkhXPgsiIIECEnvBoKdaEWcIneV8isdK7+6MF965Sl/Ef02oTMEw
         bFDzY20GMx2DDf7n3T1e6qfgE5OstXu8GVlui4sBuRksdu6dewnGhYrY5VH6JdKc59Dv
         97sDxvIYnKK75/E3f4gIc7J5cCksocBNwP6UkqteBsPW5I8K8yhBbPJxkioKEs0HjRvk
         r9Z280rzp96lYWW99hEW9xS+PcFo6xXZNdMUXMkJNrMW+VgVxAiu8i1ocffuIM/R2dhY
         YhAaOrR/xp7A+/WzfXKfpG8wlj0C++8QTtZEAZWDs26QHJXoQ3lYxThQzClUZjozZ+g6
         nFwg==
X-Received: by 10.224.28.65 with SMTP id l1mr50795747qac.81.1402484946477;
 Wed, 11 Jun 2014 04:09:06 -0700 (PDT)
Received: by 10.229.149.196 with HTTP; Wed, 11 Jun 2014 04:09:06 -0700 (PDT)
In-Reply-To: <5398359B.6060907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251362>

Hi

Thanks for your quick reply. Just read the link and I agree it is not
the right thing to do, especially when someone else has already picked
up the tag. In such case, I fully agree, the developer should say "I
messed up, sorry".

Simultaneously, once such situation occurs, I think git should not
claim all is up to date. It should not be the case on how tags are
updated, that is work with "git fetch --tags", but not work with "git
fetch --all --tags". I think by this developer's example, git should
do the same: "I messed up, sorry, it's not actually up to date".

Cheers
Wojciech

On 11 June 2014 11:55, Stefan Beller <stefanbeller@gmail.com> wrote:
> On 11.06.2014 12:21, Wojciech Przyby=C5=82 wrote:
>> Hi All
>>
>> When I was tagging, I think I might have discovered a git client bug=
=2E
>>
>> HOW TO REPRODUCE:
>> - Clone a repo into 2 separate directories. Presume there is a tag
>> "v0.1" already in there and it is set on say 10 commits ago.
>>
>> - In first directory change the tag to a different place and push it
>> to the server:
>> git tag -d v0.1
>> git tag v0.1
>> git push --tags origin master
>>
>> - In second directory try to update the tag...
>> git pull --all --tags
>> git fetch -all --tags
>> THIS DOES NOT WORK, tag is still at old place, but it says "Already =
up-to-date".
>>
>> - I noticed when I use:
>> git fetch --tags
>> it works fine and updates the position of the tag, or if I remove ta=
g
>> from local git manually (rm .git/refs/tags/v0.1) and update again.
>>
>> Is it a bug or I am doing something wrong? I use git version 1.7.9.5=
=2E
>>
>> Cheers
>> Wojciech
>
> Tags are intended to not change without the user knowing.
> To gain more understanding on that, maybe read the man page of
> git tag (see the discussion on retagging)
> https://github.com/gitster/git/blob/master/Documentation/git-tag.txt#=
L166

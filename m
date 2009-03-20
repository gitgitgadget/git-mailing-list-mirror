From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Allow http authentication via prompt for http push.
Date: Fri, 20 Mar 2009 09:49:21 +0100
Message-ID: <49C35891.7010004@drmicha.warpmail.net>
References: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>	 <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302> <d8c371a80903191202v6fb974f4t2321761d0cf21a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Amos King <amos.l.king@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 09:51:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkaRY-0001vb-NU
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 09:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbZCTIti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 04:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbZCTIti
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 04:49:38 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46493 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752821AbZCTIth (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 04:49:37 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 45FAD2F6F38;
	Fri, 20 Mar 2009 04:49:35 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 04:49:35 -0400
X-Sasl-enc: 9Bai4dSUnglncnCpmFU/UFyJFtDP4cm9MBYluDOGL2FM 1237538974
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 382264CEE3;
	Fri, 20 Mar 2009 04:49:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <d8c371a80903191202v6fb974f4t2321761d0cf21a70@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113918>

Amos King venit, vidit, dixit 19.03.2009 20:02:
> The issue with calling it remote is that it conflicts with the remote
> struct that is need for http_init, and is used in the rest of the
> code.  So do you want me to make this small impact change or a larger
> and more broad sweeping change by changing the name of the other
> remote.  I don't believe fake is a better name.  I would hope that at
> some point the 'repo' struct would go away and we can make http_push
> work like all the other remote commands.
> 
> I also believe that 'out' is the correct word.  It was not a typo, and
> I appreciate your suggestion of assuming that I can't spell just
> because I used a word that you didn't understand.  I'm not building
> OUR authorization.  I am building OUT authorization.  Have you heard
> of building something out?  Or even fleshing something out?
> 
> I appreciated your first responses to my other patch.  Even if your
> tone was that of a person with low self-esteem who needs to pick
> unimportant details apart in order to stroke their own ego.  Instead
> of responding in the same tone I thought I would respond nicely and
> get your feedback.  Responses like your first one don't cause people
> to want to continue to contribute to the community.
> 
> I have a great idea.  Why don't you try using the 'nice' tense in your
> next email instead of the high and mighty 'ass-hole' tense.  Then I
> will gladly not use past tense in my commit messages, and others might
> respond more positively to your criticisms.
> 
> Fiek Dich,
> Amos

We don't want these obscenities on this list, whether in plain English
or wrong German!

In fact, Dscho's criticism was not only constructive but nice, and not
only by his standards.

You managed to have at least 2 (3 by our count) typos in one line, and
Dscho pointed that out correctly and nicely.

Your second response (which I saw just before hitting send) doesn't show
much new insight regarding the latter two points. I'll consider the
first one dealt with by it.

Michael

> On Thu, Mar 19, 2009 at 11:59 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Thu, 19 Mar 2009, Amos King wrote:
>>
>>> There is now a faux remote created in order to
>>> be passed to http_init.
>>>
>>> Signed-off-by: Amos King <amos.l.king@gmail.com>
>>> ---
>>>  http-push.c |   11 ++++++++++-
>>>  1 files changed, 10 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/http-push.c b/http-push.c
>>> index 9ac2664..468d5af 100644
>>> --- a/http-push.c
>>> +++ b/http-push.c
>>> @@ -2195,7 +2195,16 @@ int main(int argc, char **argv)
>>>
>>>       memset(remote_dir_exists, -1, 256);
>>>
>>> -     http_init(NULL);
>>> +     /*
>>> +      * This is a faked remote so that http_init can
>>> +      * get the correct data for builidng out athorization.
>>> +      */
>>
>> You might want to pass this through aspell ;-)  Altough it will not
>> suggest 'out ->our', I guess...
>>
>>> +     struct remote *remote;
>>> +     remote = xcalloc(sizeof(*remote), 1);
>>> +     ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
>>> +     remote->url[remote->url_nr++] = repo->url;
>>> +
>>> +     http_init(remote);
>>
>> Would 'fake' not be a more appropriate name than 'remote'?
>>
>> That would also make the patch 1/2 rather unnecessary (I also have to
>> admit that I do not find 'repo' a better name, as we have a repository
>> both locally and remotely, and this _is_ the remote repository, not the
>> local one).
>>
>> Ciao,
>> Dscho
>>
>>
> 
> 
> 

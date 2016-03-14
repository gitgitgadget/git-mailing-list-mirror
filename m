From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] diff: handle "-" as abbreviation of '@{-1}'
Date: Mon, 14 Mar 2016 10:17:31 +0100
Message-ID: <56E681AB.1000201@drmicha.warpmail.net>
References: <1457748710-79370-1-git-send-email-senorsen.zhang@gmail.com>
 <CALZVapk9seKDpLGbyJ23UVxP97WAHkdXS+U+yrJoKf-2cLamAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo Cansino <javierdo1@gmail.com>,
	Senorsen <senorsen.zhang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 10:17:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afOd9-0002Eo-1n
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 10:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbcCNJRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 05:17:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52781 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932438AbcCNJRe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 05:17:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id EAAF820B3F
	for <git@vger.kernel.org>; Mon, 14 Mar 2016 05:17:32 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 14 Mar 2016 05:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=b29NXS5rhoFD/A2sjPaxQkC7qpQ=; b=L9EJCi
	fHnROZtQoVzHFkZZHsyZmzUmwm6RwjDmY7iT4fW5Y0fEnNpzKsqKJ9qY3u5q6dzl
	oW5bjcgq35jsPDpIJJrdv6o09PQ5DG3VeaA9nCg3bMpQd0GyFAaJkQ8ks+bIDyyB
	wbWqhe1M/m2NIJmPMkkKNToLq6nSDUnGRHb5M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=b29NXS5rhoFD/A2
	sjPaxQkC7qpQ=; b=JJ3X1ywqabRmWVK8Pe+Kx9lqdZRaNU6cHbFLzYB29t/PpnQ
	/eWIk2a5E/EZr9MfiYVSOCMfz8tZCqWpbZ0LcwQsesIYkJGDtYbo1Ye1fhb6P3ei
	5b+0ignIwjlwevi8y4C8U1WUfmOHkkEpuSvbFtvGVzojFqpf7L7eaoWbpK7o=
X-Sasl-enc: GkAKBhfg9OwNXly8ZICrOWiGce2CuruGLcjGJjkVf+aP 1457947052
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 59F1F680097;
	Mon, 14 Mar 2016 05:17:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CALZVapk9seKDpLGbyJ23UVxP97WAHkdXS+U+yrJoKf-2cLamAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288775>

Please bottom post - see below.

Javier Domingo Cansino venit, vidit, dixit 12.03.2016 03:48:
> dash is usually used for representing stdin / stdout as a file. I
> think this could drive to error... but I would agree with transforming
> -h1 to @{-1} or -h2 to @{-2} (-h representing head).
> 
> I do agree however that all those signs are thought with american
> keyboards in mind. All those punctuation marks are usually hard to
> type in other keyboards, and -h1 is way simpler than HEAD~ or @{-1}
> 
> This links provides an example of my worry:
> http://stackoverflow.com/questions/15270970/is-it-possible-to-git-diff-a-file-against-standard-input
> 
> On Sat, Mar 12, 2016 at 2:11 AM, Senorsen <senorsen.zhang@gmail.com> wrote:
>>
>> Currently it just replace "-" in argv[] into "@{-1}".
>>
>> For example,
>>
>>     git diff -
>>
>> equals to
>>
>>     git diff @{-1}
>>
>> Signed-off-by: Senorsen <senorsen.zhang@gmail.com>
>> ---
>> Notes:
>>     Hello everyone, I'm Zhang Sen, a college student from Zhejiang University
>>     in China, and this is a patch for the microproject of GSoC 2016. I'm
>>     looking forward to contributing to Git and participating in GSoC 2016.
>>
>>     I have learnt some rules and guides from the documents, and carefully
>>     wrote this small patch, according to other code from git.
>>
>>     Thanks a lot!
>>
>>  builtin/diff.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index 52c98a9..c110141 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -389,6 +389,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>                 }
>>         }
>>
>> +       for (i = 0; i < argc; i++) {
>> +               if (!strcmp(argv[i], "-"))
>> +                       argv[i] = "@{-1}";
>> +       }
>> +
>>         for (i = 0; i < rev.pending.nr; i++) {
>>                 struct object_array_entry *entry = &rev.pending.objects[i];
>>                 struct object *obj = entry->item;
>> --
>> 2.7.0
>>

Please bottom post on this list. Thanks.

In git land, "checkout", "merge" and "revert" know "-" as an
abbreviation for "@{-1}" already. No git command knows "-" as an
abbreviation for "stdin".

The analogy here is "cd -": switch to the previous directory.

So, a user can expect git to switch to the previously checked out branch
with "git checkout -".

The use of "-" in "merge" and "revert" stress that analogy quite a bit
already, and "diff" goes even further - I'm not a big fan of this. I
feel we should think about the meaning of "-":

"-" = "@{-1}": Then why not implement it at the revision machinery level
(rather than per command)? Otherwise, we raise expectations that we
don't meet.

OR:

"-" = "previous <thing>", with <thing> depending on the command context:
Then <thing> may be the content of HEAD or a commit or what not, and,
correspondingly, "-" should resolve to "@{-1}" (i.e. "HEAD@{1}") or
"HEAD^" or what not.

"git diff" is already a chameleon, diffing files, commits, blobs, index,
automatically choosing the second side in the diff if you specify only
one (or give options), and the questions which "-" blends in naturally
may very well depend on the actual color of the chameleon :)

Michael

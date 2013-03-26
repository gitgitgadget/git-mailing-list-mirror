From: Eric Cousineau <eacousineau@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Mon, 25 Mar 2013 22:56:18 -0500
Message-ID: <51511C62.3080704@gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de> <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com> <514782D3.5060200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 04:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKL0K-0002ah-I7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 04:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759237Ab3CZD4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 23:56:23 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:41010 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627Ab3CZD4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 23:56:22 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so6057842iak.24
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 20:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gNPJpsBglpQE2JIfmOmq7sgqYtyZ89/Es3dLrno5XEA=;
        b=K5YLnndNW5/U+zgfQIv8cXX4wdxiSZWquQtDq9qALx8sGauei93mIVZBsx87x6jArm
         29pO2jwOS8g4kn9aJtBaA+bwKdWdE1nbiMKQJEG5q6fe6gq387zy0gGQtLluCrgzz+Hr
         THUzRN4xc+g2V5tS9sYxhZCg3zSEfsuDaq9viCw6dJDbRvNWNhnU19s7UCb3KqxDBD0S
         eyTNlgIdNvhISmkzAA2WQeqk/iYA5KFLiJwqeUg+s473QRrTtDPtqdUO5FaSlq8TCBj9
         hsOxwauRubkqCPK/b/8p1zDYdsw+Jk9CP4+KY0HwqAiPEkfMY9yqaiA7uO8z+oFltfui
         c3xw==
X-Received: by 10.50.155.134 with SMTP id vw6mr303116igb.34.1364270182358;
        Mon, 25 Mar 2013 20:56:22 -0700 (PDT)
Received: from [10.3.2.6] ([199.30.163.2])
        by mx.google.com with ESMTPS id dy5sm1056059igc.1.2013.03.25.20.56.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 20:56:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <514782D3.5060200@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219130>

On 03/18/2013 04:10 PM, Jens Lehmann wrote:
> Am 12.03.2013 17:01, schrieb Phil Hord:
>> On Sat, Mar 9, 2013 at 1:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 05.03.2013 22:17, schrieb Phil Hord:
>>>> On Tue, Mar 5, 2013 at 3:51 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>>> Am 05.03.2013 19:34, schrieb Junio C Hamano:
>>>>>> Eric Cousineau <eacousineau@gmail.com> writes:
>>>>>>> ...
>>>>>> I am not entirely convinced we would want --include-super in the
>>>>>> first place, though.  It does not belong to "submodule foreach";
>>>>>> it is doing something _outside_ the submoudules.
>>>>>
>>>>> I totally agree with that. First, adding --include-super does not
>>>>> belong into the --post-order patch at all, as that is a different
>>>>> topic (even though it belongs to the same use case Eric has). Also
>>>>> the reason why we are thinking about adding the --post-order option
>>>>> IMO cuts the other way for --include-super: It is so easy to do
>>>>> that yourself I'm not convinced we should add an extra option to
>>>>> foreach for that, especially as it has nothing to do with submodules.
>>>>> So I think we should just drop --include-super.
>>>>
>>>> I agree it should not be part of this commit, but I've often found
>>>> myself in need of an --include-super switch.   To me,
>>>> git-submodule-foreach means "visit all my .git repos in this project
>>>> and execute $cmd".  It's a pity that the super-project is considered a
>>>> second-class citizen in this regard.
>>>
>>> Hmm, for me the super-project is a very natural second-class citizen
>>> to "git *submodule* foreach". But also I understand that sometimes the
>>> user wants to apply a command to superproject and submodules alike (I
>>> just recently did exactly that with "git gc" on our build server).
>>>
>>>> I have to do this sometimes:
>>>>
>>>>     ${cmd} && git submodule foreach --recursive '${cmd}'
>>>>
>>>> I often forget the first part in scripts, though, and I've seen others
>>>> do it too.  I usually create a function for it in git-heavy scripts.
>>>>
>>>> In a shell, it usually goes like this:
>>>>
>>>>     git submodule foreach --recursive '${cmd}'
>>>>     <up><home><del>{30-ish}<end><backspace><enter>
>>>>
>>>> It'd be easier if I could just include a switch for this, and maybe
>>>> even create an alias for it.  But maybe this is different command
>>>> altogether.
>>>
>>> Are you sure you wouldn't forget to provide such a switch too? ;-)
>>
>> No.  However, when I remember to add the switch, my shell history will
>> remember it for me.  This does not happen naturally for me in the
>> "<up><home><del>{30-ish}..." workflow.
> 
> I started to use '&&' in my daily shell work for exactly that reason:
> that the bash history remembers groups of two or more commands for me.
> 
>> I also hope this switch grows up into a configuration option someday.
>> Or maybe a completely different command, like I said before; because I
>> actually think it could be dangerous as a configuration option since
>> it would have drastic consequences for users executing scripts or
>> commands in other users' environments.
> 
> I agree on the possible problems a configuration option introduces.
> 
>>> I'm still not convinced we should add a new switch, as it can easily
>>> be achieved by adding "${cmd} &&" to your scripts. And on the command
>>> line you could use an alias like this one to achieve that:
>>>
>>> [alias]
>>>          recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"
>>

I tried this and the 'recurse-post' alias, but could not get it to function as
it does inside of 'git submodule foreach'. I also tried out some different escaping
methods, but nothing seemed to work. I've added the examples below.

>> Yes, making the feature itself a 2nd-class citizen.  :-)
>>
>> But this alias also denies me the benefit of the --post-order option.
>> For 'git recurse git push', for example, I wouldn't want the
>> superproject push to occur first; I would want it to occur last after
>> the submodules have been successfully pushed.
> 
> [alias]
>           recurse-post = !sh -c \"git submodule foreach --recursive --post-order $@ && $@\"
> ;-)
> 
>> I agree this should go in some other commit, but I do not think it is
>> so trivial it should never be considered as a feature for git.  That's
>> all I'm trying to say.
> 
> I am not against adding such a functionality to Git, I'm just not
> convinced "git submodule foreach" is the right command for that. I
> suspect the "git for-each-repo" Lars proposed earlier this year might
> be a better choice, as that could also recurse into other repos which
> aren't registered as submodules. And a "for-each-repo" to me looks
> like a command which could include the superproject too (at least when
> told to do so with an option).
> 

Here are the aliases I am using:

[alias]
	recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"
	recurse-post = !sh -c \"git submodule foreach --recursive --post-order $@ && $@\"
	fer = !sh -c \"eval \\\"$@\\\" && git submodule foreach --recursive \\\"$@\\\"\"
	ferpo = !sh -c \"git submodule foreach --recursive --post-order \\\"$@\\\" && eval \\\"$@\\\"\"
	fers = !sh -c \"eval '$@' && git submodule foreach --recursive '$@'\"
	ferpos = !sh -c \"git submodule foreach --recursive --post-order '$@' && eval '$@'\"

And these are the results I get with the following example:

$ cmd="echo \"'ello world: \$PWD\""
$ eval "$cmd"
'ello world: /tmp/a
$ git submodule foreach --recursive "$cmd"
Entering 'b'
'ello world: /tmp/a/b
Entering 'b/d'
'ello world: /tmp/a/b/d
Entering 'c'
'ello world: /tmp/a/c
$ git submodule foreach --recursive --post-order "$cmd" "$cmd"
Entering 'b'
'ello world: /tmp/a/b
Entering 'b/d'
'ello world: /tmp/a/b/d
Exiting 'b/d'
'ello world: /tmp/a/b/d
Exiting 'b'
'ello world: /tmp/a/b
Entering 'c'
'ello world: /tmp/a/c
Exiting 'c'
'ello world: /tmp/a/c
$ git recurse "$cmd"
'ello world: /tmp/a
Entering 'b'
/home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: Syntax error: Unterminated quoted string
Stopping at 'b'; script returned non-zero status.
$ git recurse-post "$cmd"
Entering 'b'
/home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: Syntax error: Unterminated quoted string
Stopping at 'b'; script returned non-zero status.
$ git fer "$cmd"
ello world: /tmp/a
Entering 'b'
ello world: /tmp/a
Entering 'b/d'
ello world: /tmp/a
Entering 'c'
ello world: /tmp/a
$ git ferpo "$cmd"
Entering 'b'
/home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: world:: not found
Stopping at 'b'; script returned non-zero status.
Stopping at 'b'; script returned non-zero status.
$ git fers "$cmd"
ello world: /tmp/a' && git submodule foreach --recursive 'echo ello world: /tmp/a
$ git ferpos "$cmd"
Entering 'b'
/home/eacousineau/local/lib/git/libexec/git-core/git-submodule: 1: eval: Syntax error: Unterminated quoted string
Stopping at 'b'; script returned non-zero status.

The problem is trying to escape with double-quotes, where the single-quotes are evaluated
as a shell token thing and not as a string argument, versus single-quotes, where you cannot (easily) escape single
quotes inside of it (though please correct me if I'm wrong!).
It seems the best solution would be to have it as a script to allow recursion to occur in the scope of one script,
like submodule foreach.

I understand now why it does not fit in the scope of 'git submodule', though, so I could implement it as a *very*
lightweight stand-in for Lars's "git for-each-repo" via some copy-and-paste :P

- Eric

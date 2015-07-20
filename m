From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Mon, 20 Jul 2015 13:13:33 +0530
Message-ID: <CAGDgvc08ZMdKH-6FdtYWXCBbiX=UYdKTTKVtEF65J+jW5mDYCA@mail.gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com>
	<CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
	<CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
	<CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com>
	<CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
	<CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com>
	<CAGDgvc1CwmQV75mo22v5LQH4q-kNMFtVq3Y9eSt9LL44JHr5Og@mail.gmail.com>
	<CA+P7+xqXxYtJiJ4xdYya25NgqrxncWP3rpVMLYBWTbnnA_oynQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 09:43:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH5jf-0006ox-U2
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 09:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbbGTHnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2015 03:43:35 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33844 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbbGTHnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 03:43:35 -0400
Received: by wgkl9 with SMTP id l9so123523624wgk.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=l7uk+tHPdDOWlW2mFR8oY8jfrroBKmGc00flhrQ42pY=;
        b=kbAEcCVKvJf2bIM44xqdU1uKmbU5hknv5FvxbDJZmNx+rJ3zAI8z1FTqkJkIBZVoCD
         japgVA43UILHon3ZnVkkuxIOpjosMHlziDXaPkVL8D/ejiVzrZoiaA1cUJKBMIbd9Ba9
         JDcNkNNb7ogZK8WDLMm95CA5/S3r23zirKWh5mhvLK4nOgprp/4mvseszjN0nVKxmusU
         t6ATur0cVXfNI6ooj/9Axnl7LLQZBD46a1AWvr/ZzUY2tkcvlzo7I86teJ3hmdX14VsW
         vafntl67wP13Uk5I50/domiUOna4MRJELQGLkt9/NmgD1mZjRsvjIu9u35JM4WtRIlfT
         BpJQ==
X-Received: by 10.194.78.84 with SMTP id z20mr55965790wjw.141.1437378213411;
 Mon, 20 Jul 2015 00:43:33 -0700 (PDT)
Received: by 10.28.143.1 with HTTP; Mon, 20 Jul 2015 00:43:33 -0700 (PDT)
In-Reply-To: <CA+P7+xqXxYtJiJ4xdYya25NgqrxncWP3rpVMLYBWTbnnA_oynQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274319>

Hi Jake,

Thanks about the refs/tags check. I=E2=80=99m aware about this. Junio a=
lso
explained it in one of his replies. I was actually confused why my
current code was working in past for few of the annotated tags.
Anyways, now that I have clarity about the mistake in the code, I
guess, I=E2=80=99ll figure it out myself.

@Junio: Thanks a lot for your detailed explanation about the =E2=80=98b=
ehind
the scenes=E2=80=99 activity during a push process. That was definitely
helpful and will help me in future too.

@Jake: Thanks for your help and your patience in explaining things.



On Mon, Jul 20, 2015 at 5:05 AM, Jacob Keller [via git]
<ml-node+s661346n7635968h31@n2.nabble.com> wrote:
> To check whether the ref being updated is a tag, you need to check th=
e
> 3rd parameter. pre-receive receives in the format
>
> <old-value> <new-value> <ref-name>
>
> so you need to check each line's 3rd value which is the ref-name bein=
g
> updated. If it's in refs/tags then it's a tag update. If it's not, yo=
u
> can check it as a branch update.
>
> Then you should check all new commits for each branch, as Julio menti=
oned
> above.
>
> Checking whether each commit has an associated tag is probably not
> what you meant.
>
> Regards,
> Jake
>
> On Sun, Jul 19, 2015 at 3:13 AM, Gaurav Chhabra
> <[hidden email]> wrote:
>
>> The only thing we wanted to check was whether a ref is a tag. :) Res=
t
>> other things are working fine (except for the "commits=3D$new_sha1"
>> thing which Junio already pointed out and corrected). I will correct
>> the pre-receive hook.
>>
>> The only mystery that remains is about the current nonsensical code
>> working fine in the past for few annotated tag pushes. It shouldn't
>> have worked just by providing:
>>
>> RW+ refs/tags=3Ddeveloper_name
>>
>> Ref: http://gitolite.com/gitolite/g2/aac.html (Section: "deny" rules
>> for refs in a repo)
>>
>>
>> On Sun, Jul 19, 2015 at 2:09 PM, Jacob Keller [via git]
>> <[hidden email]> wrote:
>>> On Sun, Jul 19, 2015 at 12:55 AM, Gaurav Chhabra
>>> <[hidden email]> wrote:
>>>> @Junio: So from your detailed explanation (and Jake's comment), i
>>>> understand that since my ref wasn't updated on remote so querying =
the
>>>> same using "git describe" resulted in failure, and hence, code was=
 not
>>>> entering the IF block. Correct?
>>>>
>>>
>>> I assume so.
>>>
>>>> Also, while i was reading your replies, i was just thinking that t=
he
>>>> following question that i asked Jake doesn't really make sense bec=
ause
>>>> a commit object _is_ being passed (on local machine) to "git
>>>> describe", which is what it expects so it should work for sure:
>>>>
>>>
>>> It works yes. Git describe finds the nearest tag. --exact-match fai=
ls
>>> unless it can find a tag at the commit specified.
>>>
>>>> "If i got the above right, then shouldn't Git throw an error even =
on
>>>> my local machine when i'm running "git describe --exact-match
>>>> ac28ca721e67a"?"
>>>>
>>>
>>> only if ac28ca721e67a does not have an annotated tag associated to =
it
>>>
>>>
>>>
>>>> @Junio: You wrote: "The part that I find questionable is that by
>>>> checking with "is this commit a tagged one?" and doing different
>>>> things. What makes the initial and the third special to deserve
>>>> checking (because they are not annotated with a tag) while skippin=
g
>>>> the validation for the second (merely because it has an annotated =
tag
>>>> added to it)?"
>>>>> Isn't the code that i shared doing just the opposite of what you'=
ve
>>>>> written? It's checking for annotated tags only and skipping the
>>>>> lightweight
>>>>> ones (although it shouldn't be doing all such things in the first
>>>>> place).
>>>>> Was it a typo on your part?
>>>>
>>>>
>>>
>>> I'm not sure what the code you have is trying to do. See below.
>>>
>>>> @Jake: For the question you asked: "It would help a lot if we
>>>> understood exactly what you are trying to accomplish."
>>>>> I'm not sure how my colleague zeroed in on this "git describe" co=
mmand
>>>>> but i at least know what we observed (and 'seemed' to work).  We =
saw
>>>>> that if
>>>>> we use git-describe and pass a commit object, it throws fatal err=
or
>>>>> message.
>>>>> On the other hand, if we pass a tag object, it doesn't throw any =
fatal
>>>>> error. That's the reason he added that tag check portion.
>>>>
>>>
>>> Hmmm....
>>>
>>>>
>>>> @Junio/Jake: After going through all the responses that i've recei=
ved
>>>> so far on this forum, i'm thinking how this nonsense code worked f=
or
>>>> few cases in the past? When this check was put in place, devs were
>>>> getting error while pushing annotated tags. Since we use Gitolite,=
 we
>>>> added the following to gitolite.conf and the tag push worked for t=
hem:
>>>>
>>>> RW+ refs/tags=3Ddeveloper_name
>>>>
>>>
>>> Sounds like you needed to add RW permissions to the refs/tags names=
pace.
>>>
>>>> I'm wondering why.
>>>>
>>>
>>> Ok, so normally, pre-receive hook is used to implement policy. Ie:
>>> prevent acceptance of pushes that have "bad" content as defined by =
the
>>> repository owner. For example, preventing push of tags that don't
>>> match some format, or preventing pushes which contain bad stuff.
>>>
>>> I could provide some examples or suggestions if you would describe
>>> what sort of policy you're trying to enforce..
>>>
>>> git describe will tell you if the commit you're passing it is
>>> associated with an annotated tag. I do not understand who this
>>> information can help you implement any policy, so understanding wha=
t
>>> the policy you want is would be the most helpful.
>>>
>>> I can't really help more or understand exactly what you were doing
>>> without understanding what policy you were/are trying to implement.
>>>
>>> The thing your code is doing today is something like:
>>>
>>> for each reference update, locate every commit
>>>
>>> for each commit in this reference update, check to see if it alread=
y
>>> has an associated tag connected to it.
>>>
>>> If it doesn't have a tag, then "do some more checks" which are not
>>> described here.
>>>
>>> This doesn't make sense to me at all. I think what you *meant* was =
this:
>>>
>>> for each reference update, if the reference being updated is a tag,=
 skip
>>> it
>>>
>>> otherwise, for each commit in the reference update do some checks o=
n it.
>>>
>>> That is *completely* different from the code you've written today.
>>>
>>> Regards,
>>> Jake
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to [hidden email]
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>> ________________________________
>>> If you reply to this email, your message will be added to the discu=
ssion
>>> below:
>>>
>>> http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp76=
35764p7635875.html
>>> To unsubscribe from Git tag: pre-receive hook issue, click here.
>>> NAML
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to [hidden email]
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to [hidden email]
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> ________________________________
> If you reply to this email, your message will be added to the discuss=
ion
> below:
> http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp7635=
764p7635968.html
> To unsubscribe from Git tag: pre-receive hook issue, click here.
> NAML

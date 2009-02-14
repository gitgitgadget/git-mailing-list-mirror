From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 22:09:59 +0200
Message-ID: <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
	 <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQrM-0008RY-43
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbZBNUKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZBNUKE
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:10:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:55649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZBNUKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:10:02 -0500
Received: by fg-out-1718.google.com with SMTP id 16so73506fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=si6/jcLRqbj2+EL/Jxo5n6CTg3APTlFSXX/zMGc/RMI=;
        b=dNw4eRbulfZfeUWM9tEgozBmQvYA/tybt3TVjXZYY366j6nNfVSgVV3ZKNeecaGnJ9
         TdbIzMbcwbyqhJCqos/RMx3K6+X0dZ1z2Qb2asGS1NiYacabiZW5jjdx/xDgQ4Wlp5mV
         IzvcZYv+RbN6VGAMQ37ViLohCOgsZiFkaVe5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C5cUWFWCvcxcg1iYPKvllVk6h+t8vR+PNAwR8UK3oII8N25rO6swV8Qa/08AB72xoL
         v3d1GgKJEEhIZhSzENY/H4mYYmmmAmxJ4JC46VSTQxzxG40FRjn4acNO2D9Ld+zUOXFe
         Kk6fpL4gtmvOexiHexYBQxRHXXna0IS/j3AgQ=
Received: by 10.86.33.10 with SMTP id g10mr502154fgg.44.1234642199369; Sat, 14 
	Feb 2009 12:09:59 -0800 (PST)
In-Reply-To: <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109914>

On Sat, Feb 14, 2009 at 9:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sat, Feb 14, 2009 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Reorganizing the code to use parseopt as suggested by Johannes
>>>> Schindelin.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>  builtin-config.c |  422 +++++++++++++++++++++++++++---------------------------
>>>>  1 files changed, 210 insertions(+), 212 deletions(-)
>>>
>>> Whew.  That's a lot of changes.
>>>
>>> Is this just "I am using parseopt because I can", or "I want to do this
>>> first because I am planning to do such and such things to this program,
>>> and the current mess needs to be cleaned up first before doing so"?
>>>
>>> I am asking this _not_ because I'd want to reject the patch if the answer
>>> is former.
>>
>> Then why are you asking?
>
> So that I can prioritize topics and patches that are more important in the
> short, medium and longer time according to the urgency.  For example, it
> is a very bad tradeoff for me to take "This does not change anything
> externally visible, but cleans up the implementation" near or during the
> release freeze.  "This cleans up, and then the next one will fix a
> longstanding bug building on top of the cleaner code" is different.
>
> And preferably the latter kind should be queued for 'maint', not for
> 'master', if the fix that will come later is important enough.

Oh, in that case, no, I don't have any further patches on top of this.

>> This is more a "I would like to increase the chances of my patches
>> being accepted so I'd do some chores to gain the trust of some
>> developers", and Johannes Schindelin was pushing me to do this.
>>
>> Also it's a bit of "I would like to improve git and learn the API
>> while doing so".
>
> I personally do not think "I rewrote this command's option parser using
> parseopt" earns any "trust point".  I think the latter is a *great* thing
> to do, though.

I disagree. Making a patch pass through all the filters must mean
something, and the more patches the more trust.

>> The only problem is that --bool and --int would be possible in the
>> same command and there would be no way to output an error, but I guess
>> that's not a big problem.
>
> The existing code does not have a check, and you are right, it would be
> nice to have such an error check, perhaps as a separate follow-up patch.

Yeap.

>>>> +static const char *get_color_name, *get_colorbool_name;
>>>> +static int end_null;
>>>> +
>>>> +static struct option builtin_config_options[] = {
>>>> +     OPT_GROUP("Config file location"),
>>>> +     OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
>>>> +     OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
>>>> +     OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
>>>
>>> Why CAPS?
>>
>> I looked at some other code, like builtin-commit.c and that's what is
>> used there.
>
> I see, there are mixtures; apply, blame, fmt-merge-msg and tag say "file"
> and commit and fast-export say "FILE".  commit's one could be almost
> justifyable, because it uses caps in all (except for -u=<mode>), but
> output from fast-export is a different story.  Compare "git commit -h" and
> "git fast-export -h" to see what I mean.
>
> One possible patch could make "git cmd -h" messages for all "cmd" spell
> their "fill your value here" markings consistently, and the explanation of
> the change in the proposed commit log message would have
>
>  (1) an analysis similar to the one I did in the above paragraph (but
>     doing it more thouroughly; I didn't look beyond commands that grep
>     for "file" or "FILE" hits in the sources) of the current situation;
>     and
>
>  (2) the reason why you picked the case (be it lower or upper, I do not
>     deeply care either way).
>
> Such a patch could earn a "trust point", not because such it is extremely
> important for the system's usability (it is *not*), but because it is a
> good way to demonstrate that you can do a thorough job and think things
> through.

I might do that.

>>> Hmph.  I wonder if use of OPT_BIT() and HAS_MULTI_BITS() make this simpler.
>>
>> Yeap, definitely, thanks for the suggestion.
>>
>> Again, it would have been nice to see any example of this.
>
> I actually had to look for HAS_MULTI_BITS because I *knew* such a facility
> existed, I did not recall what it was called, and api-parse-options.txt in
> Documentation/technical did not talk about it.  We can definitely improve
> things in many places.
>
> Mistakes made in the past and resulting flaws that remain in the current
> source do not justify a new patch adding more mistakes to the codebase.
> Reviewers help the author from adding more.
>
> One bad thing about the current process (and I am certainly one of the
> guilty parties because I do a lot of reviews) around this area is that a
> review comment that points out a mistake similar to the ones made in the
> past sound to the author of the patch as if the reviewer is telling that
> the patch will not be accepted unless the existing mistakes are also fixed
> by the patch author.  Such a review certainly does not mean that --- it is
> more likely that the patch author simply mimicked existing code that is
> doing a wrong thing without realizing it being wrong, and because the
> reviewer *did not know* that the mistake was copied from elsewhere, he
> just pointed it out the one in the patch.
>
> In such a situation, I've seen two kinds of responses from the patch
> author (this assumes that the nit pointed out by the reviewer was indeed a
> good thing to fix):
>
>  * This and that code already do things in a similar way.  I won't be
>   changing my patch.
>
>  * Ok, I'll fix the issue in my patch, but this and that code have the
>   same mistake.  Should I fix them in the same patch as well?
>
> Neither is an exactly optimal solution.  It is very likely that the patch
> author knows more of the existing instances of the same mistake than the
> reviewer, but there probably are more instances than he tried to defend
> his patch with.  The places he knows of were found merely because he was
> looking for an example to do something similar to what he wanted to do,
> not because he was looking for all instances of a specific class of
> mistake to fix in the existing code.
>
> An ideal response would be a follow up patch that fixes the issue that the
> original patch had, and a separate message that summarizes such issues in
> the existing codebase (saying that the instances listed are not
> exhaustive).  The patch author can attack them in a separate series if he
> wants to, and that would certainly be appreciated, but he does not have
> to.  It is a separate issue that others (not necessarily the reviewer who
> first pointed out the mistake in the patch) can attack.
>
> Unfortunately, not many patch authors write such a summary.  Sometimes we
> see summaries on things that were discussed but nobody has followed
> through posted by third parties (including myself), but we do not seem to
> have enough helpers to do that either.  This does not take much technical
> skills but is a good "trust point" earner.

For me it's easier, and more fun to write a separate patch that fixes
the issues than writing a summary, but in the mean time it makes sense
to do one patch at a time and make sure it really gets merged,
specially since I don't have many, and it's motivating to know it's
going to be on the next release.

But, if there's code that already has the same issues the patch has,
it doesn't look like a good argument for patch rejection. Perhaps the
quality standards increased, but on the other hand things wouldn't get
worst by applying the patch.

>> Yes the arguments check need to be revised.
>>
>> My hope was somebody would review this and suggest a clever and
>> generic way of doing this. Perhaps a util function check_min_args, or
>> maybe something in parseopt that receives the number of args?
>
> I thought what the original code before your patch had was quite
> reasonable, switching on argc.

The code for --replace-all was repeated on 3 places, one for each case
of args provided, and similarly for other options. Don't you think
it's better to have the code in one single place like in my patch?

Also the git_config_set_usage variable was getting quite bug, which
was the reason Johannes suggested this change. Which probably lead to
some easy mistakes like the fact that -l is not mentioned in the
usage.

>> Anyway, I can create the helper functions again, and maybe have some
>> function parameters instead of passing argc and argv
>
> It might actually be a good idea to turn the cascade of if..elseif..fi
> into a form of look-up in a table whose elements have a pointer to a
> function.  A loooong function like this cmd_config() is very hard to
> follow its logic.

Perhaps, but at least it's not bigger than the previous one.

<snip/>

-- 
Felipe Contreras

From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Tue, 13 Oct 2015 14:00:50 -0400
Message-ID: <CANoM8SVAGQ4AL9wBiBMaAu0GvaotC8rhn-rWQhLjsyWr4DnXmw@mail.gmail.com>
References: <561C1132.3090606@orange.fr> <vpqsi5fx2gr.fsf@grenoble-inp.fr>
 <561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com>
 <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:01:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm3t1-0003iu-20
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 20:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbbJMSBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 14:01:13 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34349 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540AbbJMSBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 14:01:11 -0400
Received: by vkat63 with SMTP id t63so15275704vka.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hrzh8NFjL6pGcfYDzPYZstX/+Du3ujrNTUGLvl1x6mU=;
        b=qLWD5cULoob3jU6NaI+BKIO/eNVTqUOVXsf5KFhG+7HuCZS9BO3P7iw8JF9rhK8WiR
         07cmn2xmlYxQ3hcPjDnXRQYCNRBY2qzr9dptqa0o1WxsVI/FALBEd3HjBIJhx5XUOIFM
         lJxu8MdkhC48hREdewdwQyktQn2sPphJA4/s0069j3lI6OMEi/hhcl5LMcMWURdXrrxh
         imAf7hJE8aq9GUty4ltd4efJ3J7kNzaL2pdairZkUsl4hNNmwEq45HUG9mL0nabG5rFM
         LVnw5lU89SLvb+rNU7ncQc9IMvTHS9Pggleo90L8fLKMDMF33bV0S7edrqIYFUhtYWvd
         X+4g==
X-Received: by 10.31.158.205 with SMTP id h196mr22519981vke.11.1444759270185;
 Tue, 13 Oct 2015 11:01:10 -0700 (PDT)
Received: by 10.103.92.5 with HTTP; Tue, 13 Oct 2015 11:00:50 -0700 (PDT)
In-Reply-To: <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279508>

On Tue, Oct 13, 2015 at 1:07 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Oct 13, 2015 at 6:29 AM, Philip Oakley <philipoakley@iee.org> wrote:
>> My tuppence is that the only sha1's that could/would be rewritten would be
>> those for the commits within the rebase. During rebasing it is expected that
>> the user is re-adjusting things for later upstream consumption, with social
>> controls and understandings with colleagues.
>>
>
> Agreed here. There would be no need to change any sha1s that didn't
> change during the rebase. This limits the scope. Alright.
>
>> Thus the only sha1 numbers that could be used are those that are within the
>> (possibly implied) instruction sheet (which will list the current sha1s that
>> will be converted by rebase to new sha1's).
>>
>
> Correct, you would be able to limit the number of sha1s to search for.
>
> However, (see below), any reasonable reference to a sha1 should be
> relatively stable.
>
>> It should be clear that the sha1's are always backward references (because
>> of the impossibility of including a forward reference to an as yet
>> un-created future commit's sha1).
>>
>> The key question (for me) is whether short sha1s are accepted, or if they
>> must be full 40 char sha1's (perhaps an option). There are already options
>> for making sure that short refs are not ambiguous.
>>
>> It sound to me like a sensible small project for those that have such a
>> workflow. I'm not sure if it should work with a patch based flow when
>> submitting upstream - I'm a little fuzzy on how would the upstream
>> maintainer know which sha1 referred to which patch.
>>
>
> My issue: the only sha1s in commit messages are *generally* things
> which will NOT be changed in general. Supporting a work flow that
> wants to change these is definitely crazy.
>
> Essentially: I don't see a reason that you would be rebasing a commit
> and needing to change any references in it. You can reference a commit
> which isn't changing, but here's the possible situations I see:
>
> a) you are rebasing a commit which references in the message a commit
> that is not being changed (it is ancient)
>
> In this case, nothing needs to be done.
>
> b) you are rebasing a commit which references another commit in the same rebase
>
> I see no valid reason to reference a sha1 in this case. If you're
> referencing as a "fixes", then you are being silly since you can just
> squash the fix into the original commit and thus prevent introduction
> of bug at all.
>
> What other reason? If you are referencing such as "thix extends
> implementation from sha1" then your commit message is probably poorly
> formatted. I don't see a reason to support this flow.
>
> c) you are rebasing a commit which is referencing a commit that has
> already been changed. (?)
>
> I think (maybe) this is your interesting case, but here are some caveats.
>
> Let's say you are fixing some old commit such as "Fixes: <sha1,
> summary, date>" or something.
>
> If you do a "git pull --rebase", your commit might be updated to play
> ontop of more new work, but the sha1 should still be valid, *unless*
> the remote history did some rewind, at which point I don't think any
> algorithm will work, see the issues above.
>
> It may be something worth doing in git-filter-branch, but then you're
> looking at losing the two assumptions above making it really hard to
> get right.
>
> Regards,
> Jake

It seems reasonable that this could be added as a feature of
interactive rebase.  The todo list could be automatically adjusted to
"reword" for those commits which are referring to other commits within
the same rebase.  As each commit is re-written, a mapping could be
kept of old sha1 -> new sha1.  Then when one of the reworded commits
is being applied, the old sha1 -> new sha1 mapping could be used to
add a line to the $COMMIT_MSG.

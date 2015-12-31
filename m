From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 09/10] config: add core.untrackedCache
Date: Thu, 31 Dec 2015 13:33:24 +0100
Message-ID: <CAP8UFD35VZ3QCLg525RCpacDrRHqt7EhxV1MeL-9xxHf8BCZ+A@mail.gmail.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
	<xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0pOiqa5ZxwM0Vfzr_wMJ+HDrXyhzJ+TmRDED5GH+koMw@mail.gmail.com>
	<xmqqbn97cyh3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 13:33:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcQ7-0005WD-8a
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbbLaMd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 07:33:28 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35182 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbbLaMd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:33:26 -0500
Received: by mail-lb0-f181.google.com with SMTP id bc4so126511829lbc.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=49b+1kMXZOjKRu1W3YWZXT4Bi0tHTQChSCATgh9L3kA=;
        b=O1fYSqRBZ9+bQ4mfs2coqzc9xPzqkq7JdFZOBgs0frloj9Xlj3cTcJHnuO8AKuHspV
         RMQAWd33vX1rp5IRXgYhHDprIxpFxsnpkNKU6liE5ZyEjSlhIyMXb9hkzuAJnnnCnmks
         S+solr+G2Mk5CVLIPFuhbfLvxXoz/j5XArOTlsXX5DfdWWlRtYQyEGHndd4ql0ZkJGrq
         CrW+vdfewIIvxOJGu+Orh8Uo3dBfJQIixkEYM0QM0rdn3U7oU48bJ6p6oFGK2VGiZdve
         Bqatccsre+miz+PXBjDCWivFZlyBIZnZ13h226XOiUKh8KzDpNdNmDAdBfaERkfAUsKf
         zRhQ==
X-Received: by 10.112.150.102 with SMTP id uh6mr24882351lbb.16.1451565204218;
 Thu, 31 Dec 2015 04:33:24 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Thu, 31 Dec 2015 04:33:24 -0800 (PST)
In-Reply-To: <xmqqbn97cyh3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283235>

On Thu, Dec 31, 2015 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Tue, Dec 29, 2015 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> While the above is not wrong per-se, from the point of those who
>>> looked for these options (that is, those who wanted to do a one-shot
>>> enabling or disabling of the feature, perhaps to try it out to see
>>> how well it helps on their system), I think the explanation of the
>>> interaction between the option and the config is backwards.  For
>>> their purpose, setting it to `true` or `false` will be hinderance,
>>> because the options are made no-op by such a setting.  IOW, the
>>> advertisement "once you decided that you want to use the feature,
>>> configuration is a better place to set it" does not belong here.
>>>
>>> If I were writing this documentation, I'd probably rephrase the
>>> second paragraph like so:
>>>
>>>         These options take effect only when the
>>>         `core.untrackedCache` configuration variable (see
>>>         linkgit:git-config[1]) is set to `keep` (or it is left
>>>         unset).  When the configuration variable is set to `true`,
>>>         the untracked cache feature is always enabled (and when it
>>>         is set to `false`, it is always disabled), making these
>>>         options no-op.
>>>
>>> perhaps.
>>
>> Yeah, but "no-op" is not technically true, as if you just set the
>> config variable to true for example and then use "--untracked-cache"
>> then the cache will be added immediately.
>
> The "update-index --[no-]untracked-cache" command is made to no
> longer follow the user's immediate desire (i.e. enable or disable)
> expressed by the invocation of the command.  That is what I meant by
> 'no-op'.
>
>> ... for example "git update-index --untracked-cache" will die() if
>> the config variable is set to false.
>
> As I think it is a BUG to make these die(), it is an irrelevant
> objection ;-).

Ok I think I will just use what you suggest except the "no-op" part:

      These options take effect only when the
      `core.untrackedCache` configuration variable (see
      linkgit:git-config[1]) is set to `keep` (or it is left
      unset).  When the configuration variable is set to `true`,
      the untracked cache feature is always enabled (and when it
      is set to `false`, it is always disabled).


>>> I somehow thought, per the previous discussion with Duy, that the
>>> check and addition of an empty one (if missing in the index and
>>> configuration is set to `true`) or removal of an existing one (if
>>> configuration is set to `false`) were to be done when the index is
>>> read by read_index_from(), though.  If you have to say "After
>>> setting the configuration, you must run this command", that does not
>>> sound like a huge improvement over "If you want to enable this
>>> feature, you must run this command".
>>
>> The untracked-cache feature, as I tried to explain in an email in the
>> previous discussion, has an effect only on git status when it has to
>> show untracked files. Otherwise the untracked-cache is simply not
>> used. It might be a goal to use it more often, but it's not my patch
>> series' goal.
>
> In the future we may extend the system to allow "git add somedir/"
> to take advantage of the untracked cache (i.e. we may already know
> what untracked paths there are without letting readdir(3) to scan it
> in somedir/), for example.  Is it reasonable to force users to say
> "git status", in such a future?

If a new feature takes advantage of the untracked cache, it is
reasonable that this feature enables or disables it if should be
enabled or disabled. Maybe we can just say in the doc something like:

    When the `core.untrackedCache` configuration variable is changed, the
    untracked cache is added to or removed from the index the next time
    a command that can use the untracked cache is run; while when
    `--[no-|force-]untracked-cache` are used, the untracked cache is
    immediately added to or removed from the index. Currently only
    "git status" can use the untracked cache.

> And more importantly, when that
> future comes, is it reasonable to force users to re-learn Git to do
> something else to do things differently at that point?

I don't think people will have to relearn anything or do things
differently especially if things are explained like above.

If they want to use the untracked cache by setting a config option,
and then want to enable it right away, they can still use git status
for that, so things will continue to work.

What scenario do you have in mind where people would have to do things
differently?

> Itt sounds like somewhat a short-sighted mindset to design the
> system, and I was hoping that by now you would have become better
> than that.
>
> The real question is what are the problems in implementing this in
> the way Duy suggested in the previous discussion.  The answer may
> fall into somewhere between "that approach does not work in such and
> such cases, so this is the best I could come up with" and "I know
> that approach is far superiour, but I have invested too much in this
> inferiour approach and refuse to rework it further to make it better."

My question is why should I invest time thinking about and testing
another approach when the current approach seems simpler, less bug
prone, faster and without any downside?

> I unfortunately am not getting the sense that I know where your
> answer would fall into that spectrum from your response.
>
>>> Exiting with 0 (= success) after issuing a warning() might be more
>>> appropriate.
>>
>> Scripts users might just not look at the warnings and expect things to
>> work if the exit code is 0.
>
> That is exactly why I said it is inappropriate to error out.

Suppose that we do as you suggest. This means that when "git
update-index --untracked-cache" is called while the config variable is
false, we issue a warning, add the UC to the index and exit 0.

So a legacy script calling "git update-index --untracked-cache" and
getting a 0 exit code from it will assume that every time "git status"
is called the UC will be used because it has been enabled in the
index. But that would be wrong if the config variable is false,
because in this case when git status is called, it will remove the UC.

> Using of not using untracked-cache is (supposed to be) purely
> performance and not correctness thing, and I do not think the users
> and the scripts do not deserve to see a failure from "update-index
> --untracked-cache" only because there is a stray core.untrackedCache
> set to 'false' somewhere.

This "stray core.untrackedCache" could not have been put there by
users of previous git versions because it has no meaning before this
patch series. So I don't understand why you call it "a stray
core.untrackedCache".

It is no more "stray" to me than the call to "update-index --untracked-cache".

If it has been put in /etc/git.config by an admin and if the user
thinks he knows better, the user can still change the config locally
to override the system one.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/10] config: add core.untrackedCache
Date: Wed, 30 Dec 2015 15:23:36 -0800
Message-ID: <xmqqbn97cyh3.fsf@gitster.mtv.corp.google.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
	<xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0pOiqa5ZxwM0Vfzr_wMJ+HDrXyhzJ+TmRDED5GH+koMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 00:23:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEQ5o-0004wc-8t
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 00:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbbL3XXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 18:23:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751452AbbL3XXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 18:23:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A593836988;
	Wed, 30 Dec 2015 18:23:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JEdq9E7fOFts6AjL2hdEDMAwYag=; b=Iyut7v
	wW0YtSHBuhVBZl+W+no9LzN/4HrX40HplKCoTnnzfo3PM8CLdSpyeOB5Lenf8roT
	jZekYDhbxTVuNYV8mNxitI55VrekN7NWkQ63vAqAAHoSl45qozy6qpnETk7cZ/JL
	LdIIsmyphx5zVhgGW/FCh4EttN8PRL0jSaoxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HhpjcuuVjEQ85yfygtrmGIfTJxaKNaHd
	F/lyRJQV3eRGY1FBQxAmU47FosSYe9iOqCsX/136r+GHcPLnkT8XZlpupVb3zvNx
	8yG9c5FxDRmRMaMHK/nL2hw8BGUm+EUiNxVxi9xq5ewm9nCoMcYKoq/VculxOUsF
	iFApk5+srB4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C29236987;
	Wed, 30 Dec 2015 18:23:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0951436986;
	Wed, 30 Dec 2015 18:23:38 -0500 (EST)
In-Reply-To: <CAP8UFD0pOiqa5ZxwM0Vfzr_wMJ+HDrXyhzJ+TmRDED5GH+koMw@mail.gmail.com>
	(Christian Couder's message of "Wed, 30 Dec 2015 23:47:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5AD8AA94-AF4C-11E5-A122-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283214>

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Dec 29, 2015 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> While the above is not wrong per-se, from the point of those who
>> looked for these options (that is, those who wanted to do a one-shot
>> enabling or disabling of the feature, perhaps to try it out to see
>> how well it helps on their system), I think the explanation of the
>> interaction between the option and the config is backwards.  For
>> their purpose, setting it to `true` or `false` will be hinderance,
>> because the options are made no-op by such a setting.  IOW, the
>> advertisement "once you decided that you want to use the feature,
>> configuration is a better place to set it" does not belong here.
>>
>> If I were writing this documentation, I'd probably rephrase the
>> second paragraph like so:
>>
>>         These options take effect only when the
>>         `core.untrackedCache` configuration variable (see
>>         linkgit:git-config[1]) is set to `keep` (or it is left
>>         unset).  When the configuration variable is set to `true`,
>>         the untracked cache feature is always enabled (and when it
>>         is set to `false`, it is always disabled), making these
>>         options no-op.
>>
>> perhaps.
>
> Yeah, but "no-op" is not technically true, as if you just set the
> config variable to true for example and then use "--untracked-cache"
> then the cache will be added immediately.

The "update-index --[no-]untracked-cache" command is made to no
longer follow the user's immediate desire (i.e. enable or disable)
expressed by the invocation of the command.  That is what I meant by
'no-op'.

> ... for example "git update-index --untracked-cache" will die() if
> the config variable is set to false.

As I think it is a BUG to make these die(), it is an irrelevant
objection ;-).

>> I somehow thought, per the previous discussion with Duy, that the
>> check and addition of an empty one (if missing in the index and
>> configuration is set to `true`) or removal of an existing one (if
>> configuration is set to `false`) were to be done when the index is
>> read by read_index_from(), though.  If you have to say "After
>> setting the configuration, you must run this command", that does not
>> sound like a huge improvement over "If you want to enable this
>> feature, you must run this command".
>
> The untracked-cache feature, as I tried to explain in an email in the
> previous discussion, has an effect only on git status when it has to
> show untracked files. Otherwise the untracked-cache is simply not
> used. It might be a goal to use it more often, but it's not my patch
> series' goal.

In the future we may extend the system to allow "git add somedir/"
to take advantage of the untracked cache (i.e. we may already know
what untracked paths there are without letting readdir(3) to scan it
in somedir/), for example.  Is it reasonable to force users to say
"git status", in such a future?  And more importantly, when that
future comes, is it reasonable to force users to re-learn Git to do
something else to do things differently at that point?

Itt sounds like somewhat a short-sighted mindset to design the
system, and I was hoping that by now you would have become better
than that.

The real question is what are the problems in implementing this in
the way Duy suggested in the previous discussion.  The answer may
fall into somewhere between "that approach does not work in such and
such cases, so this is the best I could come up with" and "I know
that approach is far superiour, but I have invested too much in this
inferiour approach and refuse to rework it further to make it better."

I unfortunately am not getting the sense that I know where your
answer would fall into that spectrum from your response.

>> Exiting with 0 (= success) after issuing a warning() might be more
>> appropriate.
>
> Scripts users might just not look at the warnings and expect things to
> work if the exit code is 0.

That is exactly why I said it is inappropriate to error out.

Using of not using untracked-cache is (supposed to be) purely
performance and not correctness thing, and I do not think the users
and the scripts do not deserve to see a failure from "update-index
--untracked-cache" only because there is a stray core.untrackedCache
set to 'false' somewhere.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 08 Sep 2013 11:10:37 -0700
Message-ID: <xmqqa9jn6v6q.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com>
	<522C168B.7050300@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 20:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIjRd-0006dk-Cv
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 20:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150Ab3IHSKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 14:10:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab3IHSKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 14:10:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10AE03D6F7;
	Sun,  8 Sep 2013 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J2fxREyqPeee1IpKhnHwGPX+ExM=; b=LKYveo
	RhHo2jEXxEYgMDUAY87Amjv7fQ6xPgD2SrkcaE5miTCHk0POeFQpK2BK7/bdwquB
	ElkOP5+v36VMYHGVgn/qsTGR9KQsVi+mSqgkLmDGkI9ll2vJkZLjyYOIFQTuDMa+
	WbjbHumvOlPDT/Ts7AC+pTPVEg/9ddnL36u58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMRww78Y6/QU456ee0AiMUx+rxYc369B
	VmgYIVLtidjG4RF1u/cfQfXj32wlzBEVGeUkBOntzVSbFSe1XGbgZg+4E76Uh/D4
	yr8taJ/3aikAfPTZR+F29P0lndMMSVZQlWjRZMOTeAOuMA/NpbRyYgjTdsVPgZFy
	7mmj0qVDI1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0368A3D6F6;
	Sun,  8 Sep 2013 18:10:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B3BB3D6F0;
	Sun,  8 Sep 2013 18:10:39 +0000 (UTC)
In-Reply-To: <522C168B.7050300@bbn.com> (Richard Hansen's message of "Sun, 08
	Sep 2013 02:17:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F793AD18-18B1-11E3-AEDF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234257>

Richard Hansen <rhansen@bbn.com> writes:

> On 2013-09-07 22:41, Felipe Contreras wrote:
>> On Wed, Sep 4, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>>> Which can be solved by adding the above "fail" option, and then
>>> renaming them to "pull.integrate" and "branch.<name>.integrate" to
>>> clarify what these variables are about (it is no longer "do you
>>> rebase or not---if you choose not to rebase, by definition you are
>>> going to merge", as there is a third choice to "fail"), while
>>> retaining "pull.rebase" and "branch.<name>.rebase" as a deprecated
>>> synonym.
>> 
>> All these names are completely unintuitive. First of all, why
>> "integrate"? Integrate what to what? And then, why "fail"? Fail on
>> what circumstances? Always?
>> 
>> My proposal that does:
>> 
>>   pull.mode = merge/rebase/merge-ff-only
>> 
>> Is way more intuitive.
>
> +1
>
> What about something like:
>
>     pull.mergeoptions (defaults to --ff-only)
>     pull.rebaseoptions (defaults to empty?  --preserve-merges?)
>     branch.<name>.pull.mergeoptions (defaults to pull.mergeoptions)
>     branch.<name>.pull.rebaseoptions (defaults to pull.rebaseoptions)

As "pull" has two distinct phases "fetch" and "merge/rebase", your
mergeoptions/rebaseoptions is much better than "mode", which does
not tell which phase of "pull" the mode refers to. It is clear that
they apply to the process to integrate the history obtained from
the other side and your own history into one history.

But it does not help Philip's case, if I understand correctly, where
running "git pull" on some branches is always a mistake and the user
wants it to stop at "fetch the history and objects needed to
complete the history from the other side" phase without proceeding
to the "then integrate the history from the other side and the
history of your branch into one" step, which may be done with either
merge or rebase.  Even if we ignore that "always fail, do not do
anything" use case, your two seemingly independent "mergeoptions"
and "rebaseoptions" do not tell us which one is preferred between
merge and rebase.  A single

    pull.<someoption> = rebase | merge [| always-fail]

makes that choice in a clear way, I think.

Regarding the verb "integrate".

We used to explain "pull" is a "fetch" followed by a "merge".  With
more people using "git pull --rebase", the word "merge" used in that
explanation of "pull" stopped being generic enough.  Simplarily the
"upstream branch" of local branch X is "what you fetch and merge to
update the branch X" but that 'merge' can be 'rebase'.  We needed a
verb to call the process of integrate the two histories into one.

"git pull --help" since 153d7265 (pull: change the description to
"integrate" changes, 2013-07-07) uses that verb [*1*].

And that is where the name of the single configuration to pick how
to integrate the history obtained by the first phase of "pull" came
from.


[Footnote]

*1* I suspect that there may still be places in the documentation
that have not been updated since the days back when the only valid
way to integrate two lines of histories was to merge, and updating
them may be a low-hanging fruit. Hint, hint.
 

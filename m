From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Thu, 5 May 2016 14:02:58 -0700
Message-ID: <CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	<xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:03:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQQM-0001dg-KP
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbcEEVDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:03:01 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37930 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740AbcEEVDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:03:00 -0400
Received: by mail-ig0-f181.google.com with SMTP id m9so25052986ige.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=OSf413estdql5paiOtuBelz7DivLdVq/r/YUFF00YEw=;
        b=NC82IkiINfcLip31PJwm2uHfZN3GBJnmOLA4r4hOEGLxO3BrmjgETnVwG/rjemujHI
         Eorm76aU9sTVr1HmeZijS+4/pDK+nQikDIPk51e//D9Zko8tG4Zx8LHvWTJTxRspgjEq
         xcWkAHAm34XIZ/fM5+QfZFwYShcGP1zcd+E+bvyDL+GUs81H6adeZLNezrfXQeCvPikQ
         R4J/YFhOqWs1c27jTUulLPFLdXZdKBefQ1l0q/IcLXH/ZNL994FcBODA0WXcJ/4dGKd+
         Kn56/lAc18S5yWUnrls1P51s2LcDqxa3haKKeX4VlyQpRX7b/Vok+zl2Rb6czxD1s+SV
         39jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=OSf413estdql5paiOtuBelz7DivLdVq/r/YUFF00YEw=;
        b=GLKVPIFIiKv2sq6SRqt5LjpbbXQqsiacz/yXiF2FUsak/dRuoWuLoXucm8QzpjRm++
         u52gFzqKfB6829dHTksGO7+CRfknlHY7uENssXvnPoKaF6tFOoM0TjZbt/AO8+xQqRDS
         49S8Tqtw+qqe29gJLkT6JG3BniUe/n/Bd98aWFJFXPr18XrECPRJJcpI4tpBoHHK5Jfw
         If8+ALrYbzdz2GmOJxArYlF8kecWouHHql//baWHfAg6Hq0qOQ4MM+8crI11dI061Y/d
         xiYZMG2yp7tdFB0AlOrcxmMTy4iT6IqzlrjwMTQ3roKz4GxAnexlz6HCKq3VEBE8l2Ka
         AY2g==
X-Gm-Message-State: AOPr4FWtliHu6or/O6V92zbIxIV/nSlOm8CJ9Q5EtmbxGUyutGr2Dkugt5Mq5e0xIHyXYM4o0J7RGoch+rDHEDFk
X-Received: by 10.50.30.228 with SMTP id v4mr6331521igh.85.1462482179110; Thu,
 05 May 2016 14:02:59 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 14:02:58 -0700 (PDT)
In-Reply-To: <xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293680>

On Thu, May 5, 2016 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Any thoughts on my thoughts below?
>>
>>> So here is a thought experiment:
>>>
>>>     # get all submodules into the work tree
>>>     git submodule update --recursive --init
>>>
>>>     # The selected default group will not include all submodules
>>>     git config submodule.defaultGroup "*SomeLabel"
>>>
>>>     git status
>>>     # What do we expect now?
>>>     # either a "nothing to commit, working directory clean"
>>>     # or rather what was described in 0/15:
>>>
>>>         More than 2 submodules (123 actually) including
>>>             'path/foo'
>>>             'lib/baz'
>>>         are checked out, but not part of the default group.
>>>         You can add these submodules via
>>>             git config --add submodule.defaultGroup ./path/foo
>>>             git config --add submodule.defaultGroup ./lib/baz
>
> That may be an interesting thing to know, but I am not sure if it
> adds value to the user.  The user wanted the defaultGroup to be
> the set of submodules labeled with SomeLabel, and an alternative
> valid suggestion could be
>
>         'path/foo' and other submodules are not part of what you are
>         interested in; if you want to deinitialize them, do
>
>             git submodule deinit !defaultGroup
>
> Both look equally valid to me, but offering both would be way too
> much.  I'd say you should give that only with "status -v" or
> something, perhaps?
>
>>> If we want to go with the second option,
>
> You already lost me here, as it is not clear what two "options" you
> are comparing.

The first option is giving nothing:

     git config submodule.defaultGroup "*SomeLabel"
     git -C submodule-not-labeled reset --hard HEAD^
     git status
     # all good, no report about  submodule-not-labeled
     # because it is not in the default group.
     # (This is implemented in the series)

The "second option" is some sort of reporting. Either what I or you proposed.

>
>>> If we want to go with the second option, the design described in 0/15
>>> is broken. Going one step further:
>>>
>>> ...
>>>     # But what about subC which is not in the default group? It was
>>> changed as well.
>
> So why not show it?  Is there anything controversial?

The user made clear to not be interested in subC by setting
up the default group.

>
> If you are truly not interested in it by excluding it from the
> default group, you wouldn't have touched it in the first place.

Well it can get out of sync by not touching it as well, because others
changed the submodule pointer who are interested in that though.

    # in the superproject
    git checkout new-version
    git submodule update
    # checks out submodules to their version

    git checkout some-ancient-version
    git submodule update
    # this would only update the submodules in the defaultGroup,
    # not those which are initialized but "uninteresting"
    # the labeling may have changed between the different versions
    git status
    # I don't want to see any submodule changes here.
    # but there may be a submodule which is not at the right version
    # as `git submodule update` only paid attention to the default group.

> If
> you did touch it, then you are showing some special interest that
> overrides what you said in the default mechanism.
>
> In short, I think I understood what you wanted with your analogy to
> the ignore/exclude mechanism in 0/15.  Default is a handy way to say
> "I do not want to bother specifying everything from the command line
> every time" but we can say that it is nothing more than that.  That
> is exactly how the ignore/exclude mechanism is used--"git add" by
> default will not add those that are ignored when discovering paths
> by recursively descending, but once added, that is part of what the
> user told Git that she cares about.
>
>>> In case we report these submodules which are checked out but not in
>>> the default group, we probably want to adapt "git submodule update" to
>>> un-checkout the work tree of the submodules in case they are clean.
>
> Why?
>
> Letting them know that they have such an option, and giving them a
> way to tell which submodules fall into that category, are both good
> things.  But why is it a good thing to automatically clean what the
> user has checked out (which I expect that she expects to remain
> until she explicitly tells us otherwise)?
>
> We do not automatically "git rm" a clean tracked path that happens
> to match .gitignore pattern and I do not think it is a good thing to
> do so.

git rm changes the index (which may show up in the next commit)

The state of a submodule (un-initialized, initialized, checked out)
doesn't change the index or anything. Only the working tree is affected.

And by flipping between the initialized and checked-out state we do not
lose any information (such as user configured remote urls) nor does it
affect the "state" (index, recorded tree, history) of the repository.

So I just wonder if

    git init <submodule group spec>
    git deinit ! <submodule group spec>

should be done in `git submodule update <submodule group spec>`
(or by having the default group configured and running `git submodule update`
with no arguments.)



>
> Puzzled.
>

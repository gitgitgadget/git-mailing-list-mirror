From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 14:51:22 -0800
Message-ID: <CAGZ79kbOO=-nXj5htrg8GXV-iH-62gVwVb_SAGtbz3DOWXC=rg@mail.gmail.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
	<1448415139-23675-6-git-send-email-sbeller@google.com>
	<5655F544.6050003@web.de>
	<CAGZ79kZrBRo9dfU=p8-bgvSpp=SSiXQHZGm7iCQ=9v0f_f_-aQ@mail.gmail.com>
	<565610FD.9070303@web.de>
	<CAGZ79kY8=HbKB-om+FynDPf0w4c=12PtJ_9CsUyBU21yyD4CXA@mail.gmail.com>
	<5656366D.4010508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:51:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1iuM-0005J6-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 23:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbbKYWvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 17:51:25 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33571 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbKYWvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 17:51:23 -0500
Received: by ykdv3 with SMTP id v3so72416146ykd.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ALwLKU1dibQo7VEwf85AoDiRavJe49/YQH5JiVGU540=;
        b=lCe1fHBkmjCbFmeUci0camCJXklt0pjzVFNOmlzf0jqKyTIHAQtpZRMX95vrY8Cn9z
         rgoRrJJN29UmsfKeczTyyPyxxTHku8eJsSO3rO4uFzhtpLUDDX/7KdMfmoD3ctNpX0Kt
         Wxizbyp5AEG6qAM8wVMN2gliNX3A6n+EYw8HjcB9OE/lxPps5KXUpSzk9w6NSqMYLDzC
         676+s/nct5EMACymcLxMF3aaJ4goZTcPRQzDyg9ww44u0GtLat4QiFSGgX43+oXRloea
         0le59+mamXmw/GJ3kGq3Y90fCu6tZOZkSQn9em8bpmKOCmwru+weIBNrHKRGa38MFbhF
         B2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ALwLKU1dibQo7VEwf85AoDiRavJe49/YQH5JiVGU540=;
        b=D47QS6+MBmk94dFsObPpWqEF5V3zLu+ZHwdSQScXpzMSsTmRNVxyMpJLvhwCOv9S45
         uGd3VXUeeP+8mBfBT1y43vXHK8tiqdSPfqDfAINSNEZ/neRZhDnjIMaBu9yqAnOH7PUk
         /3+WF1aWlp02a1zZ3hi4GhJJM7ZmKGWj//sHWO0JHfo3WIsO4/V2CpbSt/sMdwkrhNeX
         P/2NLyHv1xq+THJzeqyqg7/dYD/2MSMGwx74p72uV2q+4Fg+a/UdihoyUe8aH36zHjOn
         mG3FIQYfRv6CST1EKbS+nMXBaJe7KnVxLsv78hqmFLVFRi4GyANHkfM4ztIn8Avbo3Hk
         G6tA==
X-Gm-Message-State: ALoCoQld4wsD/YH101atZ8Qo9BNt9fyyzRNE1oLMx0fEnqsJWex1RRKFkDcFOrdLBw/w5BxXiu8y
X-Received: by 10.13.235.135 with SMTP id u129mr38233685ywe.48.1448491882955;
 Wed, 25 Nov 2015 14:51:22 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 14:51:22 -0800 (PST)
In-Reply-To: <5656366D.4010508@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281749>

On Wed, Nov 25, 2015 at 2:30 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>>
>> I like the concept of subgroups as it allows to have some control over
>> subsubmodules you may want to aggregate from a third party via the
>> middleman submodule.
>
>
> That's the point (though maybe someone might come up with a better
> name than "subgroups" ;-). And each repo configures its own submodule
> groups.
>
>> I'd prefer to delay that feature though by not giving a high priority.
>
>
> No problem, we can start with "check out all subsubmodules" for now.
> But I suspect we'll need subgroups rather sooner than later.

Oh!
I thought we'd recursively propagate the groups, so the subsubmodules
are checked to be either in groups or subgroups, and the subgroups are
just a way to enhance the union of groups.

>
>> Also would you go with subsubgroups, too? When does the recursion
>> end?
>
>
> Subsubgroups do not make sense in the superproject, that can only
> configure its direct submodules.

> I think you are talking about the
> groups of the subsubmodules, and these have to be chosen inside the
> first level submodules via the subgroups of its submodules (which
> are the second level submodules of the superproject). Still with
> me? ;-)

I believe so.

> So the recursion can go on forever even as soon as we
> implement the subgroup configuration.

So lets say you have your meta collection repository,
which looks like that:

operating systems:
    ubuntu
        linux
        nonfree-game
        ...
    gentoo
        ...
    fedora
        ...
    android
        linux
        linux-build-configs
            vendor-phones
            nexus-family

In the "operating systems" repo I have the submodules
ubuntu and android marked via a group: "work-related".

Now I want to specify to have the linux, linux-build-configs,
and in there the nexus-family in the android repository.

One way would be to have the "operating systems" repo to
have subsubgroups specifying the groups in the
submodules of linux-build-configs (3rd level of submodules).
You seem to oppose that.

The other way to do that, would be to have a fork of the android
repo and put in the right subgroups to select for the right submodules
in linux-build-configs. So forking and fixing the groups config
would be the way to make changes from upstream.

I personally would find it easier to have all the spec in the one
superproject repository as then I don't need to update the
forks. (the .gitmodules file would get some conflicts, in case of my
fork there, so it's not easy to maintain long term)

Is there yet another way to handle such a case of deeply nested
submodules properly?

>
>> In case we have more than the union of groups, but also prohibitive
>>
>> terms available, could subgroups clash with the submodules groups spec?
>
>
> Not that I'm aware of. Groups decide which submodules to update and
> only for those submodules subgroups tell git what group to use inside
> that submodule. And so on.

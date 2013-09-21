From: John Szakmeister <john@szakmeister.net>
Subject: Re: Local tag killer
Date: Sat, 21 Sep 2013 08:28:13 -0400
Message-ID: <CAEBDL5UVZERxHF5FwR66HummgjoczWGwzXwiHZtFKZGBLt6c+A@mail.gmail.com>
References: <52327E62.2040301@alum.mit.edu>
	<CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
	<xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
	<523D3FD2.4090002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 21 14:28:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNMIN-0000fg-UP
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 14:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab3IUM2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 08:28:16 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61404 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab3IUM2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 08:28:14 -0400
Received: by mail-wg0-f42.google.com with SMTP id m15so590574wgh.3
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hOJv4u/1c1aZZktUlzhUg6gvvPScLY2nIStCsHm+qEo=;
        b=qzQ12LhQSJQastGzSX4d4Qumvi3Xf/YRaAWBPgj8B5X/iKLBF/SZskHFbCwf/4Ob98
         spqDhGLlOiCTxUE3NHJCDXtvN/vX1F5ekDMQu4fg+3/IcqQZzEHSFWAPufxCVO17GisX
         Uxjwmp3tL7g+VzfRAkK+8rvu7eI294fFuIgZBT4Bm1vXxZH6DcCZPp+vf0J1vhLjuVoI
         6oaRNHyGBoTbQ4QFVi+w2cK/SawHzlnxGX97FLaDyWE5gaWGJ1RDySDaT8Uxbix0MVNU
         A41zLZeD10wVe+hIhxgIYq+32v2niRl4I4SlLnqodpm0jcGJXHhEv28kkNXV0iH5Lkxs
         Upkg==
X-Received: by 10.180.76.171 with SMTP id l11mr6359624wiw.39.1379766493748;
 Sat, 21 Sep 2013 05:28:13 -0700 (PDT)
Received: by 10.180.228.42 with HTTP; Sat, 21 Sep 2013 05:28:13 -0700 (PDT)
In-Reply-To: <523D3FD2.4090002@alum.mit.edu>
X-Google-Sender-Auth: d-JxigwhxtYqbtu1CCXkrDW_7Kw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235098>

On Sat, Sep 21, 2013 at 2:42 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 09/21/2013 12:51 AM, Junio C Hamano wrote:
>> Junio C Hamano <gitster-vger@pobox.com> writes:
>>
>>> I also agree that the documentation is misstated; "remote-tracking branch"
>>> may have been a convenient and well understood phrase for whoever wrote
>>> that part, but the --prune is designed to cull extra refs in the
>>> hierarchies into
>>> which refs would be fetched if counterparts existed on the other side, so
>>> culling tags that do not exist on the remote side should also be described.
>>
>> (gleaning-leftovers mode)
>
> Thanks for following up on this with your proposed documentation patch.
>  I have been researching and experimenting, and still find the use of
> fetch confusing with respect to tags.  I think the problem is primarily
> that the behavior is awkward, and that it would be better to change the
> behavior than to document the awkward behavior.

I agree with this sentiment.  I've never liked how `--tags` operates.

> I must have read an old version of the documentation, from which it
> seemed that "git fetch --tags" fetches all tags from the remote *in
> addition to* the references and tags that would otherwise be fetched.
> This seems like a handy and safe feature, and I wish that this were
> indeed the effect of "--tags".

Me too.

> But I see that the documentation for "--tags" has been changed and now
> states explicitly that "--tags" is equivalent to specifying
> "refs/tags/*:refs/tags/*" on the command line, overriding any configured
> refspecs.  This doesn't seem like useful behavior; why would I want to
> fetch tags from a remote without also updating the configured refspecs?
>  And contrariwise, how can I fetch the configured refspecs *and* all
> tags at the same time in a single fetch?
>
> OK, one way to do it is to configure an explicit refspec for fetching
> the tags:
>
> [remote "origin"]
>         url = [...]
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = refs/tags/*:refs/tags/*
>
> [Here is one oddity: even if the tags refspec doesn't have a "+" prefix,
> "git fetch" will do non-ff updates to tags, presumably because of the
> implicit tag-fetching behavior.]
>
> But if I use this configuration and type "git fetch --prune", then any
> local tags that are not present on the remote will be killed.
>
> In short, when local tags are in use, or tags that are in one remote but
> not another [1], then the current Git implementation makes it impossible to
>
> - Configure "fetch.prune" or "remote.$REMOTE.prune" without preventing
> the use of "fetch --tags"
>
> - Configure default fetching of all tags (via a refspec or via
> remote.$REMOTE.tagopt) without preventing the use of "fetch --prune"
>
> - Configure "fetch.prune" or "remote.$REMOTE.prune" and the default
> fetching of all tags (via a refspec or via remote.$REMOTE.tagopt) at the
> same time.
>
> This is unfortunate.
>
> I think it would be preferable if "--prune" would *not* affect tags, and
> if there were an extra option like "--prune-tags" that would have to be
> used explicitly to cause tags to be pruned.  Would somebody object to
> such a change?

I, personally, think what you outline makes more sense.  Also, I'm
curious if `git remote update -p $REMOTE` suffers from the same
problem, if the remote was added with the `--tags` option.

-John

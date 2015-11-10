From: Stefan Beller <sbeller@google.com>
Subject: Re: Allow git alias to override existing Git commands
Date: Tue, 10 Nov 2015 10:12:45 -0800
Message-ID: <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
References: <56421BD9.5060501@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 19:12:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwDPX-0006Tp-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 19:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbbKJSMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 13:12:47 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35538 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbbKJSMq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 13:12:46 -0500
Received: by ykba77 with SMTP id a77so7627842ykb.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WmuEBsEgo4YcoxqztQkeMb3GMWvyviSrGgQ7prg3ghE=;
        b=VjT/4JM8bAo4Q63mka25Z3tdFkM5armFDrazczVDJ7DosdmKHFzQUMNBlnUrl+kQxi
         2VlEyM1znouTBQvDq0alLddTTiegsgcoN84Q0ezrMTF+BnANi1t4TTHQgSDlgkZtI9F3
         7xY92chJEL8G7RUf+CVj0Se/fZMOWU3Bej7N27z+vB44sfNzd3D40e1hBOJGCeKFMkcF
         dEwsNojt4sIxxNL10EUyiX0bwD51G0VLjwOF7avq3h82gzbjRenRICxY8Mo8QI2aP8xf
         0thfYUToDNJ+YCOF4GqVMIG4R0shxXNI3wD2jxHfm60WNE+TsY6HM9Qvc7LB3v5bp4/D
         vu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WmuEBsEgo4YcoxqztQkeMb3GMWvyviSrGgQ7prg3ghE=;
        b=JwqPbSaHnYNk1EcPgLTRBmXwgmz8wZqpSC9MpjriNHna6QggnzSojVQ/HXz8zYObV6
         4rileIoLMLXFEPfyJqi/q9xG7yfrmeblGhwF5N6rXioaqdFs13zlxAxcpHkeCIqtrjb3
         U3r/xL4/5CSa9Gl32aQy62sWEvxLvqfjjqtt9L620OSq75l20KD2jcNa5ggASi7HAQpV
         +gA2KXwTQtEoDVjzUe5BoJzEQbThz6MXNJbAn/9UQvKHBwLMKMs5ROut8IFCok47XnbA
         ERSVAUmWrNAU77MTgUYGKsjhAfCdH2KNMDMR+Nrck16wejNQgPb9Q9CO1ivTFwN6kGvT
         c1uA==
X-Gm-Message-State: ALoCoQkjnmZpPH1fCIJsmYmUi85uHZxZ2vVvYItu3XBfOFzn4E6HThAlRbjZg6anTWLBGwiCmFmI
X-Received: by 10.13.210.4 with SMTP id u4mr4445156ywd.68.1447179165937; Tue,
 10 Nov 2015 10:12:45 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 10 Nov 2015 10:12:45 -0800 (PST)
In-Reply-To: <56421BD9.5060501@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281127>

On Tue, Nov 10, 2015 at 8:31 AM, Jeremy Morton <admin@game-point.net> wrote:
> It's recently come to my attention that the "git alias" config functionality
> ignores all aliases that would override existing Git commands.  This seems
> like a bad idea to me.

This ensures that the plumbing commands always work as expected.
As scripts *should* only use plumbing commands, the scripts should
work with high probability despite all the crazy user configuration/aliases.

>
> For example, I wanted to setup "git clone" to automatically act as "git
> clone --recursive".  Sure I could do it in the shell, but it's more of a
> pain - any tutorial I set up about doing it would have to worry about what
> shell the user was using - and if you're going to make that argument, why
> have "git alias" at all?  It can all be done from the shell.

I think the git way for your example would be to configure git to include that
option by default, something like

    git config --global submodules.recursiveClone yes

though I was skimming through the man page of git config and did not find
that option there. I guess it's missing.


>
> Obviously I could also use a different alias that wasn't an existing Git
> command for this behaviour, but that would rather defeat the point: I want
> "git clone" to have different functionality.  If I remembered to use a
> different Git command, I might as well remember to type "git clone
> --recursive".  Also, if a future Git command were introduced with the same
> name as my alias, my alias's functionality would suddenly be ignored, giving
> unexpected behaviour.
>
> The reasoning behind this that it's "to avoid confusion and troubles with
> script usage" seems to be at odds with the general Git mentality that the
> user is given lots of power, and if they screw it up it's basically just
> user error.

For scripting the plumbing commands are recommended. The plumbing commands
usually cannot be configured to do crazy stuff.

> For example, Git doesn't *have* to allow you to rebase.  It's a
> potentially dangerous operation, so why is it allowed?  It might "cause
> confusion and troubles".

Git doesn't try to hide its complexity from the users. And if a user would need
to hack their way around to get rebasing working again, might also
"cause confusion
and troubles".

>
> On the other hand, by disallowing the overriding of existing Git commands
> through aliases you are preventing a lot of useful functionality that those
> aliases might be used for.
>
> So I think you should either allow Git aliases to override existing Git
> commands by default, or at least provide a config option that allows the
> user to say that this should happen.
>
> --
> Best regards,
> Jeremy Morton (Jez)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

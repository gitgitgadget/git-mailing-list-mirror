From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 1/6] pull: rename pull.rename to pull.mode
Date: Tue, 29 Apr 2014 17:05:04 -0500
Message-ID: <53602210aff0c_10a211e3308d@nysa.notmuch>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
 <1398770226-9686-2-git-send-email-felipe.contreras@gmail.com>
 <5324ACC54F034438BBAFDB15A9D716D5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:15:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGJV-000658-KB
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbaD2WPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:15:42 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:45146 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965250AbaD2WPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:15:41 -0400
Received: by mail-yh0-f42.google.com with SMTP id f73so895179yha.29
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=3Js5dqhyy1eHYqYw2ivhQMDqUoexzUgYES+DPv94qN8=;
        b=zvwIFLpuzX9q8JwRSIlvzM7jJJ3KPJ3stLLklArfyC145+5TaniAlRRchJhLsXD4WZ
         /w5flBgjf0TO0uScOJmbr06w97tz9niD89q/bLLecCmgMb1WwKqiuZvFnwpe7ZPitBGk
         np74KksW8UwM95wwuYcFXVs45bKtd83snhwSUGwHH6tEQuPTSRctpxRIhtP/Z4joldgZ
         2NMPEIPEu/1ww4jX+zZleJRzoYik5wTDWtKFbnRU5360Jo+ti1QXA82Xis7vFk0Gvd18
         P+cIWBWnyKuHUrOTfj78zia/n3B2CuZiQvxDmTvwERFJgnU1tg4KbGX58mIjw0WELrya
         PjjQ==
X-Received: by 10.236.104.234 with SMTP id i70mr521198yhg.125.1398809740844;
        Tue, 29 Apr 2014 15:15:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x37sm2381610yhn.39.2014.04.29.15.15.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 15:15:39 -0700 (PDT)
In-Reply-To: <5324ACC54F034438BBAFDB15A9D716D5@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247626>

Philip Oakley wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> > Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.
> 
> Sorry I haven't commented earlier. Because the 0/6 explanation isn't a
> commit, a few extra words would be useful to capture what the 0/6 cover
> letter said to start the patch series cleanly/clearly e.g. start with
> 
>     Begin the "Reject non-ff pulls by default" process by creating new
>     config variables which will allow extra options, to replace the old 
> pull
>     configuration options.
> 
> I didn't immediately grasp why the 'replacement' was happening, rather
> than it being a creation and a deprecation.

How about this:

> > This way 'pull.mode' can be set to 'merge', and the default can be
> > something else.

This will allow us to eventually add a 'merge-ff-only' option, and
eventually set it as default to solve the problem of not rejecting
non-ff pulls by default.

> > The old configurations still work, but get deprecated.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt

> > @@ -764,15 +764,15 @@ branch.<name>.mergeoptions::
> >  option values containing whitespace characters are currently not
> >  supported.
> >
> > -branch.<name>.rebase::
> > - When true, rebase the branch <name> on top of the fetched branch,
> > - instead of merging the default branch from the default remote when
> > - "git pull" is run. See "pull.rebase" for doing this in a non
> > - branch-specific manner.
> > +branch.<name>.pullmode::
> > + When "git pull" is run, this determines if it would either merge or
> > + rebase the fetched branch. The possible values are 'merge',
> > + 'rebase', and 'rebase-preserve'. See "pull.mode" for doing this in a
> > + non branch-specific manner.
> 
> I'd think it useful to add that:
>     branch.<name>.rebase is deprecated.
> given the large amount of internet cruft about this older config
> variable name

I don't recall deprecated configurations in the documentation, but I
don't see a problem adding that either.

-- 
Felipe Contreras

From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge"
 during a merge
Date: Wed, 26 Feb 2014 19:00:56 -0500
Message-ID: <CADgNjamXxvhS-JzFY7DxvZAQQA3AQmY2hS5AoJv9xHv2DzP7=Q@mail.gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
	<vpq8usxenul.fsf@anie.imag.fr>
	<CADgNjanavxZfuXgvEAOMzPAJr9YqAvF4+ZDq9KW9aeR_PcVo-Q@mail.gmail.com>
	<vpqeh2pd237.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 27 01:01:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIoPO-0002kI-5c
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 01:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbaB0AA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 19:00:58 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36058 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbaB0AA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 19:00:58 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm4so2834218wib.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 16:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i7pZniumeb5L8YtXYSx5MzZqV8NLaXfxRmAsbcibPIg=;
        b=ClRaMyNStQqF4FWXv/uTIylyyCC60Cj08XCmD8pin1PmQbfAU/Zoq5qFVVQGRjLgJ+
         gEL9ahnbyF/eW2bhahEXzoVp4U+oUzPd4ftbg3U1Mf4/wYvDSWDARv3wjR+PUrtmq7cu
         eHv9kXwl/iGVURtbJDl6cgjI3d6Gzdgi8R9D1cqhODF1Y8P8nk/8qoI+3bX+ONfTpZ3E
         nw3l0/wBJzdN+MvwfrVJlPUPCiUWCg4Noclz4nyRFP+UHjtZmXAFVmlC/lPVvI8KEI/T
         OuaQLE9yuuNiKMP/XAGD7ocJHouvmh10ZtiQ60RM6qYtcpDZF054xjW2HsyCnZ0hDVjt
         6JSQ==
X-Received: by 10.194.59.210 with SMTP id b18mr4276999wjr.60.1393459256736;
 Wed, 26 Feb 2014 16:00:56 -0800 (PST)
Received: by 10.194.81.65 with HTTP; Wed, 26 Feb 2014 16:00:56 -0800 (PST)
In-Reply-To: <vpqeh2pd237.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242776>

On Wed, Feb 26, 2014 at 3:57 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> If you were to design "git reset"'s interface from scratch, your
> proposal would make sense. But we're talking about a change, and you
> can't expect that users never use the current behavior. At the very
> least, there should be a warning telling the user that the behavior
> changed, and I'm really afraid that the warning goes along the lines of
> "I've thought you'd prefer me to discard your unsaved changes, please
> rewrite them if you actually didn't want me to".
>
>>> I'm not really convinced that this is such a good change, and if we go
>>> this way, there should be a transition to let users stop using
>>> argumentless "git reset" to reset the index during a merge.
>>
>> Yeah, this breaks compatibility, but like I said, during a merge, I don't
>> see a good reason to do "git reset --mixed",
>
> The point with backward compatibility is not to know whether users have
> a good reason to, but whether you can guarantee that no one ever does
> it.

Yeah, I do see what you mean. But the problem of using "git reset
--mixed" during a merge is problematic too. It leaves you with a mix
of merge changes and local changes. As Junio pointed out, new files
will also be left in the worktree. So users would have to clean all
that up manually. Perhaps what Junio suggested is a better approach.
Slowly phase out this behavior by printing out warnings. Then
eventually erroring out in this situation, and then finally switch to
a new behavior, whatever that may be.

Andrew

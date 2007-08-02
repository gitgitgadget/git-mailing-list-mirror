From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 10:48:58 -0400
Message-ID: <f158199e0708020748o5cac4505ic76bfb39f25ab1f8@mail.gmail.com>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:49:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGbz9-0005i8-MT
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 16:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbXHBOtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 10:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbXHBOtB
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 10:49:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:22219 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbXHBOtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 10:49:00 -0400
Received: by nf-out-0910.google.com with SMTP id g13so145382nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 07:48:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QXFo/IgWzMNmOe3Ws+kk/HY14KTuDqRdfLxlYSD5E5yQduwuaEs+ymdox7zjSYHJw/xwVHfykEH14vxAWDErn8dkjuxpYD27WGHSn/SaQLdnOJbLv+XaSe+jLltA8IrZDdfOuFxKTDctUaL9i5InaiI8SgscVxck0qINXUua1Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I8fJGdLSvcX9ljS14DsLn548Y9RKKK9Fv0f/GhZj0HlDK+MlatlR6tAkK0FH9BWb70fkiLVI6aWR81AG1nxDvjpfh+ND1e5ZzWz5amQpvZXOEXxbgn/vDD7C80bqtQMWWw7wPnVQsxqR7jbJ3xlW0++L9m2rpUKGdpB0jQ0y7VI=
Received: by 10.82.105.13 with SMTP id d13mr2544868buc.1186066138952;
        Thu, 02 Aug 2007 07:48:58 -0700 (PDT)
Received: by 10.82.191.19 with HTTP; Thu, 2 Aug 2007 07:48:58 -0700 (PDT)
In-Reply-To: <86bqdqkygp.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54555>

On 8/2/07, David Kastrup <dak@gnu.org> wrote:
> Hi, I wanted to ask what the general stance towards shell script
> cleanups and simplifications would be.  For example, I find the expr
> usage quite inscrutable in commit, and there is no necessity of
> putting "shift" in every case branch instead of once behind it, and a
> lot of conditionals and other manipulations can be made much easier on
> the eye by using parameter expansion patterns that are, as far as I
> can see, available with every reasonable Bourne Shell and clones.
>
> Here is an example context diff (in this case, I find it more readable
> than unified) to illustrate (untested!, please don't apply without a
> regular formatted git patch).
>
> Should I bother doing such cleanups as I read up on code, or should I
> just leave things alone?

I have no authority over the git project, but please consider this argument:

Every time you submit a patch there are three costs:
1. The time you put into making the patch.
2. The time required for the maintainer to review the patch and
possibly merge it into the code base.
3. The risk that you may have accidentally broken something.

Obviously, you aren't too concerned about 1 (the cost to you), because
you're willing to do that work.  However, if I were Junio, I wouldn't
be willing to "spend" costs 2 and 3 on a patch that didn't either fix
a problem or provide a new feature.

So, I recommend you do the clean-up that you want to do on your own
local branch.  This will no doubt be fun and educational for you.  I
know I've learned a lot in the past by experimentally "cleaning up"
old ugly code on other projects, even though the result never made it
into the official code base.

Along the way, you will probably find real bugs.  When you do, submit
patches for them based on the current master branch.  You can probably
manage to sneak a bit of clean-up into those bug-fixing patches, as
long as you make sure it is all relevant to fixing the bugs and you
keep the patches readable.

Best Wishes,

Bradford C Smith

p.s. I should also point out that writing portable shell scripts is
far from trivial, so it is very difficult to be certain that what
works for you will work for someone with a different shell.

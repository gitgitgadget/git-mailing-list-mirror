From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Fri, 11 Apr 2014 08:48:01 -0500
Message-ID: <20140411134801.GB5871@nysa.casa.local>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 15:58:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYby7-0006YZ-LC
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 15:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbaDKN6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 09:58:05 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:49325 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbaDKN6B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 09:58:01 -0400
Received: by mail-ob0-f169.google.com with SMTP id va2so6083109obc.14
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PMAwbOz7osggnF5WzrQ+ae/OoBtQqG30Bo06vobgt7g=;
        b=c0rv1U6Gzz40zMMpLMLka2OKDA+uOPm1bdE/F6efttmSIeP59D3JNvA28veBtL7DcE
         AH8lHRBK5HCuPb1nZWj9ee6iFXc5jv9H/zW79D48pI8feAWJR85WzZx6i197oWFVJ4Il
         Awtm7UDTHcPyEoKQbM6E2AW/3yaYXDjw15QFi06HzYjvvA2vjqkZB9YAfRqYg+draFQw
         smAnDhAC7ig8Juncr/YzqG1mr2p16WZsB6GlT3DSibqd14ppFb5PuP1TrgGfg/k/oQiw
         Iss5gEf3+JcSHOgf9ehf7zwNQh7BFABZyKzHWLCYk4PMB0x8qBzKLREy4jLe4nuDw6NA
         iGEQ==
X-Received: by 10.60.162.7 with SMTP id xw7mr19535870oeb.13.1397224680672;
        Fri, 11 Apr 2014 06:58:00 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id or12sm12456252obc.0.2014.04.11.06.57.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 06:57:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140411111750.GA28858@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246093>

Jeff King wrote:
> On Thu, Apr 10, 2014 at 05:36:59PM -0500, Felipe Contreras wrote:
> 
> > > I noticed that this only picks up a publish-branch if
> > > branch.*.pushremote is configured. What happened to the case when
> > > remote.pushdefault is configured?
> > 
> > What happens when branch.*.remote is not configured for @{upstream}? The same
> > thing.
> 
> I don't know if that is a good comparison.

I think it is. @{publish} is like @{upstream}. Period.

> In other threads, the discussed meaning of @{publish} was something like
> "the tracking branch of the ref you would push to if you ran 'git push'
> without arguments".

And I disagree.

> That is consistent with @{upstream} being "the tracking branch of the
> ref you would pull from with 'git pull'". But "git pull" without a
> branch.*.remote will do nothing, so "what pull would do" is the same as
> "what you have configured in your branch.*.remote".
> 
> Whereas "git push" does not depend on having branch.*.pushremote
> configured. Its behavior is based on push.default and push refspecs, so
> "what push would do" must take that into account.

Yes, but we are not talking about 'git push', we are talking about
@{publish}.

I think of @{publish} as "the branch the user has configured to push
to"; it overrides all other configurations (push.default and push
refspecs). I wouldn't mind having a @{push} *in addition* to @{publish}
that would have the behavior you mention, but for @{publish} I'm pretty
certain the behavior I want is that it maps *directly* to what the user
has configured.

Similarly, I don't want 'git branch -vv' to show @{push}; it would be a
mess to show something on all the branches, probably origin/$branch, and
probably all "ahead/behind". I want it to show @{publish}, so only the
branches the user has *explicitly* configured.

> > It might be useful to visualize what would be the name of the branch when
> > pushing it (without a refspec) even if the publish branch hasn't been
> > configured, but I think the code would be much more coplicated, and it would
> > break symetry with @{upstream}, besides, the user can just do 'git push -p
> > branch', and from that moment on it will be visible.
> 
> It is more complicated (see the patches that Junio had at
> jk/branch-at-publish), but I think it is more likely to do what the user
> expects.
> 
> For instance, it looks like your @{publish} requires config like:
> 
>   [branch "master"]
>   pushremote = foo
>   push = refs/heads/bar
> 
> to operate. Setting "pushremote" affects what "git push" does; it will
> go to the "foo" remote. But the branch.master.push setting does not do
> anything to "git push". Only a push refspec (or push.default setting)
> will change that. So the "branch.*.push" must be kept in sync manually
> (perhaps by running "git push -p").
> 
> Whereas if @{publish} means "where you would push to"

It doesn't mean that to me.

For the record, I've been thinking about this for a long long time, and
I argued for @{push} and @{publish} long before you discussed this in
January (which apparently you forgot). I implemented this more than half
a year ago, and have been using it since; it works great. The problem of
triangular workflows is pretty much solved for me.

-- 
Felipe Contreras

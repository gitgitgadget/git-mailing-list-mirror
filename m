From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap format
Date: Wed, 30 Oct 2013 10:23:10 +0000
Message-ID: <CAJo=hJvOb=oooJ3O0wjxt77caGOMeKwT0VRaV=znMAzm0yNCYw@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180347.GI24180@sigill.intra.peff.net>
 <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com>
 <20131025032144.GB26283@sigill.intra.peff.net> <CAJo=hJvmL0=MN7W-NW4bACK0m+Y39+LBVZ+ufXTEh8KzyjFbKg@mail.gmail.com>
 <20131030075040.GJ11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Colby Ranger <cranger@google.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 11:23:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbSw5-0006IL-9J
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 11:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab3J3KXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 06:23:33 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:44434 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab3J3KXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 06:23:32 -0400
Received: by mail-wi0-f175.google.com with SMTP id hm4so6520157wib.14
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=V3r3fg6+fy4r26XnRe2B42Lb2bBJKSaqwgui8ws+DZE=;
        b=B41ka95yPIw8ZCH8wMb7f3y3pmqVU/iMLjhqfFdOtgAl5CpGdpH5hA1KGhsKcO/5wm
         dOTrM8jAZK5MuabxRM271BcrqygB/x0nIXqjZPci/gWkIAYZwlufaACPEuGAO6oSglbp
         ILJJwf5CeFfLnMguwmeuMwo9T6/9a5lci/Wqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=V3r3fg6+fy4r26XnRe2B42Lb2bBJKSaqwgui8ws+DZE=;
        b=YTA6wh0D3VC3mmqDgHAaJMMqKVTppxiGKsFo6/H16kXhRMtp9HbLPIR+q5BSEd8JlQ
         94lCLW7mio43/BsLHXc9BAajkVIdyPJkP3rlH074gPB+7n2R1m+5Idm/wrF834BVpC7w
         oBs2+aOobQ0diLMgrlBkCh0BYUpDSyU5PJMz5a9l5qGkqSbfTW6QyIKXpicOlXo/K+4W
         EiwHDqsIi3WVc2eGfkG59hhW9/Q+JBdVqmyESp4NNCADc1YprJ/uE2kP7S7mFqzyCeDy
         ZKf87Tj8c3zMq5TvOQHtzCrJUC21VwpXtBIAk9tzwzldd58a4YRo1QujTzoZs3GmQuoD
         BzKQ==
X-Gm-Message-State: ALoCoQksR7b2ITp31Eq+kyNRt3LnIIttUnL1egEHAJVOIBf0TDK67KTU7uE/lFxFZlJih4+D5rdG
X-Received: by 10.194.6.161 with SMTP id c1mr82611wja.89.1383128610723; Wed,
 30 Oct 2013 03:23:30 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Wed, 30 Oct 2013 03:23:10 -0700 (PDT)
In-Reply-To: <20131030075040.GJ11317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237007>

On Wed, Oct 30, 2013 at 7:50 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 25, 2013 at 01:47:06PM +0000, Shawn O. Pearce wrote:
>
>> I think Colby and I talked about having additional optional sections
>> in this file, but Colby didn't want to overcomplicate the format early
>> on. So v1 is probably not very extensible and we may have to go to v2
>> to safely create an extension with the name hash cache used in this
>> series.
>>
>> Given that the JGit v1 bitmap format has been shipping since JGit 3.0
>> and in Gerrit Code Review 2.6, its in use in the wild. So we aren't
>> going to go back and redefine v1.
>
> I don't think either course of action affects how JGit in the wild will
> react. If we add a new flag to v1, existing JGit barfs. If we move to
> v2, existing JGit barfs.  In either case, the simplest fix for JGit is
> to ignore the new section.

Fair point. Then we can use v1 with the flag for now, JGit will barf and...

> If we want to define a v2 format and make it clear how to add optional
> sections, that's fine. But what I really want to avoid is a big v2
> bikeshedding discussion where other features get added because it's a
> version bump.

We can defer the v2 bikeshedding until after v1 lands and we get more
experience with the format.

> If that means dropping the name-hash cache from the series, so be it
> (that's part of why I pulled it out into its own patch at the end). We
> could also make it optional with a documentation warning that existing
> JGit will not like the resulting bitmap files. In practice, I do not
> expect it to be a big deal, as most sites will not mix-and-match serving
> from the two implementations (though you might repack with C git and
> serve with JGit, which means "off" would be the sane default for the
> feature).

The name-hash cache is probably important, but it would be nice to
have a variable or flag we can use to disable the name-cache
generation and thus permit Git to create JGit style v1 indexes, and
also use JGit v1 indexes if the name-cache is not available.

From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: What's cooking in gitweb (20 Sep 2008)
Date: Mon, 22 Sep 2008 18:51:22 +0200
Message-ID: <cb7bb73a0809220951p5c19d19g2d79ecba0ef7e394@mail.gmail.com>
References: <200809210138.01874.jnareb@gmail.com>
	 <cb7bb73a0809211322q5aa6d8ex88651aa33a6c2688@mail.gmail.com>
	 <200809221443.38689.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Lea Wiemann" <lewiemann@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 18:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhoeL-0006qn-DY
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 18:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbYIVQv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbYIVQv1
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 12:51:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:9937 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYIVQv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 12:51:26 -0400
Received: by wx-out-0506.google.com with SMTP id h27so402707wxd.4
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oFehmV0Lq10MndIBjarRsSzC8PM6uX+21ijXPI0DqVg=;
        b=qBjnHkPmo/3bODLIgbgU4sy/TW+vT28xVpvuH8IR8Nh22YM0UL7EPcAjpN0HjjwQZf
         /h21O9lUjLG39vZJRcc3XMcXhSJ+0EpoevXmXx/c+9po4B/Jzv8zxp+lqMKJGnOUXy8I
         U0N5yEI/6WY9a6Ic2FqdrJ6bvHlAGTLhyQKGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lhU9Oh4cfhWTkswmp7Sf71m4lIaDaJNP8XPruIWY1f38S+y/nrpcbhpiH5hrB32YVB
         J6TstjNVF0+0ZIgDXa8x1U0acO4ah2dD7aKhrb8i99TPPQ41UlmYRi04nWDAx45Led2n
         hUBfrmuT7kszIu+nchUC8gB+UYJAEHkyJ2clY=
Received: by 10.151.158.2 with SMTP id k2mr7420677ybo.54.1222102282323;
        Mon, 22 Sep 2008 09:51:22 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Mon, 22 Sep 2008 09:51:22 -0700 (PDT)
In-Reply-To: <200809221443.38689.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96497>

On Mon, Sep 22, 2008 at 2:43 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>>
>> I'll resend the whole series (plus an additional patch to fix an
>> aesthetical issue I found recently) as soon as I fix the url
>> generation for the dotted filename corner case (which by re-reading
>> the past emails seemed to be the only significant issue, correct?).
>
> I think it was the only significant issue (besides the fact that
> two mentioned patches could be in separate series).  To be more
> exact the issue was with generating gitweb URLs for sets of
> parameters which cannot be represented as path_info URL.  One
> example was filename with '..' in it, which cannot be used in
> the following path_info form:
>  $hash_parent_base:$file_parent..$hash_base:$filename
> but it can be used in 'no name change' form
>  $hash_parent_base..$hash_base:$filename
> This requires fallback to 'query' form URL.

This is fixed in the resend.

> Other example was branch name with the same name as one of gitweb
> actions, which require action to be stated explicitly even if it
> is default action and otherwise could be omitted.

Generated urls now _always_ contain the action

>> > 2. "[PATCH] gitweb: shortlog now also obeys $hash_parent"
>> > by Giuseppe Bilotta
> [...]
>> > More important fact is that I'd very much like for _all_ log-like
>> > views (perhaps with exception of feeds: Atom and RSS) to implement
>> > this feature.  This could be done by either doing it all in the same
>> > commit, doing commit series changing 'shortlog', 'log' and 'history'
>> > separately, or what I would prefer actually, to refactor generation
>> > of log-like views to use single worker/engine subroutine.
>>
>> I agree that refactoring is probably the best idea. It will also take
>> me some more time ;)
>
> But it has the advantage of making it easier to add more log-like
> views, like 'log' like view for the 'history' view, i.e. --pretty=full
> like view with path limiting.
>
> I have thought about doing the refactoring (it is/was on my long-term
> TODO list for gitweb), but I haven't even found good way to code it,
> to be flexible but not too generalized.  Callbacks, perhaps?

Actually, the only reason I mentioned it would take time was to
explain why _that_ patch wouldn't be resent 'shortly' by me. I need to
study the log/shortlog/history code better to get an idea of what
might be a good refactoring strategy :)


-- 
Giuseppe "Oblomov" Bilotta

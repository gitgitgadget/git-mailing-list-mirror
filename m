From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project search
Date: Sun, 4 Mar 2012 19:00:31 +0100
Message-ID: <201203041900.32114.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <7vwr72a6m6.fsf@alter.siamese.dyndns.org> <201203031156.00948.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 19:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Fju-0001Rb-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 19:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab2CDSAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 13:00:37 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41135 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab2CDSAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 13:00:37 -0500
Received: by eekc41 with SMTP id c41so1200824eek.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 10:00:35 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.102.1 as permitted sender) client-ip=10.213.102.1;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.102.1 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.102.1])
        by 10.213.102.1 with SMTP id e1mr2706305ebo.20.1330884035921 (num_hops = 1);
        Sun, 04 Mar 2012 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=/fJb2QnHLGasAHkZ+E6+oHzSOsU6plEl8w0T2EfSf0s=;
        b=A71L7nHOS1TIaOtsYNKowt9QJi5RoFdBWYgiqsULY3XTInB3tCOh3BxbjLMvKU5QWQ
         9zOog2xoaCZppFcF5pY5OrP2ZuyxeeVf5vq3z5Svj9hJ/yClFOGqUbEU8uqBqhPgLO8I
         m+BVpCWnFbLo46sIRxwRn2K2Xe3miY/9VyGpzcksvcJjrcllEAIYykOzmEhqgFVvD8Rm
         gEq42FWoNufeUJH1KEunpEU/aJvZ+ckXqps0zqvxUg3o7FC9iq+Ase4DPhjv4cH3h5zH
         0x5TFitS9bBgD8mbBuUWzGb90XOKcvLu7oEB+WB9nMsoz3FBwFkAf8Yc1pbKPzqnO+wB
         Qv8A==
Received: by 10.213.102.1 with SMTP id e1mr2053575ebo.20.1330884035782;
        Sun, 04 Mar 2012 10:00:35 -0800 (PST)
Received: from [192.168.1.13] (abwo57.neoplus.adsl.tpnet.pl. [83.8.238.57])
        by mx.google.com with ESMTPS id u11sm51057592eeb.1.2012.03.04.10.00.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 10:00:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201203031156.00948.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192167>

Jakub Narebski wrote:
> On Sat, 3 Mar 2012, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Use $search_regexp, where regex metacharacters are quoted, for
>>> searching projects list, rather than $searchtext, which contains
>>> original search term.
>>>
>>> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>> ---
>>> I think this bug was here from the very beginning of adding project
>>> search, i.e. from  v1.6.0.2-446-g0d1d154 (gitweb: Support for simple
>>> project search form, 2008-10-03)  which was present since 1.6.1
>>>
>>> On Fri, 2 Mar 2012, Ramsay Jones wrote:
>>> 
>>>> This patch solves the problem for me when using a regex search
>>>> (re checkbox checked), but *not* for a non-regex search.
>>>> 
>> 
>> This patch depends on the more recent changes than the regexp fix, no?  I
>> was hoping that we could merge the earlier fix for the regexp case to
>> older maintenance tracks later, but if we were going to do so, we would
>> want to do the same for a fix for fixed-string case.
> 
> The regexp and non-regexp bugs and fixes are different.
> 
> The regexp "bug" was just us forgetting that regexp is provided by user
> input, and should be validated.  The bug as reported by Ramsay was here
> from the very beginning, i.e. commit 0e55991 (gitweb: Clearly distinguish
> regexp / exact match searches, 2008-02-26), which was present in v1.5.1
> if I have checked correctly.  The fix is about adding new code and should
> apply cleanly to 'maint' and even to older versions; the only trouble
> with older version might be whitespace issue related to refactoring
> code into subroutines.
> 
> The non-regexp project search bug was using $searchtext instead of
> $search_regexp as search regexp in gitweb.  The bug was present from
> the very addition of project search, namely commit 0d1d154 (gitweb:
> Support for simple project search form, 2008-10-03), which was present
> in v1.5.1 if I have checked correctly.  Unfortunately the fix affects
> code that was changed recently in a1e1b2d (gitweb: improve usability
> of projects search form, 2012-01-31); I'll try to come up with equivalent
> patch to 'maint' soon (if the current one does not apply, and I guess it
> doesn't).

In other words: while "*foo" is invalid regular expression, it is
perfectly valid fixed string search term (which translates to "\*foo"
regexp).

-- 
Jakub Narebski
Poland

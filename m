From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Implementing CSP (Content Security Policy) for gitweb in the future
Date: Wed, 8 Jun 2011 12:27:19 +0200
Message-ID: <201106081227.19495.jnareb@gmail.com>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com> <201106051533.51735.jnareb@gmail.com> <1307292370.23564.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:27:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUFz9-0007Eo-Ar
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 12:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab1FHK1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 06:27:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44549 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1FHK13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 06:27:29 -0400
Received: by bwz15 with SMTP id 15so289382bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6YWt0s2lZ20wxbwJyIZoDbAy7y28wV5VIY9fXWTVq6Q=;
        b=HBM8imn2d/PM7e3gPStjo+26/dXpsKC2xoevbzhDsfvWZKivZDK6QWFxqNL6IT0NPD
         trbHTtS05EThnM+qz5pcE39utbVP7uyGXWw/Zn2mEP6wc8O/PXpDCIARU2ivqxQD7J57
         +1lr3rphmdRnhrT/kFet0uMAyVWljlpK8d/dY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IsSKAB7GaQ97D1dPwl+fPi8G4E8PVwq+zngvbQQw3VX5MM16cBilfk6oMjMf5M//wM
         wqHus71eGS1uZ4REMChFuXj+fj1qd6sNxAWik8dug/ErW1+NHAMbB7glmJfu7YYOy8bf
         pq4SW471/u0qhEJrX3jl24N3b3Ag/tjou/KU0=
Received: by 10.204.6.219 with SMTP id a27mr931932bka.171.1307528848291;
        Wed, 08 Jun 2011 03:27:28 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id k10sm414635bkq.10.2011.06.08.03.27.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 03:27:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307292370.23564.10.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175348>

On Sun 5 June 2011 Matt McCutchen wrote:
> On Sun 2011-06-05 at 15:33 +0200 Jakub Narebski wrote:
>> On Sun 5 July 2011 Matt McCutchen wrote:
>>> On Sun 2011-06-05 at 11:03 +0200 Jakub Narebski wrote:
>> 
>>>> In the future however it might be better solution for gitweb to implement
>>>> (as an option) support for CSP (Content Security Policy) which IIRC did
>>>> not exists in 2009 in addition to current $prevent_xss.
>>> 
>>> Sure. CSP is not a substitute for designing to prevent harmful HTML
>>> injection but a mitigation for some of its worst effects in case some
>>> injection points are overlooked. There's no reason not to enable it by
>>> default with $prevent_xss though third parties adding functionality to
>>> gitweb would need to know to disable it or modify the policy
>>> accordingly.
>> 
>> I propose CSP support _in addition to_ and not replacing $prevent_xss
>> (which would be nice to have more fine-grained control over).
>> 
>> Well while we can whitelist HTML fragment from README.html or render
>> README.md / README.rs / README.pod etc. instead of blocking it like gitweb
>> currently does if $prevent_xss is enabled I don't think it would be
>> feasible to do the same for text/html 'blob_plain' pages. 
>> 
>> Serving HTML pages etc. from 'blob_plain' view with path_info links
>> is quite useful feature; this way one can use gitweb as a cheap and easy
>> way to deploy web pages
> 
> Yes.
> 
>> and web apps;
> 
> Probably not: the browser features needed to make a nontrivial web app
> are probably the same ones that are dangerous to other web apps.

"Deploying" with gitweb doesn't allow for server-side scripting, so it
is "web apps" only as far as there can be web application done entirely
on client-side: HTML or HTML5 + JavaScript.  Well, there is demo of a
game played in HTML5+JavaScript played entirely in URL bar ;-)

With CSP you would be restricted to prerequisites (web page itself,
scripts, stylesheets, images) to be also hosted/deployed via gitweb.

What features would non server-side nontrivial web app need that would
be dangerous to other web apps?

>> or just test results of development.
>> CSP would serve this purpose well; current $prevent_xss behavior of
>> serving as attachment (forcing download) or serving them as text/plain
>> as e.g. GitHub does simply remove this feature.
> 
> CSP is not intended to be used by itself as a sandbox although it might
> almost work for the purpose. It would be more appropriate to set up a
> wildcard virtual host and appropriate rewrite rules to expose each
> repository at a different DNS name and take advantage of the usual
> same-origin policy.

Could this virtualhost + DNS + same-origin sandboxing be used for gitweb?
If not, then perhaps it is better solution in other cases, but not for
gitweb.


P.S. I don't know how difficult implementing CSP support for gitweb would
be, given that gitweb is quite configurable wrt. external resources it
uses: $javascript, @stylesheets, various *logo variables...

-- 
Jakub Narebski
Poland

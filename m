From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: Implementing CSP (Content Security Policy) for gitweb in the
 future
Date: Wed, 08 Jun 2011 10:31:10 -0700
Message-ID: <4DEFB1DE.7070102@eaglescrag.net>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com> <201106051533.51735.jnareb@gmail.com> <1307292370.23564.10.camel@localhost> <201106081227.19495.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMbB-0003dp-CD
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab1FHRbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:31:16 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:57185 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab1FHRbP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:31:15 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p58HVAPU017568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 10:31:10 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <201106081227.19495.jnareb@gmail.com>
X-Enigmail-Version: 1.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Wed, 08 Jun 2011 10:31:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175410>

On 06/08/2011 03:27 AM, Jakub Narebski wrote:
> On Sun 5 June 2011 Matt McCutchen wrote:
>> On Sun 2011-06-05 at 15:33 +0200 Jakub Narebski wrote:
>>> On Sun 5 July 2011 Matt McCutchen wrote:
>>>> On Sun 2011-06-05 at 11:03 +0200 Jakub Narebski wrote:
>>>
>>>>> In the future however it might be better solution for gitweb to implement
>>>>> (as an option) support for CSP (Content Security Policy) which IIRC did
>>>>> not exists in 2009 in addition to current $prevent_xss.
>>>>
>>>> Sure. CSP is not a substitute for designing to prevent harmful HTML
>>>> injection but a mitigation for some of its worst effects in case some
>>>> injection points are overlooked. There's no reason not to enable it by
>>>> default with $prevent_xss though third parties adding functionality to
>>>> gitweb would need to know to disable it or modify the policy
>>>> accordingly.
>>>
>>> I propose CSP support _in addition to_ and not replacing $prevent_xss
>>> (which would be nice to have more fine-grained control over).
>>>
>>> Well while we can whitelist HTML fragment from README.html or render
>>> README.md / README.rs / README.pod etc. instead of blocking it like gitweb
>>> currently does if $prevent_xss is enabled I don't think it would be
>>> feasible to do the same for text/html 'blob_plain' pages. 
>>>
>>> Serving HTML pages etc. from 'blob_plain' view with path_info links
>>> is quite useful feature; this way one can use gitweb as a cheap and easy
>>> way to deploy web pages
>>
>> Yes.
>>
>>> and web apps;
>>
>> Probably not: the browser features needed to make a nontrivial web app
>> are probably the same ones that are dangerous to other web apps.
> 
> "Deploying" with gitweb doesn't allow for server-side scripting, so it
> is "web apps" only as far as there can be web application done entirely
> on client-side: HTML or HTML5 + JavaScript.  Well, there is demo of a
> game played in HTML5+JavaScript played entirely in URL bar ;-)
> 
> With CSP you would be restricted to prerequisites (web page itself,
> scripts, stylesheets, images) to be also hosted/deployed via gitweb.
> 
> What features would non server-side nontrivial web app need that would
> be dangerous to other web apps?
> 
>>> or just test results of development.
>>> CSP would serve this purpose well; current $prevent_xss behavior of
>>> serving as attachment (forcing download) or serving them as text/plain
>>> as e.g. GitHub does simply remove this feature.
>>
>> CSP is not intended to be used by itself as a sandbox although it might
>> almost work for the purpose. It would be more appropriate to set up a
>> wildcard virtual host and appropriate rewrite rules to expose each
>> repository at a different DNS name and take advantage of the usual
>> same-origin policy.
> 
> Could this virtualhost + DNS + same-origin sandboxing be used for gitweb?
> If not, then perhaps it is better solution in other cases, but not for
> gitweb.
> 
> 
> P.S. I don't know how difficult implementing CSP support for gitweb would
> be, given that gitweb is quite configurable wrt. external resources it
> uses: $javascript, @stylesheets, various *logo variables...
> 

The long and the short of it is, until browsers other than
Mozilla/Firefox support CSP, it's a dead standard and we shouldn't spend
any time on it.  There are few enough resources on gitweb as it is to be
tilting at windmills.

- John 'Warthog9' Hawley

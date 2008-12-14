From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on pathinfo-style project URLs
Date: Mon, 15 Dec 2008 00:39:57 +0100
Message-ID: <200812150039.58797.jnareb@gmail.com>
References: <1229195421.3943.8.camel@mattlaptop2.local> <cb7bb73a0812131423h1f629ec1n9e8eacd657a4901@mail.gmail.com> <1229217235.3360.13.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0aX-0002iI-Jb
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYLNXkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbYLNXkL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:40:11 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:38534 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYLNXkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:40:09 -0500
Received: by ewy10 with SMTP id 10so2739794ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 15:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WJMWU6HAEDmhUJxwvTJ9NfbzBoLai8PgRk/v+95vH2c=;
        b=vN8hpOdAg0wkoee9TtSz4OLTpCLofq6mlUBki00QJL/XPwHIgCt/6OWt3s5im89X8u
         gnhPoNgaUmi5g5ZsP3GTlApBOCc+BmPY1sPml+ZLQCzLLWyYE7jo1RInPeFUxsKt+JTU
         zuAjF0mpuc8qlteKyVPZJ0CTV45vP4ZrEs9mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bMcjdrITFG2jeULBEE7s9zluYCDp/+QEmWFaYxIdiA2EdZKomt7mHwhFQ/7hsEZgxL
         85UYN4QzM5NLQ60d1JE8nEfg7ohVuwWF8iVnvePLya1RymEo8QqWYzdF4CGE7qgyFiS1
         9S2Ob+CGDz2YSBnhDmFrqLBBqVFwZMma4RTz0=
Received: by 10.210.78.7 with SMTP id a7mr3736357ebb.13.1229298007120;
        Sun, 14 Dec 2008 15:40:07 -0800 (PST)
Received: from ?192.168.1.11? (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id b36sm8898652ika.3.2008.12.14.15.40.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 15:40:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1229217235.3360.13.camel@mattlaptop2.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103107>

On Sun, 14 Dec 2008, Matt McCutchen wrote:
> On Sat, 2008-12-13 at 23:23 +0100, Giuseppe Bilotta wrote:
>> On Sat, Dec 13, 2008 at 10:47 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> Matt McCutchen <matt@mattmccutchen.net> writes:
>>>
>>>> My Web site uses pathinfo mode and some rewrite magic to show the gitweb
>>>> interface at the URL of the real repository directory (which users also
>>>> pull from).  In this case, it's desirable to end generated links to the
>>>> project in a trailing slash so the Web server doesn't have to redirect
>>>> the client to add the slash.  This patch adds a second element to the
>>>> "pathinfo" feature configuration to control the trailing slash.
>>>>
>>>> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
[...]
>>>
>>> Errr... I see that it adds trailing slash only for project-only
>>> path_info links, but the commit message was not entirely clear for me.
>> 
>> If indeed the additional / is only asked for in summary view, I think
>> there's no need for a feature toggle, we can always put it there. If
>> not, I'm really curious about seeing the rewrite rules (they might
>> also be worth adding to the gitweb documentation as examples of 'power
>> usage').
> 
> The trailing slash is used only when the URL refers to a project with no
> appended parameters (i.e., summary view), because the URL refers to the
> real git dir on disk (hence, pulling from the same URL) and it plays
> nicer with the Web server configuration to have the trailing slash.

It would be nice to have in commit message that we want to have
trailing slash in the cases where URL can correspond to filesystem
path.

But there are two cases: 
 * http://example.com/ corresponding to $projectroot on filesystem,
   and giving projects_list in gitweb
 * http://example.com/project.git/ corresponding to project.git dir
   on filesystem, and giving project summary view in gitweb.

> I was wary about changing the default behavior, but if you and Jakub
> both think it's OK, that's great.

Now I'm not so sure... but I guess the performance cost would be
negligible, and I'm not sure if it would be worth slight complication
in the code (and configuration).

> I was thinking of proposing the addition of some info about my setup,
> including the rewrite rules, to the documentation.  Maybe we could do
> that after dealing with the patches.

Do you plan updating "Webserver configuration" section in 
gitweb/README? 

BTW. could you please check if the $my_uri and $my_link need to be set
in gitweb config for your configuration, or did some of Giuseppe's
path_info improvements took care of that, and it is no longer needed?

-- 
Jakub Narebski
Poland

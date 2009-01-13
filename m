From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [BUG/RFH] gitweb: Trouble with ref markers being hyperlinks because of illegally nested links
Date: Mon, 12 Jan 2009 19:59:24 -0500
Message-ID: <cb7bb73a0901121659h7277c074ia73786b15d66b804@mail.gmail.com>
References: <200901120215.13668.jnareb@gmail.com>
	 <cb7bb73a0901111859q3a166d92k5176b27af2c4d256@mail.gmail.com>
	 <200901130113.54517.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXeD-0002Yb-RO
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbZAMA72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZAMA71
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:59:27 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:60222 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZAMA71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:59:27 -0500
Received: by ewy10 with SMTP id 10so11816087ewy.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 16:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NUZaew44fyiGj5zwjhex+XU4Su96WSToO7t/343gU2c=;
        b=N8+ppGPwEQnfLAZUNgsldtFEii2CVcScsRI6XDdxmgOYyX9x7jRKmkyUIy9t58QNKX
         lGZPpqJTvh0EuP7nskFuHDZUX+VifqPJljMYl7BTuNVmNuvN4zbnVi1v0Rn7VD9NaPWD
         5Om8mljAcLEdXMhtcsWN4o17GW2/e62Ey4Y9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OqwdxyzeVBcdYA/Aavc3++1lmMQ7lQIaeVFKrAgau1JM8dFvR8brZbxpDoZkUiJjXk
         YUuv0pdfVTvNmsNVEg221GZFp0bbXonNNeDE00/2ISTy7ThSGmxv8rBMawNfQk8KjehO
         RGw9wT75py6ymqHi3agTcfBRE5AyoV16QBu7g=
Received: by 10.210.111.4 with SMTP id j4mr3250863ebc.170.1231808364983;
        Mon, 12 Jan 2009 16:59:24 -0800 (PST)
Received: by 10.210.57.20 with HTTP; Mon, 12 Jan 2009 16:59:24 -0800 (PST)
In-Reply-To: <200901130113.54517.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105430>

On Mon, Jan 12, 2009 at 7:13 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 12 Jan 2009, Giuseppe Bilotta wrote:
>> On Sun, Jan 11, 2009 at 8:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
>> > I see possible the following alternate solutions:
>> >  * Ignore this issue (e.g. if it does not affect modern browsers)
>>
>> That would be my current choice until we find a better solution.
>
> By the way, how common this error is? Could you check if _your_ web
> browser (Firefox, Internet Explorer, Opera, Konqueror, Safari, Chrome)
> does show this bug or not, please?

Opera works fine (no display or functionality anomaly). That makes
sense, since I was the one who submitted the patch 8-D. Konqueror
3.5.9 does the ugly thing instead.

Notice that nested links are actually valid *XML*. Indeed, I asked on
www-style and they suggested leaving the problem as-is, serving as
html+xml which is what we do.

>> >  * Revert 4afbaef (we lose feature, but how often used is it?)
>> >  * Always use quirks mode, or check browser and use quirks mode if it
>> >    would break layout
>> >  * Use extra divs and links and CSS positioning to make layout which
>> >    looks like current one, and behaves as current one, but is more
>> >    complicated.
>>
>> I'm asking on #html, hopefully I'll get some interesting idea to try for this.
>
> I have found _a_ solution. Perhaps not the best one, but it works.
> And IMHO gives / can give even better visual.
>
> Current version (line wrapped for better visibility):
>  <div class="header">
>  <a class="title" href="...">GIT 1.6.1
>  <span class="refs">
>    <span class="tag indirect" title="tags/v1.6.1">
>    <a href="...">v1.6.1</a>
>    </span>
>  </span>
>  </a>
>  </div>
>
> Current CSS (relevant part):
>  a.title {
>        display: block;
>        padding: 6px 8px;
>  }
>
> Current rendering:
>  -----------------------------------------------------------
>  |_GIT 1.6.1_ []                                           |
>  -----------------------------------------------------------
>  __v1.6.1__
>
>
> Proposed code (line wrapped for better visibility, with CSS embedded,
> which would change in final version of course). Only parts of style
> related to positioning are shown.
>  <div class="header">
>  <a href="..." style="float: left; margin: 6px 1px 6px 8px;">GIT 1.6.1</a>
>  <div style="float: left; margin: 6px 1px;">
>    <span class="refs">
>      <span class="tag indirect" title="tags/v1.6.1">
>      <a href="...">v1.6.1</a>
>      </span>
>    </span>
>  </div>
>  <a href="..." style="display: block; padding: 6px 8px;">&nbsp;</a>
>  </div>
>
> Rendering with proposed code:
>  -----------------------------------------------------------
>  _|_GIT 1.6.1_ [_v1.6.1_]                                 |_
>  -----------------------------------------------------------
>
> I guess that instead of additional DIV element, we could use DIV for
> .refs, or use "float: right" style with SPAN element. I have not
> checked if other variations works: this one does.
>
> What do you think?

The float thing was the second suggestion I was given on www-style.
Can you provide a patch I can apply to my tree for testing to see how
it comes up?


-- 
Giuseppe "Oblomov" Bilotta

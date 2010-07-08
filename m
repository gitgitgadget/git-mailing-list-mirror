From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb.css
Date: Thu, 8 Jul 2010 21:25:58 +0200
Message-ID: <201007082125.59544.jnareb@gmail.com>
References: <19509.15171.909921.769184@winooski.ccs.neu.edu> <201007082049.23550.jnareb@gmail.com> <19510.8063.606085.233114@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:26:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwjo-0002gu-28
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758520Ab0GHT0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:26:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57892 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106Ab0GHT0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:26:17 -0400
Received: by bwz1 with SMTP id 1so633859bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eSYKVJpGME+oCf4nmMee6BqkWOAPtSn8eYUB5Gj2hl8=;
        b=QyqJ/M8Sh9RNKCUQzrbINW4FNnSO9sqhY4m1bNb5dbu47HbxkFB8B8MBNJMsL6WxWk
         qSGrFWLVlJ0wk/E6O2i2YAQ1nsXG5ybvGJwpcH7bI41uKRfA8RU/fTDhA20OCg6uCKri
         08hi0iM5SJKSxi19ZvjSfF9Z2EXKhMxW77BNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UvKypbuMO+vPUq627Vw+5j0VV3Zg9I9QkcFzpttHhxrvPyajiBFlIDOTrwcxZEf+5n
         kuHQr2GIF5t+4yyUPdjWSGaDbcNVhuOMZ/dQLmLKomJ7/vClcmTwxt3lfl/cBA7Cwz9j
         zeBoC/foesQHTf3Y3UvfzJ2iDcVUghzFhQLn4=
Received: by 10.204.83.194 with SMTP id g2mr6661981bkl.48.1278617170680;
        Thu, 08 Jul 2010 12:26:10 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id o20sm101476bkw.3.2010.07.08.12.26.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 12:26:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <19510.8063.606085.233114@winooski.ccs.neu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150600>

On Thu, 8 July 2010, Eli Barzilay wrote:
> On Jul 8 Jakub Narebski wrote:

>>>> [...]
>>>> I'd rather not add 'gitweb' class (or similar) to every element just
>>>> to have common style for all links tables table header cells 
>>>> table cells.
>>> 
>>> Why not add just a <div class=".gitweb"> container for all gitweb
>>> content then have css for ".gitweb foo" for anything you want?
>> 
>> First I dislike this solution.
> 
> I don't like it either -- but having similar problems in the past it
> looked like the most convenient way to deal with such problems.
> (Specifically it doesn't require changing all elements in the page.)

I like the variant described below significantly more, even if it is
similar.

>> Second similar solution would be beter namely consistent division
>> of page into gitweb_header gitweb_body and gitweb_footer moving
>> style of 'body' to gitweb_* and 'table' etc. to '.gitweb_body
>> table'. The problem is with the way CSS is structured currently: I
>> had problems with some elements losing their margin and some
>> elements having double margin.
> 
> This is similar enough that I don't see any difference :)
> 
> As for the `gitweb_header' and `gitweb_footer' -- do you mean the user
> included files? If so it doesn't sounds like something that is
> needed since users can do any formatting that they want there 
> including using some of the gitweb classes. Another point to consider
> here: I found it convenient that the header/footer are included as is 
> we have a bunch of stuff in the header -- and our footer is "</div>" 
> so wrapping them with some div will break this use.

No, what I meant here is that the structure of gitweb page should look
like the following, in pseudocode:

  <body>

  [% GITWEB_SITE_HEADER %]

  <div class="gitweb_header"> <!-- or page_header -->
  breadcrumbs
  logo, search box
  perhaps navigation menu and subnavigation menu
  </div>

  [% if ($action eq 'project_list') HOME_TEXT %]

  <div class="gitweb_body"> 

  ...

  </div>

  <div class="gitweb_footer">
  stuff generated by git_footer_html()
  </div>

  [% GITWEB_SITE_FOOTER %]

  <script src="static/gitweb.js"></script> <!-- if needed -->

  </body>

-- 
Jakub Narebski
Poland

From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v5 4/6] builtin/verify-tag: replace name argument with
 sha1
Date: Wed, 6 Apr 2016 23:38:45 -0400
Message-ID: <20160407033844.GB17848@LykOS>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
 <1459872449-7537-5-git-send-email-santiago@nyu.edu>
 <xmqqa8l6zoqc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 05:38:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao0mZ-0001jY-01
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 05:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbcDGDis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 23:38:48 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34996 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcDGDir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 23:38:47 -0400
Received: by mail-qk0-f194.google.com with SMTP id s190so2672586qke.2
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rNMqiVU6RQpCSE0lH7MS2y+uHyBgSwPzOUiwUorBgSk=;
        b=fe9XgYWzD8rAwYElBD0eQknrwGUShxKBLwENB7SPd56STYvJsFja0tsXaoSfUNaH/R
         HnaXDp4qo/IIKl80akBxreopD6iw5zEhT9mBR2qU7kDb/7kIYLKM3/TmO3P0zr26hnsH
         4oBaUJAHf3qaghVZ5ZELJlk2eLbLljUkMDMHWobX8jxcz7UBhxndbOazuQQayGnzXIZv
         TCpLCXXsGjvRSR5wCjlG4/Wg0vwUd8rVVzBVjEXgvcahsjOqviKTQI1CNMibkJg+3k9U
         kASGJrcjl02hUuLBs20wKWWHXdg5kQpQ+oKni+dBEnLUtzKRW+Awo+RGK6pDFZAPt0pi
         UuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNMqiVU6RQpCSE0lH7MS2y+uHyBgSwPzOUiwUorBgSk=;
        b=GSVnEUHBawXOXFjTEPNgOub9zqzvTjenrn66wx1a6m81hpXrzf9u8990GprsDOlHax
         YmWUXSJureUPvGBAn8z5+nwdrF8Lilu+2SbVibSZn6z1CGTQ6dtSwEBm+A/j7ANgD9/n
         2472Lma3uX7kz2AbDtT5QRr7s9hVKCYPDWDYWUIt/pZjQ3vVpIBTu5ofBbY4174YJleP
         dm3U/YVzZFF7/KDjuZFdY1bBJ+aYpPvhQ2ZEIRbQU7Bvwf6r9R0Xq0mZ9QRCOqtVJW1K
         m4k5Tvdcpqo8yS0UJmG3Ka5DIq3czxYvW7uu9o3A5KQXt9Tje3I1PeBRIk47Qpg1utmz
         hBXA==
X-Gm-Message-State: AD7BkJKF3Yul0HqmqOJxm07txi8GpsznCCqhDTkQpYX8YyNESq8cAZXnMCqA6O+7KyEn54Zm
X-Received: by 10.55.23.68 with SMTP id i65mr830296qkh.74.1460000326311;
        Wed, 06 Apr 2016 20:38:46 -0700 (PDT)
Received: from LykOS ([12.11.110.3])
        by smtp.gmail.com with ESMTPSA id a90sm2682753qka.4.2016.04.06.20.38.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 20:38:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqa8l6zoqc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290903>

> >  	type = sha1_object_info(sha1, NULL);
> >  	if (type != OBJ_TAG)
> >  		return error("%s: cannot verify a non-tag object of type %s.",
> > -				name, typename(type));
> > +				hex_sha1, typename(type));
> 
> So, if I said
> 
>     $ git verify-tag master
> 
> the code used to take "master" from argv[], fed it to verify_tag()
> as parameter 'name', turned it to the object name of the commit,
> noticed that it is not a tag, and complained that "master: cannot verify".
> 
> With this rewrite, the same invocation would cause "master" to be
> turned into the object name, which is passed to verify_tag() and the
> complaint is an overlong
> 
>     76bece327f490cb344b95ae8f869cbeb89a4d20b: cannot verify a non-tag object of type commit
> 
> That does not sound like a good change at all.

Yep, I agree. At least I believe that we can do better in terms of user
feedback.

> 
> If you want to support a future caller of a libified version of
> verify_tag() that has a raw object name but not the original name,
> I'd suggest to make this function keep parameter 'name' while adding
> the new parameter 'sha1'.  Then, the error reporting may become:
> 
> 	return error("%s: cannot verify a non-tag object of type '%s'",
> 		     name ? name : sha1_to_hex(sha1), typename(type));
> 

Yep, I'll do some experimenting with this.

> and the output would still be useful.  Further improvements may be
> 
>  - rename 'name' to 'report_name' to clarify that the parameter is
>    only used for reporting, and that the tag object to verify is
>    always identified by the new 'sha1' parameter.

This seems to be fundamental. As it was suggested before, making it
clear that name is only for feedback purposes is really necessary. 

> 
>  - use find_unique_abbrev() to shorten the fallback name displayed in
>  the error message.

I think we can do both. Let me try this out. 

Would you suggest having these changes in a separate patch?


Thanks!
-Santiago.

From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v13 00/11] Add interpret-trailers builtin
Date: Sun, 17 Aug 2014 00:25:25 +0200
Message-ID: <CAP8UFD2ta53VyEo=5AQ=W+EF4sOKzRUT=Ew26oz0CKHg9A7PXQ@mail.gmail.com>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 00:25:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XImPi-0005G0-J1
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 00:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbaHPWZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 18:25:26 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:52064 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaHPWZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 18:25:26 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so4733741igq.15
        for <git@vger.kernel.org>; Sat, 16 Aug 2014 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RZS6DCR7vPpO/+Kmhk8O6HoXWNSpvSfw6Ssg7y85I+A=;
        b=1A/dNRlseIDqKnR8f1GKwQFHPJbPuoean6z+pQrhK15v+mJ5y2r11HEg/HWZRDRv7w
         a7BUhUvw94rostOpzjKjRj4sdAtRnIyIWPR5HhwPO0j5wHdl2tE6zc1VBvapz3AcZj3f
         07GvplcuELMHqv6AOSXoaOthChbi/HCQcwo27Dt5xb+/nu0Jad9+7uyfO9YJQMTMIjbw
         DK7OAUFjJSm/ot/QmBVlrg3q3d+JIXIKfdQfY1jsn4N+rUs3lBofNJa3/uWItvJ6LokN
         McwYwFGspL7np6/tRlP6eLijDsrL/5coN71QasK8eNdYM8Do6+W/c4ZOm4QtGEKlTqos
         Tusw==
X-Received: by 10.50.49.8 with SMTP id q8mr66052454ign.40.1408227925399; Sat,
 16 Aug 2014 15:25:25 -0700 (PDT)
Received: by 10.50.212.3 with HTTP; Sat, 16 Aug 2014 15:25:25 -0700 (PDT)
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255344>

On Sat, Aug 16, 2014 at 6:06 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
>
> 3) Changes since version 12, thanks to Jakub, Michael, Johan and Junio:
>
> * "end" and "start" values for "trailer.<token>.where" have been
>   implemented
> * "end" has been made the default value for "where", but this default
>   value can be changed using the new "trailer.where" config
>   variable
> * "addIfDifferentNeighbor" is now the default value for "ifexists",
>   but this default can be changed using the new "trailer.ifexists"
>   config variable
> * the new "trailer.ifmissing" can be used to change the default value
>   for "ifmissing" (which is "add")
> * by default the only separator is ':', this can be changed by using
>   the new "trailer.separators" config variable
> * only the configured separators (or just ':' by default) are used for
>   both input parsing and output printing; the only exception is that
>   '=' is always accepted as separator when parsing
>   "--trailer '<token><sep><value>'" command line arguments, for
>   compatibility with other git commands
> * 14 tests have been added

I forgot the following change:

* "overwrite" value for "ifexists" option has been replaced with
  "replace" value; when used with "where = after" or
  "where = before", "replace" does the same thing as "overwrite"
  did; but when used with "where = end" or "where = start", the
  new trailer appears at the end or the start of the existing trailers,
  instead of where the replaced trailer was

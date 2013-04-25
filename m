From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Hold an 'unsigned long' chunk of the sha1 in obj_hash
Date: Fri, 26 Apr 2013 04:12:10 +0700
Message-ID: <CACsJy8CJO+rLHgMo+F_fsWBj7Nm0rbpVNHTLXbi7u60+rT0OJQ@mail.gmail.com>
References: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:12:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVTTC-0003f0-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759224Ab3DYVMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:12:42 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:63843 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080Ab3DYVMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:12:41 -0400
Received: by mail-ob0-f173.google.com with SMTP id xn12so2982722obc.32
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yC6Ajrhr0G0mQUOPDlT+Hr53gbwz+0qalcKN0LWekPM=;
        b=NT/Q9/Z3mSF7fnDChZ7KGn55fC8DyByp5hzZfEHrzP83n5D0M8bIt0MhEoUjbrEzb1
         twjPrjFBTkziBLx/VUwi/NNvhzjpEH5uz8T3PUEHghgjGnLrYF+CewaIrg5BGauZYD3x
         YVE9p53iTCmaxwJwwRsWYfuauz24n2g7MEVExaikWimS1oSEcfHJGNOT/HeXzDbv9J/2
         U/FDTzyZ+4f9uWtRtUhI5Hk9ZrcTEbLx+0Hgg9Sl0eg/5NKj67gOIvZNFBALD5O5JxzU
         0T5LArqWN8o8lCGN6xgh7hykbqq2SChjIApW0u+oMwGJw+oCSM0I+QzoHq1uRjAux7jT
         Rxig==
X-Received: by 10.60.135.234 with SMTP id pv10mr21272657oeb.101.1366924361228;
 Thu, 25 Apr 2013 14:12:41 -0700 (PDT)
Received: by 10.76.142.74 with HTTP; Thu, 25 Apr 2013 14:12:10 -0700 (PDT)
In-Reply-To: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222450>

On Fri, Apr 26, 2013 at 1:04 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> So we take a slightly different approach, and trade some memory for
> better cache locality.  Namely, we change the hash table slots to
> contain
>
>   struct object *obj;
>   unsigned long sha1prefix;
>
> We use this new 'sha1prefix' field to store the first part of the
> object's sha1, from which its hash table slot is computed.

Clever. I went a similar road before. But I put the whole 20-byte
sha-1 in obj_hash, which makes obj_hash even bigger and less
cache-friendly.
--
Duy

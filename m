From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/13] Use current output for "git repack"
Date: Sat, 24 Aug 2013 21:15:53 -0700
Message-ID: <20130825041553.GC2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1172777180.1090921.1377329200690.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 06:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRkD-0005Q0-6R
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 06:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab3HYEP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 00:15:59 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38583 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab3HYEP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 00:15:58 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so2165279pdj.11
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=n2gLLh5jUrBeXOPzHEhxUjqC71gIXzIONGnm7pd4aKM=;
        b=yZ84FE2/ku96RRCB2grU8afbtD/o4zacaa9G/ocFbR3+31QU9QB2dyRX98+8LbSEMA
         sI9B5MTK9AfHKrxDWJ2MjZzKt+bEDBZfUw8Wj8oPElJpYS7eq3T/X4fh75KQnMXc2G+o
         mdOFT6d20SPO5hSzBn1mY9nIn8WVw1V9kn0QlUUVf7h2iPBd6PxLh9fhDhnQRBQRn7r6
         KvWANGkKLdUhaW5PRVX8MEmGpybq4vmpCV0gBIp3r10D1mMuuYWXK6UML2/U4Wm4pUrI
         ktvEe0eF3kllpYGa6VOJMUDRIRbI43mt+DVquEWOFHCxXC+oPyWnixSiTiYytDggNwxX
         9qsQ==
X-Received: by 10.68.36.38 with SMTP id n6mr8289992pbj.15.1377404158292;
        Sat, 24 Aug 2013 21:15:58 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ai6sm11161984pad.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 21:15:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1172777180.1090921.1377329200690.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232910>

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3203,14 +3203,11 @@ To put the loose objects into a pack, just run git repack:
>  
>  ------------------------------------------------
>  $ git repack
[...]
> -Total 6020, written 6020 (delta 4070), reused 0 (delta 0)
> -Pack pack-3e54ad29d5b2e05838c75df582c65257b8d08e1c created.
> +Total 6020 (delta 4070), reused 0 (delta 0)

Sure.  I wonder if there should be some text to replace the output
that mentions the pack being created, though.  E.g.:

>  ------------------------------------------------
>  
>  You can then run

	Total 6020 (delta 4070), reused 0 (delta 0)
	------------------------------------------------

	This creates a single "pack file" in .git/objects/pack/ containing
	all currently unpacked objects.  You can then run

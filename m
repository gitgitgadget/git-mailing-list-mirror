From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Mon, 20 Mar 2006 13:17:55 +0100
Message-ID: <e5bfff550603200417h71c083f9saebbf1fe6b21076c@mail.gmail.com>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
	 <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
	 <e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
	 <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550603191340u466d3551t8a95c3808eb977c1@mail.gmail.com>
	 <7vmzfmm35t.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550603192231k7843a741xbf14394bc5e4c57@mail.gmail.com>
	 <7v8xr5ld38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 13:18:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLJKi-0002CE-OL
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 13:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWCTMR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 07:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWCTMR5
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 07:17:57 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:7872 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932245AbWCTMR5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 07:17:57 -0500
Received: by wproxy.gmail.com with SMTP id i30so983480wra
        for <git@vger.kernel.org>; Mon, 20 Mar 2006 04:17:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P3v9hISGjG3O3hy1DF84m1lGdy7qNwRgB6XA6L9acrqmMZrJhgbAHTIyisyDvSfkyp4qqUohH6uIny56gzFAH9YEjKHMPjmymxkZhB4fogqVuwtaEzRh1bW8dxifQGvHKaRTe6BogGi789FrjIiWglF9QfYCnQxc7zbrFsm8GJ4=
Received: by 10.65.235.19 with SMTP id m19mr315882qbr;
        Mon, 20 Mar 2006 04:17:56 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Mon, 20 Mar 2006 04:17:52 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xr5ld38.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17751>

On 3/20/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> >> This is totally untested, but maybe something like this?
> >
> > It works for me. Just some trailing white space warning when applying.
>
> The change only removes the error message without changing any
> other logic, so if that works for you, I wonder if leaving
> things as they are is a better option than doing anything short
> of implementing an AI that tries to pattern-match the "allegedly
> corrupt file" with "sorry no such page found" in many natural
> languages.
>
> My test patch makes it impossible to track down the real
> breakage when an HTTP-reachable repository _does_ have a corrupt
> object.
>
> So how about doing this instead?
>
> -- >8 --

> +               fprintf(stderr,
> +"Some loose object were found to be corrupt, but they might be just\n"
> +"a false '404 Not Found' error message sent with incorrect HTTP\n"
> +"status code.  Suggest running git fsck-objects.\n");
> +       }
>         return rc;
>  }
>

I think it's better, read more correct.

Could be a real corrupted file or just a false 404, so better a
warning then an error message and also better a warning then nothing.

Marco

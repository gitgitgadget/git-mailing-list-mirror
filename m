From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Sat, 6 Sep 2008 22:50:39 -0400
Message-ID: <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
	 <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
	 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
	 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 04:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcANb-0006YQ-3A
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 04:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYIGCum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Sep 2008 22:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYIGCul
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 22:50:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:7821 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbYIGCul convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2008 22:50:41 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1051864wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 19:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cd1DI+tiIHIxKbeymJjTAO+ghHO6HlMj3pyy3576dc0=;
        b=KdEq7FqxZccUH9zk6rGAAO112f25kpJp8tDB6j31+7YIFhsGmLPm1CkS4f2dNLcs3o
         FYeJ8lZ+luJm0UV27E4aFcdoeRqeUMe0bpOcu0RwHXvuJLyU5UWO6LrM2Liv/BH2yVKg
         rdRDNWEuuBrGlS4JO7TLa3bWvhZ4Y57DsTbjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SQV+HmyPyZ1b95bGKtc0xViDfrb5JYAI2BjKQKqUWszFdWmqa93oIDYEpkSq6JnXc0
         /uaOzCppz3gvwnQHyV1MdTHJsgEnx5HxiRdvKiCDc6VKSxdJILl8yyt4m38h9IEGVSHb
         Mf7IFbtVUryL1wskEhb6n7aRdlnHn2fwR/F/Q=
Received: by 10.70.126.8 with SMTP id y8mr16803859wxc.64.1220755839586;
        Sat, 06 Sep 2008 19:50:39 -0700 (PDT)
Received: by 10.70.55.6 with HTTP; Sat, 6 Sep 2008 19:50:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95105>

On 9/6/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>  I'm starting to hate zlib. I actually spent almost a week trying to =
clean
>  up the zlib source code and make it something that gcc can compile i=
nto
>  clean code, but the fact is, zlib isn't amenable to that. The whole =
"shift
>  <n> bits in from the buffer" approach means that there is no way to =
make
>  zlib generate good code unless you are an insanely competent assembl=
y
>  hacker or have tons of registers to keep all the temporaries live in=
=2E
>
>  Now, I still do think that all my reasons for choosing zlib were pre=
tty
>  solid (it's a well-tested piece of code and it is _everywhere_ and e=
asy to
>  use), but boy do I wish there had been alternatives.

Some alternative algorithms are here...
http://cs.fit.edu/~mmahoney/compression
It is possible to beat zlib by 2x at the cost of CPU time and memory.

Of course switching to these algorithms would involve a lot of testing
and benchmarking. I'm also not sure how PAQ would fare on lots of
small git objects instead of large files.

Turning a 500MB packfile into a 250MB has lots of advantages in IO
reduction so it is worth some CPU/memory to create it.

You can even win 50'000=80 for a better algorithm.
http://prize.hutter1.net/

--=20
Jon Smirl
jonsmirl@gmail.com

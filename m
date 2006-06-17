From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 23:31:38 -0400
Message-ID: <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
	 <1150513943.29738.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Keith Packard" <keithp@keithp.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 05:31:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrRXL-0004rA-OF
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 05:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWFQDbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 23:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWFQDbj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 23:31:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:51385 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750756AbWFQDbj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 23:31:39 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1284626nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 20:31:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RMf+aBIJ82uGvHsxwbUr1b7KkhqCzR3ioARVnq2gyQLnKRwGavcxACRLlv1DtJRU0rIWemL4RDyV8GCwdvZJ8T2KdPQlgM7cFpl5bfCS/tlTAi7Dhe09g+iZvtMrTXNkLwii9lqm9UsYcnQ88Y6RJC8LlP2JRGRRFEtbdT5eYuk=
Received: by 10.36.104.10 with SMTP id b10mr36818nzc;
        Fri, 16 Jun 2006 20:31:38 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 20:31:38 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1150513943.29738.15.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21996>

On 6/16/06, Pavel Roskin <proski@gnu.org> wrote:
> Hi, Jon!
>
> On Fri, 2006-06-16 at 23:02 -0400, Jon Smirl wrote:
> > My parsecvs job died after 5 hours of CPU time. Does this tell you anything?
> >
> > Pack pack-e28915a5ea09143a9139e84e24534ed888bf1c45 created
> >
> > Error: branch cycle
> > *** glibc detected *** parsecvs: munmap_chunk(): invalid pointer: 0x0a820198 ***
> > *** glibc detected *** parsecvs: corrupted double-linked list: 0x45b1e158 ***
>
> Obviously, memory corruption.  Valgrind is likely to help, but it may
> take 50 hours rather than 5.  It may still be worth it.  Make sure to
> use the latest version of Valgrind and compile parsecvs without
> optimization with full debug information.  If you can get debug info for
> libc, install it (on Fedora: "yum install glibc-debuginfo").
>
> > /lib/libc.so.6(__libc_free+0x179)[0x45a554f0]
> > parsecvs[0x804dec8]
>
> You see, even some libc symbols can be found, but parsecvs is opaque.
> That's why debug information is useful.  Make sure to keep the sources
> around for debugging.

Parsecvs was compiled '-O2 -g' why didn't it decode the addresses to symbols?

The 'Error: branch cycle' message was critical, the app was in the
process of doing exit clean up with the link list error was found. If
the list is linked in a circle it is likely that the routine freeing
it corrupted memory. So the real error is why did I get 'Error: branch
cycle'.

> --
> Regards,
> Pavel Roskin
>
>


-- 
Jon Smirl
jonsmirl@gmail.com

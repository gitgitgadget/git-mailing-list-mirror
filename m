From: Takis <panagiotis.issaris@gmail.com>
Subject: Re: [BUG] make test (t3600-rm.sh) fails
Date: Fri, 24 Mar 2006 11:45:39 +0100
Message-ID: <df33fe7c0603240245o516095b5m@mail.gmail.com>
References: <4423C681.3000302@issaris.org>
	 <7v7j6k16g2.fsf@assigned-by-dhcp.cox.net>
Reply-To: takis@issaris.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 11:45:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMjnh-0003Qv-W6
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 11:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWCXKpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 05:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422845AbWCXKpm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 05:45:42 -0500
Received: from nproxy.gmail.com ([64.233.182.186]:14870 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422849AbWCXKpm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 05:45:42 -0500
Received: by nproxy.gmail.com with SMTP id n15so541392nfc
        for <git@vger.kernel.org>; Fri, 24 Mar 2006 02:45:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OY/XI/eezhbabfoG64irGrdanu4J6fiW40oBL0f0zgq2Bm+saFZ9WFaMHElXeFF/FIhmHD+kRFPsKLYEhBB9BPS6sQjHfexvMcYVplK40LL6NXLffqDI+BLMKiC1Kcy5SUFCdv9fnBmuv+nHr5NiwTSwL7Axa0AzVsycKivksZ4=
Received: by 10.48.163.5 with SMTP id l5mr210212nfe;
        Fri, 24 Mar 2006 02:45:40 -0800 (PST)
Received: by 10.49.1.8 with HTTP; Fri, 24 Mar 2006 02:45:39 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v7j6k16g2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17907>

Hi,

2006/3/24, Junio C Hamano <junkio@cox.net>:
> Panagiotis Issaris <takis@issaris.org> writes:
>
> > * FAIL 9: Test that "git-rm -f" fails if its rm fails
> >        git-rm -f baz
> >...
> > My system:
> > Ubuntu 5.10 aka Breezy
> > Linux issaris 2.6.15.060103 #1 Tue Jan 3 14:27:55 CET 2006 i686 GNU/Linux
>
> I wonder what your system shows if you run:
>
>         $ cd t && sh -x t3600-rm.sh -i -v

Here's the output:

takis@issaris:/usr/local/src/git$ cd t && sh -x t3600-rm.sh -i -v
...
*   ok 8: Test that "git-rm -f" succeeds with embedded space, tab, or
newline characters.
+ test y = y
+ chmod u-w .
+ test_expect_failure 'Test that "git-rm -f" fails if its rm fails'
'git-rm -f baz'
+ test 2 = 2
+ say 'expecting failure: git-rm -f baz'
+ echo '* expecting failure: git-rm -f baz'
* expecting failure: git-rm -f baz
+ test_run_ 'git-rm -f baz'
+ eval 'git-rm -f baz'
++ git-rm -f baz
rm: cannot remove `baz': Permission denied
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 '!=' 0 ']'
+ test_failure_ 'Test that "git-rm -f" fails if its rm fails' 'git-rm -f baz'
++ expr 8 + 1
+ test_count=9
++ expr 0 + 1
+ test_failure=1
+ say 'FAIL 9: Test that "git-rm -f" fails if its rm fails'
+ echo '* FAIL 9: Test that "git-rm -f" fails if its rm fails'
* FAIL 9: Test that "git-rm -f" fails if its rm fails
+ shift
+ echo 'git-rm -f baz'
+ sed -e 's/^/  /'
        git-rm -f baz
+ test t = ''
+ trap - exit
+ exit 1

> The test #9 makes the test directory unwritable before trying to
> unlink a file there, and git-rm runs rm without -f which should
> make it fail.  So either your "chmod u-w ." is broken, you are
> running it as root and defeating "chmod u-w .", or you have a
> broken rm that does not report failure with its exit status.
I am running it as fakeroot, as part of the "dpkg-buildpackage
-rfakeroot -uc -us -b"
command for building Debian packages. Would this be the problem (the fakeroot)?

With friendly regards,
Takis

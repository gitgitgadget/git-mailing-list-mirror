From: bob <kranki@mac.com>
Subject: Re: git packs
Date: Sun, 11 Nov 2007 21:53:36 -0500
Message-ID: <B298202C-3D54-498D-A348-0338914FBA46@mac.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <alpine.LFD.0.9999.0711100011150.21255@xanadu.home> <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com> <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org> <B20E1D71-BCDB-4189-952F-3B809A342870@mac.com> <alpine.LFD.0.9999.0711102331270.21255@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 03:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrPRG-0002DA-0F
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 03:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbXKLCx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 21:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754320AbXKLCx7
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 21:53:59 -0500
Received: from smtpoutm.mac.com ([17.148.16.77]:64466 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291AbXKLCx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 21:53:58 -0500
Received: from mac.com (asmtp001-s [10.150.69.64])
	by smtpoutm.mac.com (Xserve/smtpout014/MantshX 4.0) with ESMTP id lAC2ri7R010913;
	Sun, 11 Nov 2007 18:53:44 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp001/MantshX 4.0) with ESMTP id lAC2rdGY024509
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Nov 2007 18:53:40 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711102331270.21255@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64555>

I applied the patch and these commands:

cd rmwHtmlOld
rm -fr .git
git init
git config core.compression 0
git add .

I then got the same error as before, "Bus error".  Rats!

Then I modified your script since I do not have seq or
your test-genrandom.  I substituted:

dd count=XX  if=/dev/random of=file_$i

where XX is adjusted to meet dd's requirements.  Also,
I found after searching for a while, that the following
works just like your seq command:

xyzzy="1 2 3 4"
for i in $xyzzy
do
...
done

Your script then ran flawlessly.

I looked through index-pack.c some more, but it is
very hard to figure it out without doing a lot of research
since there doesn't seem to be anything that describes
the layout of a pack.  The link towards the end of the user's
manual doesn't work for me.

The difference between your test and my data is that
instead of having a few large files, I have 11,500 files
of varying sizes.  On average though, the file size is
about 370k.

HTH

On Nov 10, 2007, at 11:35 PM, Nicolas Pitre wrote:

> On Sat, 10 Nov 2007, bob wrote:
>
>> I will try a few things and see if I can get a script put together
>> that generates the inflate problem.  The data that I am
>> using is a backup of my original repository.  So, I can
>> play all that I want.  But it would be a lot easier if I
>> could just generate some files using dd or something.
>
> Please see the patch I just posted to the list.  That should fix your
> problem.  I even included a small script to create a repository
> confirming the problem and allowing to test the fix.
>
>
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

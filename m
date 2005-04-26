From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 12:11:49 -0400
Message-ID: <426E6845.2030008@tmr.com>
References: <426DA7B5.2080204@timesys.com><Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030507050100080507000405"
Cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 18:16:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQSiK-00011s-Vq
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDZQTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 12:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDZQQr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 12:16:47 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:54155 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261637AbVDZQMW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 12:12:22 -0400
Received: from [127.0.0.1] (oddball.prodigy.com [127.0.0.1])
	by oddball.prodigy.com (8.11.6/8.11.6) with ESMTP id j3QGBtV07815;
	Tue, 26 Apr 2005 12:12:00 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
Newsgroups: mail.linux-kernel
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507050100080507000405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Mon, 25 Apr 2005, Mike Taht wrote:
> 
>>One difference is probably - mercurial appears to be using zlib's 
>>*default* compression of 6....
>>
>>using zlib compression of 9 really impacts git...
> 
> 
> I agree that it will hurt for big changes, but since I really do believe 
> that most changes are just a couple of files, I don't believe it matters 
> for those. 
> 
> I forget what the exact numbers were, but I did some timings on plain
> "gzip", and it basically said that doing gzip on a medium-sized file was
> not that different for -6 and -9. Why? Because most of the overhead was
> elsewhere ;)

Certainly not different in the overall numbers, but after trying gzip on 
a bunch of various source files on 32 bit CPUs, from P-II to Xeon, it 
looks as if after 7 the cpu jumps about 40% to 8, and another 30% to 9. 
Neither 8 nor 9 give any significant size improvement (< 2%).

Again, this is 32 bit CPU and just the gzip component, reading from 
stdin and writing to stdout which I hope gets directory operations out 
of the time measure.

Sample attached.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

--------------030507050100080507000405
Content-Type: text/plain;
 name="ziptime.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ziptime.log"

Comp level 1

real	0m1.972s
user	0m1.790s
sys	0m0.098s
-rw-r--r--    1 davidsen  1792050 Apr 26 11:56 dummy.tar.gz
Comp level 2

real	0m2.021s
user	0m1.858s
sys	0m0.097s
-rw-r--r--    1 davidsen  1737227 Apr 26 11:56 dummy.tar.gz
Comp level 3

real	0m2.296s
user	0m2.124s
sys	0m0.095s
-rw-r--r--    1 davidsen  1697644 Apr 26 11:56 dummy.tar.gz
Comp level 4

real	0m2.604s
user	0m2.423s
sys	0m0.099s
-rw-r--r--    1 davidsen  1593207 Apr 26 11:56 dummy.tar.gz
Comp level 5

real	0m3.181s
user	0m3.003s
sys	0m0.087s
-rw-r--r--    1 davidsen  1549050 Apr 26 11:56 dummy.tar.gz
Comp level 6

real	0m4.185s
user	0m3.965s
sys	0m0.089s
-rw-r--r--    1 davidsen  1531866 Apr 26 11:56 dummy.tar.gz
Comp level 7

real	0m4.889s
user	0m4.642s
sys	0m0.096s
-rw-r--r--    1 davidsen  1524350 Apr 26 11:57 dummy.tar.gz
Comp level 8

real	0m7.836s
user	0m7.532s
sys	0m0.085s
-rw-r--r--    1 davidsen  1513763 Apr 26 11:57 dummy.tar.gz
Comp level 9

real	0m11.020s
user	0m10.616s
sys	0m0.092s
-rw-r--r--    1 davidsen  1511970 Apr 26 11:57 dummy.tar.gz

--------------030507050100080507000405--


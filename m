From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Problem with pack
Date: Sat, 26 Aug 2006 20:49:36 +0200
Organization: ARCES - =?ISO-8859-15?Q?Universit=E0_di_Bologna?=
Message-ID: <44F097C0.1000109@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 26 20:50:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH3EF-0000Zu-K2
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 20:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWHZSto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWHZSto
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 14:49:44 -0400
Received: from arces.unibo.it ([137.204.143.6]:27116 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S932126AbWHZSto (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 14:49:44 -0400
Received: from [192.168.143.223] (mars-fw.arces.unibo.it [137.204.143.2])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k7QJ2cg2019208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 21:02:40 +0200
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_50,USER_IN_WHITELIST 
	autolearn=unavailable version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1733/Sat Aug 26 15:08:57 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26062>

>
> Junio C Hamano <junkio@cox.net> writes:
>
> > Earlier you said "unpack-objects <$that-pack.pack" fails with
> > "error code -3 in inflate..."  What exact error do you get?
> > I am guessing that it is get_data() which says:
> >
> > 	"inflate returned %d\n"
> >
> > (side note: we should not say \n there).
> > ...
> > This pattern appears practically everywhere...
> > ...  I've been
> > wondering if it is possible for inflate to eat some input but
> > that was not enough to produce one byte of output, and what [it]
> > would return in such a case...
>
> I do not think this fear does not apply to this particular case;
> return value -3 is Z_DATA_ERROR, so the deflated stream is
> corrupt.
>
> > So there are only a few ways you can get that error message.
> > ...
>
> I just realized there is another not so inplausible explanation.
>
> When the problematic pack was made on the mothership,
> csum-file.c::sha1write_compressed() gave the data for the base
> object to zlib, an alpha particle hit a memory cell that
> contained zlib output buffer (resulting in a corrupt deflated
> stream in variable "out"), and sha1write() wrote it out while
> computing the right checksum.
>
> Is the memory on your mothership reliable (I do not want to make
> this message sound like one on the kernel list, but memtest86
> might be in order)?
>   
For sure you can never say, but so far I have never had any problem with 
that machine nor I had any after this incident...

Sergio
>
>
>
>   

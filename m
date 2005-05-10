From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Tue, 10 May 2005 07:52:54 -0700
Message-ID: <4280CAC6.4000805@zytor.com>
References: <20050510021105.53984.qmail@web41213.mail.yahoo.com>	<428038D0.5000706@zytor.com> <7vpsvzpolp.fsf@assigned-by-dhcp.cox.net> <4280C883.6080209@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Mark Allen <mrallen1@yahoo.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:46:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVVzi-0001GO-Bq
	for gcvg-git@gmane.org; Tue, 10 May 2005 16:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVEJOxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 10:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVEJOxN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 10:53:13 -0400
Received: from terminus.zytor.com ([209.128.68.124]:14309 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261651AbVEJOxJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 10:53:09 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4AEqs91019438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 May 2005 07:52:55 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4280C883.6080209@zytor.com>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:
> Junio C Hamano wrote:
> 
>>
>> HPA> This is just plain WRONG.  st.st_size is longer than long on many
>> HPA> architectures, including Linux/i386.
>>
>> HPA> The easiest way to deal with it is to #include <inttypes.h>, use %jd
>> HPA> and cast it to (intmax_t).  That is, however, a C99-ism.
>>
>> Actually the easiest way is to stop reporting the size.  Nobody
>> else in core GIT reports st.st_size in their error messages.
>>
>> Although I agree with you that what you say about the size of
>> st.st_size is correct, in GIT world view, apparently "unsigned
>> long" is big enough to hold st.st_size all over the code.  Would
>> you recommend tackling that assumption as well?
> 
> Probably.  It's an off_t.
> 

That being said, there are also a whole bunch of assumptions that any 
object can be memory-mapped *plus* fit uncompressed in memory... that's 
obviously not going to be the case for large files.

On the other hand, one has to start cleaning up somewhere...

	-hpa

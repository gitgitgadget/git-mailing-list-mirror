From: Christian <crich-ml@beronet.com>
Subject: Re: git push over http is very dangerous
Date: Fri, 20 Apr 2007 20:37:33 +0200
Message-ID: <4629086D.5010302@beronet.com>
References: <462394AC.303@beronet.com>	<Pine.LNX.4.64.0704161212140.5473@woody.linux-foundation.org> <7vk5wcrt5m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080003080409010903020807"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 20:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hey0B-0008L5-1A
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 20:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767184AbXDTSic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767185AbXDTSic
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 14:38:32 -0400
Received: from beronet.com ([80.244.243.34]:4156 "EHLO mail.beronet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767184AbXDTSib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 14:38:31 -0400
Received: from mail.beronet.com (localhost [127.0.0.1])
	by mail.beronet.com (Postfix) with ESMTP id 2DC4C510C3B;
	Fri, 20 Apr 2007 20:47:03 +0200 (CEST)
Received: from [172.20.5.5] (pd956852e.dip0.t-ipconnect.de [217.86.133.46])
	by mail.beronet.com (Postfix) with ESMTP id 9EA12510C35;
	Fri, 20 Apr 2007 20:47:02 +0200 (CEST)
User-Agent: Icedove 1.5.0.7 (X11/20061013)
In-Reply-To: <7vk5wcrt5m.fsf@assigned-by-dhcp.cox.net>
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on m24s12.beronet.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45120>

This is a multi-part message in MIME format.
--------------080003080409010903020807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi Junio,

today i got access to the machine with the corrupt git blobs, attached 
are the requested files, but there was no error, so i've not attached 
the output from stderr.

I hope this helps.


Christian



Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>   
>> On Mon, 16 Apr 2007, Christian wrote:
>>     
>>> We have moved from CVS to git in the beginning of last week, all went well
>>> until this weekend. This weekend one developer wanted to push some of his
>>> local modifications, unfortunately during the push his http connection seemed
>>> to have broken or so. Unfortunately git does not prove if the push went well.
>>> Therefore our repository was broken this morning.
>>>       
>> I have to agree: pushing over http really is dangerous.
>> ...
>>     
>
> Just for the record, I do not think anybody during that #git
> discussion actually proved that http-push was the culprit.  It
> is a very plausible working conjecture, though.
>
> I do not know if Nick is still using his own http-push (or if he
> is still using git for that matter), but just in case he may
> still be interested, I am cc'ing this message to him.
>
>   
>> I'd also love it if somebody were to actually look into making 
>> http-pushing a bit safer. It really needs somebody who cares about it, or 
>> it should likely just be disabled entirely (perhaps with a config option 
>> that you have to enable to get it - so that people *realize* that it's not 
>> maintained and not really supported).
>>     
>
> I think the fetch side does the right thing, more or less, by
> downloading to a temporary file and using move_temp_to_file()
> after validating the SHA-1 matches.  I haven't followed the push
> side but as we do not have a single line of code on the
> receiving end, I would not be surprised if there is no error
> checking beyond HTTP response code would give the pushing end.
>
> I would still love to see the corrupt loose object to see how it
> is broken.
>
> Christian, can you do this with the first (i.e. older) commit
> that is broken, and tar up these 7 files for the initial round
> of inspection?
>
> 	$ git cat-file commit $commit >commit-text 2>commit-error
>         $ git ls-tree ${commit} >toplevel-tree 2>toplevel-tree-error
>         $ git ls-tree -r -t ${commit} >whole-tree 2>whole-tree-error
> 	$ cp .git/objects/cd/1aac1a43cfdac07118240f75c0ba7662eb8140 corrupt
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   


--------------080003080409010903020807
Content-Type: application/gzip;
 name="git-debug.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-debug.tar.gz"

H4sIACQIKUYAA+2Xz4scRRTHx5szCF4E9WTfkrDsbP149UuMKEZM1F2ISwgeJNSPV7vDzkxP
enpiDgoSEfwLvOhBwYviVQlevOS28QeLsojiIYqgCCriQQhi9Q66mSVkMTgbDPU5THcz/d5U
1ffV+9b4cjDo1YtYVWXVmhOEEiIBWmTK3uvOPSWSMka4ZDS9z4iSrYLMa0DXMhnXtiqKVlWW
9Y3e2+/7/yl+qn+N5+c3u/30B8X26E8VZP0PhLpCLGj0AZwWkUkdDSgfwQSluYYgDaU8CCIY
gu6MbIXDuoiSo0TtovJgPTWaRyQhRGLBmAg8KiMFdfbv9yVRREXhOAEdZfTeRe24iaiQEx5D
CuYgUHXspF4vq2J1MsKqODVOHw816/6IHY02ykH38LAc4pGHi1QfimgGQIoFwgjpTKu4xpsI
7SxjtYaFq+zQrxeHBnac0hwqylis1/XowaWltV7dHZxYPbbSLau15mlp56lzq5X7b3h+vezj
YlMF8/uNf9P/FWPN/hcc8v4/COpy1Mdz2J9nCeyjPwVCd/u/FI3/M5n1PxCm0hSuX7rU1o3R
WgDRxGttCEdQAcDYGL02lClNNXCp248df3TlicdXO9cGK4GR29TdwSPjYJFFCCygkMI5gwjC
cgjUt5ftBsZeH2ejnSGWU4OM6mAkCx4E98Ia5jQipV6mJE6Ff6K7gzJM9iQRUlLllJKEgeHS
Gc4kodIo76MToEOaRLBhdwjdpP0w2H6yhplEnjJphGPIlOUOBQPUyCRjydisS+6nQzDR0fYz
aQjj7iCl66YD1EwOqom2SmkZtXSR2WACFYE5leZEQYHDSIgRtG1D6PpyGHtrHQLNfih2PBlD
1IYHB8YBa+bBHWiezDKtKzo0QnHOkOv2dWIVKm94GrohNBggInkrSU7tmDA0ZWISXRLZtEPV
O4fVeCY4GM0UE1KD4oEbb6ik2kaGHoVLV+XS2ngj2r2h70/C7MpFSiO1TKUySAmdcl4R7oF4
bkOauTBJCkNBtjcGZ6amOh6hb1IoIaYpNPWKptrjGqMmCjVoTSRL5QXpPCKIB+9TGt4e14Ft
YDWciSbKWWEIk1RKBSEgpmpCnZYr1bSIBpWILh12mujQi/E2sfGbxpdVNRnNt7M1/R9u4P9U
8V3/V03/T38ASe7/B8H5NxaOPLl8KukTmybA6clfVj759KnNp7cX+Bb3x/3Jd1795uzPr219
+NJnZ+5W31/EB/yFd39bvryyvHn5xCuHP7/r/fEL25s/XPz1ze+ufHT6z5+ufjG+9NWl1p33
VEdffu7qfe/d+/UHz/5+7OML377949b921+efvGPt16/o3V0sXvlVk89k8lkMplMJpPJZDKZ
TCaTyWQymduWvwA4CVIAACgAAA==
--------------080003080409010903020807--

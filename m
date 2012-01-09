From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH][RFC] git on Mac OS and precomposed unicode
Date: Mon, 09 Jan 2012 21:47:07 +0100
Message-ID: <4F0B524B.8090203@web.de>
References: <201201072059.19103.tboegi@web.de> <7vboqehpxm.fsf@alter.siamese.dyndns.org> <4F0B196B.8010904@web.de> <7vty44eksp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 21:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkM87-0001QT-PU
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 21:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab2AIUri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 15:47:38 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48945 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab2AIUrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 15:47:37 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id A68611A8843B1
	for <git@vger.kernel.org>; Mon,  9 Jan 2012 21:47:20 +0100 (CET)
Received: from [192.168.209.16] ([194.22.188.61]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MDxWR-1Rvevp16HH-00H4Dp; Mon, 09 Jan 2012 21:47:19
 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vty44eksp.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:XaW3p53yTxeKKcLIQYf7J9G+w9d42IS7dbkJXlycUVJ
 UhWL5LsGK1q+vVqaFtPtRWljBkzy/WuIJd17UIceKKJl2oS0Vq
 DYlkb9g9aYHyaE0jkf91FbSpADm9rkrrtnfnXkbjdKmNtsuQ8e
 B9PvziVibih7Y0ioZLtYsBog0iB+fvveHucLlltEgNNOSKbbC3
 eUM+hlADS1Gk9+0rC7c+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188190>

On 01/09/2012 08:29 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen<tboegi@web.de>  writes:
>
>> On 08.01.12 03:46, Junio C Hamano wrote:
>> ...
>>> That also sounds sensible, but...
>>>
>>>> This is done in git.c by calling argv_precompose() for all command=
s
>>>> except "git commit".
>>>
>>> ... I think it generally is a bad idea to say "all except foo". The=
re may
>>> be a reason why "foo" happens to be special in today's code, but wh=
o says
>>> there won't be another command "bar" that shares the same reason wi=
th
>>> "foo" to be treated specially? Or depending on the options, perhaps=
 some
>>> codepath of "foo" may not want the special casing and want to go th=
rough
>>> the argv_precompose(), no?
>>>
>>> After all, "git commit -- pathspec" will have to get the pathspec f=
rom the
>>> command line,...
>>
>> Thanks Junio for catching this.
>> I added a new test case as well as fixed the code.
>
> I think you are sidestepping the real issue I raised, which is:
>
>      What is the reason why you do not want to feed the precompose he=
lper
>      with some arguments to 'git commit', while it is OK to pass all
>      arguments to other commands through precomposition?
>
> I admit it was my fault that I did not spell it out clearly in my
> response.
>
> I understand that arguments other than pathspec and revs could be lef=
t in
> decomposed form, but is there any harm in canonicalizing any and all
> command line parameters given in decomposed form consistently into
> precomposed form? What problem are you trying to solve by special cas=
ing
> "git commit"? That is the real question to be answered, as there may =
be
> other commands some of whose arguments may not want to be canonicaliz=
ed
> due to the same reason, but you simply overlooked them. When other pe=
ople
> need to fix that oversight, they need a clearly written criterion wha=
t
> kind of arguments should not be fixed and why.
>
> And the reason cannot be a desire to pass the value to "--message"
> argument intact [*1*]; it is not like osx cannot handle text in
> precomposed form, right?

The short answer for treating "git commit" special:
   The test suite didn't pass any more. (t4201-shortlog.sh)
   This seems more and more to be a bad excuse...
The long answer:
   I have to look into that more deeply.

Thanks for your replies.
/Torsten

     (And yes, Mac OS can handle precomposed unicode (at least the
      western european code points))

[snip]

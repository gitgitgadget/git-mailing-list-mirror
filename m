From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Tue, 01 Mar 2011 12:57:20 +0100
Message-ID: <4D6CDF20.3020701@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 13:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuOG1-0003LJ-Ts
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 13:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab1CAMAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 07:00:45 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59293 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752847Ab1CAMAo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 07:00:44 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 257D220A64;
	Tue,  1 Mar 2011 07:00:44 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 01 Mar 2011 07:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Y3X0/yCxcqEdpLWiI8yYIWhFsHs=; b=uc2snDeIgZNmtAy9HnfD5THLhGLb8tom3X2D1FPH0dLCFcKBQoiMIKihspPZCZRzOpg1VJwuOwYl1MFonf9NOJa4EMtusOGe+5Ip+5HEooeQzmr07dXFVReiswnJM4F9SW373m8IUD86hJum5fW+EyydUUehr1VDR1e42V6NAi8=
X-Sasl-enc: BwrMQUw6GP2VJ/r7qrYVcLjk1o66bIfUW+YB8vg4dMxP 1298980843
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8E8524490BB;
	Tue,  1 Mar 2011 07:00:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168215>

Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 12:50:
> On Tue, Mar 1, 2011 at 6:16 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 12:13:
>>> 2011/3/1 Michael J Gruber <git@drmicha.warpmail.net>:
>>>> Introduce a leading ':' as the notation for repo-wide pathspecs.
>>>>
>>>> This is in line with our treeish:path notation which defaults to
>>>> repowide paths.
>>>>
>>>> Heck: Even ':./path' works for pathspecs, and I have no clue why!
>>>
>>> If you are going to turn pathspecs into something more complex,
>>> reserve room for future extension. I have negative pathspecs that can
>>> utilize it.
>>>
>>> I take it, from now on people must refer file name ':foo' as './:foo'
>>> with your patch?
>>
>> That is up for discussion, of course. When discussing a new approach for
>> file mode dependent attributes, I was hoping to get through with
>> symlink:path, and did not. But it was decided that something like
>> :symlink:path would be good enough, in the sense of avoiding enough
>> possible conflicts. That made me hope that :path would be, too.
> 
> Take me down. I'm going crazy now.

What is crazy about that?

HEAD:path is repo wide already

:path is also, after this patch

Note that when you have a file named :foo now, it can already be
mistaken as the blob at "foo" in the index (or HEAD) already, in places
where rev:path makes sense. So you would need quotation before my patch.

> Another, less cryptic choice, is to make these special notations
> separate from true pathspecs. For example, instead of ":foo" we can
> say "--root foo". get_pathspec() and friends can be updated to remove
> --root and rewrite the next pathspec. Extensibility is obvious.

Only that some commands have "--root" as an option, and even if not,
it's just too much to type.

> Problems are plenty:
> 
>  - may be confused with command line options without "--" as separator
> ("-:" on the other hand is not, but looks weird)
>  - '-' is not a reserved letter, the same as ':'
>  - ...
> 
>> (I have not checked for interaction of those two, which are in flight.)
>>
>> I would think that file names like ":foo" are problematic on msys
>> already, so in a sense they are no-no already, and free to take as
>> special notation.
> 
> Back to what I'm writing above, '-' may be chosen over ':' even
> without separation because UNIXers are trained that '-' is usually the
> beginning of something special, I suppose most of us would go with
> ./-blah for file names.

If ":" is crazy which is in line with our current notation, then how do
you call "-"? "-" is

- a short option identifier
- a negation (attributes)
- a notation for stdin

Michael

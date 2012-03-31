From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 31 Mar 2012 11:49:59 -0500
Message-ID: <4F7735B7.1050707@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bo Chen <chen@chenirvine.org>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 18:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE1VC-00029W-Fi
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 18:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab2CaQuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 12:50:05 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54869 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab2CaQuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 12:50:03 -0400
Received: by obbtb18 with SMTP id tb18so321641obb.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=DZeMaBvO3WxSbvruG+zI+mrlyQX1NoHV7LwqMG5xHic=;
        b=nV3kcRU3B4oZGMXmOrBcB93DcbHcuSayk9or/fvD22grSh/L30M7IVVLRHUUEySI8P
         0eNRr3oetFamhhyiaXsuLLzVjBDUEzvr2v4KJKUc95cqC+9g7vzbLinaqBsWkI/EBGG0
         5Xb2FsGLdvVSSBznrkMp4XaB2aNAvBkwRhe82xcnWmy9HQuyabaD26NZHlAQmt/Uu3iK
         jUWoJFalPgz6aENAGarNdc9vTiZTVEp0znEgSge2hCS85yNL7C8b3LW/fQikEBaNiXir
         aJjmXk4B6uMuOooDykyhD1zZqXgTZ2zMSUsgiIEIDiiRCsHZuSFS6rjnYZHltnw32iAC
         UcaA==
Received: by 10.60.22.70 with SMTP id b6mr3496882oef.5.1333212603166;
        Sat, 31 Mar 2012 09:50:03 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id uu10sm1051973obb.1.2012.03.31.09.50.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 09:50:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20120330203430.GB20376@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194456>

On 3/30/2012 3:34 PM, Jeff King wrote:
> On Fri, Mar 30, 2012 at 03:51:20PM -0400, Bo Chen wrote:
>
>> The sub-problems of "delta for large file" problem.
>>
>> 1 large file
>>
>> 1.1 text file (always delta well? need to be confirmed)
>
> ...But let's take a step back for a moment. Forget about whether a file
> is binary or not. Imagine you want to store a very large file in
> git.
>
> ...Nowadays, we stream large files directly into their own packfiles,
> and we have to pay the I/O only once (and the memory cost never). As
> a tradeoff, we no longer get delta compression of large objects.
> That's OK for some large objects, like movie files (which don't tend
> to delta well, anyway). But it's not for other objects, like virtual
> machine images, which do tend to delta well.
>
> So can we devise a solution which efficiently stores these
> delta-friendly objects, without losing the performance improvements
> we got with the stream-directly-to-packfile approach?
>

gitconfig or gitattributes could specify big-file handlers for 
filetypes.  It seems a bit ridiculous to expect git to autoconfigure 
big-file handlers for everything from gif's to vm-images.  In the case 
of vm-images you would need to read the "big-files" man-page and then 
configure your git for the "vm image handler" for whatever your vm-image 
wildcards are for those files.  For movie files you would also read the 
big-file man-page and configure "movie file 'x' big file handler' for 
whatever your movie file wildcards are.  Movie files and vm-images are 
very expectable (version control) but not very normative (source code 
management) so you need to configure those as needed.  More 
widely-tracked-by-the-public-at-large files like gif, png, etc, could be 
autoconfigured by git to used the correct big-file handler.

v/r,
neal

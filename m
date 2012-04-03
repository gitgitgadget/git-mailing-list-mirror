From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Tue, 03 Apr 2012 11:58:58 +0200
Message-ID: <4F7AC9E2.60203@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 11:59:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF0WE-0008RV-1A
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 11:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab2DCJ7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 05:59:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51150 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab2DCJ7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 05:59:11 -0400
Received: by eaaq12 with SMTP id q12so1127260eaa.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 02:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MDtSKDqrJnTsHVvVHwAjj8qyQnq/4aO0Gv+F6DcPNwY=;
        b=ApHjKif35fy27jiWfbsYGjk8vra4ys/ctdS6vfXd0JUD11A2zP6BWiOTQHvFuC0stj
         prOMDMSnG51c1ucFtYfcnRnhYfSHLiHbsSoYNPvjaRTPXty0+ZygaQjUyb+PwOlW/edG
         VfNSh7DBUUXzH8WoSelaO75s3Cnm9B9LemGvqDL7EJIx5AhrJUMJPZTmmbg67as3DKuR
         0MQxrPLjQ5X/ixPeYUJ8ohDOz1u2Ve8UXHyk4e7JIJ8NMzg0Zz4RZCvcTy7E4qFwBy+I
         jcjKKyqtzWcu8X4mJXwC60y6sPWJbMvyySliDHZuBOEQ91uie/Kupl+QsSVcA+rvmG0D
         zd7A==
Received: by 10.213.113.212 with SMTP id b20mr1032013ebq.80.1333447145905;
        Tue, 03 Apr 2012 02:59:05 -0700 (PDT)
Received: from [2.198.159.115] ([2.198.159.115])
        by mx.google.com with ESMTPS id n55sm72208167eef.6.2012.04.03.02.59.03
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 02:59:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <20120402210708.GA28926@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194610>

On 02/04/2012 23:07, Jeff King wrote:
>> gitattributes or gitconfig could configure the big-file handler for
>> specified files.  Known/supported filetypes like gif, png, zip, pdf,
>> etc., could be auto-configured by git.  Any
>> yet-unknown/yet-unsupported filetypes could be configured manually by
>> the user, e.g.
>> *.zgp=bigcontainer
> This is a tempting route (and one I've even suggested myself before),
> but I think ultimately it is a bad way to go. The problem is that
> splitting is only half of the equation. Once you have split contents,
> you have to use them intelligently, which means looking at the sha1s of
> each split chunk and discarding whole chunks as "the same" without even
> looking at the contents.
>
> Which means that it is very important that your chunking algorithm
> remain stable from version to version. A change in the algorithm is
> going to completely negate the benefits of chunking in the first place.
> So something configurable, or something that is not applied consistently
> (because it depends on each user's git config, or even on the specific
> version of a tool used) can end up being no help at all.
Isn't this the same with filters? The clean algorithms should remain 
stable from
version to version. Filters are often perceived as simpler, so that this 
stability seems easier to achieve, but it is not necessarily the case.
> Properly applied, I think a content-aware chunking algorithm could
> out-perform a generic one. But I think we need to first find out exactly
> how well the generic algorithm can perform. It may be "good enough"
> compared to the hassle that inconsistent application of a content-aware
> algorithm will cause.
Absolutely true, but why not giving freedom to the user to chose? Git 
could provide the bupsplit mechanism and at the same time have a means 
so that the user can plug in a different machinery for specific file 
types.  In this case, it is the user responsibility to do it right.

One could have a special 'filter' for splitting/unsplitting. Say

[splitfilter "XXX"]
     split = xxx
     unsplit = uxxx

xxx is given the file to split on stdin and returns on stdout a stream 
made of an index header and the concatenation of the parts in which the 
file should be split. For unsplitting uxxx is given on stdin the index 
and the concatenation of parts and returns on stdout the binary file.

bupsplit and bupunsplit could be built in, with other tools being user 
provided.  If the users gets them wrong it is ultimately his/her 
responsibility. In the end, the user is given even 'rm' isn't he/she? 
Git could provide a header file defining the index header format to help 
the coding of the alternative, more specific splitters. If people devise 
some of them that look promising, they can probably be collected in contrib.

Possibly, the index header could comprise starting positions for the 
various parts in the stream, but also 'names' for them. This would let 
reusing blob and tree objects to physically store the various parts. For 
bupsplit, names could be flat (e.g. sequence numbers like 0000, 0001). 
For files that are container, they could reflect the inner names. 
Perspectively, one could even devise specific diff tools for these 
'special' trees of split-object components. With this, when storing say 
a very large zip file in git, these tools could help saying things like 
'from version x to version y, only that specific part in the zip file 
has changed'.

Sergio

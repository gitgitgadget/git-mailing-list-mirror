From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 12:40:24 -0400
Message-ID: <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
	 <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
	 <20080501153457.GB11469@sigill.intra.peff.net>
	 <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com>
	 <20080501231427.GD21731@sigill.intra.peff.net>
	 <481CA742.4080909@tikalk.com>
	 <32541b130805031111r4cbea8e1l19c34ac05016a89b@mail.gmail.com>
	 <481D52CC.1030503@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ittay Dror" <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Mon May 05 18:41:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3ka-0007y6-Qz
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbYEEQk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbYEEQk1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:40:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:13934 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbYEEQk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:40:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so751051fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3mE5zJKMMEOfE9Ftql6+KskXR5HvWesVnrFzaqa0tJQ=;
        b=f72h2WqWphzneYjAGFq+bLF0fw9MoSulFdhihXEN5scqVxt0dxcDwDIGA3+9JtPyxWEM9lLvUC2J6vhtr2OUXV8iG77DdAlWli4kIKIGnXsb9x0tG6i/2/IvcpbBLaQQqqGChaSq7VnR0wcOCrPjg9UxtKKuW5G7WSpr8WHxJn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sNdfLGxQSoeH6pLu25AMFotXFNNQw8QKH0bb1FiGj0aZCMTdVYirnhJJivKpFyhsGOmO03Z87CLqxvGZwpF48q9G06pnnLLcY0uBCBVSQkerVX+jzBLfRZF+h3AFMaqobsT9Qz7kdPAUAx8eczZMS0iYWM8NdF4bytKP6ZgcXK8=
Received: by 10.82.135.7 with SMTP id i7mr582228bud.42.1210005625023;
        Mon, 05 May 2008 09:40:25 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Mon, 5 May 2008 09:40:24 -0700 (PDT)
In-Reply-To: <481D52CC.1030503@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81297>

On 5/4/08, Ittay Dror <ittayd@tikalk.com> wrote:
>  Avery Pennarun wrote:
> > In fact, as someone else pointed out, renaming a java file requires
> > you to modify the file anyhow, so having git auto-move the file to
> > another directory *still* wouldn't make it work any better.
>
> Sure it will, because otherwise I need to move it and still need to fix it.
> And there are many other file formats and languages where such a move will
> not require any change (I think it is funny that Java is a justification for
> not doing something for a tool primarily used by C people).

I mentioned Java because you mentioned you were working in java.

The particular problem with Java doesn't happen to C people.  Imagine,
for example, that I add a new file, lib/foo.c, to lib/lib.a (thus they
have to modify lib/Makefile), while someone else renames "lib" to
"bettername".

When I merge, if git would create bettername/foo.c (it currently
won't) and properly automerge bettername/Makefile (it will), then the
program would still compile correctly.  However this doesn't work in
Java: lib/foo.java would include the word "lib" in its contents (in
the namespace declaration) and so there's no way automatic merging
would have resulted in a version that compiles correctly.

So what I said isn't to *justify* git's behaviour, merely to point out
that in java's case, there seems to be no way to get fully automatic
merging that would work.  In C, this case would have worked, if only
git supported directory renames.

In neither case is it very much work to fix by hand, though :)

Have fun,

Avery

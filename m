From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A better approach to diffing and merging
Date: Mon, 01 Dec 2008 03:41:38 -0800 (PST)
Message-ID: <m3y6z0i0mu.fsf@localhost.localdomain>
References: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ian Clarke" <ian.clarke@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 12:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77B5-0000SK-4Q
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 12:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbYLALlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 06:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbYLALlm
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 06:41:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYLALll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 06:41:41 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2629895ugf.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 03:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=3Afwg67COL5TNS3gu0lo6AMCcXTvTnRNHWxTQnpfO88=;
        b=YCQ3DHiIq/YVB2JimagsuRFYlGKj7sjyY0CZgRQ4J4ktoR45MY9bp+0mmlp/OuGIsF
         EadBF7TDfBVOR4B0vuNeGviI1mXfce5ngKqC1+xn7bShJCcmFeAFbYL4LMdBCQhUUBeU
         ESw2ed7tqA+IYGfHSufVnth0r0MKsrBKeWbDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Qv9t4NLgbhkrtQVMzd3nqBS/yUGPl49emzbMscVTfZ7Dig0QWP+OGe3xz4WexjUrbf
         nAxpNngdRxZMFsji8XjkoN0BAG6o1KzhGCSy5k6RJMBw8oGR+Y+hcxEyoybwTDaVYtxW
         EjVOZaLZ6K6tCOsFCtM9zFJI5Xewtnmq8ki+A=
Received: by 10.67.119.8 with SMTP id w8mr2307395ugm.3.1228131699187;
        Mon, 01 Dec 2008 03:41:39 -0800 (PST)
Received: from localhost.localdomain (abwt156.neoplus.adsl.tpnet.pl [83.8.243.156])
        by mx.google.com with ESMTPS id s8sm4589478uge.18.2008.12.01.03.41.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 03:41:38 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB1Bf7P5008676;
	Mon, 1 Dec 2008 12:41:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB1BevB0008673;
	Mon, 1 Dec 2008 12:40:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102020>

"Ian Clarke" <ian.clarke@gmail.com> writes:

> Apologies if this is off-topic, but I recently had an idea for a
> better way to do diffs and merging which I thought may be of interest
> to those on this list.

[...]
> While I'm no merging expert, it seems that most merging algorithms do
> it on a line-by-line basis, treating source code as nothing but a list
> of lines of text.  It got me thinking, what if the merging algorithm
> understood the structure of the source code it is trying to merge?
> 
> So the idea is this:
> 
> Provide the merge algorithm with the grammar of the programming
> language, perhaps in the form of a Bison grammar file, or some other
> standardized way to represent a grammar.
> 
> The merge algorithm then uses this to parse the files to be diffed
> and/or merged into trees, and then the diff and merge are treated as
> operations on these trees.  These operations may include creating,
> deleting, or moving nodes or branches, renaming nodes, etc.  There has
> been quite a bit (pdf) of academic research on this topic, although I
> haven't yet found off-the-shelf code that will do what we need.

First, as Brian Dessent said it would be hard to generate parse tree
in the presence of compile-time configuration (using preprocessor
in C/C++, but in principle this applies to programs in any language;
not only you have to know conditionals, but also compile options).
And for dynamic languages you would have to take care about
self-modifying programs.

Second, from what I understand we have _good_, established algorithms
for merging sequences (which includes sequence of lines, or sequence
of words), and for merging special kinds of trees that are
representations of directory structure.  I haven't read link to
mentioned research, but I think that it is still unproven research,
and not something well established and well tested.

Third, it would require embedding knowledge about various programming
languages (including C, shell, Perl, TeX) and document formats
(including XML, HTML, AsciiDoc) in version control system...

> Still, it shouldn't be terribly hard to implement.

So, try to provide us with some proof-of-concept patches, then.
-- 
Jakub Narebski
Poland
ShadeHawk on #git

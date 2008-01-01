From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Tue, 1 Jan 2008 10:01:21 +0100
Message-ID: <e5bfff550801010101w9d32122l1d7d76f2813a2eca@mail.gmail.com>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
	 <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>
	 <7vodc77t0o.fsf@gitster.siamese.dyndns.org>
	 <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com>
	 <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org>
	 <20080101063616.GA21605@coredump.intra.peff.net>
	 <e5bfff550801010040k59c9608do1acb9da548620f85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 10:01:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9d0V-0005g2-64
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 10:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbYAAJBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 04:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYAAJBW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 04:01:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:52097 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbYAAJBW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 04:01:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4849425rvb.1
        for <git@vger.kernel.org>; Tue, 01 Jan 2008 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nLxIyADx8g9lT3vsiQzdfFeJNlPTpZM6Hf8v49TKGYI=;
        b=F+O5qnilQTHHekQLofhR/HCtrWY3ORsicGQQ0nIbGSYNtO4OjH3iCKTc6I0FepnLLrJN5tZS5kFRWRxRi+PIWLZqiAdRjdbdxVQgy3v/0a0GnxkD+TZTTKiaU0/hGIFdnruVWQbkYZYOyWGgxkKUsVe1G95PsUjfLtywevpnwZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ALyybAKv886DYn2IaaJvTBmzPt3RrWVsKXXfPrlZFt7UAF01ahVOzIy/QufgZiLVhBMPlGZ3iVfzXUl2vo0Wgg0pa+1Ay4I1CLazlXx5BqEunRjKqVhXbADl1ofP1zUFqamHX01aLDs49nTnJ7tUVKXMESJcs96XYEPF1JVOyNE=
Received: by 10.141.36.10 with SMTP id o10mr1301620rvj.176.1199178081294;
        Tue, 01 Jan 2008 01:01:21 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 1 Jan 2008 01:01:21 -0800 (PST)
In-Reply-To: <e5bfff550801010040k59c9608do1acb9da548620f85@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69434>

On Jan 1, 2008 9:40 AM, Marco Costalba <mcostalba@gmail.com> wrote:
> On Jan 1, 2008 7:36 AM, Jeff King <peff@peff.net> wrote:
> >
> > The packfile is noticeably larger (55M versus 40M)
>
> Well 55M versus 40M is _only_  27% of compression ratio. It means that
> the compression algorithm is not so fundamental because the data is
> already, how to say, well packaged.
>

I think zlib is a very good general purpose algorithm, but is main
strength is to give good final file sizes, it is mainly intended for
files that are seldom decompressed.

For the use we do in git IMHO it would seem appropriate to look for
algorithms used in the field of filesystem compression, where
decompression penalty is a design goal. I know very little about this
but I think among kernel people, expert and competent hackers should
not be difficult to find, given that compressed filesystem are around
from many years under linux/fs/ directory.

Marco

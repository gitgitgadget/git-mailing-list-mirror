From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git
 repository
Date: Tue, 24 Mar 2009 13:05:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
References: <49C8B159.2040600@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 13:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm5PU-0006MY-EC
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 13:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbZCXMFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 08:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbZCXMFj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 08:05:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:47187 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754173AbZCXMFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 08:05:38 -0400
Received: (qmail invoked by alias); 24 Mar 2009 12:05:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 24 Mar 2009 13:05:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IEstm+swIqtBkIciyl45vizqdzRgPGk2GJgfUpj
	QOuJgiRVpvdMBf
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49C8B159.2040600@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114455>

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to
answer with insults to the comments I offer, please stop reading this mail
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying
that I appreciate your work.

On Tue, 24 Mar 2009, Roel Kluin wrote:

> Maybe something like this is useful?
> ------------------------------>8-------------8<---------------------------------
> Add git-cget.sh: prints elements of C code in the git repository.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

I really like what this tries to do.

But there are some problems:

- the name is not expressive enough,

- the commit message is severely lacking (I had to apply it and run it to 
  find out what problem it tries to solve),

- it still uses dashed git commands,

- it might be better to put it into contrib/, otherwise it needs 
  documentation with examples, and tests,

- it misdetects functions: trying

	$ ./git-cget -f get_sha1.*

  shows this, amongst others:

-- snip --
// vi sha1_name.c +59
                return get_sha1_hex(hex, sha1) == 0;
        return found;
}

static int match_sha(unsigned len, const unsigned char *a, const unsigned 
char *b)
{
        do {
                if (*a != *b)
                        return 0;
                a++;
                b++;
                len -= 2;
        } while (len > 1);
        if (len)
                if ((*a ^ *b) & 0xf0)
                        return 0;
        return 1;
}
-- snap --

- maybe it would be nicer to integrate this into git grep itself?  Maybe 
  by allowing multi-line matches and default patterns, or pattern 
  templates?

Ciao,
Dscho

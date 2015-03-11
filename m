From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/10] Use a structure for object IDs.
Date: Wed, 11 Mar 2015 17:08:58 +0100
Message-ID: <5500689A.5090101@alum.mit.edu>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 17:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVjC8-0005Fe-KE
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 17:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbbCKQJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 12:09:12 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52845 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751056AbbCKQJK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 12:09:10 -0400
X-AuditID: 12074414-f797f6d000004084-6e-5500689e2f47
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.DC.16516.E9860055; Wed, 11 Mar 2015 12:09:02 -0400 (EDT)
Received: from [192.168.69.130] (p4FC960B5.dip0.t-ipconnect.de [79.201.96.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2BG8wK2013298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Mar 2015 12:09:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqDsvgyHUYP4JU4vZN7axWXRd6Way
	aOi9wmzxZO5dZovLe5ezWPy/N4/FonvKW0aLtpk/mCz6l3awOXB6LL/5l8lj56y77B5t08w8
	Hr7qYvc4dLiD0ePiJWWPz5vkAtijuG2SEkvKgjPT8/TtErgzbv/iLnioWnH92xrGBsZuuS5G
	Tg4JAROJ2SeOMEHYYhIX7q1n62Lk4hASuMwo0f3oGiOEc55JYvuj6WwgVbwC2hJ/djSA2SwC
	qhJNf1+zgthsAroSi3qawSaJCgRJvLz1lxGiXlDi5MwnLCC2iICXxPxHM1hBhjILLGCSeHz8
	JFhCWMBW4snsNrBmIQFfiZdnj7CD2JwCfhITWi+B1TAL6EnsuP6LFcKWl2jeOpt5AqPALCQ7
	ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkPgQ2cF45KTc
	IUYBDkYlHt4Zs/6HCLEmlhVX5h5ilORgUhLlDUhmCBXiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wrsjECjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBuzkdqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKvxxcBoBUnxAO1dANLOW1yQmAsUhWg9xago
	Jc67ASQhAJLIKM2DGwtLeq8YxYG+FOZdAlLFA0yYcN2vgAYzAQ1msQb6n7e4JBEhJdXAKGA/
	Z1f/07onxjOT7Pc5/qiq/BrBurPlbZbclTxDh59B9S+Yb9xZc/9J+iaxmZ+khL48 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265328>

On 03/08/2015 12:23 AM, brian m. carlson wrote:
> This is a patch series to convert some of the relevant uses of unsigned
> char [20] to struct object_id.
> 
> The goal of this series to improve type-checking in the codebase and to
> make it easier to move to a different hash function if the project
> decides to do that.  This series does not convert all of the codebase,
> but only parts.  I've dropped some of the patches from earlier (which no
> longer apply) and added others.
> 
> Certain parts of the code have to be converted before others to keep the
> patch sizes small, maintainable, and bisectable, so functions and
> structures that are used across the codebase (e.g. struct object) will
> be converted later.  Conversion has been done in a somewhat haphazard
> manner by converting modules with leaf functions and less commonly used
> structs first.
> 
> Since part of the goal is to ease a move to a different hash function if
> the project decides to do that, I've adopted Michael Haggerty's
> suggestion of using variables named "oid", naming the structure member
> "sha1", and using GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ as the constants.
> 
> I've been holding on to this series for a long time in hopes of
> converting more of the code before submitting, but realized that this
> deprived others of the ability to use the new structure and required me
> to rebase extremely frequently.
> [...]

I've added CC to several people who commented on v1.

I think this is a really interesting project and I hope that it works out.

In my opinion, the biggest risk (aside from the sheer amount of work
required) is the issue that was brought up on the mailing list when you
submitted v1 [1]: Converting an arbitrary (unsigned char *) to a (struct
object_id *) is not allowed, because the alignment requirements of the
latter might be stricter than those of the former. This means that if,
for example, we are reading some data from disk or from the network, and
we expect the 20 bytes starting with byte number 17 to be a SHA-1 in
binary format, we used to be able to do

    unsigned char *sha1 = buf + 17;

and use sha1 like any other SHA-1, without the need for any copying. But
we can't do the analogous

    struct object_id *oid = (struct object_id *)(buf + 17);

because the alignment is not necessarily correct. So in a pure "struct
object_id" world, I think we would be forced to change such code to

    struct object_id oid;
    hashcpy(oid.sha1, buf + 17);

This uses additional memory and introduces copying overhead. Also, the
lifetime of oid might exceed the scope of a function, so oid might have
to be allocated on the heap and later freed. This adds more
computational overhead, more memory overhead, and more programming
effort to get it all right.

So as much as I like the idea of wrapping SHA-1s in objects, I think it
would be a good idea to first make sure that we can all agree on a plan
for dealing with situations like this. I can think of the following
possibilities:

1. Maybe code that needs to handle SHA-1s with screwy alignment does not
exist, or maybe it does the copying anyway. I haven't actually checked.

2. Maybe somebody can prove that

       struct object_id *oid = (struct object_id *)(buf + 17);

   somehow *is* allowed by the C standard, or at least that it is
sufficiently portable for our purposes.

3. We accept the additional runtime costs and development effort for the
extra copies. To accept this approach, we would need some idea of which
areas of the code will be affected, and some estimate of how much
additional memory it would cost.

4. We continue to support working with SHA-1s declared to be (unsigned
char *) in some performance-critical code, even as we migrate most other
code to using SHA-1s embedded within a (struct object_id). This will
cost some duplication of code. To accept this approach, we would need an
idea of *how much* code duplication would be needed. E.g., how many
functions will need both (unsigned char *) versions and (struct
object_id *) versions?

5. We only make the change opportunistically. Whenever we find a
function that needs to work with non-struct-aligned SHA-1s, we leave the
function as-is rather than converting it or creating a second version
that works with object_id objects. This approach would leave the
codebase somewhat schizophrenic.

I'm not trying to dissuade you from this project, but I think that for
your project to have a chance of success, we need an answer to this
question. So let's confront it now rather than after you have invested
lots more time and/or gotten patches merged.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/248054

-- 
Michael Haggerty
mhagger@alum.mit.edu

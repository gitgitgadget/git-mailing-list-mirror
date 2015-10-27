From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Tue, 27 Oct 2015 10:42:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de> <20151026191724.GE7881@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0mG-00055C-FN
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbbJ0Jmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:42:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:50295 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbbJ0Jmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:42:43 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0M6730-1ajYEu3kc6-00yA9W;
 Tue, 27 Oct 2015 10:42:30 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20151026191724.GE7881@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:8tAPaXWUTPmwL7xX5WC4dE+6/beLXDTL3sA1QLyugbLltmvdAVR
 9IZuU+y9XQCtTHcWtPK3F0PeAVC99diZNZowZR0W2zPGai9ffav55w/aXrOOVhLhx9GfiA4
 cio+rwEYFSUTJojx08GvVWkAxOMaT9GUCY18CYxgpv5uUbeapZ+FMHdDqJGVKyAa4nQz/mA
 XitKGscv39ol/22/RsnLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5a6hicK/NC0=:lpOUvTu0oNBbUHP+yDTl7u
 ZSHxhOiAKUuKJgenlsjWB5Emi/H6OkR6ZvtLL0KgqxAxduKYdJdquOsMY25uMvAvdv2Q5h04M
 Ot3yB5KsnoSgzbRxoCL6w1f8hjNBPhou3eIrlOyHiVfNHNFxIrdf4o/TMnHtIhc/g90ixXu7u
 M8q7gbgFP8cJtgkXPqIU4Frsjov5Aav7gS/oj14IVltOvF8BGTENCWR3oQCfK5WBRJdxiB4jM
 LXlcEXjHOQOoAsiE0F9J/mOrgUFVzLtIxJ69/m9WjpHKSGJBeBwTTIvY2bqh36duB8u6agdI/
 GwZ1+CRwxo5BrRI7ld14APtOHT28um74s1NigWZowf2JXSqKI10Y5OqdsEW1iMzOFRjQw0hCe
 SjdVhxis7OvmZwAD42Iffy/MehODnPdqFBKgWdn7r12wT2OYK2+IvPzhhdNuvhSz8qxBIvhss
 IfE0oqxqdkotzOV9GDavNtJffdzhir2flEtefnx3o9FQHyEfLMoVi9tu/VAZ8vpbn61wmHUZC
 VW+8O5UljYf2w7I0sNimZU0CkW6EdWy5+3ejs9JYOA0w+cZzOH5lAUOav9OTdDynkKXgjcNHQ
 JHfhMQhmzMeNKxZOC+kTvqVbOdl+VfH63L/0np4c/go/xOKSZPM4Zv4Aqr8EFoRFK/9CeuSSF
 m3M2hS7EK/uO4Ja+sFOHi3MGAMa9yU5oYyRq0Q3OSt0Hq3MD2w8TSiC/QDc8EUCyiLrvvEDA0
 p/Hd+gtd3D90u9sQVlEl1iX6JrlLPU9d+eFoNUup2CP1vIFItIJuDhiO4hDt/QTI8SiwT+bZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280251>

Hi Jonathan,

On Mon, 26 Oct 2015, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > --- a/wrap-for-bin.sh
> > +++ b/wrap-for-bin.sh
> > @@ -19,4 +19,11 @@ GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
> >  PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
> >  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
> >  
> > +if test -n "$TEST_GDB_GIT"
> > +then
> > +	exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> 
> Most TEST_ environment variables that git respects are under
> GIT_TEST_* --- e.g., GIT_TEST_OPTS.  Should this match that pattern
> as well, for easier debugging with commands like 'env | grep GIT_'?

I dunno. This variable is most useful when inserted into the shell scripts
in t/ themselves, not when specified via the command line. For example, if
you have something like

	test_expect_success '123' '
		...
		# This Git call somehow fails and I have no clue why
		git push remote HEAD
		...
	'

then prefixing the `git push` command with `TEST_GDB_GIT=1` lets you use
`gdb` when running the test with the `-i` and `-v` flags.

Please note that `TEST_GDB_GIT` is already a major step up from my initial
`DDD`.

> What happens if the child in turn calls git again?  Should this
> unset TEST_GDB_GIT in gdb's environment?

It probably would call gdb again. Which is sometimes useful. But I have to
admit that I do not know whether that works.

> The gdb manual and --help output advertise "--args".  Has "-args"
> (with a single dash) always worked?

I always used it with a single dash... So I assume that it worked for a
long time (IIRC I used it first in 1994).

> > +	echo "Could not run gdb -args ${GIT_EXEC_PATH}/@@PROG@@ $*" >&2
> > +	exit 1
> 
> Does the 'exec' after the fi need this as well?  exec is supposed to
> itself print a message and exit when it runs into an error.  Would
> including an 'else' with the if make the control flow clearer?  E.g.
> 
> 	if test -n "$TEST_GDB_GIT"
> 	then
> 		exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> 	else
> 		exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> 	fi

I suppose you're right! The `exec` can fail easily, e.g. when `gdb` was
not found.

Ciao,
Johannes

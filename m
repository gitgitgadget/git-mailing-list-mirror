From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 15:27:36 -0700
Message-ID: <7vy69zay7b.fsf@alter.siamese.dyndns.org>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
 <20101015051750.GA21830@burratino>
 <AANLkTinBuAhLLUMLd6ZWtVFWCjnFAxYwVSo1Pkja7bT4@mail.gmail.com>
 <20101015060654.GD21830@burratino>
 <AANLkTi=YN41n-BnVNo3HsnxNxQNBX=Ev-upmM0N49uOZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 00:27:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6skl-00046N-UP
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 00:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab0JOW1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 18:27:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab0JOW1t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 18:27:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 254F4DE3C5;
	Fri, 15 Oct 2010 18:27:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A1uWjEXbjkps
	bZdXVQzyUrmkN7E=; b=G8HbcWIx15GMAmcCn+nIz5y+ADHlEeKDWjXCPhREVpQC
	AwIakNSaZKvGfHOzhwg/BB8u0MkqczzcGoY9rLvaLU+IdpwZrS/HNU6vGRk1L86H
	bc0TkOl5Wdwb7sledkfgGp8n1U8piIW8NnYRpRLu/5rQaT1lSMSHMJIztUvlGMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p9tp/x
	iAnPIWF57DPUnRwNrfPbOwuZg4F4mgr6f3srOby6UMvC2gE01DLeSab5JC1f7esC
	hNOXYq17Zbbkhh3za5qT32hJ9k7SODDO+GjtaULSuFRlOTigkQPP7eiEt0+bdQYI
	4aXsqcMCUx1wimcyWXguX//D+3FBFbPlEtUUQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4EC7DE3C3;
	Fri, 15 Oct 2010 18:27:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADCA6DE3C0; Fri, 15 Oct
 2010 18:27:38 -0400 (EDT)
In-Reply-To: <AANLkTi=YN41n-BnVNo3HsnxNxQNBX=Ev-upmM0N49uOZ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 15 Oct
 2010 10\:49\:00 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6DDA131C-D8AB-11DF-BB86-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159139>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe it should be a NO_* flag since that's what we use when we expec=
t
> sanity, e.g. we have NO_REGEXP=3D, NO_CURL and NO_GETTEXT.
>
> Then you just need NO_MEMRCHR=3DUnfortunatelyYes entries in the big
> if/else block for those platforms that don't have it.

Hmmm, perhaps our naming convention have deteriorated over time.

I think one of the oldest one is NO_CURL, which started out as a way to
say "I do not have to go over http and dumb http transport is of no use=
 to
me.  I _might_ have curl library installed on this system, but it does =
not
matter.  No thanks, please do not build git with curl support".  For so=
me
people, it also meant "Unfortunately I do not have a working curl libra=
ry
here, so I'll live with a git without http support".

On the other hand, NO_REGEX means "regrettably the platform implementat=
ion
is not good enough for our codebase, and we do need to use a replacemen=
t
implementation from compat/".

The difference is that it is not an option to build a less capable git
that lacks features that depend on REGEX.  But somehow we ended up usin=
g
the same NO_ prefix, conflating the two.  In that sense NO_GETTEXT is
named correctly, I think, as we fall back on implementation (i.e. less
capable git) that does not do i18n/l10n.

> But memrchr() is a GNU extension so it should probably be a HAVE_*. I
> don't know.

Yes, if we want to express that we positively rely on the existence of =
an
extension, HAVE_* does sound more correct.  It also is how the world wi=
th
autoconf/configure works.

We might want to clean up the names of variables at some point, but fro=
m a
quick glance things do not look very good.

Most NO_FOO are misnamed and should be !HAVE_FOO, but because our codeb=
ase
tend to use more common features, switching from the way we currently d=
o,
i.e. assuming we have FOO and defining NO_FOO for oddball platforms, to
the other way around of defining HAVE_FOO for platforms where we do hav=
e FOO
and omit it for the ones that lack, may make the Makefile more cluttere=
d.

But as I already said, switching to HAVE_FOO has one definite advantage=
;
it is more conventional and would mesh a lot better with the way
autoconf/configure would do things.

Here is a quick break-down of the current set I found from the 'master'
branch.

* You decline to build, or are unable to build, git with...

  NO_CURL		transport based on libcurl e.g. HTTP.
  NO_ICONV		charset re-encoding support.
  NO_IPV6		IPV6
  NO_NSEC		nanosecond resolution file timestamps
  NO_POSIX_ONLY_PROGRAMS
  NO_PYTHON		anything that depends on Python
  NO_SYMLINK_HEAD	support for original layout where .git/HEAD was a sym=
link
  NO_SVN_TESTS		test that spends too much time on git-svn


* We work around the lack of the platform feature FOO without loss of
  features from git (i.e. should be !HAVE_FOO):

  NO_C99_FORMAT		SZ_FMT and friends
  NO_D_INO_IN_DIRENT	(struct dirent)d.d_ino
  NO_D_TYPE_IN_DIRENT	(struct dirent)d.d_type
  NO_HSTRERROR
  NO_INET_NTOP
  NO_INET_PTON
  NO_LIBGEN_H
  NO_MEMMEM
  NO_MKDTEMP
  NO_MKSTEMPS
  NO_MMAP
  HAVE_PATHS_H		#include <paths.h>
  NO_PERL_MAKEMAKER
  NO_PREAD
  NO_REGEX
  NO_R_TO_GCC_LINKER
  NO_SETENV
  NO_SOCKADDR_STORAGE
  NO_ST_BLOCKS_IN_STRUCT_STAT
  NO_STRCASESTR
  NO_STRLCPY
  NO_STRTOK_R
  NO_STRTOULL
  NO_STRTOUMAX
  NO_SYS_SELECT_H
  NO_TRUSTABLE_FILEMODE
  NO_UINTMAX_T
  NO_UNSETENV

Unfortunately the world is not so black-and-white.  There is another cl=
ass

* Depending on platform features, we use different implementation with
  almost no observable difference in behaviour (perhaps except for
  performance)

  NO_PTHREADS
	Use of threads for better machine utilization

  NO_FAST_WORKING_DIRECTORY
	Reading from object database is faster than opening a file in the
	working directory and reading from it on this platform, so we do
	the former when we know the file in the working directory is clean.
        Perhaps !HAVE_FAST_WORKING_DIRECTORY.

And yet another that is completely unrelated:

  NO_SUBDIR

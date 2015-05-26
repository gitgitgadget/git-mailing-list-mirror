From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.2
Date: Tue, 26 May 2015 14:47:17 -0700
Message-ID: <xmqqfv6jj9ju.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMh3-000412-MW
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbbEZVrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 17:47:21 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34162 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbEZVrT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 17:47:19 -0400
Received: by igbhj9 with SMTP id hj9so71847367igb.1;
        Tue, 26 May 2015 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=hAPonFaGgkHgKb59LlgFbuFJ+aCAlHMZwr+EcFNC55w=;
        b=Zz0AU/yBu1+8+JGFbYi0kO92JTiJ91YGV2uVmFwquboBy+6OPYvbP6c0NPKnlmlKBD
         QnxSxYxQ4LZHxzmqSXFkw568igt3/0Fmu5bHPrTBy1ofkY1Ex+1+JAvKun2Krou8qnnv
         knIk51L/5L3y5HmleWtm9pZF+Ra/16TLGpMvHdd0qNQUWJ5tVvEs3G+KTYFCpPh8jIY8
         nMONUv9cHkjI7DVjjdqfVIEtIjemc6OtUNokg7FoDsN9A10UvQzLC0ehIJWRDYLampIV
         K/BWlUAt7ToeGBkfqhlCCuDF+RXzRWd2eQZj1IwXZbOyaVpGp4C1Tets1IoQ5/dRNvWn
         eV4A==
X-Received: by 10.50.43.196 with SMTP id y4mr32318997igl.14.1432676838879;
        Tue, 26 May 2015 14:47:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id r4sm287236igh.9.2015.05.26.14.47.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 14:47:18 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269983>

The latest maintenance release Git v2.4.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.4.1
------------------

 * "git rev-list --objects $old --not --all" to see if everything that
   is reachable from $old is already connected to the existing refs
   was very inefficient.

 * "hash-object --literally" introduced in v2.2 was not prepared to
   take a really long object type name.

 * "git rebase --quiet" was not quite quiet when there is nothing to
   do.

 * The completion for "log --decorate=3D" parameter value was incorrect=
=2E

 * "filter-branch" corrupted commit log message that ends with an
   incomplete line on platforms with some "sed" implementations that
   munge such a line.  Work it around by avoiding to use "sed".

 * "git daemon" fails to build from the source under NO_IPV6
   configuration (regression in 2.4).

 * "git stash pop/apply" forgot to make sure that not just the working
   tree is clean but also the index is clean. The latter is important
   as a stash application can conflict and the index will be used for
   conflict resolution.

 * We have prepended $GIT_EXEC_PATH and the path "git" is installed in
   (typically "/usr/bin") to $PATH when invoking subprograms and hooks
   for almost eternity, but the original use case the latter tried to
   support was semi-bogus (i.e. install git to /opt/foo/git and run it
   without having /opt/foo on $PATH), and more importantly it has
   become less and less relevant as Git grew more mainstream (i.e. the
   users would _want_ to have it on their $PATH).  Stop prepending the
   path in which "git" is installed to users' $PATH, as that would
   interfere the command search order people depend on (e.g. they may
   not like versions of programs that are unrelated to Git in /usr/bin
   and want to override them by having different ones in /usr/local/bin
   and have the latter directory earlier in their $PATH).

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.1 are as follows:

Eric Sunshine (3):
      git-hash-object.txt: document --literally option
      hash-object --literally: fix buffer overrun with extra-long objec=
t type
      t1007: add hash-object --literally tests

Jeff King (7):
      limit_list: avoid quadratic behavior from still_interesting
      t3903: stop hard-coding commit sha1s
      t3903: avoid applying onto dirty index
      stash: require a clean index to apply
      stop putting argv[0] dirname at front of PATH
      rebase: silence "git checkout" for noop rebase
      filter-branch: avoid passing commit message through sed

Junio C Hamano (3):
      write_sha1_file(): do not use a separate sha1[] array
      daemon: unbreak NO_IPV6 build regression
      Git 2.4.2

SZEDER G=C3=A1bor (1):
      completion: fix and update 'git log --decorate=3D' options

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 00/45] nd/parse-pathspec and :(glob) pathspec magic
Date: Fri, 15 Mar 2013 10:48:08 -0700
Message-ID: <7vk3p8v9k7.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 18:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGYkB-0001ce-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 18:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab3CORsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 13:48:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab3CORsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 13:48:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36202A731;
	Fri, 15 Mar 2013 13:48:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/cm+/RHE+vfv
	J94eVQh7gmxdbqM=; b=qghl3XKgToz0WJLtwFJ7kB60d+bIvKGqXFojxttjNHOn
	vxb4Zitj+bGV1hN6CAq/JsgbWFvesyfUaYaZHVe6QaYwyMKgnWYYS2i0vTtVoq83
	kFjmfRN610QnLtA2nDy/570/2eTi5Rv3ZQU5XR/1cOZ7fiolT2sc+wGcY2a5Rcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ut22c8
	WvzPmsKA+bXXFsG8cOmubSKHcIxqnk1CWRX1Q8ni+EgTyJi6vKRHAHaRhXvlfwmY
	uPHtLngJFYymRSFQo2Q5SLt3DLJ5P531jDJnVzNqwvXAZ6DT8YtvIF1lr2b8iL+B
	tSqytB3/V/Ry3o1KZH5a8SyIGt1KTeJxDLQNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A845A730;
	Fri, 15 Mar 2013 13:48:11 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CC36A72E; Fri, 15 Mar 2013
 13:48:10 -0400 (EDT)
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 15 Mar
 2013 13:06:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80798E18-8D98-11E2-939A-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218256>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Probably not much to say. A big portion of this series is the
> conversion to struct pathspec, which enables more use of pathspec
> magic. :(glob) magic is added to verify that the conversion makes
> sense.

I haven't read any of these patches, but there remains only one user
of the _raw field in dir.c (read_directory) and get_pathspec() is
called by nobody other than builtin/mv.c after this series.

Very encouraging.

> Andrew Wong (1):
>   setup.c: check that the pathspec magic ends with ")"
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (44):
>   clean: remove unused variable "seen"
>   Move struct pathspec and related functions to pathspec.[ch]
>   pathspec: i18n-ize error strings in pathspec parsing code
>   pathspec: add copy_pathspec
>   Add parse_pathspec() that converts cmdline args to struct pathspec
>   parse_pathspec: save original pathspec for reporting
>   parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
>   Convert some get_pathspec() calls to parse_pathspec()
>   parse_pathspec: a special flag for max_depth feature
>   parse_pathspec: support stripping submodule trailing slashes
>   parse_pathspec: support stripping/checking submodule paths
>   parse_pathspec: support prefixing original patterns
>   Guard against new pathspec magic in pathspec matching code
>   clean: convert to use parse_pathspec
>   commit: convert to use parse_pathspec
>   status: convert to use parse_pathspec
>   rerere: convert to use parse_pathspec
>   checkout: convert to use parse_pathspec
>   rm: convert to use parse_pathspec
>   ls-files: convert to use parse_pathspec
>   archive: convert to use parse_pathspec
>   check-ignore: convert to use parse_pathspec
>   add: convert to use parse_pathspec
>   reset: convert to use parse_pathspec
>   Convert read_cache_preload() to take struct pathspec
>   Convert run_add_interactive to use struct pathspec
>   Convert unmerge_cache to take struct pathspec
>   checkout: convert read_tree_some to take struct pathspec
>   Convert report_path_error to take struct pathspec
>   Convert refresh_index to take struct pathspec
>   Convert {read,fill}_directory to take struct pathspec
>   Convert add_files_to_cache to take struct pathspec
>   Convert common_prefix() to use struct pathspec
>   Remove diff_tree_{setup,release}_paths
>   Remove init_pathspec() in favor of parse_pathspec()
>   Remove match_pathspec() in favor of match_pathspec_depth()
>   tree-diff: remove the use of pathspec's raw[] in follow-rename code=
path
>   parse_pathspec: make sure the prefix part is wildcard-free
>   parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
>   Kill limit_pathspec_to_literal() as it's only used by parse_pathspe=
c()
>   pathspec: support :(literal) syntax for noglob pathspec
>   pathspec: make --literal-pathspecs disable pathspec magic
>   pathspec: support :(glob) syntax
>   Rename field "raw" to "_raw" in struct pathspec
>
>  Documentation/git.txt              |  23 +-
>  Documentation/glossary-content.txt |  33 +++
>  archive.c                          |  18 +-
>  archive.h                          |   4 +-
>  builtin/add.c                      | 156 ++++++--------
>  builtin/blame.c                    |  14 +-
>  builtin/check-ignore.c             |  34 +--
>  builtin/checkout.c                 |  46 ++--
>  builtin/clean.c                    |  24 +--
>  builtin/commit.c                   |  37 ++--
>  builtin/diff-files.c               |   2 +-
>  builtin/diff-index.c               |   2 +-
>  builtin/diff.c                     |   6 +-
>  builtin/grep.c                     |  10 +-
>  builtin/log.c                      |   2 +-
>  builtin/ls-files.c                 |  75 +++----
>  builtin/ls-tree.c                  |  13 +-
>  builtin/mv.c                       |  13 +-
>  builtin/rerere.c                   |   8 +-
>  builtin/reset.c                    |  33 +--
>  builtin/rm.c                       |  24 +--
>  builtin/update-index.c             |   6 +-
>  cache.h                            |  34 +--
>  commit.h                           |   2 +-
>  diff-lib.c                         |   3 +-
>  diff.h                             |   3 +-
>  dir.c                              | 261 +++++-----------------
>  dir.h                              |  18 +-
>  git.c                              |   8 +
>  merge-recursive.c                  |   2 +-
>  notes-merge.c                      |   4 +-
>  path.c                             |  15 +-
>  pathspec.c                         | 431 +++++++++++++++++++++++++++=
++++++----
>  pathspec.h                         |  59 ++++-
>  preload-index.c                    |  21 +-
>  read-cache.c                       |   5 +-
>  rerere.c                           |   7 +-
>  rerere.h                           |   4 +-
>  resolve-undo.c                     |   4 +-
>  resolve-undo.h                     |   2 +-
>  revision.c                         |  11 +-
>  setup.c                            | 157 +-------------
>  t/t0008-ignores.sh                 |   8 +-
>  t/t6130-pathspec-noglob.sh         |  18 ++
>  tree-diff.c                        |  48 +++--
>  tree-walk.c                        |  21 +-
>  tree.c                             |   4 +-
>  tree.h                             |   2 +-
>  wt-status.c                        |  18 +-
>  wt-status.h                        |   2 +-
>  50 files changed, 983 insertions(+), 772 deletions(-)

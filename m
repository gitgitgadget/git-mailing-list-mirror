From: Mike Hommey <mh@glandium.org>
Subject: Announcing git-cinnabar 0.3.1
Date: Sat, 16 Jan 2016 20:27:36 +0900
Message-ID: <20160116112736.GA21994@glandium.org>
References: <20160115085658.GA15539@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 12:28:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKP1u-0001IE-1o
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 12:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbcAPL1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2016 06:27:44 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35850 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbcAPL1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2016 06:27:43 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aKP16-0005oF-JY
	for git@vger.kernel.org; Sat, 16 Jan 2016 20:27:36 +0900
Content-Disposition: inline
In-Reply-To: <20160115085658.GA15539@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284240>

This is a brown paper bag release. It turns out I managed to break the
upgrade path only 10 commits before the release.

What's new since 0.3.0?

- `git cinnabar fsck` doesn't fail to upgrade metadata.
- The remote.$remote.cinnabar-draft config works again.
- Don't fail to clone an empty repository.
- Allow to specify mercurial configuration items in a .git/hgrc file.

Mike

On Fri, Jan 15, 2016 at 05:56:58PM +0900, Mike Hommey wrote:
> Git-cinnabar is a git remote helper to interact with mercurial
> repositories. It allows to clone, pull and push from/to mercurial remote
> repositories, using git.
> 
> Code on https://github.com/glandium/git-cinnabar
> 
> [ Previous announcements:
>   http://marc.info/?l=git&m=142837367709781
>   http://marc.info/?l=git&m=142364715001983
>   http://marc.info/?l=git&m=141781485726430 ]
> 
> Development had been stalled for a few months, with many improvements in
> the `next` branch without any new release. I used some time during the
> new year break and after in order to straighten things up in order to
> create a new release, delaying many of the originally planned changes to
> a future 0.4.0 release.
> 
> What's new since 0.2.2?
> 
> - Speed and memory usage were improved when doing `git push`.
> - Now works on Windows, at least to some extent. See details[1].
> - Support for pre-0.1.0 git-cinnabar repositories was removed. You must
>   first use a git-cinnabar version between 0.1.0 and 0.2.2 to upgrade
>   its metadata.
> - It is now possible to attach/graft git-cinnabar metadata to existing
>   commits matching mercurial changesets. This allows to migrate from
>   some other hg-to-git tool to git-cinnabar while preserving the
>   existing git commits.  See an example of how this works with the git
>   clone of the Gecko mercurial repository[2]
> - Avoid mercurial printing its progress bar, messing up with
>   git-cinnabar's output.
> - It is now possible to fetch from an incremental mercurial bundle
>   (without a root changeset).
> - It is now possible to push to a new mercurial repository without `-f`.
> - By default, reject pushing a new root to a mercurial repository.
> - Make the connection to a mercurial repository through ssh respect the
>   `GIT_SSH` and `GIT_SSH_COMMAND` environment variables.
> - `git cinnabar` now has a proper argument parser for all its
>   subcommands.
> - A new `git cinnabar python` command allows to run python scripts or
>   open a python shell with the right sys.path to import the cinnabar
>   module.
> - All git-cinnabar metadata is now kept under a single ref (although for
>   convenience, other refs are created, but they can be derived if
>   necessary).
> - Consequently, a new `git cinnabar rollback` command allows to roll
>   back to previous metadata states.
> - git-cinnabar metadata now tracks the manifests DAG.
> - A new `git cinnabar bundle` command allows to create mercurial
>   bundles, mostly for debugging purposes, without requiring to hit a
>   mercurial server.
> - Updated git to 2.7.0 for the native helper.
> 
> Development process changes
> 
> Up to before this release closing in, the `master` branch was dedicated
> to releases, and development was happening on the `next` branch, until a
> new release happens.
> 
> From now on, the `release` branch will take dot-release fixes and new
> releases, while the `master` branch will receive all changes that are
> validated through testing (currently semi-automatically tested with
> out-of-tree tests based on four real-life mercurial repositories, with
> some automated CI based on in-tree tests used in the future).
> 
> The `next` branch will receive changes to be tested in CI when things
> will be hooked up, and may have rewritten history as a consequence of
> wanting passing tests on every commit on `master`.
> 
> Mike
> 
> 1. https://github.com/glandium/git-cinnabar/wiki/Windows-Support
> 2. https://github.com/glandium/git-cinnabar/wiki/Mozilla:-Using-a-git-clone-of-gecko%E2%80%90dev-to-push-to-mercurial
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

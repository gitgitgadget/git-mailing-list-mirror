From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Fri, 21 Dec 2007 21:17:45 +0700
Message-ID: <fcaeb9bf0712210617x2bafa33cp15815a59fc631f45@mail.gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	 <20071218204623.GC2875@steel.home>
	 <200712182224.28152.jnareb@gmail.com>
	 <20071218222032.GH2875@steel.home>
	 <Pine.LNX.4.64.0712182239500.23902@racer.site>
	 <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
	 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
	 <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
	 <Pine.LNX.4.64.0712191334460.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dana How" <danahow@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 15:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5ihs-0003H7-MZ
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 15:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbXLUORu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 09:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbXLUORu
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 09:17:50 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:52509 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500AbXLUORs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 09:17:48 -0500
Received: by mu-out-0910.google.com with SMTP id i10so433776mue.5
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=k3ncQ0agougSPuXtGegXv86+MGsQCde9AMUabIdf/s8=;
        b=BSo9suM1RTIopSFFtYU8qM6jyIjSdHY5vmte6Z6dSsEnVzmw2U7A+ii0BtCA9SVgXree1LLmrlE1g7UdFQ+xMM/Eldi1yiRZvf9pjaS/4ph9SsHXCwe1T7j9FReCoQoMyGDhZ22Vv8vBp64iZqQOGmrOeeMJzcZP7OPVwOz3LK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IresQ10Sr0K4eIxoFAQRlnRJ5fgwTEKr6/IyKA4RIYPEShQSUKN2egXICAMwIjmE140uqSilkCyQPNaziV6vAtiByOhNPcWg43MO8vDW3J0OlNiboZiF2gKEZwYbzpkPVLttlWLslZyqSFb+H4U/fSnmdbIul7B8rFe2IjFDdYs=
Received: by 10.86.50.8 with SMTP id x8mr1178832fgx.30.1198246665994;
        Fri, 21 Dec 2007 06:17:45 -0800 (PST)
Received: by 10.86.53.17 with HTTP; Fri, 21 Dec 2007 06:17:45 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712191334460.23902@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69066>

On Dec 19, 2007 8:40 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> When you are in a deeply-nested directory structure, and just want
> to reference a blob in a past revision, it can be pretty slow to
> type out "HEAD~29:/bla/blub/.../that-file".
>
> This patch makes "HEAD~29:./that-file" substitute the current prefix
> for "./".  If there is not working directory, the prefix is empty.
>
> Note that this patch does not handle "../", and neither do I plan to.

Junio's rc1 announcement got me to read this. It would be indeed
useful as I usually work in deep subdirs. However, from my user
perspective, the right approach is to make <treeish>:path always be
relative to current directory. If you want absolute path, use
<treeish>:/path. More intuitive but it breaks current behavior. Can we
slowly migrate from current absolute-path-by-default behavior to
relative-pat- by-default one? (I don't know how to make such migration
smoothly though)

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>         On Tue, 18 Dec 2007, Dana How wrote:
>
>         > On Dec 18, 2007 5:16 PM, Linus Torvalds
>         >                       <torvalds@linux-foundation.org> wrote:
>         > > On Tue, 18 Dec 2007, Dana How wrote:
>         > >
>         > > > The cases we are talking about are all subtrees of the
>         > > > working tree. There is a useful cwd suffix.
>         > >
>         > > No.
>         > >
>         > > The cases we're talking of are *not* subtrees of the working
>         > > tree.
>         > >
>         > > The SHA1 of a commit may well be a totally disjoint tree. Try
>         > > it in the git repository with something like
>         >
>         > Agreed,  but note you wrote *may*.
>
>         Okay, this is a proposed patch.  It leaves the existing
>         "HEAD:<path>" handling alone, and only touches "HEAD:./<path>",
>         which would have been invalid anyway (except if you hacked your
>         objects database to include a tree named ".").
>
>         Note: this patch is not meant for application directly.  It should
>         be split into get_current_prefix() as one patch, and the
>         sha1_name.c stuff as the second.  (Not only to boost my ohloh
>         statistics, but because they are logically two separate things.)
>
>         Note, too: this is a quick and little-bit-dirty patch, not well
>         tested.  Particularly, I was unable to trigger the "No <path> in
>         <rev>" error path, so I am not confident that this handling is
>         correct.
>
>         Note also: in contrast to Alex' approach, this will not only work
>         for git-show, but for all callers of get_sha1().
>
>  cache.h     |    1 +
>  setup.c     |   16 +++++++++++++---
>  sha1_name.c |   17 ++++++++++++++---
>  3 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 39331c2..83a2c31 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -225,6 +225,7 @@ extern char *get_index_file(void);
>  extern char *get_graft_file(void);
>  extern int set_git_dir(const char *path);
>  extern const char *get_git_work_tree(void);
> +extern const char *get_current_prefix(void);
>
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>
> diff --git a/setup.c b/setup.c
> index b59dbe7..fb9b680 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -3,6 +3,12 @@
>
>  static int inside_git_dir = -1;
>  static int inside_work_tree = -1;
> +static const char *current_prefix;
> +
> +const char *get_current_prefix()
> +{
> +       return current_prefix;
> +}
>
>  const char *prefix_path(const char *prefix, int len, const char *path)
>  {
> @@ -267,6 +273,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                                 /* config may override worktree */
>                                 if (check_repository_format_gently(nongit_ok))
>                                         return NULL;
> +                               current_prefix = retval;
>                                 return retval;
>                         }
>                         if (check_repository_format_gently(nongit_ok))
> @@ -279,7 +286,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                         if (chdir(work_tree_env) < 0)
>                                 die ("Could not chdir to %s", work_tree_env);
>                         strcat(buffer, "/");
> -                       return retval;
> +                       current_prefix = retval;
> +                       return current_prefix;
>                 }
>                 if (nongit_ok) {
>                         *nongit_ok = 1;
> @@ -339,7 +347,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>         offset++;
>         cwd[len++] = '/';
>         cwd[len] = 0;
> -       return cwd + offset;
> +       current_prefix = cwd + offset;
> +       return current_prefix;
>  }
>
>  int git_config_perm(const char *var, const char *value)
> @@ -396,7 +405,8 @@ const char *setup_git_directory(void)
>                 if (retval && chdir(retval))
>                         die ("Could not jump back into original cwd");
>                 rel = get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
> -               return rel && *rel ? strcat(rel, "/") : NULL;
> +               current_prefix = rel && *rel ? strcat(rel, "/") : NULL;
> +               return current_prefix;
>         }
>
>         return retval;
> diff --git a/sha1_name.c b/sha1_name.c
> index 13e1164..6f61d26 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -712,9 +712,20 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
>         }
>         if (*cp == ':') {
>                 unsigned char tree_sha1[20];
> -               if (!get_sha1_1(name, cp-name, tree_sha1))
> -                       return get_tree_entry(tree_sha1, cp+1, sha1,
> -                                             mode);
> +               if (!get_sha1_1(name, cp-name, tree_sha1)) {
> +                       const char *prefix;
> +                       if (!prefixcmp(cp + 1, "./") &&
> +                                       (prefix = get_current_prefix())) {
> +                               unsigned char subtree_sha1[20];
> +                               if (get_tree_entry(tree_sha1, prefix,
> +                                                       subtree_sha1, mode))
> +                                       return error("No '%s' in '%.*s'",
> +                                                       prefix, cp-name, name);
> +                               memcpy(tree_sha1, subtree_sha1, 20);
> +                               cp += 2;
> +                       }
> +                       return get_tree_entry(tree_sha1, cp+1, sha1, mode);
> +               }
>         }
>         return ret;
>  }
> --
> 1.5.4.rc0.72.g536e9
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Duy

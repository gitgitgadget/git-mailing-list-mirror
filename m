From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Wed, 23 Dec 2015 14:34:23 +0100
Message-ID: <567AA2DF.1020408@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 14:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBjfg-00043C-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 14:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180AbbLWNlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 08:41:32 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62706 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752314AbbLWNl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 08:41:27 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2015 08:41:27 EST
X-AuditID: 12074412-f79a76d000007c8b-c1-567aa2e194ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FE.E7.31883.1E2AA765; Wed, 23 Dec 2015 08:34:25 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBNDYNRZ025407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 08:34:24 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <1449102921-7707-14-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1H24qCrMYOdjAYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BltU1rZCpYmVpxrvcfcwHjOp4uRk0NCwERi
	wrceJghbTOLCvfVsXYxcHEIClxklTj/YzwThXGCSWPHjAhtIlbBAsMSGe1vBbBEBB4nLu44y
	QxS1MUpMvb6XHSTBJqArsainGWqsnERv9ySWLkYODl4BbYmNOwVBwiwCqhJtlxcxgtiiAiES
	e3d2sIDYvAKCEidnPgGzOQU8JZbtbQGzmQX0JHZc/8UKYctLNG+dzTyBUWAWkpZZSMpmISlb
	wMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkVIV2MK4/KXeIUYCDUYmH
	16GtMkyINbGsuDL3EKMkB5OSKG90VVWYEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe9HdA5bwp
	iZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErxLFgINFSxKTU+tSMvMKUFI
	M3FwggznkhIpTs1LSS1KLC3JiAfFanwxMFpBUjxAeyeAtPMWFyTmAkUhWk8xKkqJ8+4CSQiA
	JDJK8+DGwhLQK0ZxoC+FeRtBqniAyQuu+xXQYCagwX/WlYMMLklESEk1MEZuK3u+y0xlKmNO
	Q3zb21MlTnM7H352095dIVRyVPrXV6ak6a/bpxnFX1DW+fPhffREeRdlpkSetRvceRUUbxuv
	L3z/fMtLTjGzyde3iM9XFW3+7JBddTc3/qHwr19OHdfnbD8ef30t8yFuZqX5D0vu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282934>

On 12/03/2015 01:35 AM, David Turner wrote:
> git init learns a new argument --refs-backend-type.  Presently, only
> "files" is supported, but later we will add other backends.
> 
> When this argument is used, the repository's core.refsBackendType
> configuration value is set, and the refs backend's initdb function is
> used to set up the ref database.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-init-db.txt |  2 +-
>  Documentation/git-init.txt    |  6 +++++-
>  builtin/init-db.c             | 10 ++++++++++
>  cache.h                       |  2 ++
>  config.c                      | 20 ++++++++++++++++++++
>  environment.c                 |  1 +
>  path.c                        | 32 ++++++++++++++++++++++++++++++--
>  refs.c                        |  8 ++++++++
>  refs.h                        | 12 ++++++++++++
>  setup.c                       | 10 ++++++++++
>  10 files changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
> index 648a6cd..72fbd71 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]] [--refs-backend-type=<name>]
>  
>  
>  DESCRIPTION
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 8174d27..9ea6753 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
>  	  [--separate-git-dir <git dir>]
>  	  [--shared[=<permissions>]] [directory]
> -
> +	  [--refs-backend-type=<name>]

ISTM that "backend" (used here in this option name, and in the manpage)
is not such a meaningful term to users. Could we pick a less obscure
term? E.g., maybe "--ref-storage=<name>"?


>  DESCRIPTION
>  -----------
> @@ -113,6 +113,10 @@ does not exist, it will be created.
>  
>  --
>  
> +--refs-backend-type=<name>::
> +Type of refs backend. Default is to use the original "files" backend,
> +which stores ref data in files in .git/refs and .git/packed-refs.
> +
>  TEMPLATE DIRECTORY
>  ------------------
>  
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 4771e7e..44db591 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -204,6 +204,14 @@ static int create_default_files(const char *template_path)
>  		adjust_shared_perm(get_git_dir());
>  	}
>  
> +	if (refs_backend_type) {
> +		struct refdb_config_data config_data = {NULL};
> +		git_config_set("core.refsBackendType", refs_backend_type);
> +		config_data.refs_backend_type = refs_backend_type;
> +		config_data.refs_base = get_git_dir();
> +		set_refs_backend(refs_backend_type, &config_data);
> +	}
> +

Here is the source of the "void *data" argument that puzzled me in patch
08/16. I'm still puzzled. This code, which is later also used for the
LMDB backend, *always* passes that function a "struct refdb_config_data
*". So why is the argument declared to be "void *"?

If, on the other hand, you want to preserve a backend's freedom to
require different extra data in this parameter, then this code in
init-db.c, and code like it elsewhere, would have to know about the
reference backends so that it knows what data to pass to each one. In
that case, there would be no reason to make this function virtual; this
code could just as well call a different function (with a different
signature) depending on the backend that is in use.

Either way, something seems strange here.

(Remember that another alternative is to let the refs backend read
whatever specialized information it needs from the config by itself.)

>  	if (refs_init_db(&err, shared_repository))
>  		die("failed to set up refs db: %s", err.buf);
>  
> @@ -469,6 +477,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
>  		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  			   N_("separate git dir from working tree")),
> +		OPT_STRING(0, "refs-backend-type", &refs_backend_type,
> +			   N_("name"), N_("name of backend type to use")),
>  		OPT_END()
>  	};
>  
> diff --git a/cache.h b/cache.h
> index 707455a..d1534db 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -696,6 +696,8 @@ extern enum object_creation_mode object_creation_mode;
>  
>  extern char *notes_ref_name;
>  
> +extern const char *refs_backend_type;
> +
>  extern int grafts_replace_parents;
>  
>  /*
> diff --git a/config.c b/config.c
> index 248a21a..210aa08 100644
> --- a/config.c
> +++ b/config.c
> @@ -10,6 +10,7 @@
>  #include "exec_cmd.h"
>  #include "strbuf.h"
>  #include "quote.h"
> +#include "refs.h"
>  #include "hashmap.h"
>  #include "string-list.h"
>  #include "utf8.h"
> @@ -1207,6 +1208,25 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  	}
>  
>  	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
> +		struct refdb_config_data refdb_data = {NULL};
> +		char *repo_config_copy;
> +
> +		/*
> +		 * make sure we always read the backend config from the
> +		 * core section on startup
> +		 */
> +		ret += git_config_from_file(refdb_config, repo_config,
> +					    &refdb_data);
> +
> +		repo_config_copy = xstrdup(repo_config);
> +		refdb_data.refs_base = xstrdup(dirname(repo_config_copy));
> +		free(repo_config_copy);
> +
> +		if (refdb_data.refs_backend_type &&
> +		    strcmp(refdb_data.refs_backend_type, "files")) {
> +			die("Unexpected backend %s", refdb_data.refs_backend_type);
> +		}

The refs code already maintains a list of valid backend names. It would
be better to ask it to validate this parameter than to maintain a second
list here. Or just call set_refs_backend() and let *it* fail.

> +
>  		ret += git_config_from_file(fn, repo_config, data);
>  		found += 1;
>  	}
> diff --git a/environment.c b/environment.c
> index 2da7fe2..8dbf0ab 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -66,6 +66,7 @@ int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  struct startup_info *startup_info;
>  unsigned long pack_size_limit_cfg;
> +const char *refs_backend_type;
>  
>  #ifndef PROTECT_HFS_DEFAULT
>  #define PROTECT_HFS_DEFAULT 0
> diff --git a/path.c b/path.c
> index 3cd155e..86a8035 100644
> --- a/path.c
> +++ b/path.c
> @@ -2,6 +2,7 @@
>   * Utilities for paths and pathnames
>   */
>  #include "cache.h"
> +#include "refs.h"
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "dir.h"
> @@ -510,9 +511,36 @@ int validate_headref(const char *path)
>  	unsigned char sha1[20];
>  	int fd;
>  	ssize_t len;
> +	struct refdb_config_data refdb_data = {NULL, NULL};
> +
> +	if (lstat(path, &st) < 0) {
> +		int backend_type_set;
> +		struct strbuf config_path = STRBUF_INIT;
> +		if (path) {
> +			char *pathdup = xstrdup(path);
> +			char *git_dir = dirname(pathdup);
> +			strbuf_addf(&config_path, "%s/%s", git_dir, "config");
> +			free(pathdup);
> +		} else {
> +			strbuf_addstr(&config_path, "config");
> +		}
>  
> -	if (lstat(path, &st) < 0)
> -		return -1;
> +		if (git_config_from_file(refdb_config, config_path.buf, &refdb_data)) {
> +			strbuf_release(&config_path);
> +			return -1;
> +		}
> +
> +		backend_type_set = !!refdb_data.refs_backend_type;
> +		free((void *)refdb_data.refs_backend_type);
> +		free((void *)refdb_data.refs_base);
> +		strbuf_release(&config_path);
> +		/*
> +		 * Alternate backends are assumed to keep HEAD
> +		 * in a valid state, so there's no need to do
> +		 * further validation.
> +		 */
> +		return backend_type_set ? 0 : -1;
> +	}

I'm not sure what problem you are trying to solve with this particular
change. Won't a lmdb-backed repository still have a "HEAD" file with the
usual contents?

In any case, it seems like you are doing work that belongs at a higher
level.

validate_headref() has only one caller, is_git_directory(). The purpose
of that function is to check whether a specified directory is a
plausible Git directory, which it does by looking for some required files:

* "objects/" (unless GIT_OBJECT_DIRECTORY is set)
* "refs/"
* "HEAD" (which must also have appropriate contents)

NB: it doesn't care whether there is a "config" file. Presumably that
was invented later.

It seems to me that whether a repository should have a "refs/" and/or
"HEAD", and if so what contents "HEAD" should have, or whether (for
example) it should have a "refdb" file, depends on what reference
backend is in use. But *that* depends on the contents of "config" or its
absence.

You are reading "config" down here in validate_headref(). It feels to me
more like is_git_directory() should read "config", determine which
reference backend seems to be in use, and then ask *that* reference
backend whether the directory is a plausible Git directory. The files
backend would check for "HEAD" and "refs/" and the LMDB backend would
check for "HEAD" and "refdb/".

Note that this approach would require "config" to be read and parsed an
extra time. That might be considered too expensive to do so early in the
startup code. I don't know.

By the way, this code ends up reading "config" files a bit more
promiscuously than the old code. I don't think this raises any security
considerations, but I wanted to point it out anyway. If somebody can put
a hostile "config" file in a directory where you are running git, then
they can probably put an "objects/", "refs/", and "HEAD" file there,
which is all that is needed to get even the old code to read the
"config" file.

>  	/* Make sure it is a "refs/.." symlink */
>  	if (S_ISLNK(st.st_mode)) {
> diff --git a/refs.c b/refs.c
> index e48e43a..96e1673 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -24,6 +24,14 @@ struct ref_be *the_refs_backend = &refs_be_files;
>   */
>  struct ref_be *refs_backends = &refs_be_files;
>  
> +const char *refs_backend_type;
> +
> +void register_refs_backend(struct ref_be *be)
> +{
> +	be->next = refs_backends;
> +	refs_backends = be;
> +}
> +
>  /*
>   * This function is used to switch to an alternate backend.
>   */
> diff --git a/refs.h b/refs.h
> index c211b9e..c3670e8 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -510,6 +510,18 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
>  			 reflog_expiry_cleanup_fn cleanup_fn,
>  			 void *policy_cb_data);
>  
> +struct refdb_config_data {
> +	const char *refs_backend_type;
> +	const char *refs_base;
> +};
> +/*
> + * Read the refdb configuration data out of the config file
> + */
> +int refdb_config(const char *var, const char *value, void *ptr);
> +
> +struct ref_be;
>  int set_refs_backend(const char *name, void *data);
>  
> +void register_refs_backend(struct ref_be *be);
> +
>  #endif /* REFS_H */
> diff --git a/setup.c b/setup.c
> index d343725..de6b8ac 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "dir.h"
> +#include "refs.h"
>  #include "string-list.h"
>  
>  static int inside_git_dir = -1;
> @@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>  	return ret;
>  }
>  
> +int refdb_config(const char *var, const char *value, void *ptr)
> +{
> +       struct refdb_config_data *cdata = ptr;
> +
> +       if (!strcmp(var, "core.refsbackendtype"))
> +	       cdata->refs_backend_type = xstrdup((char *)value);

Unnecessary cast.

> +       return 0;
> +}
> +
>  /*
>   * Test if it looks like we're at a git directory.
>   * We want to see:

I can guarantee that before long somebody will want a config option that
can be put in a global .gitconfig to choose the default refs backend
type for new repositories when it is not specified explicitly via the
command line. But that can wait :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu

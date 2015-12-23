From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 14/16] refs: allow ref backend to be set for clone
Date: Wed, 23 Dec 2015 14:51:25 +0100
Message-ID: <567AA6DD.9000404@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-15-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 14:51:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBjpI-0000y2-8X
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 14:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933869AbbLWNvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 08:51:32 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43153 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932322AbbLWNvb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 08:51:31 -0500
X-AuditID: 1207440e-f79516d0000012b3-c0-567aa6e04ac5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B5.38.04787.0E6AA765; Wed, 23 Dec 2015 08:51:28 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBNDpPTm026195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 08:51:26 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <1449102921-7707-15-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqPtgWVWYwfEj4hbzN51gtOi60s1k
	sfLxXWaLidMWMzuweLS/f8fsseD5fXaPz5vkPG4/28YSwBLFbZOUWFIWnJmep2+XwJ0x4V8L
	a8FNrYrGhTUNjHOVuhg5OCQETCSeHNfrYuQEMsUkLtxbzwZiCwlcZpRo3erexcgFZF9gktj7
	6y47SEJYwE3i7+kzjCC2iICDxOVdR5khGtoYJeZMFQKx2QR0JRb1NDNBDJWT6O2exAJiMwu4
	S0w/MB8sziugLbFhxSWwmSwCqhLLV/wCs0UFQiT27uxggagRlDg58wmYzSngKdH3r58VYo6e
	xI7rv6BseYnmrbOZJzAKzkLSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr
	5WaW6KWmlG5ihAQ53w7G9vUyhxgFOBiVeHgd2yrDhFgTy4orcw8xSnIwKYnyRldVhQnxJeWn
	VGYkFmfEF5XmpBYfYpTgYFYS4U1/B1TOm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQ
	WgSTleHgUJLgXbkUaKhgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KHrji4HxC5Li
	Ado7BaSdt7ggMRcoCtF6ilFRSpy3GiQhAJLIKM2DGwtLXa8YxYG+FObdDlLFA0x7cN2vgAYz
	AQ3+s64cZHBJIkJKqoGR9YDMhlTJh1n5c59N2b3y8L8HVnIfTXaZx528ftSc/UtFiZRagmA3
	1/MJWy8KNt8qe3a+c6+9SPWnB2pp/3Rmiv91dF/ypI4xRall5fZXtW2fgt48PbdZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282946>

On 12/03/2015 01:35 AM, David Turner wrote:
> Add a new option, --refs-backend-type, to allow the ref backend type to
> be set on new clones.
> 
> Submodules must use the same ref backend as the parent repository, so

^^^ is this verified anywhere? Hint: if not, it probably should be. For
example, imagine a future where an existing repository can be migrated
in place from files -> lmdb. If somebody runs that command in a
submodule, this invariant would be broken and *this* version of git
would have to at least detect the problem and refuse to corrupt things.

I added CC to a couple submodules experts in case they have any
feedback. Are there any other code paths that can lead to submodules
being newly cloned, where this option would also have to be passed?

> we also pass the --refs-backend-type option option when cloning
> submodules.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-clone.txt |  4 ++++
>  builtin/clone.c             | 27 +++++++++++++++++++++++++--
>  builtin/submodule--helper.c |  5 ++++-
>  cache.h                     |  1 +
>  4 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 6bf000d..431575b 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -14,6 +14,7 @@ SYNOPSIS
>  	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
>  	  [--dissociate] [--separate-git-dir <git dir>]
>  	  [--depth <depth>] [--[no-]single-branch]
> +	  [--refs-backend-type=<name>]
>  	  [--recursive | --recurse-submodules] [--] <repository>
>  	  [<directory>]
>  
> @@ -221,6 +222,9 @@ objects from the source repository into a pack in the cloned repository.
>  	The result is Git repository can be separated from working
>  	tree.
>  
> +--refs-backend-type=<name>::
> +	Type of refs backend. Default is to use the original files based
> +	backend.
>  
>  <repository>::
>  	The (possibly remote) repository to clone from.  See the
> diff --git a/builtin/clone.c b/builtin/clone.c
> index caae43e..a53f341 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -92,11 +92,13 @@ static struct option builtin_clone_options[] = {
>  		   N_("separate git dir from working tree")),
>  	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
>  			N_("set config inside the new repository")),
> +	OPT_STRING(0, "refs-backend-type", &refs_backend_type,
> +		   N_("name"), N_("name of backend type to use")),
>  	OPT_END()
>  };
>  
>  static const char *argv_submodule[] = {
> -	"submodule", "update", "--init", "--recursive", NULL
> +	"submodule", "update", "--init", "--recursive", NULL, NULL
>  };
>  
>  static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
> @@ -724,8 +726,24 @@ static int checkout(void)
>  	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
>  			   sha1_to_hex(sha1), "1", NULL);
>  
> -	if (!err && option_recursive)
> +	if (!err && option_recursive) {
> +		const char **backend_arg = argv_submodule;
> +		char *new_backend_arg = NULL;
> +		if (refs_backend_type) {
> +			while (*backend_arg)
> +				++backend_arg;
> +
> +			new_backend_arg = xmalloc(21 + strlen(refs_backend_type));
> +			sprintf(new_backend_arg, "--refs-backend-type=%s",
> +				refs_backend_type);
> +			*backend_arg = new_backend_arg;
> +		}
>  		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
> +		if (refs_backend_type) {
> +			free(new_backend_arg);
> +			*backend_arg = NULL;
> +		}
> +	}

I sent a separate email about this hunk:


http://mid.gmane.org/c21eb4a5d3a3a4886c45da0abe307fe1772e932e.1450869637.git.mhagger@alum.mit.edu

>  
>  	return err;
>  }
> @@ -744,6 +762,11 @@ static void write_config(struct string_list *config)
>  					       write_one_config, NULL) < 0)
>  			die("unable to write parameters to config file");
>  	}
> +
> +	if (refs_backend_type &&
> +	    write_one_config("core.refsBackendType",
> +			     refs_backend_type, NULL) < 0)
> +		die("unable to write backend parameter to config file");
>  }
>  
>  static void write_refspec_config(const char *src_ref_prefix,
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff..5c9ca4e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -140,7 +140,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>  		argv_array_pushl(&cp.args, "--reference", reference, NULL);
>  	if (gitdir && *gitdir)
>  		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
> -
> +	if (refs_backend_type && *refs_backend_type) {
> +		argv_array_push(&cp.args, "--refs-backend-type");
> +		argv_array_push(&cp.args, refs_backend_type);
> +	}

This could be shortened to

    argv_array_pushf(&cp.args, "--refs-backend-type=%s", refs_backend_type);

>  	argv_array_push(&cp.args, url);
>  	argv_array_push(&cp.args, path);
>  
> diff --git a/cache.h b/cache.h
> index d1534db..8f2ca55 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -695,6 +695,7 @@ enum object_creation_mode {
>  extern enum object_creation_mode object_creation_mode;
>  
>  extern char *notes_ref_name;
> +extern const char *refs_backend_type;
>  
>  extern const char *refs_backend_type;

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu

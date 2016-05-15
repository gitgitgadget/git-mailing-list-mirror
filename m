From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v10 20/20] untracked-cache: config option
Date: Sun, 15 May 2016 16:43:21 +0700
Message-ID: <CACsJy8CV4tue8LscUuBcVyu-xnKadtJEajr7+X-q-RhqgdW01g@mail.gmail.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com> <1463084415-19826-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun May 15 11:44:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1sai-0005k5-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 11:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbcEOJny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 05:43:54 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33092 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbcEOJnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 05:43:53 -0400
Received: by mail-lf0-f54.google.com with SMTP id y84so106754490lfc.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fwjl/vdUoB5ohDGK5LXL97cr3DtG50p2mqbIvANoCtg=;
        b=Lzf/d9yFde3u9RmRAb0AqmKWcpMRwNtrGk3mHzUe7ZUt9sCH63U/HrAtJMZYT0XQIl
         GXBSt364XsRZs57xvUd0VX3dc3VS4wTFOe6VhSmQ5YPQbhVCTqCakRdpHErtI61oMAAf
         C9trIx+WV3Y4VZrQl89FNspfpnzeK1EU0O9AiagNzO+IRvc5fmlLG9wtLw2HhuhsX0q/
         n2qBD90lCDtcqd15rf+p/O4kwDPxmxUisIvdvTkKLBQAsAxHRZOpifqGDLIbd97Cd90F
         RkFpfQKHlTW8l9xhLmKHTK/UTdVOFcLvg/0vMjyGE5ypLk875r86Eq9QoYaHAmPPDoPB
         1x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fwjl/vdUoB5ohDGK5LXL97cr3DtG50p2mqbIvANoCtg=;
        b=VrS7PoetSEEsCkMU3ZAOCb2A4DSx555IHEE+1/DTdjm2tQLRgyQUOkn0J6uCi+cVgW
         LYJTkob2BEr1pibpjcC/a3WTUZA6ip4mDeuk+/N4GQkEvvIoX/hbGc57zYG6R4QTBlYJ
         yUj8+L3b3NiSPaBCTWrTBHTTNoPN6zdCg1zPQUqdS3+i6ytLgJDCLpQve/NN9P5rJpIn
         8HUeQOxykK9rpxhkYQCWE4PQZt++4jSUykETGVG1NLrxZgnZFcmc9R4NMbaw/pKoW9xG
         xnx4ijxqmk8ao4fwnVOyYrZyF9vhwCdJDXVsGAiVtdtQpCHdLjjYa8y9WsFX6ONMOZ6Z
         DrAg==
X-Gm-Message-State: AOPr4FUIub4IbAErIuje7KLyyPm6PHJm3h5CAH5tDrcrOfnULWBPk6hec9NkkMJitBCwd2tlumBtqekqG8Hi8A==
X-Received: by 10.25.165.70 with SMTP id o67mr451317lfe.162.1463305431405;
 Sun, 15 May 2016 02:43:51 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sun, 15 May 2016 02:43:21 -0700 (PDT)
In-Reply-To: <1463084415-19826-21-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294646>

On Fri, May 13, 2016 at 3:20 AM, David Turner <dturner@twopensource.com> wrote:
> Add a config option to populate the untracked cache.
>
> For installations that have centrally-managed configuration, it's
> easier to set a config once than to run update-index on every
> repository.

This sounds like the job for core.untrackedCache. It populates after
reading the index though (in post_read_index_from) not writing, but I
think it accomplishes the same thing.

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/config.txt | 4 ++++
>  read-cache.c             | 7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 385ea66..c7b76ef 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1848,6 +1848,10 @@ imap::
>         The configuration variables in the 'imap' section are described
>         in linkgit:git-imap-send[1].
>
> +index.adduntrackedcache::
> +       Automatically populate the untracked cache whenever the index
> +       is written.
> +
>  index.addwatchmanextension::
>         Automatically add the watchman extension to the index whenever
>         it is written.
> diff --git a/read-cache.c b/read-cache.c
> index 22c64d0..4a1cccf 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2472,7 +2472,7 @@ static int do_write_index(struct index_state *istate, int newfd,
>         int entries = istate->cache_nr;
>         struct stat st;
>         struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> -       int watchman = 0;
> +       int watchman = 0, untracked = 0;
>         uint64_t start = getnanotime();
>
>         for (i = removed = extended = 0; i < entries; i++) {
> @@ -2502,6 +2502,11 @@ static int do_write_index(struct index_state *istate, int newfd,
>             !the_index.last_update)
>                 the_index.last_update = xstrdup("");
>
> +       if (!git_config_get_bool("index.adduntrackedcache", &untracked) &&
> +           untracked &&
> +           !istate->untracked)
> +               add_untracked_cache(&the_index);
> +
>         hdr_version = istate->version;
>
>         hdr.hdr_signature = htonl(CACHE_SIGNATURE);
> --
> 2.4.2.767.g62658d5-twtrsrc
>



-- 
Duy

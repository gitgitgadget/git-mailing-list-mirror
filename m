From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Completion: Cleanup tcsh script and add debug flag
Date: Fri, 29 May 2015 12:37:18 -0700
Message-ID: <xmqqd21jch01.fsf@gitster.dls.corp.google.com>
References: <CAFj1UpGpGS-C2EWif4sk_ijq8PjpM1UY09+vLwbjX17idZdkfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 21:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyQ5u-0002tJ-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 21:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbbE2ThX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 15:37:23 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37837 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718AbbE2ThU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 15:37:20 -0400
Received: by igbsb11 with SMTP id sb11so22477683igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=z90T0fHcMaBt4dAGH2KqtSZyO9xqenZ+VO06N8+ZGKw=;
        b=hZIcJZiQEVXdNF5LumNxppA2eXZ3TeI6REnO5bbZ5WZOZb/bpnOB/Hv2viAQCPblx/
         c/rO8MiY61wowbOjFRF8rl+jbX9NMwdMbXAmaU3nlpCooBVrii+OoDwMPIpCwmxgfR9y
         Ozh9509k5CBeZFEXTMWsNLHwlYrfDDrVFOGsMjHFhC/NcgGsw3l5J0QIriUX5WRNu88T
         kX5msype7OiTAEgLw2NC+WLRb3D6MEW+4xNfSvpIc6BsKbX91J8InZDYn0Kn8oN+mCKI
         koz9WizQgVptEV5sZmcPosFzaAYBdnh5g4hGK9ZvZIYGp9fRA15Ihejv3tQgd/GMZYcd
         4FFw==
X-Received: by 10.42.177.198 with SMTP id bj6mr17195864icb.0.1432928240256;
        Fri, 29 May 2015 12:37:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id lq3sm2187848igb.3.2015.05.29.12.37.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 12:37:19 -0700 (PDT)
In-Reply-To: <CAFj1UpGpGS-C2EWif4sk_ijq8PjpM1UY09+vLwbjX17idZdkfA@mail.gmail.com>
	(Marc Khouzam's message of "Thu, 23 Apr 2015 21:07:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270266>

Marc Khouzam <marc.khouzam@gmail.com> writes:

> Remove overriding of __git_index_file_list_filter
> since that method is no longer used in git-completion.bash.
> Overriding that method was needed before to get
> git-completion.bash to append a '/' to the end
> of directories; this does not seem to be needed anymore since
> that script no longer provides completions of directories/files.
>
> Also add -d/--debug flag support to help troubleshoot
> the script.
>
> Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
> ---
>
> I thought this would help when for people that experience issues with
> the script.

Thanks; unfortunately what I received suffers from serious
whitespace damages.  All the tabs in preimage seem to have been
corrupted into runs of whitespaces, and I suspect the same for tabs
in the new lines, too.

>
> Thanks!
>
> Marc
>
>  contrib/completion/git-completion.tcsh |   50 +++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/contrib/completion/git-completion.tcsh
> b/contrib/completion/git-completion.tcsh
> index 6104a42..fd0b906 100644
> --- a/contrib/completion/git-completion.tcsh
> +++ b/contrib/completion/git-completion.tcsh
> @@ -1,6 +1,6 @@
>  # tcsh completion support for core Git.
>  #
> -# Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
> +# Copyright (C) 2012, 2015 Marc Khouzam <marc.khouzam@gmail.com>
>  # Distributed under the GNU General Public License, version 2.0.
>  #
>  # When sourced, this script will generate a new script that uses
> @@ -22,6 +22,25 @@
>  #       add the following line to your .tcshrc/.cshrc:
>  #        set autolist=ambiguous
>  #       It will tell tcsh to list the possible completion choices.
> +#
> +# To debug this script one can use the -d flag by running the
> +# generated final script directly.  For example, to see the completions
> +# generated when pressing <tab> for the command line:
> +#     git co
> +# one should run:
> +#     bash ~/.git-completion.tcsh.bash -d git 'git co'
> +# and will obtain:
> +#     =====================================
> +#     git-completion.bash returned:
> +#     commit  config
> +#     =====================================
> +#     Completions including tcsh additions:
> +#     commit  config
> +#     =====================================
> +#     Final completions returned:
> +#     commit
> +#     config
> +#
>
>  set __git_tcsh_completion_version = `\echo ${tcsh} | \sed 's/\./ /g'`
>  if ( ${__git_tcsh_completion_version[1]} < 6 || \
> @@ -48,20 +67,17 @@ cat << EOF > ${__git_tcsh_completion_script}
>  # Do not modify it directly.  Instead, modify git-completion.tcsh
>  # and source it again.
>
> +# Allow for debug printouts when running the script by hand
> +if [ "\$1" == "-d" ] || [ "\$1" == "--debug" ]; then
> +       __git_tcsh_debug=true
> +       shift
> +fi
> +
>  source ${__git_tcsh_completion_original_script}
>
>  # Remove the colon as a completion separator because tcsh cannot handle it
>  COMP_WORDBREAKS=\${COMP_WORDBREAKS//:}
>
> -# For file completion, tcsh needs the '/' to be appended to directories.
> -# By default, the bash script does not do that.
> -# We can achieve this by using the below compatibility
> -# method of the git-completion.bash script.
> -__git_index_file_list_filter ()
> -{
> -       __git_index_file_list_filter_compat
> -}
> -
>  # Set COMP_WORDS in a way that can be handled by the bash script.
>  COMP_WORDS=(\$2)
>
> @@ -83,6 +99,12 @@ fi
>  # Call _git() or _gitk() of the bash script, based on the first argument
>  _\${1}
>
> +if [ "\$__git_tcsh_debug" == "true" ]; then
> +       echo =====================================
> +       echo git-completion.bash returned:
> +       echo "\${COMPREPLY[@]}"
> +fi
> +
>  IFS=\$'\n'
>  if [ \${#COMPREPLY[*]} -eq 0 ]; then
>         # No completions suggested.  In this case, we want tcsh to perform
> @@ -108,6 +130,14 @@ if [ \${#COMPREPLY[*]} -eq 0 ]; then
>         fi
>  fi
>
> +if [ "\$__git_tcsh_debug" == "true" ]; then
> +       echo =====================================
> +       echo Completions including tcsh additions:
> +       echo "\${COMPREPLY[@]}"
> +       echo =====================================
> +       echo Final completions returned:
> +fi
> +
>  # tcsh does not automatically remove duplicates, so we do it ourselves
>  echo "\${COMPREPLY[*]}" | sort | uniq

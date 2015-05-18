From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] pull: handle git-fetch's options as well
Date: Mon, 18 May 2015 16:37:17 +0200
Organization: gmx
Message-ID: <1a102d8dabff79207c0d7e3bf434bd6f@www.dscho.org>
References: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 16:37:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMAa-0005xT-PT
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 16:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbbEROhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 10:37:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:61718 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbbEROhU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 10:37:20 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lmvlg-1ZNtcP1uJg-00h9hq; Mon, 18 May 2015 16:37:17
 +0200
In-Reply-To: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:i1sHXqKggVoiwnFiSVuVAmg31b9mAGKqEO954kmyxys72Fn0qms
 EOjjb6T8lZyeX4aFenDGvU/mi2hqbFxh4yAIPCbxj22iR+kzkXM9FnVQynF6qB2ZJJZSkmF
 qs457zZXkHK0A6kAQSfnBkb/M+nln2p+T36kE+SfOvbklg+xfpsL9vbtvPd0/t6g9muRXqT
 BPdesCKy5QUskzNZ6U29w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269253>

Hi Paul,

On 2015-05-18 15:30, Paul Tan wrote:
> t5520: failing test for pull --all with no configured upstream
> t5521: test pull --all --dry-run does not make any changes
> 
> error_on_no_merge_candidates() does not consider the case where "$#"
> includes command-line flags that are passed to git-fetch.
> 
> As such, when the current branch has no configured upstream, and there
> are no merge candidates because of that, git-pull --all erroneously reports
> that we are pulling from "--all", as it believes that the first argument
> is the remote name.
> 
> Add a failing test that shows this case.
> 
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  git-pull.sh             | 34 ++++++++++++++++++++++++++++++++--
>  t/t5520-pull.sh         | 20 ++++++++++++++++++++
>  t/t5521-pull-options.sh | 14 ++++++++++++++
>  3 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/git-pull.sh b/git-pull.sh
> index 9ed01fd..28d49ab 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -163,11 +163,39 @@ do
>  	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
>  		dry_run=--dry-run
>  		;;
> +	--all|--no-all)
> +		all=$1 ;;

I *think* you also want to add a corresponding "all=" line just below the "dry_run=" line, to ensure that "all=blablabla git pull" does not interfere with this command-line setting.

The patch looks fine to me, otherwise.

Ciao,
Dscho

From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 4/7] git-reflog: add exists command
Date: Tue, 21 Jul 2015 06:27:33 -0700
Message-ID: <55AE48C5.8000007@alum.mit.edu>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com> <1436482260-28088-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	j6t@kdbg.org
X-From: git-owner@vger.kernel.org Tue Jul 21 15:28:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHXau-0002hb-1b
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 15:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbbGUN1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 09:27:50 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54711 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754491AbbGUN1q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 09:27:46 -0400
X-AuditID: 12074412-f79a76d000007c8b-15-55ae48c8c3fd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 94.5D.31883.8C84EA55; Tue, 21 Jul 2015 09:27:36 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LDRXIS006276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 09:27:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436482260-28088-5-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1D3hsS7U4MpSNov5m04wWnRd6Way
	eDL3LrMDs8fDV13sHgue32f3+LxJLoA5itsmKbGkLDgzPU/fLoE7Y9/JVcwFjTwVE1YsYmtg
	vMLZxcjJISFgIvHlxCQmCFtM4sK99WwgtpDAZUaJeb2aXYxcQPYmJolFn5YCFXFw8ApoS7w+
	ww9SwyKgKnHo7w5mEJtNQFdiUU8zWImoQJDE65e5IGFeAUGJkzOfsIDYIgJ+Etu65jCC2MIC
	VhIbJ/9ihhjfyiixfdofNpBeTgFPiaWPCkFqmAX0JHZc/8UKYctLbH87h3kCI/8sJGNnISmb
	haRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQABXawbj+pNwhRgEO
	RiUe3oqWtaFCrIllxZW5hxglOZiURHn1jdaFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh/WIP
	lONNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuDNcwdqFCxKTU+tSMvM
	KUFIM3FwggznkhIpTs1LSS1KLC3JiAdFY3wxMB5BUjxAextB2nmLCxJzgaIQracYFaXEeWtA
	EgIgiYzSPLixsLTzilEc6Eth3skgVTzAlAXX/QpoMBPQ4Fuz1oAMLklESEk1MMYbmZeIlF5/
	YqA71aNSpnXVM5env/8/TrLufCvj/dSz3aW6ZL/6jxUHKhOU7t+4Ela21VYqz8f0u59erkv1
	hOZtd8/PWih9vVVmtkB3Tjz7tVbDziULwj4uW3LK1SPcVjDOdcWcZa0Wnj7N/R9v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274377>

On 07/09/2015 03:50 PM, David Turner wrote:
> Theis are necessary because alternate ref backends might store reflogs
> somewhere other than .git/logs.  Code that now directly manipulates
> .git/logs should instead go through git-reflog.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-reflog.txt |  4 ++++
>  builtin/reflog.c             | 33 ++++++++++++++++++++++++++++++++-
>  t/t1411-reflog-show.sh       |  5 +++++
>  3 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
> index 5e7908e..4b08fc7 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -23,6 +23,7 @@ depending on the subcommand:
>  	[--dry-run] [--verbose] [--all | <refs>...]
>  'git reflog delete' [--rewrite] [--updateref]
>  	[--dry-run] [--verbose] ref@\{specifier\}...
> +'git reflog exists' <ref>
>  
>  Reference logs, or "reflogs", record when the tips of branches and
>  other references were updated in the local repository. Reflogs are
> @@ -52,6 +53,9 @@ argument must be an _exact_ entry (e.g. "`git reflog delete
>  master@{2}`"). This subcommand is also typically not used directly by
>  end users.
>  
> +The "exists" subcommand checks whether a ref has a reflog.  It exists

The second "exists" should be "exits".

> +with zero status if the reflog exists, and non-zero status if it does
> +not.
>  
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu

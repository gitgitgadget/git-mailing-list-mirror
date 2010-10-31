From: Kevin Ballard <kevin@sb.org>
Subject: Re: Add colors to the prompt for status indicators
Date: Sat, 30 Oct 2010 23:26:21 -0700
Message-ID: <334DB5BC-BE36-4D83-B358-3982DBA38EA1@sb.org>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 07:32:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCRT7-0001OY-8U
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 07:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab0JaG00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 02:26:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39031 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab0JaG0Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Oct 2010 02:26:24 -0400
Received: by iwn10 with SMTP id 10so5628767iwn.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 23:26:24 -0700 (PDT)
Received: by 10.231.146.80 with SMTP id g16mr12595278ibv.70.1288506384132;
        Sat, 30 Oct 2010 23:26:24 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id d21sm3103003ibg.3.2010.10.30.23.26.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 23:26:23 -0700 (PDT)
In-Reply-To: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160417>

You could write a shell function that takes a string as an argument and inserts the appropriate color codes based on string substitution, and then just pass the results of __git_ps1 to that function.

Something like the following might work:

function __my_git_colorize_ps1 () {
    echo "$1" | while read -N 1 char; do
        case "$char" in
            \*) echo -n $'\e[34m*\e[m';;
            +) echo -n $'\e[31m+\e[m';;
            $) echo -n $'\e[32m$\e[m';;
            %) echo -n $'\e[1;34m%\e[m';;
            \<|\>) echo -n $'\e[31m'"$char"$'\e[m';;
            *) echo -n "$char";;
        esac
    done
}

-Kevin Ballard

On Oct 30, 2010, at 9:14 PM, Sebastien Douche wrote:

> Hi,
> the prompt (git-completion.bash) bundled with git is the most
> "advanced" I found on the web. But I would add colors for "status".
> Example show: * (unstaged) in blue, + (staged in red), $ (stashed) in
> green, % (untracked) in bold blue and < > <> (upstream indicator) in
> red.
> 
> How make this?
> 
> Cheers
> 
> -- 
> Sebastien Douche <sdouche@gmail.com>
> Twitter: http://bit.ly/afkrK (agile, lean, python, git, open source)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

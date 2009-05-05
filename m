From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Two problems on alias of git
Date: Tue, 05 May 2009 07:03:49 -0700 (PDT)
Message-ID: <m3bpq7oddw.fsf@localhost.localdomain>
References: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kana Natsuno" <kana@whileimautomaton.net>
X-From: git-owner@vger.kernel.org Tue May 05 16:04:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1LFY-0003RO-PG
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 16:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbZEEODw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 10:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbZEEODv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 10:03:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:44808 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbZEEODu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 10:03:50 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3498656rvb.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wyDJNrTLKJ7or/cswUi4PuD5Em1nOG2+F5rR0g5zCMw=;
        b=lRSBFmNkIVEdcA7R3ZCPX45S8EE5pFVgi2Gc025HLgrWSfeFBFiX5AVmhe6f32YXY0
         KWicpk6kCWBV1hGCeh4x+Uvdkffsn7OoR60TiDzC9J1l7Q/bH8ob5GIp2bWNVkhNh2Ha
         uzW0ZqcC14b0Xii54qpcK+SoIEa6Bm8m8jelM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=NTtkPMF+0CtuCQr366EIM8ClzM0yB/nci8CwLN92T77iYlgsqkJv+rHD8Iu86b+ne+
         6mS7d89GefppLqotl0HZbEKoMzxa6QCQxkY8HYcmi35ADPWabcHcgsXXHDE2/C+7H83v
         19EYhM7xfrdHZE5aCq1TF+GZv0vkgVvgijY/o=
Received: by 10.114.102.20 with SMTP id z20mr63452wab.53.1241532230467;
        Tue, 05 May 2009 07:03:50 -0700 (PDT)
Received: from localhost.localdomain (abwk74.neoplus.adsl.tpnet.pl [83.8.234.74])
        by mx.google.com with ESMTPS id y11sm33696531pod.18.2009.05.05.07.03.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 07:03:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n45E3i46025767;
	Tue, 5 May 2009 16:03:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n45E3ggS025763;
	Tue, 5 May 2009 16:03:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118298>

"Kana Natsuno" <kana@whileimautomaton.net> writes:

> Hello.  I found 2 problems on alias of git.

[...]
> The second one is that git doesn't expand a kind of aliases
> properly, especially with double quotation marks (").  I used the
> following alias recently to list the last 10 commits on HEAD:
> 
> [alias]
>         lr = !git l1 | head | tac
> 
> Then I want to extend this alias to list the last N commits on
> a branch with "git lr 20", "git lr master", "git lr master 20",
> etc.  So that I wrote the following definition (note that the
> actual definition is written in a single line, though the quoted
> definition is folded in multiple lines for readability):
> 
> [alias]
>         lr = !$SHELL -c '
>                 n=10;
>                 1="${1:-$n}";
>                 if ! [ "${1##[0-9]*}" = "" ]; then
>                   t="$1";
>                   1="${2:-$n}";
>                   2="$t";
>                 fi;
>                 git --no-pager l1 --reverse -"$1" "${2:-HEAD}"
>               ' __dummy__
> 
> But it doesn't work because git expands as follows:
> 
> $ git config --get alias.lr
> !$SHELL -c '1=${1:-10}
> 
> Double quotation marks (") are removed and the aliased string is
> cut at a random position.  I expect that the aliased string is
> passed to system() as-is, but git doesn't so.  Why does git behave
> so?  Is it a bug or an intentional behavior?

I don't know if it is a bug or a feature, but git-config supports
quoted strings (required if you want to have value which has trailing
or leading whitespace, or which contains '#' which is beginning of
comment character).  Inside quoted string you need to escape '"':

   [string]
        quotes = "quoted \" string ' with # character"

expands as intended.  Perhaps stripping of double quotes
inside string are artifact of that feature.  Try escaping or
double escaping quotes: \" or \\\".

-- 
Jakub Narebski
Poland
ShadeHawk on #git

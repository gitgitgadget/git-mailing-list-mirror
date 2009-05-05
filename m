From: "Kana Natsuno" <kana@whileimautomaton.net>
Subject: Re: Two problems on alias of git
Date: Wed, 06 May 2009 01:25:50 +0900
Message-ID: <op.utgs86ta6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
References: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
 <m3bpq7oddw.fsf@localhost.localdomain>
 <op.utgptirm6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
 <200905051742.51163.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 18:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1NTF-0001ym-F3
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 18:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbZEEQ0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 12:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbZEEQ0A
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 12:26:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:46533 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbZEEQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 12:25:59 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3555259rvb.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:to:subject:from
         :cc:content-type:mime-version:references:content-transfer-encoding
         :message-id:in-reply-to:user-agent;
        bh=/mh59gJ9yj8hEeII8vnGScHcwIGyHu/bT5gHlfeK27g=;
        b=gW6Seg9YCxNMjfIA4ljgUKrxq7Y8oNzmG8Xin0D4u7B/qT/lUGcWhYLZ2B7eeDdOZg
         AmAzROmjXQr++erwuKQiyZis5QEjvIF9s2nKpTuERDlPk0X33gsvqztha1akMEphryHT
         NKhtrt2WDHSiA7zK1MliJ5Ni1Tv60PBoEuMKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:to:subject:from:cc:content-type:mime-version:references
         :content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=wYfJylKdfGnNt1B0At0IuByOdZUF29rYb/rSlA+AnscqzBTCPDWmb2lIX+/ANslfm+
         o8zVOHSN5zdO+kySM9GHJSA7yeASrZ3ZEZmJk0Y+ndbTZXiAdvpfD0DGPyFlXftlT90v
         HBXWsO/zRofXqT7f/iRhtAfJekGLrlk27srAM=
Received: by 10.141.75.12 with SMTP id c12mr66361rvl.276.1241540758631;
        Tue, 05 May 2009 09:25:58 -0700 (PDT)
Received: from i220-99-253-139.s27.a098.ap.plala.or.jp (i220-99-253-139.s27.a098.ap.plala.or.jp [220.99.253.139])
        by mx.google.com with ESMTPS id c20sm18474922rvf.50.2009.05.05.09.25.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 09:25:58 -0700 (PDT)
In-Reply-To: <200905051742.51163.jnareb@gmail.com>
User-Agent: Opera Mail/9.63 (MacIntel)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118305>

On Wed, 06 May 2009 00:42:49 +0900, Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, you can use continuation-of-line character (end line
> with '\') and/or can embed newlines using C escape sequence, i.e. "\n".
>
> So your code can look like this (although I am not sure it is worth it):
>
>   [alias]
>         lr = "!$SHELL -c '                               \n\
>                 n=10;                                    \n\
>                 1=\"${1:-$n}\";                          \n\
>                 if ! [ \"${1##[0-9]*}\" = \"\" ]; then   \n\
>                   t=\"$1\";                              \n\
>                   1=\"${2:-$n}\";                        \n\
>                   2=\"$t\";                              \n\
>                 fi;                                      \n\
>                 git --no-pager l1 --reverse -\"$1\" \"${2:-HEAD}\" \n\
>               ' __dummy__"

Thank you again, I didn't know that.  It is better than what I wrote.


> BTW. you need to quote value because it contains comment character '#'
> in 4th line of script.

Really?  As far as I read the code of git, especially parse_value() in config.c,
it is not necessary to escape '#'s because they are inside of the outermost
doublequotes and they should not be escaped, because \# is an unknown escape
sequence and git rejects them.  If #s are escaped, it causes an error as follows:

$ git config --get alias.lr
fatal: bad config file line 29 in /Users/kana/.gitconfig


-- 
To Vim, or not to Vim.
http://whileimautomaton.net/

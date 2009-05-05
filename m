From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Two problems on alias of git
Date: Tue, 5 May 2009 17:42:49 +0200
Message-ID: <200905051742.51163.jnareb@gmail.com>
References: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp> <m3bpq7oddw.fsf@localhost.localdomain> <op.utgptirm6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kana Natsuno" <kana@whileimautomaton.net>
X-From: git-owner@vger.kernel.org Tue May 05 17:43:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1MnS-0003l5-Ax
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 17:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbZEEPm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 11:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZEEPm5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 11:42:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:43852 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbZEEPm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 11:42:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3538170rvb.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3oVFnjZWhfIZSpYKiHycaqxM+z15dmGJw3DoTrs3wHE=;
        b=M49GIvUqttb4U35Q4XjW1vCFgms5+3SQn3gQLoA7/9n2nP3yTDuIdz9TEZ6r5jrJwq
         TDkbMTxW8VRyYPSn4939IrV5qnkO4mjHPn0l5nciE6PcC8bUIlKFSRe9WQkxp4wnIXvE
         ZA5x7P0rBtoBuycGuSwTe75OBR9egqWl7IrwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JTKm26cIhRSwjHwk9zbastf+3hkO2gHYXMVMp1MmXdgGjzIvX9e2fxcGMiP41cnppm
         yOipupL7whiKhr4wcKA9WhZFmaNFDDi50NtPU8g34Jnh/TwLhIbsz5gs5tnVEz7IC+SL
         wzoOqfWgQqKTuOE11IlcSfk4sCbTe2kl98MgM=
Received: by 10.141.84.21 with SMTP id m21mr59057rvl.98.1241538176507;
        Tue, 05 May 2009 08:42:56 -0700 (PDT)
Received: from ?192.168.1.13? (abwk74.neoplus.adsl.tpnet.pl [83.8.234.74])
        by mx.google.com with ESMTPS id g22sm18717424rvb.36.2009.05.05.08.42.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 08:42:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <op.utgptirm6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118303>

On Tue, 5 May 2009, Kana Natsuno wrote:
> On Tue, 05 May 2009 23:03:49 +0900, Jakub Narebski <jnareb@gmail.com> wrote:

> > I don't know if it is a bug or a feature, but git-config supports
> > quoted strings (required if you want to have value which has trailing
> > or leading whitespace, or which contains '#' which is beginning of
> > comment character).  Inside quoted string you need to escape '"':

Errr... what I meant here is that I don't know whether stripping
quotes inside value which is not quoted (does not begin and end in '"')
is intended or unintended consequence of git-config behaviour.

> >
> >    [string]
> >         quotes = "quoted \" string ' with # character"
> >
> > expands as intended.  Perhaps stripping of double quotes
> > inside string are artifact of that feature.  Try escaping or
> > double escaping quotes: \" or \\\".
> 
> Thank you for the information.  I've read the source code of git
> and I confirmed that this stripping is caused by parse_value() in
> config.c.
> 
> 
> And as I changed the old definition
> 
>         lr = !$SHELL -c 'n=10; 1="${1:-$n}"; ...' __dummy__
> 
> by enclosing all text in double quotes and substituting '"' with
> '\"' as follows,
> 
> 	lr = "!$SHELL -c 'n=10; 1=\"${1:-$n}\"; ...' __dummy__"
> 
> it works well now.
> 
> 	$ git config --get alias.lr
> 	!$SHELL -c 'n=10; 1="${1:-$n}"; if ! [ "${1##[0-9]*}" ...

By the way, you can use continuation-of-line character (end line
with '\') and/or can embed newlines using C escape sequence, i.e. "\n".

So your code can look like this (although I am not sure it is worth it):

  [alias]
        lr = "!$SHELL -c '                               \n\
                n=10;                                    \n\
                1=\"${1:-$n}\";                          \n\
                if ! [ \"${1##[0-9]*}\" = \"\" ]; then   \n\
                  t=\"$1\";                              \n\
                  1=\"${2:-$n}\";                        \n\
                  2=\"$t\";                              \n\
                fi;                                      \n\
                git --no-pager l1 --reverse -\"$1\" \"${2:-HEAD}\" \n\
              ' __dummy__"

BTW. you need to quote value because it contains comment character '#'
in 4th line of script.

-- 
Jakub Narebski
Poland

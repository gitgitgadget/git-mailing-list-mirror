From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 16:10:11 +0300
Message-ID: <20060706161011.ccc2ea1c.tihirvon@gmail.com>
References: <20060706124025.G325584e9@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 15:10:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyTcQ-00060E-1E
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 15:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWGFNKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 09:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWGFNKG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 09:10:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:63507 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030255AbWGFNKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 09:10:04 -0400
Received: by nf-out-0910.google.com with SMTP id y25so197344nfb
        for <git@vger.kernel.org>; Thu, 06 Jul 2006 06:10:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=f1e0SuMPT8vsinzm4JmIoKB6azULAV+LUqiqQt9awrha1e79Wx/iMeqKqwNvj+DwfdfKVDycufz/uMV2nR9yyBbnmEA1glLei03cD5q/XMIq+XpinwjagMV99LgkkU7eWy4zX5EQQhqpDrys6I+6Sb3sbyPzuqniF3fXL9tOPfA=
Received: by 10.48.240.10 with SMTP id n10mr448505nfh;
        Thu, 06 Jul 2006 06:10:03 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id o9sm2053926nfa.2006.07.06.06.10.02;
        Thu, 06 Jul 2006 06:10:03 -0700 (PDT)
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060706124025.G325584e9@leonov.stosberg.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23387>

Dennis Stosberg <dennis@stosberg.net> wrote:

> +	echocheck "for perl"
> +	if test -z "$_perl" ; then
> +		_perl=`which perl`
> +		test "$_perl" || die "cannot find path to perl"
> +	fi
> +	echores "$_perl"

"which" isn't portable. On SunOS 5.9 "which foo" prints error message to
stdout and returns 0.  I use this in my own configure scripts:

path_find()
{
        if test -x "$1"
        then
                echo "$1"
                return 0
        fi
        for i in `echo $PATH | sed 's/:/ /g'`
        do
                if test -x "$i/$1"
                then
                        echo "$i/$1"
                        return 0
                fi
        done
        return 1
}

-- 
http://onion.dynserv.net/~timo/

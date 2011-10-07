From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add Git::config_path()
Date: Fri, 7 Oct 2011 23:44:45 +0200
Message-ID: <201110072344.46556.jnareb@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr> <m3vcs01r32.fsf@localhost.localdomain> <7vk48gtrh9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCIDx-0007qq-Fn
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 23:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab1JGVox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 17:44:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39716 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab1JGVow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 17:44:52 -0400
Received: by eyg7 with SMTP id 7so1587450eyg.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QhXLiXa038Emz4Oh6ok5BIacvLCsRigL9nTSQATbY8A=;
        b=Mjflv2q6T9kU6vFe8IwRo+F72Gu43XJBeDTi+HP2867BDUO6AcfC7uR/3df/wgHWfs
         P5Q7N79zco9CYwDt6CZLUepWWpLBRnzzeqJyVpJHXgFjEv1G2Fm7YacrbGuQwR5IqQbI
         oW8k6pzO3yyP0xsBuvtt8sGyMFfiudetRtIxk=
Received: by 10.223.92.152 with SMTP id r24mr13317048fam.19.1318023891292;
        Fri, 07 Oct 2011 14:44:51 -0700 (PDT)
Received: from [192.168.1.13] (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id b10sm14786655fam.1.2011.10.07.14.44.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 14:44:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk48gtrh9.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183113>

On Mon, 7 Oct 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> > index 3787186..7558f0c 100755
> > --- a/t/t9700-perl-git.sh
> > +++ b/t/t9700-perl-git.sh
> > @@ -43,7 +43,9 @@ test_expect_success \
> >       git config --add test.booltrue true &&
> >       git config --add test.boolfalse no &&
> >       git config --add test.boolother other &&
> > -     git config --add test.int 2k
> > +     git config --add test.int 2k &&
> > +     git config --add test.path "~/foo" &&
> > +     git config --add test.pathexpanded "$HOME/foo"
> 
> Given that test-lib.sh sets up the $HOME away from unknown place to ensure
> repeatability of tests, I am not sure if this test would ever pass.

Well, it passes.

test-lib.sh sets $HOME to "$TRASH_DIRECTORY", but this value of $HOME
is then later seen by "git config --path ..." run by Git::config_path
in t9700/test.pl

  char *expand_user_path(const char *path)
  [...]
                if (username_len == 0) {
                        const char *home = getenv("HOME");
                        if (!home)
                                goto return_null;
                        strbuf_add(&user_path, home, strlen(home));
                } else {
  [...]

-- 
Jakub Narebski
Poland

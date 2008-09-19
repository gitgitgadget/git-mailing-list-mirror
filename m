From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Default exclude rules for Git
Date: Fri, 19 Sep 2008 12:42:31 -0400
Message-ID: <32541b130809190942j10dfde82q15726772a7657520@mail.gmail.com>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
	 <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru>
	 <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
	 <alpine.LNX.1.00.0809181526190.19665@iabervon.org>
	 <20080919050612.GA4423@roro3> <20080919142211.GE10360@machine.or.cz>
	 <7v8wtouoit.fsf@gitster.siamese.dyndns.org>
	 <20080919163311.GH10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Kirill Smelkov" <kirr@landau.phys.spbu.ru>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Bert Wesarg" <bert.wesarg@googlemail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 19 18:44:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgj5g-0004Re-9M
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 18:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbYISQme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYISQme
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 12:42:34 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:61277 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbYISQmd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 12:42:33 -0400
Received: by gxk9 with SMTP id 9so936150gxk.13
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nrT1iqzYVH1qZ8nhboCSQJhvyiLw5+6iwomQVbLx394=;
        b=xBsbrt6Rw2IYxmmnRsMY+a8cbCxvkm5pBEw57YYrh9NX7rEAvnvSmrSN7ievNdCHp4
         MliKxWszuHexK0ROxihnqbsGf4t40WLAv3VFO+71OT4yJZFiRuFiTzRC8Rdw7zx7X1mg
         yFH6iRPF0/0OPtLj6pUzoppiqQxggJlR2q1yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WNelhBfnnU1SHKlbIszL9832EOt7xF1pmYiVTreMHW9N9RE3t5zpTvllKVGLJ/i7wd
         KYJm3S7umVgmuSRaiGljDaxWxD/SV5Eg/NJUAiip1ekvSj2wxLnZFzJ+cwNm/WlK0D5a
         DOdSc4JEmliBiVkEoz2yyTXL+RGA6XztVxy04=
Received: by 10.151.141.16 with SMTP id t16mr3403176ybn.167.1221842551935;
        Fri, 19 Sep 2008 09:42:31 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Fri, 19 Sep 2008 09:42:31 -0700 (PDT)
In-Reply-To: <20080919163311.GH10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96300>

On Fri, Sep 19, 2008 at 12:33 PM, Petr Baudis <pasky@suse.cz> wrote:
> Yes, but the idea here is to give both the projects and the users
> sensible default to work on, in case of users even one that might change
> system to system based on tools behavior. It is that VAST MAJORITY of
> projects won't care about object or (most kinds of) hidden files, so to
> me it makes sense to make people opt out instead of opt in.

The problem here is that the cost of a false positive (ie. too much
ignored) is much greater than the cost of a false negative (ie. too
little ignored).

In the very worst case, if too few files are ignored and a developer
is paying no attention at all, then a *.o or *~ file gets committed;
you can just delete it again.  But if too *many* files are ignored,
you can work on your private branch for weeks at a time, thinking
you're keeping regular snapshots, and actually all your commits are
useless because an important file was never versioned.

I never, ever want to end up in the latter situation, so even though I
start virtually every git project by putting "*.[oa]" and "*~" in my
.gitignore, I'm glad it's *me* doing that and not somebody else.

Have fun,

Avery

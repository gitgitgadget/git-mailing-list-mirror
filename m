From: Tatsuhiko Miyagawa <miyagawa@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Mon, 10 May 2010 10:03:44 -0700
Message-ID: <AANLkTikH39rbm64sc0nn7eTBJSfxcqWpz6VXZBCQQIl3@mail.gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
	 <201005100105.49985.jnareb@gmail.com>
	 <x2k693254b91005091805re0f63ac5z471e05fa4ab71ca7@mail.gmail.com>
	 <201005101232.32908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 19:03:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWOV-0000D3-BH
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab0EJRDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:03:46 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:43066 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446Ab0EJRDp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:03:45 -0400
Received: by ywh36 with SMTP id 36so2063938ywh.4
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=VJodMorUsyTj9tPDwcoxCkm/jeqbCA3GyB+FoPJI6bs=;
        b=eaFKaJXCNygH3fVMVaXUJgU6nvcnnnht7YpSeD8mokFZKJ88PmWMY9XGzIPCdgXDCv
         jyEqFGbnVdiZPrH4Hk64z/TFBX8Oq+LI7zi+kkf/y3heiQxfRGdVbKSrwayK7WosLANA
         gNoMEpBGJwBQ1lxh8tCGBA99OmX80WZJSzfIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Yz7FSutVINig1h8iGAGR+NUiIRzWu0sFRHyNL9o1t+rHXeBOw3tIIBd696xy+TYLYn
         rZxTl32ecHjhFQ+9PEiZ1ziZaWd/+oPMg23TYUjYTm77LZ0VY+RMSaWqdY28goFRc1WL
         9UjsW4Q4dRazjhNWdh7P1ftNhIbJI/G91ysqs=
Received: by 10.101.2.18 with SMTP id e18mr359713ani.72.1273511024376; Mon, 10 
	May 2010 10:03:44 -0700 (PDT)
Received: by 10.100.228.6 with HTTP; Mon, 10 May 2010 10:03:44 -0700 (PDT)
In-Reply-To: <201005101232.32908.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146826>

On Mon, May 10, 2010 at 3:32 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> You have a CGI script and you want to turn it into a PSGI application,
>> hence we have CGI::Emulate::PSGI and CGI::Compile.
>>
>> You usually do not have a FCGI "application". You're writing a .fcgi
>> "wrapper" to make your CGI script runnable from a web server (like
>> you're doing with gitweb.fcgi).
>
> After thinking about it a bit, I realized that I don't want to have
> Plack::App::WrapFCGI wrapper (which if there are no FastCGI-only Perl
> web apps, e.g. using FCGI directly and which do not have support for
> running as ordinary CGI would be totally unnecessary), but I want to
> avoid price of using CGI::Compile.

Yes, that makes sense - if implementing FastCGI is just switching CGI
to CGI::Fast and a while loop, implementing PSGI interface just for
that is far more complicated. I just argued about it because i saw on
a separate thread that PSGI implementation is also on its way.



-- 
Tatsuhiko Miyagawa

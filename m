From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Tue, 24 Jun 2008 11:23:41 +0200
Message-ID: <200806241123.42456.jnareb@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com> <485FE3F7.4040102@gmail.com> <7vtzfjea64.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 11:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB4i6-0001be-Kc
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYFXJUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbYFXJUN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:20:13 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:6122 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbYFXJUM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:20:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so682440and.103
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FQ+c9LgWGevgQUYUkNwwCncZURbNeOKKlbG88RDyVFg=;
        b=CfHwpl7GspDQStQ6oyiH4TJfkbFh08kFDf97Jl+PeeYyEQp7ERBQ7iYmtiJ23DfxXm
         4aWXcI75Ozm1pRC2R8pa/TZtUo/7tXkHVZMSbeL3ypr+Pkosfrwl2m4tZ4O8jTWQu5E1
         hHS7Wfo1TNfbr7kguU/LuJpEE85NEZzTOwuqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PmLMteHEqTgVSBaKxKKJOlpQ19YB0AryuWaJiUFidYl1ePZnPvMoNlzNtFwfKZitmS
         14uVk5UTDy0dLuRu200Yw0DtompTw4BfM24e1XXZS3hAockeDgaRtbEPWjXD9FKy+n3e
         u9htEH/+PGTqn5BTiRLbLTYbPnEom5PTFNIoM=
Received: by 10.100.122.12 with SMTP id u12mr15359150anc.109.1214299210916;
        Tue, 24 Jun 2008 02:20:10 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.195.249])
        by mx.google.com with ESMTPS id d12sm13884344and.6.2008.06.24.02.20.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 02:20:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtzfjea64.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86027>

On Tue, 24 Jun 2008, Junio C Hamano wrote:

> About the Test::WWW::Mechanize::CGI thing, how widely available is it?
> I do not think it is packaged for Debian nor Ubuntu, for example.

Not very widely; practically you have to install it from CPAN.  
Test::WWW::Mechanize::CGI is at v0.1, WWW::Mechanize::CGI is at v0.3.

But if Test::WWW::Mechanize::CGI is not installed, test would be not 
run.  If you are gitweb developer, then installing locally in $HOME 
from CPAN is I guess viable option; if you are not gitweb developer, we 
still have t/t9500-gitweb-standalone-no-errors.sh


The whole point of using those packages was that it makes it _easy_
to write those tests.  This consist of two parts: 

1). running gitweb as if it was CGI application, which otherwise would 
either require deep knowledge of how CGI application is invoked (what 
it is in WWW::Mechanize::CGI and required dependence 
HTTP::Request::AsCGI which I think does all the work) or working
web server, done a la "git instaweb",

2.) accessing and testing gitweb output (what Test::WWW::Mechanize,
WWW::Mechanize does; we could do the same with LWP* modules from 
libwww-perl / perl-libwww-perl package and Test::More from Perl, but
it would be repeating Test::WWW::Mechanize work).
-- 
Jakub Narebski
Poland

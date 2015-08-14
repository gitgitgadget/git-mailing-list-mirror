From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: [bug] 2.5.0 build with =?utf-8?b?Tk9fUEVSTA==?= is broken
Date: Fri, 14 Aug 2015 16:46:18 +0000 (UTC)
Message-ID: <loom.20150814T184447-932@post.gmane.org>
References: <loom.20150814T171757-901@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 18:46:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQI7u-0008Jv-0D
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 18:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbbHNQqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 12:46:37 -0400
Received: from plane.gmane.org ([80.91.229.3]:37011 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113AbbHNQqh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 12:46:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZQI7f-00087l-4F
	for git@vger.kernel.org; Fri, 14 Aug 2015 18:46:27 +0200
Received: from 179-125-142-105.desktop.com.br ([179.125.142.105])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 18:46:27 +0200
Received: from garga by 179-125-142-105.desktop.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 18:46:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 179.125.142.105 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:39.0) Gecko/20100101 Firefox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275910>

Renato Botelho <garga <at> FreeBSD.org> writes:

> 
> I was working on update git on FreeBSD ports tree to 2.5.0 and I noted 2.5.0
> is trying to use perl even when it's being built with NO_PERL knob.
> 
> /bin/sh: /usr/bin/perl: not found
> Makefile:1701: recipe for target 'common-cmds.h' failed
> gmake[2]: *** [common-cmds.h] Error 127
> gmake[2]: *** Waiting for unfinished jobs....
> gmake[2]: Leaving directory '/freebsd/ports/head/devel/git/work/git-2.5.0'
> 
> After a quick search, looks like commit 527ec3980b is the culprit since it
> removed generate-cmdlist.sh and introduced generate-cmdlist.perl.
> 
> I just would like to check if it's planned to add perl dependency during
> build time or it happened by accident and will be fixed so NO_PERL can work
> again.

I also found that some commands require perl when NO_PERL is set:

git-submodule
git-request-pull
git-am

Definitely NO_PERL is not working as expected.

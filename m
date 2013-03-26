From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] difftool: don't overwrite modified files
Date: Tue, 26 Mar 2013 19:34:19 +0000
Message-ID: <20130326193419.GK2286@serenity.lan>
References: <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
 <20130324123620.GA2286@serenity.lan>
 <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
 <20130324151557.GB2286@serenity.lan>
 <514FFFC7.3090004@viscovery.net>
 <20130325104219.GD2286@serenity.lan>
 <20130325214430.GG2286@serenity.lan>
 <51515E92.4030009@viscovery.net>
 <20130326093141.GI2286@serenity.lan>
 <5151702C.9060502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZeA-0002Lt-HV
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab3CZTee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:34:34 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:32881 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab3CZTed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:34:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2D4AECDA600;
	Tue, 26 Mar 2013 19:34:33 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lFrqdXNJb2Fu; Tue, 26 Mar 2013 19:34:32 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1B4DDCDA5D8;
	Tue, 26 Mar 2013 19:34:21 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <5151702C.9060502@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219192>

On Tue, Mar 26, 2013 at 10:53:48AM +0100, Johannes Sixt wrote:
> Am 3/26/2013 10:31, schrieb John Keeping:
> > On Tue, Mar 26, 2013 at 09:38:42AM +0100, Johannes Sixt wrote:
> > The last test does result in /tmp filling up with temporary directories
> > though, it would be good if the test could clean up after itself.  The
> > best I can come up with is adding something like this immediately after
> > running difftool but I'm not entirely happy with the ".." in the
> > argument to rm:
> > 
> > 	test_when_finished rm -rf "$(cat tmpdir)/.."
> 
> Wrap the test in
> 
> 	(
> 		TMPDIR=$TRASH_DIRECTORY &&
> 		export TMPDIR &&
> 	...
> 	)
> 
> It works for me.

Nice.  I've reviewed File::Spec and it looks like that TMPDIR takes
priority on every operating system except VMS, and I don't think we care
about that.

Unless Junio says otherwise, I'll hold off sending this until difftool
calms down a bit to avoid too many conflicted merges.

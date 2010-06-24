From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] Add infrastructure to write revisions in
 fast-export format
Date: Thu, 24 Jun 2010 14:49:27 -0500
Message-ID: <20100624194927.GB2065@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624110217.GG12376@burratino>
 <AANLkTikyjq7HQY1hUTOGF_oBsGDj_jUI-GwDBRdacCzG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:49:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsQi-0003aH-LN
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab0FXTtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 15:49:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36408 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab0FXTti (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 15:49:38 -0400
Received: by iwn41 with SMTP id 41so1163933iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3MiIwHOPF/TI1/ng0admVy68F3pCa5gsFSe2Wt06rEo=;
        b=g6nK1XD4nGQOt8Q3fHRE9lkbHUCDt+UTndKfmX7JiLZhsCUp69RIhVGt3+0z5K8qOV
         6MZ6l3pktrXMOcIiLwVXGgop8tIdUq00qYhqyoQazAhaw0i6nlgwf0pTFL1zfnsIkCXj
         oUSVtuug8PcSHS4AoHB46z8mCuW68yVEIqxrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CLVe11q6LCAYBJqZSvvp0idByZM2web+PuN17TocEai7tfopj1p8ZvItKKyTrMKCYQ
         J/2Is8EVLgwgTw9FY9GZjN3/J09rG7ljD15WkaANHhpwhFVA0FlOk5T79EGYsyHckT/0
         L+XCxfsU3THql/0hlWwINzjbvZ1+rNfLAmIuI=
Received: by 10.231.139.214 with SMTP id f22mr10746640ibu.141.1277408977328;
        Thu, 24 Jun 2010 12:49:37 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm36378588ibi.20.2010.06.24.12.49.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 12:49:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikyjq7HQY1hUTOGF_oBsGDj_jUI-GwDBRdacCzG@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149629>

On Thu, Jun 24, 2010 at 09:29:29PM +0200, Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> =A0. repo_reset erases the exporter's state, so valgrind can be happ=
y.
>=20
> This is like API documentation- should it go into the commit message?

A more terse summary, to save readers time:

 . repo_add, repo_modify, repo_copy, repo_replace, and repo_delete
   update the current commit, based roughly on the corresponding
   Subversion FS operation.

 . repo_commit calls out to fast_export to write the current commit to
   the fast-import stream in stdout.

 . repo_diff is used by the fast_export module to write the changes
   for a commit.

 . repo_reset erases the exporter's state, so valgrind can be happy.

Jonathan

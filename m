From: Jonathan Nieder <jrnieder@gmail.com>
Subject: remote helpers: best practices for using the "refspec" capability
Date: Mon, 30 May 2011 11:40:13 -0500
Message-ID: <20110530164013.GG10879@elie>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie>
 <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530145203.GA10879@elie>
 <BANLkTinRscvPLHbob55pxhXSTKqm+eSF6g@mail.gmail.com>
 <20110530155256.GC10879@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 18:40:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR5W2-00016g-Vf
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 18:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094Ab1E3QkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 12:40:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64162 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab1E3QkS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 12:40:18 -0400
Received: by gwaa18 with SMTP id a18so1466672gwa.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Xs6I7TV2YsUcrsaOpdg4o8oDVje0ytDvpdAMqLxiGt0=;
        b=KPL/qFoyZTBixVbySRktTnuWfAZhQ9EjOgO1TRCRTD6GtbP67iRPv3UTkZi7sBAM1c
         Z1VdmyiwJogVsC8LzeFQs5VZJp1uSw5EEzb9rdnzPao17+BYl/vrF0PjOwfkQIZetmny
         mNxi4tyxJ4KChgN11UytAKyoDck56iFxKfRhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XTwdWny1fKou4f7cy3rL9bWjjlUxakV9tsnIfKVdg3KqRCSiVq0fRg90KApM1IuZc7
         LsCjWdsVuNFavvXfy9pV2+SUqwcSFBxCLmKqCE2rjYy/2Kin7k/OrI0lAdMg4cqVDUHB
         s0bw3/ZMpJUHMF4JPW+pLdISWCRpWZY8pJdJY=
Received: by 10.236.187.103 with SMTP id x67mr6298335yhm.102.1306773617906;
        Mon, 30 May 2011 09:40:17 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id a5sm2610146yhj.22.2011.05.30.09.40.16
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 09:40:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110530155256.GC10879@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174762>

Jonathan Nieder wrote:

> | error: Ref refs/remotes/origin/master is at d94a46270250454f1fc6c1fb47abfde31a2196c9 but expected dfb79bbc658333d5c9b0427b71f6b1bc48629949
> | From mediawiki::http://localhost/mediawiki
> |  ! dfb79bb...c57c15b master     -> origin/master  (unable to update local ref)
> | error: Could not fetch origin
>
> which means that the transport machinery thought the helper was going
> to be fetching directly to "master".  I suspect you will want a
> 'refspec' capability like
>
>	refspec refs/heads/*:refs/mediawiki/${remotename}/*
>
> to fix this.
>
> Cc-ing Daniel who invented v1.7.0-rc0~62^2~19 (Allow helper to map
> private ref names into normal names, 2009-11-18).  What namespace
> should a helper use when asked to fetch to FETCH_HEAD without a remote
> name, like
>
>	git fetch mediawiki::testwiki
>
> ?

Actually cc-ing this time.  Sorry for the noise.
